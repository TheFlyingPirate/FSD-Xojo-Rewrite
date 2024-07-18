#tag Module
Protected Module fsdServer
	#tag Method, Flags = &h0
		Sub AddFile(ParamArray args() As Variant)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BreakArgs(args As String, parts() As String, maxParts As Integer) As Integer
		  // Implementation here
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BreakPacket(packet As String, parts() As String, maxParts As Integer) As Integer
		  // Implementation here
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CatArgs(args() As String, count As Integer, separator As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CatCommand(commands() As String, count As Integer, separator As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGets(s As String, size As Integer) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DBLog(msg As String, level As Integer)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function dist(lat1 as double, lon1 as double, lat2 as double, lon2 as double) As double
		  Dim dist, dlon as double
		  dlon = lon2-lon1
		  lat1 = lat1 * M_PI/180.0
		  lat2 = lat2 * M_PI/180.0
		  dlon=dlon*M_PI/180.0
		  dist=(sin(lat1)*sin(lat2))+(cos(lat1)*cos(lat2)*cos(dlon))
		  if dist >1.0 then
		    dist=1.0
		  end
		  dist = ACos(dist)*60*180/M_PI
		  return dist
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoLog(level As Integer, ParamArray args() As Variant)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FindHostname(ip As UInt32, hostname As String)
		  // Implementation here
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindItem(what As String, buf As String) As Integer
		  // Implementation here
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findsection(section as String) As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCert(name as string) As Certificate
		  for each c as certificate in Certificates
		    if c.cid = name then
		      return c
		    end
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getwprofile(name as String) As wprofile
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initilize()
		  certLevels.add("SUSPENDED")
		  certLevels.add("OBSPILOT")
		  certLevels.add("STUDENT1")
		  certLevels.add("STUDENT2")
		  certLevels.add("STUDENT3")
		  certLevels.add("CONTROLLER1")
		  certLevels.add("CONTROLLER2")
		  certLevels.add("CONTROLLER3")
		  certLevels.add("INSTRUCTOR1")
		  certLevels.add("INSTRUCTOR2")
		  certLevels.add("INSTRUCTOR3")
		  certLevels.add("SUPERVIOSR")
		  certLevels.add("ADMINISTRATOR")
		  
		  cmdNames.add("NOTIFY")
		  cmdnames.add("REQMETAR")
		  cmdnames.add("PING")
		  cmdnames.add("PONG")
		  cmdnames.add("SYNC")
		  cmdnames.add("LINKDOWN")
		  cmdnames.add("NOWX")
		  cmdnames.add("ADDCLIENT")
		  cmdnames.add("RMCLIENT")
		  cmdnames.add("PLAN")
		  cmdnames.add("PD")
		  cmdnames.add("AD")
		  cmdnames.add("ADDCERT")
		  cmdnames.add("MC")
		  cmdnames.add("WX")
		  cmdnames.add("METAR")
		  cmdnames.add("AWPROF")
		  cmdnames.add("DWPROF")
		  cmdnames.add("KILL")
		  cmdnames.add("RESET")
		  
		  silentok.Add(1) // Notify
		  silentok.Add(1) // ReqMetar
		  silentok.Add(1) // Ping
		  silentok.Add(1) // Pong
		  silentok.Add(1) // Sync
		  silentok.Add(1) // LinkDown
		  silentok.Add(1) // NoWx
		  silentok.Add(1) // AddClient
		  silentok.Add(1) // RmClient
		  silentok.Add(1) // Plan
		  silentok.Add(0) // PD
		  silentok.Add(0) // AD
		  silentok.Add(1) // AddCert
		  silentok.Add(0) // MC
		  silentok.Add(1) // WX
		  silentok.Add(1) // Metar
		  silentok.Add(1) // Add W Profile
		  silentok.Add(1) // Del W Profile
		  silentok.Add(1) // Kill Client
		  silentok.Add(1) // Reset
		  silentok.Add(0) // End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MConnect(sock As Integer, addr As MemoryBlock, addrlen As Integer, timeout As Integer) As Integer
		  // Implementation here
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MGMTTime() As Integer
		  // Implementation here
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MRand() As Integer
		  // Implementation here
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MRound(value As Double) As Integer
		  // Implementation here
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MTime() As Integer
		  // Implementation here
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrintLoc(lat As Double, lon As Double, loc As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setconfigfile(name as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SnapPacket(packet As String, snap As String, size As Integer)
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SprintDate(now As Integer, buf As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SprintGMT(now As Integer, buf As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SprintGMTDate(now As Integer, buf As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SprintTime(now As Integer, buf As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartTimer()
		  // Implementation here
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StrUpr(s As String) As String
		  // Implementation here
		  Return ""
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Certificates() As certificate
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			
			d
		#tag EndNote
		certLevels() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		clcmdnames() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		clientinterface As clinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		cmdnames() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		configman As configmanager
	#tag EndProperty

	#tag Property, Flags = &h0
		errors() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		errstr As String
	#tag EndProperty

	#tag Property, Flags = &h0
		logp As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		manager As manage
	#tag EndProperty

	#tag Property, Flags = &h0
		maxLevel As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h0
		myserver As Server
	#tag EndProperty

	#tag Property, Flags = &h0
		nerrors As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		serverinterface As servinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		servers() As Server
	#tag EndProperty

	#tag Property, Flags = &h0
		silentok() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		systeminterface As sysinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		users() As absuser
	#tag EndProperty


	#tag Constant, Name = CALLSIGNBYTES, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CERTFILECHECK, Type = Double, Dynamic = False, Default = \"120", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CLIENTTIMEOUT, Type = Double, Dynamic = False, Default = \"800", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CONNECTDELAY, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FEED_BOTH, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FEED_IN, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FEED_OUT, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GUARDRETRY, Type = Double, Dynamic = False, Default = \"120", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LAGCHECK, Type = Double, Dynamic = False, Default = \"60", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_ADMINISTRATOR, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_CONTROLLER1, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_CONTROLLER2, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_CONTROLLER3, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_INSTRUCTOR1, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_INSTRUCTOR2, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_INSTRUCTOR3, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_MAX, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_OBSPILOT, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_STUDENT1, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_STUDENT2, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_STUDENT3, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_SUPERVISOR, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LEV_SUSPENDED, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LOGFILE, Type = String, Dynamic = False, Default = \"log.txt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MAXHOPS, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MAXLINELENGTH, Type = Double, Dynamic = False, Default = \"512", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MAXMETARDOWNLOADTIME, Type = Double, Dynamic = False, Default = \"900", Scope = Public
	#tag EndConstant

	#tag Constant, Name = METARFILE, Type = String, Dynamic = False, Default = \"metar.txt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = METARFILENEW, Type = String, Dynamic = False, Default = \"metarnew.txt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = M_PI, Type = Double, Dynamic = False, Default = \"3.14159265", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NEEDREVISION, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NOTIFYCHECK, Type = Double, Dynamic = False, Default = \"300", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PATH_FSD_CONF, Type = String, Dynamic = False, Default = \"fsd.conf", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PATH_FSD_HELP, Type = String, Dynamic = False, Default = \"help.txt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PATH_FSD_MOTD, Type = String, Dynamic = False, Default = \"motd.txt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PRODUCT, Type = String, Dynamic = False, Default = \"FSFDT Xojo Rewrite from FSD V3.000 draft 9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SERVERMAXTOOK, Type = Double, Dynamic = False, Default = \"240", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SERVERTIMEOUT, Type = Double, Dynamic = False, Default = \"800", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SILENTCLIENTTIMEOUT, Type = Double, Dynamic = False, Default = \"36000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SYNCTIMEOUT, Type = Double, Dynamic = False, Default = \"120", Scope = Public
	#tag EndConstant

	#tag Constant, Name = USERFEEDCHECK, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = USERPINGTIMEOUT, Type = Double, Dynamic = False, Default = \"200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = USERTIMEOUT, Type = Double, Dynamic = False, Default = \"500", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VAR_AMOUNT, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VERSION, Type = String, Dynamic = False, Default = \"V3.000 d9 Xojo", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WHAZZUPCHECK, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WINDDELTATIMEOUT, Type = Double, Dynamic = False, Default = \"70", Scope = Public
	#tag EndConstant


	#tag Structure, Name = cloudlayer, Flags = &h0
		ceiling as integer
		  floor as integer
		  icing as integer
		turbulence as integer
	#tag EndStructure

	#tag Structure, Name = loghis, Flags = &h0
		msg as string * 100
		level as integer
	#tag EndStructure

	#tag Structure, Name = mmq, Flags = &h0
		Destination as string *20
		  metarid as string * 10
		  fd as integer
		parsed as integer
	#tag EndStructure

	#tag Structure, Name = station, Flags = &h0
		name as string * 10
		location as integer
	#tag EndStructure

	#tag Structure, Name = templayer, Flags = &h0
		ceiling as integer
		temp as integer
	#tag EndStructure

	#tag Structure, Name = windlayer, Flags = &h0
		ceiling as integer
		  floor as integer
		  direction as integer
		  speed as integer
		  gusting as integer
		turbulence as integer
	#tag EndStructure


	#tag Enum, Name = CL, Type = Integer, Flags = &h0
		ADDATC
		  RMATC
		  ADDPILOT
		  RMPILOT
		  REQHANDOFF
		  MESSAGE
		  REQWEATHER
		  PILOTPOS
		  ATCPOS
		  PING
		  PONG
		  ACHANDOFF
		  PLAN
		  SB
		  PC
		  WEATHER
		  CLOUDDATA
		  WINDDATA
		  TEMPDATA
		  REQCOM
		  REPCOM
		  REQACARS
		  REPACARS
		  ERROR
		  CQ
		  CR
		  KILL
		WDELTA
	#tag EndEnum

	#tag Enum, Name = CMD, Type = Integer, Flags = &h0
		NOTIFY
		  REQMETAR
		  PING
		  PONG
		  SYNC
		  LINKDOWN
		  NOWX
		  ADDCLIENT
		  RMCLIENT
		  PLAN
		  PD
		  AD
		  CERT
		  MULTIC
		  WEATHER
		  METAR
		  ADDWPROF
		  DELWPROF
		  KILL
		RESET
	#tag EndEnum

	#tag Enum, Name = ERR, Type = Integer, Flags = &h0
		OK
		  CSINUSE
		  CSINVALID
		  REGISTERED
		  SYNTAX
		  SRCINVALID
		  CIDINVALID
		  NOSUCHCS
		  NOFP
		  NOWEATHER
		  REVISION
		  LEVEL
		  SERVFULL
		CSSUSPEND
	#tag EndEnum

	#tag Enum, Name = KILL, Type = Integer, Flags = &h0
		NONE
		  COMMAND
		  FLOOD
		  INITTIMEOUT
		  DATATIMEOUT
		  CLOSED
		  WRITEERR
		  KILL
		PROTOCOL
	#tag EndEnum

	#tag Enum, Name = SOURCE, Type = Integer, Flags = &h0
		SOURCE_NETWORK
		  SOURCE_FILE
		SOURCE_DOWNLOAD
	#tag EndEnum


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
			Name="errstr"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="maxLevel"
			Visible=false
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
