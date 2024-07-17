#tag Class
Protected Class manage
	#tag Method, Flags = &h0
		Function addvar(name as string, type as integer) As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub decvar(num as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub delvar(num as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getnvars() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getvar(num as integer) As managevar
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getvarnum(name as String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub incvar(num as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setvar(num as integer, val as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setvar(num as integer, val as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sprintvalue(num as integer, buf as string) As String
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		nvars As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		variables As managevar
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
			Name="nvars"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
