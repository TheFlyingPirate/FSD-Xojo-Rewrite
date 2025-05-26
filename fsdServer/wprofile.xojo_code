#tag Class
Protected Class wprofile
	#tag Method, Flags = &h0
		Sub Activate()
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(name As String, creation As DateTime, origin As String)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Fix(lat As Double, lon As Double)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FixVisibility()
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GenRawCode()
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSeason(lat As Double) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadArray(s() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseAlt(s() As String, count As Integer) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ParseMetar(s() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseRvr(s() As String, count As Integer) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseSky(s() As String, count As Integer) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseTemp(s() As String, count As Integer) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseVis(s() As String, count As Integer) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseWind(s() As String, count As Integer) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseWx(s() As String, count As Integer) As Integer
		  // Implementation here
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Print() As string
		  // Implementation here
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Print(data As String) As string
		  // Implementation here
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Active As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Barometer As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Clouds() As cloudlayer
	#tag EndProperty

	#tag Property, Flags = &h0
		Creation As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		DewPoint As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Origin As String
	#tag EndProperty

	#tag Property, Flags = &h0
		RawCode As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Temps() As templayer
	#tag EndProperty

	#tag Property, Flags = &h0
		TStorm As Cloudlayer
	#tag EndProperty

	#tag Property, Flags = &h0
		Version As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Visibility As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Winds() As windlayer
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
			Name="Active"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Barometer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Creation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DewPoint"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Origin"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RawCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visibility"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
