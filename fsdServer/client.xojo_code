#tag Class
Protected Class client
	#tag Method, Flags = &h0
		Sub Constructor(i as string, where as server, cs as string, t as integer, reqrating as integer, rev as string, real as string, st as integer)
		  //ToDo add functionality
		  location = where
		  cid = StrUpr(i)
		  type = t
		  callsign = StrUpr(cs)
		  protocol = StrUpr(rev)
		  sector = ""
		  identflag = ""
		  facilitytype = 0
		  rating = reqrating
		  visualrange = 40
		  plan = nil
		  positionok = 0
		  altitude = 0
		  simtype = st
		  realname = StrUpr(real)
		  starttime = MTime()
		  alive = starttime
		  frequency = 0
		  transponder = 0
		  groundspeed=0
		  lat = 0
		  lon = 0 
		  
		  
		  clients.Add(self)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function distance(other as client) As double
		  if other = nil then
		    return -1 
		  end
		  if positionok = -1 or other.positionok = -1 then
		    return -1
		  end
		  return dist(lat,lon,other.lat,other.lon)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getrange() As Integer
		  if type=1 then //if client is pilot
		    if altitude<0 then
		      altitude = 0
		      Dim rv as double
		      Dim dalt as double = altitude
		      rv = (10+1.414*sqrt(altitude))
		      return Floor(rv)
		    end
		  end
		  Select case facilitytype
		  Case 0
		    return 40
		  Case 1
		    return 1500
		  Case 2
		    return 5
		  Case 3
		    return 5
		  Case 4
		    return 30
		  Case 5
		    return 100
		  case 6
		    return 400
		  Case 6
		    return 1500
		  Else
		    return 40
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handlefp(data() as String)
		  dim revision as integer
		  if plan<> nil then
		    revision = plan.revision + 1
		  else
		    revision = 0
		  end
		  plan = new flightplan(callsign,data(0),data(1),data(2).ToInteger, data(3), data(4).ToInteger, data(5).ToInteger,data(6),data(7),data(8).ToInteger,data(9).ToInteger,data(10).ToInteger,data(11).ToInteger,data(12),data(13),data(14))
		  plan.revision = revision
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setalive()
		  alive=MTime()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateatc(data() as string)
		  Dim newfreq as integer = data(0).ToInteger
		  frequency = newfreq
		  facilitytype = data(1).ToInteger
		  visualrange = data(2).ToInteger
		  lat = data(4).ToDouble
		  lon = data(5).ToDouble
		  altitude = data(6).ToDouble
		  setalive()
		  positionok = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updatepilot(data() as string)
		  Dim a,b,c,x,y,z as UInteger
		  transponder = data(2).ToInteger
		  identflag=StrUpr(data(0))
		  lat=data(4).ToDouble
		  lon=data(5).ToDouble
		  altitude = data(6).ToInteger
		  groundspeed = data(7).ToInteger
		  pbh = data(8).ToInteger
		  x = Bitwise.ShiftRight(Bitwise.BitAnd(pbh, &hFF800000), 22)
		  y = Bitwise.ShiftRight(Bitwise.BitAnd(pbh, &h003FF000), 12)
		  z = Bitwise.ShiftRight(Bitwise.BitAnd(pbh, &h00000FFC), 2)
		  flags = data(9).ToInteger
		  setalive
		  positionok = 1
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		alive As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		altitude As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		callsign As String
	#tag EndProperty

	#tag Property, Flags = &h0
		cid As String
	#tag EndProperty

	#tag Property, Flags = &h0
		facilitytype As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		flags As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		frequency As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		groundspeed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		identflag As String
	#tag EndProperty

	#tag Property, Flags = &h0
		lat As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		location As Server
	#tag EndProperty

	#tag Property, Flags = &h0
		lon As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		pbh As UInteger
	#tag EndProperty

	#tag Property, Flags = &h0
		plan As flightplan
	#tag EndProperty

	#tag Property, Flags = &h0
		positionok As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		protocol As String
	#tag EndProperty

	#tag Property, Flags = &h0
		rating As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		realname As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sector As String
	#tag EndProperty

	#tag Property, Flags = &h0
		simtype As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		starttime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		transponder As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		type As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		visualrange As Integer
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
			Name="altitude"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
			Name="cid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="facilitytype"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="flags"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="frequency"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="groundspeed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="identflag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="lat"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="pbh"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="positionok"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="protocol"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="rating"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="realname"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sector"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="simtype"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="transponder"
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
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="visualrange"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="alive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="starttime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
