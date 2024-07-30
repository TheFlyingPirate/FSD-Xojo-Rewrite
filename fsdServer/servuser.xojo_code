#tag Class
Protected Class servuser
Inherits fsdServer.absuser
	#tag Method, Flags = &h0
		Sub Constructor(d as integer, p as servinterface, pn as string, portnum as integer, g as integer)
		  //Super.Constructor(d,p,pn,portnum,g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub doparse(s as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execad(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function execaddclient(s() as string, count as integer) As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execaddwp(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function execcert(s() as string, count as integer) As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execdelwp(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execkill(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execlinkdown(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execmetar(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execnotify(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execnowx(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpd(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpd1(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpd2(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpd3(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execping(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpong(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execreqmetar(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execreset(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execrmclient(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execweather(s() as string, count as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub feed()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub list(s as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function needlocaldelivery(dest as String) As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parse(s() as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub runcmd(num as integer, data() as string, count as integer)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		clientok As Integer
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
			Type="Integer"
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
