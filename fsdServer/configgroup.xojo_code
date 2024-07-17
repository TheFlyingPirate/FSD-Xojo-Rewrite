#tag Class
Protected Class configgroup
	#tag Method, Flags = &h0
		Sub Constructor(n as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createentry(vari as string, data as String) As configentry
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getentry(name as string) As configentry
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handleentry(vari as string, data as string)
		  //ToDo Add Functionality
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		changed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		entries() As configentry
	#tag EndProperty

	#tag Property, Flags = &h0
		name As string
	#tag EndProperty

	#tag Property, Flags = &h0
		nentries As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
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
			Name="name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="nentries"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="changed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
