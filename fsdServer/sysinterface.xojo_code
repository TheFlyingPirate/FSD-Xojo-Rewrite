#tag Class
Protected Class sysinterface
Inherits fsdServer.tcpinterface
	#tag Method, Flags = &h0
		Sub Constructor(port as integer, code as string, descr as string)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(port, code, descr)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewUser(fd as integer, peer as string, portnum as integer, g as integer)
		   InsertUser(New fsdServer.sysuser(fd, Me, peer, portnum, g))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceiveMetar(fd As Integer, station As String, report As String)
		  ' Dispatch the METAR text to the correct sysuser
		  For Each u As fsdServer.absuser In fsdServer.users
		    If u.fd = fd Then
		      Dim st As fsdServer.sysuser = fsdServer.sysuser(u)
		      st.PrintMetar(station, report)
		      Exit
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceiveNowx(fd As Integer, st As String)
		  ' If fd = -2, we got a "no‐wx" for caching
		  If fd = -2 Then
		    Dim wp As New fsdServer.wprofile(stn, DateTime.Now, fsdServer.myserver.ident)
		    Return
		  End If
		  
		  ' Otherwise tell the sysuser there's no weather
		  For Each u As fsdServer.absuser In fsdServer.users
		    If u.fd = fd Then
		      u.UPrintf(EndOfLine + "No weather available for " + stn + "." + EndOfLine)
		      u.PrintPrompt()
		      Exit
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceivePong(from As String, data As String, pc As String, hops As String)
		  ' data is expected as "<fd> <timestamp>"
		  Dim parts() As String = data.Split(" ")
		  If parts.Ubound < 1 Then Return
		  
		  Dim fd As Integer = Val(parts(0))
		  Dim thenStamp As Int64 = Val(parts(1))
		  If fd = -1 Then Return
		  
		  ' Find the matching user by file descriptor
		  For Each u As fsdServer.absuser In fsdServer.users
		    If u.fd = fd Then
		      ' Show them the pong
		      Dim td as integer = mtime -thenStamp
		      u.UPrintf( _
		      EndOfLine + _
		      "PONG received from " + from + ": " + td.ToString + _
		      " seconds (" + pc + "," + hops + ")" + EndOfLine _
		      )
		      u.PrintPrompt()
		      Exit
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReceiveWeather(fd as Integer, w as WProfile)
		  ' If fd = -2 we are being forwarded a raw WProfile to cache
		  If fd = -2 Then
		    ' Decode the raw string into tokens
		    Dim tokens() As String = w.Print.ReplaceAll(EndOfLine, " ").Split(" ")
		    Dim count As Integer = tokens.Ubound + 1
		    ' Create and load a new profile
		    Dim wp As New fsdServer.wprofile(w.Name, DateTime.Now, fsdServer.myserver.ident)
		    wp.LoadArray(tokens, count)
		    Return
		  End If
		  
		  ' Otherwise find the user who requested it
		  For Each u As fsdServer.absuser In fsdServer.users
		    If u.fd = fd Then
		      Dim st As fsdServer.sysuser = fsdServer.sysuser(u)
		      ' fix visibility for that sysuser
		      w.Fix(st.Lat, st.Lon)
		      st.PrintWeather(w)
		      Exit
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Run() As Boolean
		  Return Super.Run()
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sock"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varcurrent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="vartotal"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varpeak"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="feedstrategy"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="floodlimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="outbuflimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevchecks"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prompt"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
