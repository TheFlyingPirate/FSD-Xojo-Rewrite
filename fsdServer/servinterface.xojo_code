#tag Class
Protected Class servinterface
Inherits fsdServer.tcpinterface
	#tag Method, Flags = &h0
		Function assemble(cmds As CMD, toDest As String, fromID As String, bi As Boolean, pc As Integer, hc As Integer, data As String) As String
		  Dim typeChar As String = If(bi, "B", "U")
		  Return svcmdnames(cmds) + ":" + toDest + ":" + fromID + ":" + _
		  typeChar + pc.ToText + ":" + hc.ToText + ":" + data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clientdropped(who as client)
		  for each u as servuser in ServUsers
		    if u.thissserver <> nil and (u.thissserver.flags and SERVER_SILENT) <> 0 then
		      sendrmclient(u,u.thissserver.ident,who,Nil)
		    end
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(port As Integer, code As String, dataDir As String)
		  // 1) Initialize base TCP interface
		  Super.Constructor(port, code, dataDir)
		  
		  // 2) Initialize packet counters
		  PacketCount      = 0
		  VarMChHandled    = Manager.AddVar("protocol.multicast.handled", 2)
		  VarMCDrops       = Manager.AddVar("protocol.multicast.dropped", 2)
		  VarUChHandled    = Manager.AddVar("protocol.unicast.handled", 2)
		  VarUCOverrun     = Manager.AddVar("protocol.unicast.overruns", 2)
		  VarFailed        = Manager.AddVar("protocol.errors.invalidcommand",2)
		  VarBounce        = Manager.AddVar("protocol.errors.bounce", 2)
		  VarShape         = Manager.AddVar("protocol.errors.shape", 2)
		  VarInterr        = Manager.AddVar("protocol.errors.integer", 2)
		  
		  // 3) Store our server identity
		  ServerIdent      = myserver.Ident
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub incpacketcount()
		  PacketCount = PacketCount + 1
		  If PacketCount < 0 Or PacketCount > 2000000000 Then
		    SendReset()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newuser(fd as integer, peername as string, portnum as integer, g as integer)
		  Dim su As New ServUser(fd, Me, peername, portnum, g)
		  InsertUser(su)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As Boolean
		  // Current time (seconds since 1970)
		  Dim now As Int64 = MTime()
		  
		  // 1) Pump the TCP interface
		  Dim busy As Boolean = Super.Run()
		  
		  // 2) Periodic SYNC if timeout exceeded
		  If (now - lastSync) > SYNCTIMEOUT Then
		    SendSync()
		  End If
		  
		  // 3) Drop any servuser still in init state too long
		  For Each u As ServUser In ServUsers
		    If Not u.ClientOk _
		      And (now - u.StartupTime) > SERVERMAXTOOK Then
		      
		      u.Kill(KILL.INITTIMEOUT)
		    End If
		  Next
		  
		  Return busy
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendaddclient(dest As String, who As Client, direction As AbsUser, source As AbsUser, feed As Boolean)
		  Dim buf As String = _
		  who.Cid + ":" + who.Location.Ident + ":" + who.Callsign + ":" + _
		  who.Type.ToText + ":" + who.Rating.ToText + ":" + who.Protocol + ":" + _
		  who.RealName + ":" + who.SimType.ToString
		  
		  SendPacket(Nil, direction, CMD.ADDCLIENT, dest, ServerIdent, PacketCount, 0, False, buf)
		  IncPacketCount()
		  
		  // Also notify local clients if not a feed
		  If Not feed Then
		    If who.Type = CLIENT_ATC Then
		      ClientInterface.SendAA(who, source)
		    ElseIf who.Type = CLIENT_PILOT Then
		      ClientInterface.SendAP(who, source)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendaddwp(direction as absuser, wp as wprofile)
		  Dim weather As String = wp.Print() 
		  Dim buf     As String = wp.Name + ":" + wp.Version.ToText + ":" + wp.Origin + ":" + weather
		  
		  SendPacket(Nil, direction, CMD.ADDWPROF, "*", ServerIdent, PacketCount, 0, False, buf)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendatcdata(who as client, ex as absuser)
		  Dim data As String = _
		  who.Callsign + ":" + who.Frequency.ToText + ":" + _
		  who.FacilityType.ToText + ":" + who.VisualRange.ToText + ":" + _
		  who.Rating.ToText + ":" + Format(who.Lat, "0.00000") + ":" + _
		  Format(who.Lon, "0.00000") + ":" + who.Altitude.ToText
		  
		  SendPacket(Nil, Nil, CMD.AD, "*", ServerIdent, PacketCount, 0, False, data)
		  ClientInterface.SendAtcPos(who, ex)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendcert(dest as string, cmd as integer, who as certificate, direction as absuser)
		  Dim data As String = _
		  cmd.ToText + ":" + who.Cid + ":" + who.Password + ":" + _
		  who.Level.ToText + ":" + who.creationTime.ToString + ":" + who.Origin
		  Dim c as fsdServer.CMD = fsdServer.cmd.CERT
		  SendPacket(Nil, direction, c, dest, ServerIdent, PacketCount, 0, False, data)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub senddelwp(wp as wprofile)
		  // Instruct all peers to delete this weather profile
		  SendPacket( _
		  Nil, _
		  Nil, _
		  CMD.DELWPROF, _
		  "*", _
		  ServerIdent, _
		  PacketCount, _
		  0, _
		  False, _
		  wp.Name _
		  )
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendkill(who as client, reason as string)
		  // Local kill?
		  If who.Location = MyServer Then
		    ClientInterface.HandleKill(who, reason)
		    Return
		  End If
		  
		  // Remote kill
		  Dim data As String = who.Callsign + ":" + reason
		  SendPacket( _
		  Nil, _
		  Nil, _
		  CMD.KILL, _
		  who.Location.Ident, _
		  ServerIdent, _
		  PacketCount, _
		  0, _
		  True, _
		  data _
		  )
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendlinkdown(data as string)
		  SendPacket(Nil, Nil, CMD.LINKDOWN, "*", ServerIdent, PacketCount, 0, True, data)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendmetar(dest as string, fd as integer, station as string, data as string)
		  If dest.Lowercase = ServerIdent.Lowercase Then
		    SystemInterface.ReceiveMetar(fd, station, data)
		    Return
		  End If
		  
		  // To a local client?
		  If dest.Left(1) = "%" Then
		    Dim c As Client = GetClient(dest.Mid(2))
		    If c <> Nil And c.Location = MyServer Then
		      ClientInterface.SendMetar(c, data)
		      Return
		    End If
		  End If
		  
		  // Otherwise send on the network
		  Dim buf As String = station + ":" + fd.ToText + ":" + data
		  SendPacket(Nil, Nil, CMD.METAR, dest, ServerIdent, PacketCount, 0, False, buf)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendmulticast(source as client, dest as string, s as string, cmd as CL, multiok as boolean, ex as absuser)
		  
		  Dim destination As Client
		  Dim servdest    As String
		  Dim sourcestr   As String = If(source <> Nil, source.Callsign, "server")
		  
		  // Special handling for server‐targeted ping
		  If source <> Nil And dest.Lowercase = "server" Then
		    Select Case cmd
		    Case CL.PING
		      ClientInterface.SendGeneric(source.Callsign, source, Nil, Nil, "server", s, CL.PONG)
		    End Select
		    Return 
		  End If
		  
		  // Determine server‐dest
		  Select Case dest.Left(1)
		  Case "@", "*"
		    If Not multiok Then Return 
		    servdest = dest
		  Case Else
		    servdest = "%" + dest
		    destination = GetClient(dest)
		    If destination = Nil Then Return 
		  End Select
		  
		  Dim data As String = clcmdnames(cmd) + ":" + sourcestr + ":" + s
		  SendPacket(Nil, Nil, fsdServer.cmd.MULTIC, servdest, ServerIdent, PacketCount, 0, False, data)
		  IncPacketCount()
		  
		  ClientInterface.SendGeneric(dest, destination, ex, source, sourcestr, s, cmd)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendnowx(dest as string, fd as integer, station as string)
		  If dest.Lowercase = ServerIdent.Lowercase Then
		    SystemInterface.ReceiveNoWx(fd, station)
		    Return
		  End If
		  
		  If dest.Left(1) = "%" Then
		    Dim c As Client = GetClient(dest.Mid(2))
		    If c <> Nil And c.Location = MyServer Then
		      ClientInterface.SendNoWx(c, station)
		      Return
		    End If
		  End If
		  
		  Dim buf As String = station + ":" + fd.ToText
		  SendPacket(Nil, Nil, CMD.NOWX, dest, ServerIdent, PacketCount, 0, False, buf)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpacket(exclude as absuser, direction as absuser, cmdnum as CMD, tos as string, from as string, pc as integer, hc as integer, bi as boolean, data as string)
		  // 1) Increase hop count
		  hc = hc + 1
		  
		  // 2) Build packet text
		  Dim packet As String = Assemble(cmdnum, tos, from, bi, pc, hc, data)
		  
		  // 3) Determine if soft‐limit check applies
		  Dim slcheck As Boolean = (cmdnum = CMD.PD Or cmdnum = CMD.AD)
		  
		  // 4) If a specific direction is given, send only there
		  If direction <> Nil Then
		    direction.Send(packet + EndOfLine)
		    Return
		  End If
		  
		  // 5) Route based on toDest first character
		  Dim firstChar As String = tos.Left(1)
		  
		  Select Case firstChar
		    
		  Case "@", "*"
		    // Broadcast to all servers/users
		    Dim outPkt As String = packet
		    If Not bi Then
		      // mark as broadcast
		      outPkt = Assemble(cmdnum, tos, from, True, pc, hc, data)
		    End If
		    For Each u As ServUser In ServUsers
		      If u <> exclude And (SilentOk(Integer(cmdnum)) Or u.thissserver = Nil Or _
		        (u.thissserver.flags And SERVER_SILENT) = 0) Then
		        u.Send(outPkt + EndOfLine)
		      End If
		    Next
		    
		  Case "%"
		    // Pilot destination
		    Dim callsign As String = tos.Mid(2)
		    Dim c        As Client = GetClientByCallsign(callsign)
		    If c <> Nil Then
		      Dim destSrv As Server = c.Location
		      If destSrv = myServer Then
		        // local broadcast
		        Dim outPkt As String = packet
		        If Not bi Then
		          outPkt = Assemble(cmdnum, tos, from, True, pc, hc, data)
		        End If
		        For Each u As ServUser In ServUsers
		          If u <> exclude And (SilentOk(Integer(cmdnum)) Or u.thissserver = Nil Or _
		            (u.thissserver.Flags And SERVER_SILENT) = 0) Then
		            u.Send(outPkt + EndOfLine)
		          End If
		        Next
		      ElseIf destSrv.Path <> Nil Then
		        // forward to that server link
		        destSrv.Path.Send(packet + EndOfLine)
		      Else
		        // fallback broadcast
		        Dim outPkt As String = packet
		        If Not bi Then
		          outPkt = Assemble(cmdnum, tos, from, True, pc, hc, data)
		        End If
		        For Each u As ServUser In ServUsers
		          If u <> exclude And (SilentOk(Integer(cmdnum)) Or u.thissserver = Nil Or _
		            (u.thissserver.Flags And SERVER_SILENT) = 0) Then
		            u.Send(outPkt + EndOfLine)
		          End If
		        Next
		      End If
		    End If
		    
		  Case Else
		    // Specific server by ident
		    Dim destSrv As Server = Server.GetServer(tos)
		    If destSrv <> Nil Then
		      If destSrv.Path <> Nil Then
		        destSrv.Path.send(packet + EndOfLine)
		      Else
		        // fallback broadcast
		        Dim outPkt As String = packet
		        If Not bi Then
		          outPkt = Assemble(cmdnum, tos, from, True, pc, hc, data)
		        End If
		        For Each u As ServUser In servUsers
		          If u <> exclude And (SilentOk(Integer(cmdnum)) Or u.thissserver = Nil Or _
		            (u.thissserver.Flags And SERVER_SILENT) = 0) Then
		            u.Send(outPkt + EndOfLine)
		          End If
		        Next
		      End If
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpilotdata(who as client, ex as absuser)
		  Dim data As String = _
		  who.IdentFlag + ":" + who.Callsign + ":" + who.Transponder.ToText + ":" + _
		  who.Rating.ToText + ":" + Format(who.Lat, "0.00000") + ":" + _
		  Format(who.Lon, "0.00000") + ":" + who.Altitude.ToText + ":" + _
		  who.GroundSpeed.ToText + ":" + who.PBH.ToText + ":" + who.Flags.ToText
		  
		  SendPacket(Nil, Nil, CMD.PD, "*", ServerIdent, PacketCount, 0, False, data)
		  ClientInterface.SendPilotPos(who, ex)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendping(dest as string, data as string)
		  SendPacket(     _
		  Nil,          _   // no exclude
		  Nil,          _  // no specific directio
		  CMD.Ping,     _  // command number
		  dest,         _  // to
		  ServerIdent,  _  // from
		  PacketCount,  _  // packet count
		  0,            _  // hop count
		  False,        _  // not yet broadcast
		  data          _  // payload
		  )
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendplan(dest as string, who as client, direction as absuser)
		  Dim plan As FlightPlan = who.Plan
		  If plan = Nil Then Return
		  
		  Dim buf As String = _
		  who.Callsign + ":" + plan.Revision.ToText + ":" + _
		  plan.Type.ToText + ":" + plan.Aircraft + ":" + _
		  plan.TAScruise.ToText + ":" + plan.DepAirport + ":" + _
		  plan.DepTime.ToText + ":" + plan.actualdeptime.ToText + ":" + _
		  plan.Alt + ":" + plan.DestAirport + ":" + _
		  plan.HrsEnRoute.ToText + ":" + plan.MinEnRoute.ToText + ":" + _
		  plan.HrsFuel.ToText + ":" + plan.MinFuel.ToText + ":" + _
		  plan.AltAirport + ":" + plan.Remarks + ":" + plan.Route
		  
		  SendPacket(Nil, direction, CMD.PLAN, dest, ServerIdent, PacketCount, 0, False, buf)
		  IncPacketCount()
		  ClientInterface.SendPlan(Nil, who, 400)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpong(dest as string, data as string)
		  SendPacket(Nil, Nil, CMD.PONG, dest, ServerIdent, PacketCount, 0, False, data)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendreqmetar(client as string, metar as string, fd as integer, parsed as boolean, dest as server)
		  Dim buf As String = _
		  client + ":" + metar + ":" + If(parsed,"1","0") + ":" + fd.ToText
		  
		  SendPacket(Nil, Nil, CMD.REQMETAR, dest.Ident, ServerIdent, PacketCount, 0, False, buf)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendreset()
		  SendPacket(Nil, Nil, CMD.RESET, "*", ServerIdent, PacketCount, 0, False, "")
		  PacketCount = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendrmclient(direction as absuser, dest as string, who as client, ex as absuser)
		  Dim buf As String = who.Callsign
		  SendPacket(Nil, direction, CMD.RMCLIENT, dest, ServerIdent, PacketCount, 0, False, buf)
		  IncPacketCount()
		  
		  If dest = "*" Then
		    If who.Type = CLIENT_ATC Then
		      ClientInterface.SendDA(who, ex)
		    ElseIf who.Type = CLIENT_PILOT Then
		      ClientInterface.SendDP(who, ex)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendservernotify(dest as string, subject as server, towho as absuser)
		  Dim localFlag As Integer = If(subject Is MyServer, 0, 1)
		  Dim buf As String = _
		  localFlag.ToText + ":" + subject.Ident + ":" + subject.Name + ":" + _
		  subject.Email + ":" + subject.Hostname + ":" + subject.Version + ":" + _
		  subject.Flags.ToText + ":" + subject.Location
		  
		  SendPacket(Nil, toWho, CMD.NOTIFY, dest, ServerIdent, PacketCount, 0, True, buf)
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendsync()
		  SendPacket(Nil, Nil, CMD.SYNC, "*", ServerIdent, PacketCount, 0, False, "")
		  lastSync = MTime()
		  IncPacketCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendweather(dest as string, fd as integer, w as wprofile)
		  // Local system?
		  If dest.Lowercase = ServerIdent.Lowercase Then
		    SystemInterface.ReceiveWeather(fd, w)
		    Return
		  End If
		  
		  // Local client?
		  If dest.Left(1) = "%" Then
		    Dim c As Client = GetClient(dest.Mid(2))
		    If c <> Nil And c.Location = MyServer Then
		      ClientInterface.SendWeather(c, w)
		      Return
		    End If
		  End If
		  
		  Dim weatherStr As String = w.Print()
		  Dim data       As String = w.Name + ":" + fd.ToText + ":" + weatherStr
		  
		  SendPacket(Nil, Nil, CMD.WEATHER, dest, ServerIdent, PacketCount, 0, False, data)
		  IncPacketCount()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		lastsync As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		packetcount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		serverident As String
	#tag EndProperty

	#tag Property, Flags = &h0
		varbounce As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varfailed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varinterr As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varmcdrops As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varmchandled As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		VarMChHandled As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varshape As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varuchandled As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		VarUChHandled As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varucoverrun As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="varcurrent"
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
			Name="varpeak"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="feedstrategy"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="floodlimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="outbuflimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevchecks"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
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
			Name="lastsync"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="packetcount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="serverident"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="varbounce"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varfailed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varinterr"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varmcdrops"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varmchandled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varshape"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varuchandled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varucoverrun"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
