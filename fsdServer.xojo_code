#tag Module
Protected Module fsdServer
	#tag Method, Flags = &h0
		Sub dist(lat1 as double, lon1 as double, lat2 as double, lon2 as double)
		  Dim dist, dlon as double
		  dlon = lon2-lon1
		  lat1 = lat1 * Pi/180.0
		  lat2 = lat2 * Pi/180.0
		  dlon=dlon*Pi/180.0
		  dist=(sin(lat1)*sin(lat2))+(cos(lat1)*cos(lat2)*cos(dlon))
		  if dist >1.0 then
		    dist=1.0
		  end
		  dist =ACos(dist)*60&180/pi
		  return dist
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initilize()
		  certificate.Initilize()
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = Pi, Type = Double, Dynamic = False, Default = \"3.1415926", Scope = Public
	#tag EndConstant


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
End Module
#tag EndModule
