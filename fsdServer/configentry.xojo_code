#tag Class
Protected Class configentry
	#tag Method, Flags = &h0
		Sub Constructor(v as string, d as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub fillparts()
		  //ToDo Add Functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getdata() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getint() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getnparts() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getpart(num as integer) As String
		  If parts.Ubound = -1 Then
		    fillparts()
		  End If
		  If num >= nparts Then
		    Return ""
		  End If
		  Return parts(num)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function inlist(entry as string) As integer
		  //ToDo Add Functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setdata(d as string)
		  //ToDo Add Functionality
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		changed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		data As String
	#tag EndProperty

	#tag Property, Flags = &h0
		nparts As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		partbuf As String
	#tag EndProperty

	#tag Property, Flags = &h0
		parts() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		vari As String
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
			Name="vari"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="data"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="partbuf"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="changed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="nparts"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
