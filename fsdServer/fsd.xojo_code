#tag Class
Protected Class fsd
	#tag Method, Flags = &h0
		Sub configmyserver()
		  Dim mode As Integer = 0
		  Dim serverident As String = ""
		  Dim servername As String = ""
		  Dim servermail As String = ""
		  Dim serverhostname As String = ""
		  Version = App.version +" " +App.MajorVersion.ToString + "." +App.MinorVersion.ToString + "." + App.BugVersion.ToString
		  Dim serverlocation As String = ""
		  Dim entry As ConfigEntry
		  Dim sysgroup As ConfigGroup = configman.GetGroup("system")
		  If sysgroup <> Nil Then
		    sysgroup.Changed = 0
		    entry = sysgroup.GetEntry("ident")
		    If entry <> Nil Then serverident = entry.GetData()
		    
		    entry = sysgroup.GetEntry("name")
		    If entry <> Nil Then servername = entry.GetData()
		    
		    entry = sysgroup.GetEntry("email")
		    If entry <> Nil Then servermail = entry.GetData()
		    
		    entry = sysgroup.GetEntry("hostname")
		    If entry <> Nil Then serverhostname = entry.GetData()
		    
		    entry = sysgroup.GetEntry("location")
		    If entry <> Nil Then serverlocation = entry.GetData()
		    
		    entry = sysgroup.GetEntry("mode")
		    If entry <> Nil And entry.GetData().Compare("silent", ComparisonOptions.CaseInsensitive) = 0 Then
		      mode = SERVER_SILENT
		    End If
		  End If
		  
		  
		  If serverident = "" then
		    serverident = version
		    DoLog(L_ERR, "No serverident specified")
		  End If
		  if servermail = "" Then
		    servermail = ""
		    DoLog(L_ERR,"No servermail specified")
		  end
		  if serverhostname = "" then
		    Dim n As NetworkInterface
		    n = System.GetNetworkInterface(System.NetworkInterfaceCount - 1)
		    serverhostname = Lowercase(System.Network.LookupDNSAddress(n.IPAddress))
		    
		  end
		  if servername = "" then
		    DoLog(L_Err,"No servername specifeied")
		    servername = serverhostname
		  end
		  if serverlocation = "" then
		    Dolog(L_ERR,"No serverlocation specified")
		    serverlocation=""
		  end
		  Dim flags as integer = mode
		  if MetarManager.source <> SOURCE.SOURCE_NETWORK then
		    flags = flags or server_metar
		  end
		  if myserver <> nil then
		    myserver.configure(servername, servermail,serverhostname,version,serverlocation)
		  else
		    myserver = new server(serverident,servername,servermail,serverhostname,version,flags,serverlocation)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub configure()
		  clientport = 6809
		  serverport = 3011
		  systemport = 3012
		  Dim entry as configentry
		  Dim sysgropup as configgroup = configman.getgroup("system")
		  if sysgropup <> Nil then
		    entry = sysgropup.getentry("clientport")
		    if entry <> Nil then clientport=entry.getint()
		    entry = sysgropup.getentry("serverport")
		    if entry <> Nil then serverport = entry.getint()
		    entry = sysgropup.getentry("systemport")
		    if entry <> Nil then systemport = entry.getint()
		    entry = sysgropup.getentry("certificates")
		    if entry <> Nil then certfile = entry.getdata().Uppercase
		    entry = sysgropup.getentry("whazzup")
		    if entry <> Nil then whazzupfile = entry.getdata().uppercase
		  end
		  configmyserver()
		  readcert()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(configfile as string)
		  certfile = ""
		  whazzupfile = ""
		  DoLog(L_INFO,"Booting Server")
		  pmanager = new pman
		  manager = new manage()
		  configman = new configmanager(configfile)
		  pmanager.registerprocess(configman)
		  MetarManager = new mm
		  pmanager.registerprocess(MetarManager)
		  configure()
		  createmanagevars()
		  createinterfaces()
		  makeconnections()
		  dolog(L_INFO,"We are up")
		  prevnotify=mtime()
		  prevlagcheck = prevnotify
		  timer = prevnotify
		  prevwhazzup = mtime()
		  fileopen=0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub createinterfaces()
		  Dim prompt as string
		  prompt = sprintf("%s> ", myserver.ident)
		  clientinterface = new clinterface(clientport,"client","client interface")
		  serverinterface = new servinterface(serverport,"server","server interface")
		  systeminterface = new sysinterface(systemport,"system","system management interface")
		  systeminterface.setprompt(prompt)
		  serverinterface.setfeedstrategy(FEED_BOTH)
		  clientinterface.setflood(100000)
		  clientinterface.setfeedstrategy(FEED_IN)
		  clientinterface.setoutbuflimit(100000)
		  pmanager.registerprocess(clientinterface)
		  pmanager.registerprocess(serverinterface)
		  pmanager.registerprocess(systeminterface)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub createmanagevars()
		  Dim varnum as integer
		  varnum = manager.addvar("system.boottime",ATT_DATE)
		  manager.setvar(varnum,Datetime.now.SecondsFrom1970)
		  varnum =  manager.addvar("version.system",ATT_VARCHAR)
		  manager.setvar(varnum, VERSION)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dochecks()
		  Dim now as integer = MTime()
		  if now-prevnotify>NOTIFYCHECK then
		    Dim sgroup as configgroup = configman.getgroup("system")
		    if sgroup <> nil and sgroup.changed = 1 then configmyserver()
		    serverinterface.sendservernotify("*",myserver,Nil)
		    prevnotify = now
		  end
		  if now-prevlagcheck > LAGCHECK then
		    Dim data as string = sprintf("-1 %lu",MTime())
		    serverinterface.sendping("*",data)
		    prevlagcheck = now
		  end
		  if now-prevcertcheck>CERTFILECHECK then
		    Dim entry as configentry
		    DIm sysgroup as configgroup = configman.getgroup("system")
		    if sysgroup <> Nil then
		      entry = sysgroup.getentry("certificates")
		      if entry<> Nil then
		        certfile = entry.getdata.Uppercase
		        Dim file as new FolderItem(certfile)
		        prevcertcheck = now
		        if file.exists then
		          Dim lastModified as double = file.ModificationDateTime.SecondsFrom1970
		          if lastModified <> cerfilestat then
		            cerfilestat=lastModified
		            readcert()
		          end
		        end
		      end
		    end
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handlecidline(line as string)
		  Dim tempcert as certificate
		  Dim mode, level as integer
		  Dim arr(),cid,pwd as string
		    If line.Left(1) = ";" Or line.Left(1) = "#" Then Return
		  arr=line.Split(" ")
		  if arr.LastIndex < 2 then return
		  cid = arr(0)
		  level = arr(2).ToInteger
		  pwd = arr(1)
		  tempCert = getCert(cid)
		  if tempcert = Nil then
		    tempCert = new certificate(cid,pwd,level,MGMTTime(),myserver.ident)
		    mode= CERT_ADD
		  else
		    tempcert.liveCheck = 1
		    if tempcert.password = pwd and tempcert.level = level then return
		    tempcert.configure(pwd,level,MGMTTime,myserver.ident)
		    mode = CERT_MODIFY
		  end
		  if serverinterface <> Nil then serverinterface.sendcert("*",mode,tempcert,NIL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeconnections()
		  Dim cgroup As ConfigGroup = configman.GetGroup("connections")
		  If cgroup Is Nil Then Return
		  
		  Dim centry As ConfigEntry = cgroup.GetEntry("connectto")
		  If centry <> Nil Then
		    ' Connect to the configured servers
		    Dim nparts As Integer = centry.GetNParts()
		    For x As Integer = 0 To nparts - 1
		      Dim portnum As Integer = 3011
		      Dim data As String = centry.GetPart(x)
		      Dim sportnum As Integer = data.IndexOf(":")
		      
		      If sportnum > -1 Then
		        Dim num As Integer
		        portnum = data.Middle(sportnum+1).ToInteger
		        
		        data = data.Left(sportnum)
		      End If
		      
		      If serverinterface.AddUser(data, portnum, Nil) <> 1 Then
		        Dolog(L_ERR, "Connection to " + data + " port " + Str(portnum) + " failed!")
		      Else
		        Dolog(L_INFO, "Connected to " + data + " port " + Str(portnum))
		      End If
		    Next
		  End If
		  
		  centry = cgroup.GetEntry("allowfrom")
		  If centry <> Nil Then
		    ' Allow the configured servers
		    Dim nparts As Integer = centry.GetNParts()
		    For x As Integer = 0 To nparts - 1
		      serverinterface.Allow(centry.GetPart(x))
		    Next
		  Else
		    Dolog(L_WARNING, "No 'allowfrom' found, allowing everybody on the server port")
		  End If
		  
		  serverinterface.SendReset()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub readcert()
		  if certfile = "" then Return
		  Dim file as new FolderItem(certfile)
		  if not file.Exists then
		    DoLog(L_ERR,"Could not open certificates file '" +certfile+"'")
		    Return
		  End If
		  Dim io as TextInputStream = TextInputStream.Open(file)
		  for each c as certificate in Certificates
		    c.liveCheck = 0
		  next
		  Dolog(L_INFO, "Reading certificates from '" + certfile + "'")
		  While not io.EndOfFile
		    
		    handlecidline(io.ReadLine)
		  wend
		  for each c as certificate in Certificates
		    if c.liveCheck = 0 then
		      serverinterface.sendcert("*",CERT_DELETE,c,nil)
		      certificates.RemoveAt(certificates.IndexOf(c))
		    end
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub run()
		  pmanager.run()
		  if timer<>MTime() then
		    timer = MTime()
		    dochecks()
		  end
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		cerfilestat As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		certfile As string
	#tag EndProperty

	#tag Property, Flags = &h0
		clientport As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		fileopen As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		pmanager As pman
	#tag EndProperty

	#tag Property, Flags = &h0
		prevcertcheck As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevlagcheck As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevnotify As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevwhazzup As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		serverport As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		systemport As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		timer As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		whazzupfile As string
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
			Name="clientport"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="serverport"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="systemport"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="certfile"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="whazzupfile"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="timer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevnotify"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevlagcheck"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="cerfilestat"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevcertcheck"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevwhazzup"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="fileopen"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
