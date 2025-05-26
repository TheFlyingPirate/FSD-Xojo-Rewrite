#tag Class
Protected Class pman
	#tag Method, Flags = &h0
		Sub Constructor()
		  busy = false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub registerprocess(what as process)
		  processes.add(what)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub run()
		  busy = false
		  for each p as Process in processes
		    if p.run then
		      busy = true
		    end
		  next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		busy As Boolean
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
			Name="busy"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
