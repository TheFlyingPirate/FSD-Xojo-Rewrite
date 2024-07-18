#tag Class
Protected Class certificate
	#tag Method, Flags = &h0
		Sub configure(pwd as string, l as integer, c as Integer, o as string)
		  level=l
		  password=StrUpr(pwd)
		  origin=StrUpr(o)
		  creationTime=c
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
			EditorType="MultiLineEditor"
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
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="password"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="creationTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevVisit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
