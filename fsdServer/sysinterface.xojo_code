#tag Class
Protected Class sysinterface
Inherits fsdServer.tcpinterface
	#tag Method, Flags = &h0
		Sub Constructor(port as integer, code as string, descr as string)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(port, code, descr)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewUser(fd as integer, peer as string, pornum as integer, g as integer)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceiveMetar(fd As Integer, wp As String, w As String)
		  // Implementation here 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceiveNowx(fd As Integer, st As String)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceivePong(from As String, data As String, pc As String, hops As String)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceiveWeather(fd As Integer, w As WProfile)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Run() As Integer
		  // Implementation here
		  Return 0
		End Function
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
