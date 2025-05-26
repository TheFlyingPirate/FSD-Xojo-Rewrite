#tag Class
Protected Class mm
Inherits fsdServer.process
	#tag Method, Flags = &h0
		Sub addq(dest as String, metar as string, parsed as integer, fd as integer)
		  // Try to short-circuit with a cached profile
		  Dim prof As WProfile = GetWProfile(metar)
		  If prof <> Nil And prof.Active =1 Then
		    If parsed =1 Then
		      ServerInterface.SendWeather(dest, fd, prof)
		    Else
		      ServerInterface.SendMetar(dest, fd, metar, prof.RawCode)
		    End If
		    Return
		  End If
		  
		  // Otherwise enqueue a new request
		  Dim temp As mmq
		  temp.Destination = dest
		  temp.MetarId     = metar
		  temp.Fd          = fd
		  temp.Parsed      = parsed
		  // insert at head of linked list
		  mmqs.add(temp)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub buildlist()
		  // 1) Locate the file
		  Dim f As FolderItem = GetFolderItem(METARFILE)
		  If f = Nil Or Not f.Exists Then Return
		  
		  // 2) Record modification time
		  metarFileTime = f.ModificationDateTime.SecondsFrom1970
		  
		  // 3) Open for random‐access
		  Dim bs As BinaryStream = BinaryStream.Open(f, False)
		  
		  // 4) Clear prior data
		  stationList = Nil
		  nStations   = 0
		  
		  // 5) Scan file line‐by‐line
		  While bs.Position < bs.Length
		    Dim offset As Int64 = bs.Position
		    Dim line   As String = ReadLine(bs)
		    If line.Length < 30 Then Continue
		    
		    // break up on whitespace, collect up to 3 tokens
		    Dim rawTokens() As String = line.ReplaceAll(Chr(9)," ").Split(" ")
		    Dim parts()     As String
		    For Each t As String In rawTokens
		      t = t.Trim
		      If t <> "" Then parts.Append(t)
		      If parts.Ubound >= 2 Then Exit For
		    Next
		    If parts.Ubound < 2 Then Continue
		    If line.BeginsWith("     ") Then Continue
		    
		    // pick the 4‐char station code
		    Dim statName As String
		    If parts(0).Length = 4 Then
		      statName = parts(0)
		    ElseIf parts(1).Length = 4 Then
		      statName = parts(1)
		    Else
		      Continue
		    End If
		    
		    statName = statName.Uppercase
		    
		    // append to dynamic array
		    Dim st As Station
		    st.Location = offset
		    st.Name     = statName
		    stationList.Append(st)
		    nStations = stationList.Ubound + 1
		  Wend
		  
		  bs.Close
		  
		  // 6) Sort and publish
		  //stationList.Sort(AddressOf CompareStation)
		  manager.SetVar(varStations, nStations)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub check()
		  // Get current UTC time
		  Dim now As DateTime = DateTime.Now
		  Dim currHour As Integer = now.Hour
		  
		  // Every 12-hour boundary (or first run) re-seed & refresh variations
		  If prevHour = -1 _
		    Or ((prevHour <> currHour) And (currHour = 0 Or currHour = 12)) Then
		    
		    prevHour = currHour
		    
		    // Seed your RNG (you'll need to implement msrand/mrand)
		    // Use year-since-1900 and month-1 to match C gmtime behavior
		    Dim seedVal As Int32 = currHour * (now.Year - 1900) * (1 + (now.Month - 1))
		    
		    // Assume VAR_AMOUNT is the length of your variation() array
		    For x As Integer = 0 To variation.Ubound
		      variation(x) = mrand()
		    Next
		  End If
		  
		  // If we're in download mode, decide whether to start a new download
		  If source = fsdServer.SOURCE.SOURCE_DOWNLOAD Then
		    // mtime() should return the timestamp (seconds since 1970) of your last
		    // successful download (matching C++ mtime())
		    Dim mNow      As Int64 = MTime()
		    Dim elapsed   As Int64 = mNow - prevDownload
		    Dim currMin   As Integer = now.Minute
		    
		    // At :10 past the hour (if >1m since last), or every hour, or never run yet
		    If (currMin = 10 And elapsed > 60) _
		      Or elapsed > 3600 _
		      Or prevDownload = 0 Then
		      
		      StartDownload()
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkmetarfile()
		  // Check if the METAR file has been updated on disk
		  Dim f As FolderItem = GetFolderItem(METARFILE)
		  If f = Nil Or Not f.Exists Then Return
		  
		  // Compare stored timestamp against current file timestamp
		  Dim currentTime As Int64 = f.ModificationDateTime.SecondsFrom1970
		  If currentTime <> metarFileTime Then
		    // Rebuild index (BuildList also updates metarFileTime)
		    BuildList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CompareStation(a As Station, b As Station) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // initialize sockets and state
		  prevDownload     = 0
		  ioIn             = Nil
		  ioOut            = Nil
		  newFileReady     = False
		  sock             = -1
		  dataSock         = -1
		  dataReadSock     = -1
		  passiveMode      = True
		  sockRecvBuffer   = ""
		  sockRecvBufferLen= 0
		  mmqs.RemoveAll()
		  source     = fsdServer.SOURCE.SOURCE_NETWORK
		  downloading= False
		  ftpEmail   = ""
		  prevHour   = -1
		  nStations  = 0
		  metarHost  = ""
		  metarDir   = ""
		  
		  //–– Load "weather" config
		  Dim wGroup As ConfigGroup = configMan.GetGroup("weather")
		  If wGroup <> Nil Then
		    Dim entry As ConfigEntry
		    
		    // source
		    entry = wGroup.getentry("source")
		    If entry <> Nil Then
		      Select Case entry.Data.Lowercase
		      Case "network"
		        source = fsdServer.SOURCE.SOURCE_NETWORK
		      Case "file"
		        source = fsdServer.SOURCE.SOURCE_FILE
		      Case "download"
		        source = fsdServer.SOURCE.SOURCE_DOWNLOAD
		      Case Else
		        dolog(L_ERR, _
		        "Unknown METAR source '" + entry.Data + "' in config file")
		      End Select
		    End If
		    
		    // server & dir
		    entry = wGroup.getentry("server")
		    If entry <> Nil Then metarHost = entry.Data
		    entry = wGroup.getentry("dir")
		    If entry <> Nil Then metarDir  = entry.Data
		    
		    // ftpmode
		    entry = wGroup.getentry("ftpmode")
		    If entry <> Nil Then
		      passiveMode = (entry.Data.Lowercase = "passive")
		    End If
		  End If
		  
		  //–– Load system email for anonymous FTP
		  wGroup = configMan.GetGroup("system")
		  If wGroup <> Nil Then
		    Dim e2 As ConfigEntry = wGroup.getentry("egetentrymail")
		    If e2 <> Nil Then ftpEmail = e2.Data
		  End If
		  
		  // defaults for download mode
		  If source = fsdServer.SOURCE.SOURCE_DOWNLOAD Then
		    If metarHost = "" Then metarHost = "weather.noaa.gov"
		    If metarDir  = "" Then metarDir  = "data/observations/metar/cycles/"
		  End If
		  
		  //–– Publish status variables
		  manager.SetVar(manager.AddVar("metar.method",  1), SourceToString(source))
		  varPrev     = manager.AddVar("metar.current",  2)
		  varTotal    = manager.AddVar("metar.requests", 3)
		  varStations = manager.AddVar("metar.stations", 3)
		  
		  manager.SetVar(varPrev, DateTime.Now.ToString)
		  
		  //–– If reading from local file, build station index now
		  If source = fsdServer.SOURCE.SOURCE_FILE Then BuildList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub delq(p as mmq)
		  If mmqs = Nil Then Return
		  
		  // Find the index of p in the array
		  For i As Integer = 0 To mmqs.LastIndex
		    If mmqs(i).StringValue(true) = p.StringValue(true) Then
		      
		      // Remove element at i
		      Dim upper As Integer = mmqs.LastIndex
		      If upper = 0 Then
		        // Last element → clear the array
		        mmqs = Nil
		        
		      ElseIf i = 0 Then
		        // Removing the first element
		        Dim tmp() As mmq
		        // Copy indices 1…upper into new array 0…upper-1
		        For j As Integer = 1 To upper
		          tmp.Append(mmqs(j))
		        Next
		        mmqs = tmp
		        
		      ElseIf i = upper Then
		        // Removing the last element → just shrink
		        mmqs.RemoveAt(mmqs.LastIndex)
		        
		      Else
		        // Removing a middle element
		        mmqs.RemoveAt(i)
		      End If
		      
		      // Done
		      Exit
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dodownload()
		  // 1) Handle FTP‐control timeout
		  If (MTime() - prevDownload) > MAXMETARDOWNLOADTIME Then
		    dolog(L_WARNING, "METAR download interrupted due to timeout")
		    StopDownload()
		    StartDownload()
		    Return
		  End If
		  // 2) Read from control socket (FTP commands/responses)
		  If controlSocket <> Nil And controlSocket.IsConnected Then
		    If controlSocket.BytesAvailable > 0 Then
		      Dim resp As String = controlSocket.Read(controlSocket.BytesAvailable)
		      If resp.Length = 0 Then
		        // Server closed control connection → download done
		        StopDownload()
		        newFileReady = True
		      ElseIf passiveMode Then
		        // Accumulate into buffer and look for “227 Entering Passive Mode”
		        sockRecvBuffer = sockRecvBuffer + resp
		        HandlePasvControl()
		      End If
		    End If
		  End If
		  
		  
		  // 4) Read incoming METAR bytes
		  Dim tos as TextOutputStream = TextOutputStream.Open(ioout)
		  
		  If dataReadSocket.BytesAvailable > 0 Then
		    Dim chunk As String = dataReadSocket.Read(dataReadSocket.BytesAvailable)
		    If chunk.Length = 0 Then
		      // EOF on data connection
		      StopDownload()
		      newFileReady = True
		    Else
		      // Write into the temp file
		      tos.Write(chunk)
		      metarSize = metarSize + chunk.Length
		    End If
		  End If
		  tos.Close()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub doparse(q as mmq)
		  // 1) Rebuild index if METAR file changed
		  CheckMetarFile()
		  
		  // 2) Normalize station code (first 4 chars, uppercase)
		  Dim metID As String = q.MetarId.Left(4).Uppercase
		  
		  // 3) Locate in stationList
		  Dim idx As Integer = -1
		  For i As Integer = 0 To stationList.Ubound
		    If stationList(i).Name = metID Then
		      idx = i 
		      Exit For
		    End If
		  Next
		  
		  // 4) If not found, send “no wx” and dequeue
		  If idx = -1 Then
		    ServerInterface.SendNoWx(q.Destination, q.Fd, q.MetarId)
		    DelQ(q)
		    Return
		  End If
		  
		  // 5) Open METAR file and seek to the stored offset
		  Dim f As FolderItem = GetFolderItem(METARFILE)
		  If f = Nil Or Not f.Exists Then Return
		  
		  Dim bs As BinaryStream = BinaryStream.Open(f, False)
		  bs.Position = stationList(idx).Location
		  
		  // 6) Read lines of this report, concatenating
		  Dim report As String = ""
		  Dim firstLine As Boolean = True
		  While True
		    Dim piece As String = ReadLine(bs)
		    If piece = "" Then Exit While
		    
		    Dim isCont As Boolean = piece.Left(5) = "     "
		    If isCont And firstLine Then Exit While
		    If Not isCont And Not firstLine Then Exit While
		    
		    firstLine = False
		    If isCont Then
		      report = report + piece.Mid(5)
		    Else
		      report = report + piece
		    End If
		  Wend
		  bs.Close
		  
		  // 7) Dispatch the result
		  If q.Parsed = 1 Then
		    // Split into tokens
		    Dim raw() As String = report.ReplaceAll(Chr(9)," ").Split(" ")
		    Dim args() As String
		    For Each t As String In raw
		      t = t.Trim
		      If t <> "" Then args.Append(t)
		    Next
		    
		    // Construct WProfile: (name, creationTime, origin)
		    Dim pr As New WProfile( _
		    stationList(idx).Name, _
		    DateTime.Now, _
		    q.MetarId)
		    
		    // ParseMetar now takes (tokens() As String, count As Integer)
		    pr.ParseMetar(args, args.Ubound + 1)
		    
		    ServerInterface.SendWeather(q.Destination, q.Fd, pr)
		    
		  Else
		    ServerInterface.SendMetar( _
		    q.Destination, q.Fd, stationList(idx).Name, report)
		  End If
		  
		  // 8) Update stats and remove from queue
		  manager.IncVar(varTotal)
		  DelQ(q)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getline(bs as binaryStream, line as string) As Boolean
		  If bs.EndOfFile Then
		    Return False
		  End If
		  
		  // Read up to the next LF, stripping CR yourself
		  Dim s As String = ""
		  While Not bs.EndOfFile
		    Dim b As UInt8 = bs.ReadUInt8
		    If b = &h0A Then Exit
		    If b <> &h0D Then s = s + Chr(b)
		  Wend
		  
		  If s = "" And bs.EndOfFile Then
		  End If
		  Return True
		  
		  
		  // strip trailing “=” or any leftover CR/LF
		  PrepareLine(s)
		  line = s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getvariation(num as integer, minVal as integer, maxVal as integer) As Integer
		  Dim val   As Integer = variation(num)
		  Dim range As Integer = (maxVal - minVal) + 1
		  // abs() then mod the range, then shift into [minVal…maxVal]
		  Return (Abs(val) Mod range) + minVal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandlePasvControl()
		  // Split on newline (we treat both CR+LF as EndOfLine)
		  Dim lines() As String = sockRecvBuffer.Split(EndOfLine)
		  For Each ln As String In lines
		    If ln.Trim.Length < 3 Then Continue
		    // Look for a 227 reply
		    Dim code As Integer
		    Try
		      code = Val(ln.Left(3))
		    Catch
		      Continue
		    End Try
		    If code = 227 And ln.InStr("(") > 0 And ln.InStr(")") > ln.InStr("(") Then
		      // Extract h1,h2,h3,h4,p1,p2
		      Dim nums() As String = ln.Mid(ln.InStr("(")+1, ln.InStr(")")-ln.InStr("(")-1).Split(",")
		      If nums.Ubound = 5 Then
		        Dim ipAddr As String = nums(0)+"."+nums(1)+"."+nums(2)+"."+nums(3)
		        Dim portNum As Integer = Val(nums(4)) * 256 + Val(nums(5))
		        
		        // Connect data socket
		        dataReadSocket = New TCPSocket
		        dataReadSocket.Address = ipAddr
		        dataReadSocket.Port    = portNum
		        dataReadSocket.Connect
		        
		        // Send the RETR command for current hour
		        Dim hr As Integer = (DateTime.Now.Hour + 21) Mod 24
		        Dim cmd As String = "RETR " + PadLeft(hr.ToString,2,"0") + "Z.TXT" + EndOfLine
		        controlSocket.Write(cmd)
		        dolog(L_INFO, "METAR: Starting download of METAR data")
		      End If
		    End If
		  Next
		  
		  // Clear buffer (or keep tail if you want partial‐line safety)
		  sockRecvBuffer = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub prepareline(line as string)
		  While line.Length > 0
		    Dim lastChar As String = line.Right(1)
		    If lastChar = "=" Or lastChar = Chr(13) Or lastChar = Chr(10) Then
		      line = line.Left(line.Length - 1)
		    Else
		      Exit
		    End If
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadLine(bs As BinaryStream) As String
		  Dim s As String = ""
		  While bs.Position < bs.Length
		    Dim b As UInt8 = bs.ReadUInt8
		    // LF (10) ends the line
		    If b = &h0A Then Exit
		    // strip CR (13), otherwise accumulate
		    If b <> &h0D Then s = s + Chr(b)
		  Wend
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub requestmetar(client as string, metar as string, parsed as integer, fd as integer)
		  // If we’re configured to fetch via the network, find the best peer
		  If source = fsdServer.SOURCE.SOURCE_NETWORK Then
		    Dim temp    As Server = myserver
		    Dim best    As Server = Nil
		    Dim bestHops As Integer = -1
		    
		    // Walk the linked list of servers
		    
		    for i as integer = 0 to servers.LastIndex
		      temp = Servers(i)
		      If temp <> myServer And (temp.Flags And SERVER_METAR) <> 0 Then
		        // Choose the lowest-hops server (excluding hops = –1), or first match
		        If best = Nil Or (temp.Hops < bestHops And temp.Hops <> -1) Then
		          best    = temp
		          bestHops = temp.Hops
		        End If
		      End If
		    next
		    
		    
		    // Nothing to forward to?
		    
		    
		    // Forward the request
		    ServerInterface.SendReqMetar(client, metar, fd, parsed.ToString, best)
		    
		  Else
		    // Local mode: enqueue for later processing
		    AddQ(client, metar, parsed, fd)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub run()
		  // 1) If in network‐forward mode, do nothing locally
		  If source = fsdServer.SOURCE.SOURCE_NETWORK Then Return
		  
		  // 2) If we’re in the middle of an FTP download, pump it
		  If downloading Then
		    DoDownload()
		  End If
		  
		  // 3) Process any queued METAR requests
		  //    We always look at the first element in 'mmqs'
		  While mmqs <> Nil And mmqs.Ubound >= 0
		    DoParse(mmqs(0))
		  Wend
		  
		  // 4) If a download just finished, install the new file
		  If Not downloading And newFileReady Then
		    SetupNewFile()
		  End If
		  
		  // 5) Perform periodic checks (new download, reseed RNG, etc.)
		  Check()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setupnewfile()
		  // Clear the flag
		  newFileReady = False
		  
		  // 1) Reject too‐small downloads
		  If metarSize < 100000 Then
		    Dim newF As FolderItem = GetFolderItem(METARFILENEW)
		    If newF <> Nil And newF.Exists Then newF.Delete
		    dolog(L_WARNING, _
		    "METAR: Size of new METAR file (" + metarSize.ToText + ") is too small, dropping.")
		    Return
		  End If
		  
		  // 2) Remove old METAR file
		  Dim oldF As FolderItem = GetFolderItem(METARFILE)
		  If oldF <> Nil And oldF.Exists Then oldF.Delete
		  
		  // 3) Rename the new file into place
		  Dim newF As FolderItem = GetFolderItem(METARFILENEW)
		  If newF <> Nil And newF.Exists Then
		    newF.name = METARFILE
		    dolog(L_INFO, "METAR: Installed new METAR data.")
		     
		  Else
		    dolog(L_ERR, "METAR: New METAR file not found: " + METARFILENEW)
		  End If
		  
		  // 4) Rebuild the station index and update the timestamp
		  BuildList()
		  manager.SetVar(varPrev, DateTime.Now.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SourceToString(source as fsdServer.SOURCE) As string
		  select case source
		  Case fsdServer.SOURCE.SOURCE_DOWNLOAD
		    return "download"
		  Case fsdServer.SOURCE.SOURCE_FILE
		    return "file"
		  Case fsdServer.SOURCE.SOURCE_NETWORK
		    return "network"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub startdownload()
		  // Prevent concurrent downloads
		  If downloading Then
		    dolog(L_ERR, "METAR: server seems to be still loading")
		    Return
		  End If
		  
		  // 1) Timestamp this download attempt
		  prevDownload = MTime()
		  
		  // 2) Prepare the temp file
		  ioout = GetFolderItem(METARFILENEW)
		  If ioout <> Nil And ioout.Exists Then ioout.Delete
		  // Create zero-length file so TextOutputStream.Open will succeed
		  Dim t0 As TextOutputStream = TextOutputStream.Create(ioout)
		  t0.Close
		  metarSize = 0
		  
		  // 3) Open FTP control connection
		  controlSocket = New TCPSocket
		  controlSocket.Address = metarHost
		  controlSocket.Port    = 21
		  Try
		    controlSocket.Connect
		  Catch err As IOException
		    dolog(L_ERR, "METAR: Could not connect to FTP on " + metarHost + ": " + err.Message)
		    StopDownload()
		    Return
		  End Try
		  
		  // 4) Prepare data listener (active mode)
		  dataListener = New ServerSocket
		  // Listen on any port
		  dataListener.Listen()
		  
		  // 5) Send FTP login & CWD
		  Dim cmd As String = _
		  "USER anonymous" + EndOfLine + _
		  "PASS " + ftpEmail + EndOfLine + _
		  "CWD "  + metarDir  + EndOfLine
		  
		  // 6) Passive vs. Active
		  If passiveMode Then
		    cmd = cmd + "PASV" + EndOfLine
		    // We'll send RETR once we get the 227 response in HandlePasvControl()
		  Else
		    // Build PORT h1,h2,h3,h4,p1,p2
		    Dim localIP As String = controlSocket.LocalAddress
		    Dim octets() As String = localIP.Split(".")
		    Dim p As Integer = dataListener.Port
		    Dim p1 As Integer = p \ 256
		    Dim p2 As Integer = p Mod 256
		    Dim portCmd As String = _
		    "PORT " + octets(0) + "," + octets(1) + "," + _
		    octets(2) + "," + octets(3) + "," + _
		    p1.ToText + "," + p2.ToText + EndOfLine
		    
		    cmd = cmd + portCmd
		    
		    // Immediately send RETR for current cycle hour
		    Dim hr As Integer = (DateTime.Now.Hour + 21) Mod 24
		    cmd = cmd + "RETR " + PadLeft(hr.ToString,2, "0") + "Z.TXT" + EndOfLine
		    dolog(L_INFO, "METAR: Starting download of METAR data")
		  End If
		  
		  // 7) Dispatch control commands
		  controlSocket.Write(cmd)
		  
		  // 8) Mark state
		  downloading     = True
		  sockRecvBuffer  = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub stopdownload()
		  // 1) Close FTP control socket
		  If controlSocket <> Nil Then
		    Try
		      controlSocket.Close
		    Catch
		    End Try
		    controlSocket = Nil
		  End If
		  
		  // 2) Close the data‐connection socket
		  If dataReadSocket <> Nil Then
		    Try
		      dataReadSocket.Close
		    Catch
		    End Try
		    dataReadSocket = Nil
		  End If
		  
		  // 3) Shut down the listening socket (active mode)
		  If dataListener <> Nil Then
		    Try
		      dataListener.StopListening()
		    Catch
		    End Try
		    dataListener = Nil
		  End If
		  
		  // 4) Clear any buffered PASV response
		  sockRecvBuffer = ""
		  
		  // 5) Reset flags
		  downloading = False
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		
		Metar Manager
	#tag EndNote


	#tag Property, Flags = &h0
		controlSocket As TCPSOcket
	#tag EndProperty

	#tag Property, Flags = &h0
		dataListener As ServerSocket
	#tag EndProperty

	#tag Property, Flags = &h0
		datareadsock As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		dataReadSocket As TCPSocket
	#tag EndProperty

	#tag Property, Flags = &h0
		datasock As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		downloading As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ftpemail As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ioin As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		ioout As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		metardir As string
	#tag EndProperty

	#tag Property, Flags = &h0
		metarfiletime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		metarhost As string
	#tag EndProperty

	#tag Property, Flags = &h0
		metarsize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		mmqs() As MMQ
	#tag EndProperty

	#tag Property, Flags = &h0
		newfileready As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		nstations As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		passivemode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		prevdownload As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevhour As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		rootq As fsdServer.mmq
	#tag EndProperty

	#tag Property, Flags = &h0
		sock As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		sockrecvbuffer As string
	#tag EndProperty

	#tag Property, Flags = &h0
		sockrecvbufferlen As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		source As fsdServer.SOURCE
	#tag EndProperty

	#tag Property, Flags = &h0
		stationlist() As station
	#tag EndProperty

	#tag Property, Flags = &h0
		variation() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varprev As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varstations As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		vartotal As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevdownload"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="metarfiletime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="nstations"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevhour"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="sock"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="datasock"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="datareadsock"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="newfileready"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="metarsize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="sockrecvbuffer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sockrecvbufferlen"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varprev"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="vartotal"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varstations"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="metarhost"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="metardir"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ftpemail"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="passivemode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="downloading"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="source"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="fsdServer.SOURCE"
			EditorType="Enum"
			#tag EnumValues
				"0 - SOURCE_NETWORK"
				"1 - SOURCE_FILE"
				"2 - SOURCE_DOWNLOAD"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
