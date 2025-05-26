#tag Class
Protected Class tcpinterface
Inherits fsdServer.process
	#tag Method, Flags = &h0
		Sub addguard(who as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function adduser(name as string, port as integer, terminal as absuser) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub allow(name as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function calcmasks(rmask as MemoryBlock, wmask as MemoryBlock) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(port as integer, code as string, descr as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub delguard()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dochecks()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertuser(u as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makevars(code as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newuser(fd as integer, peername as string, portnum as integer, g as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeuser(u as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setfeedstrategy(strat as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setflood(limit as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setoutbuflimit(limit as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setprompt(s as string)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		feedstrategy As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		floodlimit As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		outbuflimit As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevchecks As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prompt As String
	#tag EndProperty

	#tag Property, Flags = &h0
		rootallow As allowstruct
	#tag EndProperty

	#tag Property, Flags = &h0
		sock As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varclosed(9) As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varcurrent As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varpeak As Integer
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
	#tag EndViewBehavior
End Class
#tag EndClass
