#tag Class
Protected Class servuser
Inherits fsdServer.absuser
	#tag Method, Flags = &h0
		Sub Constructor(fd As Integer, parentIF As ServInterface, peer As String, portnum As Integer, group As Integer)
		  Super.Constructor(fd, parentIF, peer, portnum, group)
		  
		  // Initialize
		  Parent      = parentIF
		  StartupTime = MTime()      // your UNIX‐timestamp helper
		  ClientOk    = False
		  thissserver  = Nil
		  
		  // Send initial state to this new server link
		  Feed()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub doparse(s as string)
		  If s.Left(1) = "#" Then Return
		  SetActive()
		  If s.Left(1) <> "\" Then
		    doparse(s)
		  Else
		    Select Case s.Mid(2,1)
		    Case "q"
		      Kill(KILL.COMMAND)
		    Case "l"
		      List(s)
		    Case Else
		      UPrintf("Syntax error, type \h for help" + EndOfLine)
		    End Select
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execad(args() as string, count as integer)
		  If count < 12 Then Return
		  Dim who As Client = fsdServer.getClient(args(4))
		  If who = Nil Then Return
		  who.UpdateATC(args)
		  clientinterface.SendAtcPos(who, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function execaddclient(args() as string, count as integer) As Boolean
		  If count < 12 Then Return True
		  Dim location As Server = fsdServer.getServer(args(5))
		  If location = Nil Or location = myserver Then Return True
		  Dim type     As Integer = args(7).ToInteger
		  Dim cs       As String  = args(6)
		  If fsdServer.getClient(cs) <> Nil Then Return False
		  Dim c As New Client(args(4), location, cs, type, args(8).ToInteger, args(9), args(10), args(11).ToInteger)
		  If type = CLIENT_ATC Then
		    clientinterface.SendAA(c, Nil)
		  Else
		    clientinterface.SendAP(c, Nil)
		  End If
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execaddwp(args() as string, count as integer)
		  If count<57 Or MetarManager.Source=SOURCE.SOURCE_NETWORK Then Return
		  Dim group As configgroup = configman.GetGroup("hosts")
		  Dim entry As configentry = If(group<>Nil, group.GetEntry("weather"), Nil)
		  Dim ok    As Boolean     = If(entry<>Nil, entry.InList(args(6))=1, True)
		  If Not ok Then Return
		  
		  Dim version As Integer   = args(5).ToInteger
		  Dim prof    As wprofile  = fsdServer.getwprofile(args(4))
		  If prof<>Nil And prof.Version>=version Then Return
		  If prof<>Nil Then
		    // delete old profile if your arrays support it
		  End If
		  Dim dob as double = version
		  Dim d as new DateTime(dob)
		  prof = New wprofile(args(4), D, args(6))
		  prof.LoadArray(args, count-7)
		  prof.GenRawCode()
		  wProf.add(prof)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execcert(args() as string, count as integer)
		  If count < 10 Then Return
		  Dim group As configgroup   = configman.GetGroup("hosts")
		  Dim entry As configentry   = If(group<>Nil, group.GetEntry("certificates"), Nil)
		  Dim ok    As Boolean       = If(entry<>Nil, entry.InList(args(9))=1, True)
		  Dim mode  As Integer       = args(4).ToInteger
		  Dim cid   As String        = args(5)
		  Dim pwd   As String        = args(6)
		  Dim lev   As Integer       = args(7).ToInteger
		  Dim ts    As Integer       = args(8).ToInteger
		  Dim org   As String        = If(count=12, args(11), "")
		  Dim c     As Certificate   = fsdServer.getCert(cid)
		  
		  Select Case mode
		  Case CERT_ADD
		    If c=Nil And ok Then Certificates.Add(New Certificate(cid, pwd, lev, ts, org))
		  Case CERT_DELETE
		    If c<>Nil And ok Then Certificates.RemoveAt(Certificates.IndexOf(c))
		  Case CERT_MODIFY
		    If c<>Nil And ts>c.CreationTime And ok Then c.Configure(pwd, lev, ts, org)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execdelwp(args() as string, count as integer)
		  If count<5 Or MetarManager.Source=SOURCE.SOURCE_NETWORK Then Return
		  Dim group As configgroup = configman.GetGroup("hosts")
		  Dim entry As configentry = If(group<>Nil, group.GetEntry("weather"), Nil)
		  Dim ok    As Boolean     = If(entry<>Nil, entry.InList(args(1))=1, True)
		  If Not ok Then Return
		  
		  Dim prof As wprofile = fsdServer.getwprofile(args(4))
		  If prof<>Nil And prof.Active=1 Then
		    wProf.RemoveAt(wProf.IndexOf(prof))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execkill(args() as string, count as integer)
		  If count < 6 Then Return
		  Dim c As Client = fsdServer.getClient(args(4))
		  If c <> Nil Then clientinterface.HandleKill(c, args(5))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execlinkdown(args() as string, count as integer)
		  For i As Integer = 4 To count - 1
		    Dim ident As String = args(i)
		    Dim s As Server = fsdServer.getServer(ident)
		    If s <> Nil And s.Path = Me Then s.SetPath(Nil, -1)
		  Next
		  serverinterface.SendSync()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execmetar(args() as string, count as integer)
		  If count < 7 Then Return
		  Dim fd      As Integer = args(5).ToInteger
		  Dim station As String  = args(4)
		  Dim report  As String  = args(6)
		  
		  If fd<>-1 Then
		    systeminterface.ReceiveMetar(fd, station, report)
		  Else
		    Dim c As Client = fsdServer.getClient(args(0).Mid(2))
		    If c<>Nil Then clientinterface.SendMetar(c, report)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execmulticast(args() as string, count as integer)
		  If count < 7 Then Return
		  Dim cmd    As CL      = CL(args(4).ToInteger)
		  Dim source As Client  = fsdServer.getClient(args(5))
		  Dim destID As String  = args(0)
		  Dim destCl As Client
		  
		  Select Case destID.Left(1)
		  Case "*", "@"
		    ' broadcast
		  Case "%"
		    destCl = fsdServer.getClient(destID.Mid(2))
		    If destCl = Nil Then Return
		  Case Else
		    Return
		  End Select
		  
		  Dim payload As String = fsdServer.CatCommand(args, 6, "")
		  clientinterface.SendGeneric(destID, destCl, Nil, source, args(5), payload, cmd)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execnotify(args() as string, count as integer)
		  If count < 11 Then Return
		  Dim feedFlag As Boolean = (args(4).ToInteger = 0)
		  Dim ident    As String  = args(5)
		  Dim s        As Server  = fsdServer.getServer(ident)
		  If s = Nil Or s = myserver Then Return
		  
		  If s = Nil Then
		    s = New Server(ident, args(6), args(7), args(8), args(9), args(10).ToInteger, If(count=12, args(11), ""))
		  Else
		    s.Configure(args(6), args(7), args(8), args(9), If(count=12, args(11), ""))
		  End If
		  
		  If Not feedFlag And args(3).ToInteger = 1 Then
		    thissserver = s
		  End If
		  
		  If feedFlag Or (s.Hops > -1 And args(3).ToInteger >= s.Hops) Then Return
		  s.SetPath(Me, args(3).ToInteger)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execnowx(args() as string, count as integer)
		  If count < 6 Then Return
		  Dim station As String  = args(4)
		  Dim fd      As Integer = args(5).ToInteger
		  
		  If fd=-1 Then
		    Dim c As Client = fsdServer.getClient(args(0).Mid(2))
		    If c<>Nil Then clientinterface.SendNowx(c, station)
		  Else
		    systeminterface.ReceiveNowx(fd, station)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpd(args() as string, count as integer)
		  If count < 14 Then Return
		  Dim who As Client = fsdServer.getClient(args(5))
		  If who = Nil Then Return
		  who.UpdatePilot(args)
		  clientinterface.SendPilotPos(who, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execping(args() as string, count as integer)
		  If count < 2 Then Return
		  Dim dest    As String = args(1)
		  Dim payload As String = fsdServer.CatCommand(args, 4, "")
		  Parent.SendPong(dest, payload)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function execplan(args() as string, count as integer) As Boolean
		  If count < 21 Then Return False
		  Dim rev As Integer = args(5).ToInteger
		  Dim who As Client  = fsdServer.getClient(args(4))
		  If who = Nil Then Return True
		  If who.Plan<>Nil And who.Plan.Revision>=rev Then Return False
		  Dim route() As String
		  For i As Integer = 6 To UBound(args)
		    route.Append(args(i))
		  Next
		  who.HandleFP(route)
		  who.Plan.Revision = rev
		  clientinterface.SendPlan(Nil, who, 400)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpong(args() as string, count as integer)
		  If count < 5 Then Return
		  Dim data As String = args(4)
		  Dim fd   As Integer = data.ToInteger
		  Dim src  As Server  = fsdServer.getServer(args(1))
		  If src = Nil Then Return
		  src.ReceivePong(data)
		  If fd <> -1 Then
		    systeminterface.ReceivePong(args(1), data, args(2), args(3))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execreqmetar(args() as string, count as integer)
		  If count < 8 Then Return
		  Dim clientID As String = args(4)
		  Dim station  As String = args(5)
		  Dim parsed   As Boolean = (args(6)="1")
		  Dim fd       As Integer = args(7).ToInteger
		  MetarManager.RequestMetar(clientID, station, parsed, fd)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execreset(args() as string, count as integer)
		  If count < 2 Then Return
		  Dim s As Server = fsdServer.getServer(args(1))
		  If s <> Nil Then s.PCount = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execrmclient(args() as string, count as integer)
		  If count < 5 Then Return
		  Dim cs As String = args(4)
		  Dim c  As Client = fsdServer.getClient(cs)
		  If c <> Nil Then
		    If c.Location <> myserver Then
		      If c.Type = CLIENT_ATC Then
		        clientinterface.SendDA(c, Nil)
		      Else
		        clientinterface.SendDP(c, Nil)
		      End If
		    End If
		    clients.RemoveAt(clients.IndexOf(c))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execweather(args() as string, count as integer)
		  If count < 56 Then Return
		  Dim prof As New wprofile(args(4), new DateTime(0.0), "")
		  prof.LoadArray(args, count-6)
		  Dim fd As Integer = args(5).ToInteger
		  If fd=-1 Then
		    Dim c As Client = fsdServer.getClient(args(0).Mid(2))
		    If c<>Nil Then clientinterface.SendWeather(c, prof)
		  Else
		    systeminterface.ReceiveWeather(fd, prof)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub feed()
		  ' 1) All servers
		  For Each srv As Server In servers
		    Parent.SendServerNotify("*", srv, Me)
		  Next
		  ' 2) All clients
		  For Each cl As Client In clients
		    Parent.SendAddClient("*", cl, Me, Nil, True)
		    If cl.Plan <> Nil Then Parent.SendPlan("*", cl, Me)
		  Next
		  ' 3) All certificates
		  For Each cert As Certificate In Certificates
		    Parent.SendCert("*", CERT_ADD, cert, Me)
		  Next
		  ' 4) All weather profiles
		  '    (assumes you have a global wprofiles() array)
		  For Each wp As wprofile In wProf
		    Parent.SendAddWp(Me, wp)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub list(s as string)
		  Dim pattern As String = s.Mid(3).Trim
		  Dim buf     As String
		  Dim nvars   As Integer = manager.GetNVars()
		  
		  For i As Integer = 0 To nvars - 1
		    Dim val As String = manager.SprintValue(i, buf)
		    If val <> "" Then
		      Dim name As String = manager.GetVar(i).Name
		      If pattern = "" Or name.Uppercase.IndexOf(pattern.Uppercase) >= 0 Then
		        UPrintf("%s=%s" + EndOfLine, name, buf)
		      End If
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function needlocaldelivery(dest as String) As Boolean
		  Select Case dest.Left(1)
		  Case "*", "@"
		    Return True       ' wildcards always local
		  Case "%"
		    Dim c As Client = fsdServer.getClient(dest.Mid(2))
		    Return c <> Nil And c.Location = myserver
		  Case Else
		    Return dest.Lowercase = myserver.Ident.Lowercase
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function runcmd(num as CMD, data() as string, count as integer) As Boolean
		  Select Case num
		  Case CMD.NOTIFY     
		    execnotify(data, count)   
		    Return True
		  Case CMD.PING       
		    execping(data, count)       
		    Return True
		  Case CMD.LINKDOWN   
		    execlinkdown(data, count)   
		    Return True
		  Case CMD.PONG       
		    execpong(data, count)       
		    Return True
		  Case CMD.SYNC       
		    Return False
		  Case CMD.ADDCLIENT  
		    return execaddclient(data, count)
		  Case CMD.RMCLIENT   
		    execrmclient(data, count) 
		    Return True
		  Case CMD.PD         
		    execpd(data, count)         
		    Return True
		  Case CMD.AD         
		    execad(data, count)         
		    Return True
		  Case CMD.CERT       
		    execcert(data, count)       
		    Return True
		  Case CMD.MULTIC     
		    execmulticast(data, count)  
		    Return True
		  Case CMD.PLAN       
		    return execplan(data, count)
		  Case CMD.REQMETAR   
		    execreqmetar(data, count)   
		    Return True
		  Case CMD.WEATHER    
		    execweather(data, count)    
		    Return True
		  Case CMD.METAR      
		    execmetar(data, count)      
		    Return True
		  Case CMD.NOWX       
		    execnowx(data, count)       
		    Return True
		  Case CMD.ADDWPROF   
		    execaddwp(data, count)      
		    Return True
		  Case CMD.DELWPROF   
		    execdelwp(data, count)      
		    Return True
		  Case CMD.KILL       
		    execkill(data, count)       
		    Return True
		  Case CMD.RESET      
		    execreset(data, count)      
		    Return True
		  End Select
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		clientok As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		parent As servinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		startuptime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		thissserver As server
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="fd"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="killFlag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="inSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="outSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="feed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="feedCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="guardFlag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="outBufSoftLimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastPing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevFeedCheck"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="timeout"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="blocked"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="peer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="port"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="inBuf"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="outBuf"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="prompt"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="clientok"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="startuptime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
