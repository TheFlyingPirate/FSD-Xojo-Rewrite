#tag Class
Protected Class configmanager
Inherits process
	#tag Method, Flags = &h0
		Function creategroup(name as String) As configgroup
		  //ToDo Add Functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getgroup(name as string) As configgroup
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parsefile()
		  //ToDo Add Functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As integer
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		changed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		filename As String
	#tag EndProperty

	#tag Property, Flags = &h0
		groups() As configgroup
	#tag EndProperty

	#tag Property, Flags = &h0
		lastmodify As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ngroups As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevcheck As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varaccess As Integer
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
