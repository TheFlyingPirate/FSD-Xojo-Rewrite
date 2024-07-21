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
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execaa(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execacars(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execap(s() as string, count as integer)
		  //ToDo add functionalityexecapexecap
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execatcpos(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execcq(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execd(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execfp(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execkill(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execmulticast(s() as string, count as integer, cnd as integer, nargs as integer, multiok as integer)
		  //ToDo add functionality
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
		Function getcomm(s as string) As integer
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
		Function showerror(num as ERR, env as string) As integer
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
