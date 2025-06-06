#tag Class
Protected Class configentry
	#tag Method, Flags = &h0
		Sub Constructor(v as string, d as string)
		  vari = v
		  data = d
		  changed =1
		  Dim s() as string
		  parts = s
		  partbuf = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub fillparts()
		  nparts = 0
		  Dim s() as string
		  parts = s
		  partbuf = data
		  
		  Dim p As String = partbuf
		  While p <> ""
		    Dim endPos As Integer = InStr(p, ",")
		    If endPos > 0 Then
		      Dim seek As Integer = endPos - 1
		      p = p.Left(endPos - 1) + p.Mid(endPos + 1)
		      While seek > 0 And IsSpace(p.Mid(seek, 1))
		        seek = seek - 1
		      Wend
		      p = p.Left(seek + 1)
		    End If
		    
		    While p <> "" And IsSpace(p.Left(1))
		      p = p.Mid(2)
		    Wend
		    
		    If parts = Nil Then
		      Dim s2() as string
		      parts = s2
		    End If
		    parts.Append(p)
		    nparts = nparts + 1
		    
		    If endPos > 0 Then
		      p = p.Mid(endPos + 1)
		    Else
		      p = ""
		    End If
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getdata() As string
		  return data
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getint() As integer
		  return data.ToInteger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getnparts() As integer
		  if parts.LastIndex = -1 then fillparts
		  return nparts
		  
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
		  if parts.LastIndex = 1 then fillparts()
		  for x as integer = 0 to nparts
		    if parts(x).Uppercase = entry.Uppercase then return 1
		  next
		  return 0
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
