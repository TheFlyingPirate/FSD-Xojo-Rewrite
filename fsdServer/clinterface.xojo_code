#tag Class
Protected Class clinterface
Inherits fsdServer.tcpinterface
	#tag Method, Flags = &h0
		Function calcrange(from as client, toc as client, type as fsdserver.cl, range as integer) As Integer
		  Dim x,y as integer
		  Select Case type
		  case CL.PILOTPOS
		    return range
		  case CL.ATCPOS
		    if toc.type = CLIENT_ATC then
		      return toc.visualrange
		    end
		    x=toc.getrange()
		    y=from.getrange()
		    if from.type = CLIENT_PILOT then //CLIENT PILOT
		      return x +y
		    end
		    if x>y then
		      return x
		    end
		    return y
		  else
		    return range
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getbroad(s as string) As Integer
		  Dim broad as integer = CLIENT_ALL
		  if s = "*P" then
		    broad = CLIENT_PILOT
		  elseif s="*A" then
		    broad = CLIENT_ATC
		  end
		  return broad
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handlekill(who as client, reason as string)
		  if who.location<>myserver then
		    return
		  end
		  
		  for each u as absuser in users
		    if u isa cluser then
		      Dim tcl as cluser = cluser(u)
		      if tcl.thisclient = who then
		        Dim buf as string = sprintf("SERVER:%s:%s",who.callsign,reason)
		        sendpacket(who,NIL,NIL,CLIENT_ALL,-1,CL.KILL,buf)
		        u.Kill(KILL.KILL)
		      end
		    end
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendaa(who as client, ex as absuser)
		  Dim data as string
		  data = sprintf("%s:SERVER:%s:%s::%d",who.callsign,who.realname,who.cid,who.rating,who.protocol)
		  sendpacket(NIL,NIL,ex,CLIENT_ALL,-1,CL.ADDATC,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendap(who as client, ex as absuser)
		  Dim data as string
		  data = sprintf("%s:SERVER:%s::%d:%s:%d",who.callsign,who.cid,who.rating,who.protocol,who.simtype)
		  sendpacket(Nil,Nil,ex,CLIENT_ALL,-1,CL.ADDPILOT, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendatcpos(who as client, ex as absuser)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendda(who as client, ex as absuser)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub senddp(who as client, ex as absuser)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendgeneric(toc as string, dest as client, ex as absuser, source as client, from as string, s as string, cmd as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendmetar(who as client, data as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendnowx(who as client, station as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpacket(dest as client, source as client, exclude as absuser, broad as integer, range as integer, cmd as fsdServer.cl, data as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpilotpos(who as client, ex as absuser)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendplan(dest as client, who as client, range as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendweather(who as client, p as wprofile)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendwinddelta()
		  //ToDo add functionality
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private prevwinddelta As Integer
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
	#tag EndViewBehavior
End Class
#tag EndClass
