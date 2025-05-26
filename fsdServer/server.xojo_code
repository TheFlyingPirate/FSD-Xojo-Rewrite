#tag Class
Protected Class server
	#tag Method, Flags = &h0
		Shared Sub ClearServerChecks()
		  For Each s As Server In Servers
		    s.Check = False
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub configure(n as string, e as string, h as string, v as string, l as string)
		  Name = n
		  email = e
		  hostname = h
		  version = v
		  location = l
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(i as string, n as string, e as string, h as string, v as string, fl as integer, l as string)
		  Ident = i
		  Name = n
		  Email = e
		  hostname = h
		  Version = v
		  Flags = fl
		  packetdrops = 0
		  Location = l
		  Path = Nil
		  Hops = -1
		  pcount = -1 
		  Lag = -1
		  Alive = MTime()
		  check = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getServer(id as String) As Server
		  For Each s As Server In Servers
		    If s.Ident.Lowercase = id.Lowercase Then Return s
		  Next
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub receivepong(data as string)
		  // expects "fd timestamp"
		  Dim parts() As String = data.Split(" ")
		  If parts.Ubound < 1 Then Return
		  Dim tstamp As Int64 = Val(parts(1))
		  Lag = MTime() - tstamp
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove()
		  // 1) log drop
		  dolog(L_ERR, "Dropping server " + Ident + "(" + Name + ")")
		  
		  // 2) remove from global array
		  For i As Integer = 0 To Servers.LastIndex
		    If Servers(i) = Self Then
		      Servers.RemoveAt(i)
		      Exit
		    End If
		  Next
		  
		  // 3) drop any clients tied to this server
		  //    You’ll need to implement Client.List and remove logic
		  For Each c As Client In clients
		    If c.Location = Me Then
		      clients.RemoveAt(clients.IndexOf(c))
		    End If
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setalive()
		  alive = MTime
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPath(who as absuser, hopcount as integer)
		  Path = who
		  hops=hopcount
		  if who = nil then
		    pcount= -1
		  end
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		alive As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		check As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		email As String
	#tag EndProperty

	#tag Property, Flags = &h0
		flags As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		hops As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		hostname As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ident As String
	#tag EndProperty

	#tag Property, Flags = &h0
		lag As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		location As String
	#tag EndProperty

	#tag Property, Flags = &h0
		name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		packetdrops As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		path As absuser
	#tag EndProperty

	#tag Property, Flags = &h0
		pcount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		version As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
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
			Name="pcount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hops"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="check"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lag"
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
			Name="packetdrops"
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
			Name="email"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ident"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hostname"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="location"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
