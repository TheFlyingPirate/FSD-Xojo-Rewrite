#tag Class
Protected Class sysuser
Inherits fsdServer.absuser
	#tag Method, Flags = &h0
		Sub Constructor(fd As Integer, parent As SysInterface, peer As String, portnum As Integer, g As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoParse(s As String)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoSet(profile As WProfile, s As String, code As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecCert(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecClients(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecConnect(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecDelGuard(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecDisconnect(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecDistance(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecDump(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecHelp(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecKill(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecLog(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecMetar(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecPing(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecPos(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecPwd(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecRange(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecRefMetar(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecRoute(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecSay(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecServers(args() As String, count As Integer, flag As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecTime(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecWall(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecWeather(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecWp(args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Information()
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub List(s As String)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Parse(s As String)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrintMetar(wp As String, w As String)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrintWeather(w as wprofile)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RunCmd(code As Integer, args() As String, count As Integer)
		  // Implementation here
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Usage(code As Integer, s As String)
		  // Implementation here
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Authorized As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Lat As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Lon As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Parent As SysInterface
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="fd"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="killFlag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="inSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="outSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="feed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="feedCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="guardFlag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="outBufSoftLimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastPing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevFeedCheck"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="timeout"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="blocked"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="peer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="port"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="inBuf"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="outBuf"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="Authorized"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Lat"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Lon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
