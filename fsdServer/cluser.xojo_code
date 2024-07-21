#tag Class
Protected Class cluser
Inherits fsdServer.absuser
	#tag Method, Flags = &h0
		Function callsignok(name as string) As integer
		  Dim temp as string
		  if name.Length<2 or name.Length > CALLSIGNBYTES then
		    return CType(ERR.CSINVALID,Int32)
		  end
		  if strpbrk(name,"!@#$*:& \t") then
		    return CType(ERR.CSINVALID,INT32)
		  end
		  for each c as client in clients
		    if c.callsign = name then
		      return CType(ERR.CSINUSE,INT32)
		    end
		  next
		  return CType(ERR.OK,INT32)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checklogin(id as string, password as string, req as integer) As integer
		  if id = "" Then Return -2
		  Dim max as integer
		  Dim ok as boolean = MaxLevel(id,password,max)
		  if not ok then
		    Dim se as integer = showerror(ERR.CIDINVALID,id)
		    Return -1
		  end
		  if req>max then
		    return max
		  else
		    return req
		  end
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checksource(from as string) As boolean
		  if from <> thisclient.callsign then
		    Dim i as integer = showerror(ERR.SRCINVALID,from)
		    Return False
		  end
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fd as integer, p as clinterface, pn as string, portnum as integer, gg as integer)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(fd, p, pn, portnum, gg)
		  parent = p
		  thisclient = nil
		  Dim gu as configgroup = configman.getgroup("system")
		  Dim e as configentry
		  if gu<> nil then
		    e = gu.getentry("maxclients")
		  else
		    e=nil
		  end
		  'Dim total as Integer = manager.getvar(p.varcurrent).value.IntegerValue
		  'if e<>Nil and Val(e.getdata)<=total then
		  'Dim i as integer = showerror(ERR.SERVFULL,"")
		  'Kill(kill.COMMAND)
		  'end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub doparse(s as string)
		  Dim cmd As String = s.Left(3)
		  Dim data() As String
		  Dim index As CL = GetComm(cmd)
		  Dim count As Integer
		  
		  If index = CL.UNOWN Then
		    Dim i as integer = ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  If thisClient = Nil And index <> CL.ADDATC And index <> CL.ADDPILOT Then
		    Return
		  End If
		  
		  ' Just a hack to put the pointer on the first arg here
		  s = s.Mid(Len(clcmdnames(index)) + 1)
		  count = BreakPacket(s, data)
		  
		  Select Case index
		  Case CL.ADDATC
		    ExecAA(data, count)
		  Case CL.ADDPILOT
		    ExecAP(data, count)
		  Case CL.PLAN
		    ExecFP(data, count)
		  Case CL.RMATC, CL.RMPILOT
		    ExecD(data, count)
		  Case CL.PILOTPOS
		    ExecPilotPos(data, count)
		  Case CL.ATCPOS
		    ExecATCPos(data, count)
		  Case CL.PONG, CL.PING
		    ExecMulticast(data, count, index, 0, 1)
		  Case CL.MESSAGE
		    ExecMulticast(data, count, index, 1, 1)
		  Case CL.REQHANDOFF, CL.ACHANDOFF
		    ExecMulticast(data, count, index, 1, 0)
		  Case CL.SB, CL.PC
		    ExecMulticast(data, count, index, 0, 0)
		  Case CL.WEATHER
		    ExecWeather(data, count)
		  Case CL.REQCOM
		    ExecMulticast(data, count, index, 0, 0)
		  Case CL.REPCOM
		    ExecMulticast(data, count, index, 1, 0)
		  Case CL.REQACARS
		    ExecACARS(data, count)
		  Case CL.CR
		    ExecMulticast(data, count, index, 2, 0)
		  Case CL.CQ
		    ExecCQ(data, count)
		  Case CL.KILL
		    ExecKill(data, count)
		  Case Else
		    Dim i as integer = ShowError(ERR.SYNTAX,"")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execaa(s() as string, count as integer)
		  
		  If thisClient <> Nil Then
		    ShowError(ERR.REGISTERED, "")
		    Return
		  End If
		  
		  If count < 7 Then
		    ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  Dim err2 As Integer = CallSignOK(s(0))
		  If err2 <> 0 Then
		    ShowError(err2, "")
		    Kill(KILL.COMMAND)
		    Return
		  End If
		  
		  If Val(s(6)) <> NEEDREVISION Then
		    ShowError(ERR.REVISION, "")
		    Kill(KILL.PROTOCOL)
		    Return
		  End If
		  
		  Dim req As Integer = Val(s(5))
		  If req < 0 Then req = 0
		  
		  Dim level As Integer = CheckLogin(s(3), s(4), req)
		  If level = 0 Then
		    ShowError(ERR.CSSUSPEND, "")
		    Kill(KILL.COMMAND)
		    Return
		  ElseIf level = -1 Then
		    Kill(KILL.COMMAND)
		    Return
		  ElseIf level = -2 Then
		    level = 1
		  End If
		  
		  If level < req Then
		    ShowError(ERR.LEVEL, s(5))
		    Kill(KILL.COMMAND)
		    Return
		  End If
		  
		  thisClient = New Client(s(3), myServer, s(0), CLIENT_ATC, level, s(6), s(2), -1)
		  ServerInterface.SendAddClient("*", thisClient, Nil, Me, 0)
		  ReadMOTD()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execacars(s() as string, count as integer)
		  If count < 3 Then
		    ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  If Not CheckSource(s(0)) Then Return
		  
		  If StrComp(s(2), "METAR", CType(ComparisonOptions.CaseInsensitive,Int32)) = 0 And count > 3 Then
		    Dim source As String = "%" + thisClient.Callsign
		    MetarManager.RequestMetar(source, s(3), 0, -1)
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execap(s() as string, count as integer)
		  If thisClient <> Nil Then
		    ShowError(ERR.REGISTERED, "")
		    Return
		  End If
		  
		  If count < 8 Then
		    ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  Dim errs As Integer = CallSignOK(s(0))
		  If errs <> 0 Then
		    ShowError(errs, "")
		    Kill(KILL.COMMAND)
		    Return
		  End If
		  
		  If Val(s(5)) <> NEEDREVISION Then
		    ShowError(ERR.REVISION, "")
		    Kill(KILL.PROTOCOL)
		    Return
		  End If
		  
		  Dim req As Integer = Val(s(4))
		  If req < 0 Then req = 0
		  
		  Dim level As Integer = CheckLogin(s(2), s(3), req)
		  If level < 0 Then
		    Kill(KILL.COMMAND)
		    Return
		  ElseIf level = 0 Then
		    ShowError(ERR.CSSUSPEND, "")
		    Kill(KILL.COMMAND)
		    Return
		  End If
		  
		  If level < req Then
		    ShowError(ERR.LEVEL, s(4))
		    Kill(KILL.COMMAND)
		    Return
		  End If
		  
		  thisClient = New Client(s(2), myServer, s(0), CLIENT_PILOT, level, s(4), s(7), Val(s(6)))
		  ServerInterface.SendAddClient("*", thisClient, Nil, Me, 0)
		  ReadMOTD()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execatcpos(s() as string, count as integer)
		  If count < 8 Then
		    ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  If Not CheckSource(s(0)) Then Return
		  Dim subarray() as string
		  for i as integer = 1 to ubound(s)
		    subarray.add(s(i))
		  next
		  thisClient.UpdateATC(subarray)
		  ServerInterface.SendATCData(thisClient, Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execcq(s() as string, count as integer)
		  If count < 3 Then
		    ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  If StrComp(s(1), "server", Ctype(ComparisonOptions.CaseInsensitive,Int32)) <> 0 Then
		    ExecMulticast(s, count, CL.CQ, 1, 1)
		    Return
		  End If
		  
		  If StrComp(s(2).Uppercase, "RN", Ctype(ComparisonOptions.CaseInsensitive,Int32)) = 0 Then
		    Dim cli As Client = GetClient(s(1))
		    If cli <> Nil Then
		      Dim data As String = sprintf("%s:%s:RN:%s:USER:%d",cli.callsign,thisclient.callsign,cli.realname,cli.rating)
		      ClientInterface.SendPacket(thisClient, cli, Nil, CLIENT_ALL, -1, CL.CR, data)
		      Return
		    End If
		  End If
		  
		  If StrComp(s(2), "fp", Ctype(ComparisonOptions.CaseInsensitive,Int32)) = 0 Then
		    Dim cli As Client = GetClient(s(3))
		    If cli = Nil Then
		      ShowError(ERR.NOSUCHCS, s(3))
		      Return
		    End If
		    If cli.Plan = Nil Then
		      ShowError(ERR.NOFP, "")
		      Return
		    End If
		    ClientInterface.SendPlan(thisClient, cli, -1)
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execd(s() as string, count as integer)
		  if count = 0 then
		    showerror(ERR.SYNTAX,"")
		    return
		  end
		  if not checksource(s(0)) then return
		  kill(kill.COMMAND)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execfp(s() as string, count as integer)
		  if count < 17 then
		    showerror(ERR.SYNTAX,"")
		    return
		  end
		  if not checksource(s(0)) then return
		  Dim subarray() as string
		  for i as integer = 2 to UBound(s)
		    subarray.Add(s(i))
		  next
		  thisclient.handlefp(subarray)
		  serverinterface.sendplan("*",thisclient,Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execkill(s() as string, count as integer)
		  Dim junk As String
		  If count < 3 Then
		    ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  Dim cli As Client = GetClient(s(1))
		  If cli = Nil Then
		    ShowError(ERR.NOSUCHCS, s(1))
		    Return
		  End If
		  
		  If thisClient.Rating < 11 Then
		    junk = "You are not allowed to kill users!"
		    ClientInterface.SendGeneric(thisClient.Callsign, thisClient, Nil, Nil, "server", junk, CL.MESSAGE)
		    junk = thisClient.Callsign + " attempted to remove " + s(1) + ", but was not allowed to"
		    DoLog(L_ERR, junk)
		  Else
		    junk = "Attempting to kill " + s(1)
		    ClientInterface.SendGeneric(thisClient.Callsign, thisClient, Nil, Nil, "server", junk, CL.MESSAGE)
		    junk = thisClient.Callsign + " Killed " + s(1)
		    DoLog(L_INFO, junk)
		    ServerInterface.SendKill(cli, s(2))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execmulticast(s() as string, count as integer, cmd as CL, nargs as integer, multiok as integer)
		  nargs = nargs + 2
		  If count < nargs Then
		    ShowError(ERR.SYNTAX, "")
		    Return
		  End If
		  
		  Dim from As String = s(0)
		  Dim tos As String = s(1)
		  Dim data As String = ""
		  Dim subarray() as String
		  for i as integer = 2 to UBound(s)
		    subarray.add(s(i))
		  next
		  CatCommand(subarray, count - 2, data)
		  
		  If Not CheckSource(from) Then Return
		  
		  ServerInterface.SendMulticast(thisClient, tos, data, cmd, multiok, Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpilotpos(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execweather(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getcomm(s as string) As CL
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxLevel(id as string, password as string, byref max as integer) As Boolean
		  Dim temp as certificate = getCert(id)
		  if temp = nil then
		    max = LEV_OBSPILOT
		    return false
		  end
		  if temp.password =  password then
		    max = temp.level
		    temp.prevVisit = Datetime.Now.SecondsFrom1970
		    return true
		    
		  end
		  max = LEV_OBSPILOT
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parse(s() as string)
		  //ToDo Add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub readmotd()
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showerror(num as ERR, env as string)
		  Dim i as integer = showerror(num,env)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function showerror(num as ERR, env as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showerror(num as integer, env as string)
		  //ToDo add functionality
		  showerror(num,env)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function showerror(num as integer, env as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		parent As clinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		thisclient As client
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
	#tag EndViewBehavior
End Class
#tag EndClass
