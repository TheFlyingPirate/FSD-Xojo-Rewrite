#tag Class
Protected Class servinterface
Inherits fsdServer.tcpinterface
	#tag Method, Flags = &h0
		Sub assemble(buf as string, cmdnum as integer, to as string, from as string, bi as integer, pc as integer, hc as integer, data as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clientdropped(who as client)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(port, code, descr)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub incpacketcount()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newuser(fd as integer, peername as string, portnum as integer, g as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As integer
		  // Calling the overridden superclass method.
		  Var returnValue as integer = Super.run()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendaddclient(dest as string, who as client, direction as absuser, sorce as absuser, feed as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendaddwp(direction as absuser, wp as wprofile)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendatcdata(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendcert(dest as string, cmd as integer, who as certificate, direction as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub senddelwp(wp as wprofile)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendkill(who as client, reason as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendlinkdown(data as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendmetar(dest as string, fd as integer, station as string, data as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendmulticast(source as client, dest as string, s as string, cmd as integer, multiok as integer, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendnowx(dest as string, fd as integer, station as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpacket(exclude as absuser, direction as absusermcmdnum as integer, to as string, from as string, pc as integer, hc as integer, bi as integer, data as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpilotdata(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendping(dest as string, data as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendplan(dest as string, who as client, direction as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpong(dest as string, data as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendreqmetar(client as string, metar as string, fd as integer, parsed as string, dest as server)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendreset()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendrmclient(direction as absuser, dest as string, who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendservernotify(dest as string, subject as server, towho as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendsync()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendweather(dest as string, fd as integer, w as wprofile)
		  
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
		varshape As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varuchandled As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varucoverrun As Integer
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
