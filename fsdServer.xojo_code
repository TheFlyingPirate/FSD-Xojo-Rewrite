#tag Module
Protected Module fsdServer
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
		Sub Initilize()
		  certificate.Initilize()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		clientinterface As clinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		configman As configmanager
	#tag EndProperty

	#tag Property, Flags = &h0
		serverinterface As servinterface
	#tag EndProperty

	#tag Property, Flags = &h0
		systeminterface As sysinterface
	#tag EndProperty


	#tag Constant, Name = CALLSIGNBYTES, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CERTFILECHECK, Type = Double, Dynamic = False, Default = \"120", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CLIENTTIMEOUT, Type = Double, Dynamic = False, Default = \"800", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CONNECTDELAY, Type = Double, Dynamic = False, Default = \"20", Scope = Public
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

	#tag Constant, Name = VERSION, Type = String, Dynamic = False, Default = \"V3.000 d9 Xojo", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WHAZZUPCHECK, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WINDDELTATIMEOUT, Type = Double, Dynamic = False, Default = \"70", Scope = Public
	#tag EndConstant


	#tag Structure, Name = cloudlayer, Flags = &h0
	#tag EndStructure

	#tag Structure, Name = loghis, Flags = &h0
	#tag EndStructure

	#tag Structure, Name = managevar, Flags = &h0
	#tag EndStructure

	#tag Structure, Name = mmq, Flags = &h0
	#tag EndStructure

	#tag Structure, Name = station, Flags = &h0
	#tag EndStructure

	#tag Structure, Name = templayer, Flags = &h0
	#tag EndStructure

	#tag Structure, Name = windlayer, Flags = &h0
	#tag EndStructure


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
