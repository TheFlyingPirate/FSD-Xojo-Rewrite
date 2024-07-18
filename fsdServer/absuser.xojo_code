#tag Class
Protected Class absuser
	#tag Method, Flags = &h0
		Sub Block()
		  blocked = 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CalcFeed()
		  // Implementation here
		  Dim now As Integer = mtime()
		  Dim elapsed As Integer = now - prevFeedCheck
		  Dim fact1 As Double = elapsed / 300.0
		  Dim fact2 As Double = 1.0 - fact1
		  Dim newFeed As Integer = feedCount / elapsed
		  
		  If feed = -1 Then
		    feed = newFeed
		  Else
		    feed = CType(newFeed * fact1 + feed * fact2, Integer)
		  End If
		  
		  feedCount = 0
		  prevFeedCheck = now
		  Dim bandwidth As Integer = feed
		  
		  If baseParent.FeedStrategy = FEED_BOTH Then
		    bandwidth = bandwidth / 2
		  End If
		  
		  If bandwidth > 50 Then
		    outBufSoftLimit = bandwidth * 30
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(d As Integer, p As TcpInterface, peername As String, portnum As Integer, g As Integer)
		  fd = d
		  killFlag = 0
		  inBuf = ""
		  outBuf = ""
		  inSize = 1
		  outSize = 1
		  blocked = 0
		  prompt = ""
		  feedCount = 0
		  feed = -1
		  baseParent = p
		  timeout = 0
		  peer = peername
		  port = portnum
		  prevFeedCheck = 0
		  guardFlag = g
		  outBufSoftLimit = -1
		  SetActive()
		  
		  // Add the user to the users() list
		  users.Append(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Input()
		  // Implementation here
		  inbuf = Socket.ReadAll()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Kill(reason As Integer)
		  killFlag = reason
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextLine(source As String, dest As String) As Integer
		  Const MAXLINELENGTH As Integer = 1024 ' Define this according to your needs
		  Dim len As Integer = source.IndexOf(Chr(13)) ' Find the first occurrence of '\r'
		  If len = -1 Then 
		    len = source.IndexOf(Chr(10))
		  end 
		  ' If '\r' not found, find '\n'
		  If len = -1 Then 
		    Return -1 ' No newline found
		    
		  end
		  ' Extract the line
		  dest = source.Left(len)
		  
		  ' Remove the line from the source
		  Dim where As Integer = len
		  While where < source.Length And (source.Mid(where, 1) = Chr(10) Or source.Mid(where, 1) = Chr(13))
		    where = where + 1
		  Wend
		  
		  source = source.Mid(where)
		  
		  ' Check if the line length exceeds MAXLINELENGTH
		  If dest.Length >= MAXLINELENGTH Then
		    dest = ""
		    Return -1
		  End If
		  
		  Return where
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Output()
		  Socket.Write(outBuf)
		  Socket.Flush()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Parse(s As String)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrintPrompt()
		  If prompt="" or killFlag > 0 or blocked > 0 then
		    return
		  end
		  UPrintf("%s",prompt)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Run() As Integer
		  // Implementation here
		  Dim buf as string
		  Dim count as integer = 0
		  Dim stat as integer
		  Dim ok as integer = 0 
		  if blocked <> 0 then
		    return 0
		  end
		  stat=NextLine(inBuf,buf)
		  while stat<>-1 and count + 1<60
		    count = count + 1
		    If baseParent.floodlimit<>-1 and feed > baseParent.floodlimit then
		      self.kill(CType(fsdServer.KILL.FLOOD,Int32))
		      exit while
		    end
		    Parse(buf)
		    ok = 1
		    if blocked>0 then
		      exit while
		    end
		    
		    
		    stat=NextLine(inBuf,buf)
		  wend
		  
		  
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Send(data As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendPing()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetActive()
		  lastActive = MTime()
		  lastping = lastActive
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetMasks(rmask As MemoryBlock, wmask As MemoryBlock)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetPrompt(prompt As String)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unblock()
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UPrintf(format As String, ParamArray args() As Variant)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub USLPrintf(format As String, code As Integer, ParamArray args() As Variant)
		  // Implementation here
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		baseParent As tcpinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		blocked As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		fd As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		feed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		feedCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		guardFlag As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		inBuf As String
	#tag EndProperty

	#tag Property, Flags = &h0
		inSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		killFlag As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		lastActive As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		lastPing As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		outBuf As String
	#tag EndProperty

	#tag Property, Flags = &h0
		outBufSoftLimit As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		outSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		peer As String
	#tag EndProperty

	#tag Property, Flags = &h0
		port As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevFeedCheck As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prompt As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Socket As TCPSocket
	#tag EndProperty

	#tag Property, Flags = &h0
		timeout As Integer
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
	#tag EndViewBehavior
End Class
#tag EndClass
