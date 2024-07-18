#tag Class
Protected Class flightplan
	#tag Method, Flags = &h0
		Sub Constructor(cs as string, type as string, aircraft as string, tascruise as integer, depairport as string, deptime as Integer, actdeptime as integer, alt as string, destairport as string, hrsenroute as integer, minenroute as integer, hrsfuel as integer, minfuel as integer, altairport as string, remarks as string, route as string)
		  self.callsign = cs
		  self.type = type
		  self.tascruise = tascruise
		  self.depairport = depairport
		  self.deptime = deptime
		  self.actualdeptime = actdeptime
		  self.alt = alt
		  self.destairport = destairport
		  self.hrsenroute = hrsenroute
		  self.minenroute = minenroute
		  self.hrsfuel = hrsfuel
		  self.minfuel = minfuel
		  self.remarks = remarks
		  self.route = route
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		actualdeptime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		aircraft As String
	#tag EndProperty

	#tag Property, Flags = &h0
		alt As String
	#tag EndProperty

	#tag Property, Flags = &h0
		altairport As String
	#tag EndProperty

	#tag Property, Flags = &h0
		callsign As String
	#tag EndProperty

	#tag Property, Flags = &h0
		depairport As String
	#tag EndProperty

	#tag Property, Flags = &h0
		deptime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		destairport As String
	#tag EndProperty

	#tag Property, Flags = &h0
		hrsenroute As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		hrsfuel As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		minenroute As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		minfuel As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		remarks As String
	#tag EndProperty

	#tag Property, Flags = &h0
		revision As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		route As String
	#tag EndProperty

	#tag Property, Flags = &h0
		tascruise As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		type As String
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
			Name="callsign"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="actualdeptime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="aircraft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="alt"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="altairport"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="depairport"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="deptime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="destairport"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hrsenroute"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hrsfuel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="minenroute"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="minfuel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="remarks"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="revision"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="route"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="tascruise"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
