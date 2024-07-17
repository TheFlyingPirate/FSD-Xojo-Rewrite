#tag Class
Protected Class certificate
	#tag Method, Flags = &h0
		Sub configure(pwd as string, l as integer, c as Integer, o as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(cid as string, password as string, level as integer, creationTime as Integer, origin as string)
		  self.cid = cid
		  self.password = password
		  self.level = level
		  if self.level > maxLevel then
		    self.Level = maxLevel
		  end
		  self.creationTime = creationTime
		  self.origin = origin
		  prevVisit = -1
		  Certificates.Add(self)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getCert(name as string) As Certificate
		  for each c as certificate in Certificates
		    if c.cid = name then
		      return c
		    end
		  next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Initilize()
		  certLevels.add("SUSPENDED")
		  certLevels.add("OBSPILOT")
		  certLevels.add("STUDENT1")
		  certLevels.add("STUDENT2")
		  certLevels.add("STUDENT3")
		  certLevels.add("CONTROLLER1")
		  certLevels.add("CONTROLLER2")
		  certLevels.add("CONTROLLER3")
		  certLevels.add("INSTRUCTOR1")
		  certLevels.add("INSTRUCTOR2")
		  certLevels.add("INSTRUCTOR3")
		  certLevels.add("SUPERVIOSR")
		  certLevels.add("ADMINISTRATOR")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Shared Certificates() As certificate
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			
			d
		#tag EndNote
		Shared certLevels() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		cid As String
	#tag EndProperty

	#tag Property, Flags = &h0
		creationTime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		level As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		liveCheck As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared maxLevel As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h0
		origin As String
	#tag EndProperty

	#tag Property, Flags = &h0
		password As String
	#tag EndProperty

	#tag Property, Flags = &h0
		prevVisit As Integer
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
			Name="cid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="level"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="liveCheck"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="origin"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="password"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
