#tag Class
Protected Class manage
	#tag Method, Flags = &h0
		Function addvar(name as string, type as integer) As integer
		  
		  Dim num As Integer = -1
		  
		  For x as integer = 0 To nvars - 1
		    If variables(x).name = "" Then
		      num = x
		      Exit For
		    End If
		  Next
		  
		  If num = -1 Then
		    num = nvars
		    nvars = nvars + 1
		  End If
		  
		  Dim mv as new ManageVar()
		  mv.name = name
		  mv.type = type
		  variables.add(mv)
		  
		  Return num
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  nvars = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub decvar(num as integer)
		  variables(num).value = variables(num).value-1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub delvar(num as integer)
		  variables.RemoveAt(num)
		  nvars = nvars-1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getnvars() As integer
		  return nvars
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getvar(num as integer) As managevar
		  return variables(num)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getvarnum(name as String) As Integer
		  for each v as managevar in variables
		    if v.name = name then return variables.IndexOf(v)
		  next
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub incvar(num as integer)
		  variables(num).value = variables(num).value+1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setvar(num as integer, val as integer)
		  variables(num).value = val
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setvar(num as integer, val as string)
		  variables(num).value = val
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sprintvalue(num as integer, buf as string) As String
		  If num >= nvars Or variables(num).name = "" Then Return ""
		  
		  Select Case variables(num).type
		  Case ATT_VARCHAR
		    buf = Chr(34) + variables(num).value.StringValue  + Chr(34) ' Chr(34) is the double-quote character
		  Case ATT_INT
		    buf = Str(variables(num).value.IntegerValue)
		  Case ATT_DATE
		    buf = variables(num).value.IntegerValue.ToString
		    buf = buf.Left(buf.Len - 1) ' Remove the newline character
		  End Select
		  
		  Return buf
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		nvars As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		variables() As managevar
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
