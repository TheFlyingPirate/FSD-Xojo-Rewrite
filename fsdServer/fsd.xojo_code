#tag Class
Protected Class fsd
	#tag Method, Flags = &h0
		Sub configmyserver()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub configure()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(configfile as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub createinterfaces()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub createmanagevars()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dochecks()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handlecidline(line as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub initdb()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeconnections()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub readcert()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub run()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		cerfilestat As datetime
	#tag EndProperty

	#tag Property, Flags = &h0
		certfile As string
	#tag EndProperty

	#tag Property, Flags = &h0
		clientport As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		fileopen As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		pmanager As pman
	#tag EndProperty

	#tag Property, Flags = &h0
		prevcertcheck As datetime
	#tag EndProperty

	#tag Property, Flags = &h0
		prevlagcheck As datetime
	#tag EndProperty

	#tag Property, Flags = &h0
		prevnotify As datetime
	#tag EndProperty

	#tag Property, Flags = &h0
		prevwhazzup As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		serverport As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		systemport As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		timer As datetime
	#tag EndProperty

	#tag Property, Flags = &h0
		whazzupfile As string
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
