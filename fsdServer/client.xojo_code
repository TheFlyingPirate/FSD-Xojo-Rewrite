#tag Class
Protected Class client
	#tag Method, Flags = &h0
		Sub Constructor(i as string, where as server, cs as string, t as integer, reqrating as integer, rev as string, real as string, st as integer)
		  //ToDo add functionality
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
		Shared Function getclient(ident as string) As client
		  for each cl as client in clients
		    if cl.callsign = ident then
		      return cl
		    end
		  next
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getrange() As Integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handlefp(data() as String)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setalive()
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateatc(data() as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updatepilot(data() as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		alive As DateTime
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

	#tag Property, Flags = &h21
		Private Shared clients() As client
	#tag EndProperty

	#tag Property, Flags = &h0
		facilitytype As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		flags As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		flightplan As flightplan
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
		starttime As DateTime
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
			EditorType=""
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
			EditorType=""
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
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="sector"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
