#tag Class
Protected Class clinterface
Inherits fsdServer.tcpinterface
	#tag Method, Flags = &h0
		Function calcrange(from as client, toc as client, type as fsdserver.cl, range as integer) As Integer
		  Dim x,y as integer
		  Select Case type
		  case CL.PILOTPOS
		    return range
		  case CL.ATCPOS
		    if toc.type = CLIENT_ATC then
		      return toc.visualrange
		    end
		    x=toc.getrange()
		    y=from.getrange()
		    if from.type = CLIENT_PILOT then //CLIENT PILOT
		      return x +y
		    end
		    if x>y then
		      return x
		    end
		    return y
		  else
		    return range
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(port as integer, code as string, descr as string)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(port, code, descr)
		  prevwinddelta=MTime()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getbroad(s as string) As Integer
		  Dim broad as integer = CLIENT_ALL
		  if s = "*P" then
		    broad = CLIENT_PILOT
		  elseif s="*A" then
		    broad = CLIENT_ATC
		  end
		  return broad
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handlekill(who as client, reason as string)
		  if who.location<>myserver then
		    return
		  end
		  
		  for each u as absuser in users
		    if u isa cluser then
		      Dim tcl as cluser = cluser(u)
		      if tcl.thisclient = who then
		        Dim buf as string = sprintf("SERVER:%s:%s",who.callsign,reason)
		        sendpacket(who,NIL,NIL,CLIENT_ALL,-1,CL.KILL,buf)
		        u.Kill(KILL.KILL)
		      end
		    end
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newuser(fd as integer, peername as string, portnum as integer, g as integer)
		  insertuser(new cluser(fd,self,peername,portnum,g))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As Integer
		  Dim busy as integer = super.run()
		  if MTime()-prevwinddelta>WINDDELTATIMEOUT then
		    prevwinddelta=MTime()
		    sendwinddelta()
		  end
		  return busy
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendaa(who as client, ex as absuser)
		  Dim data as string
		  data = sprintf("%s:SERVER:%s:%s::%d",who.callsign,who.realname,who.cid,who.rating,who.protocol)
		  sendpacket(NIL,NIL,ex,CLIENT_ALL,-1,CL.ADDATC,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendap(who as client, ex as absuser)
		  Dim data as string
		  data = sprintf("%s:SERVER:%s::%d:%s:%d",who.callsign,who.cid,who.rating,who.protocol,who.simtype)
		  sendpacket(Nil,Nil,ex,CLIENT_ALL,-1,CL.ADDPILOT, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendatcpos(who as client, ex as absuser)
		  Dim data as string
		  data = sprintf("%s:%d:%d:%d:%d:%.5f:%.5f:%d",who.callsign,who.frequency,who.facilitytype,who.visualrange,who.rating,who.lat, who.lon, who.altitude)
		  sendpacket(Nil,who,ex,CLIENT_ALL,-1,CL.ATCPOS,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendda(who as client, ex as absuser)
		  Dim data as string
		  data = sprintf("%s:%s",who.callsign,who.cid)
		  sendpacket(NIL,NIL,ex,CLIENT_ALL,-1,CL.RMATC,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub senddp(who as client, ex as absuser)
		  Dim data as string
		  data = sprintf("%s:%s",who.callsign,who.cid)
		  sendpacket(NIL,NIL,ex,CLIENT_ALL,-1,CL.RMPILOT,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendgeneric(toc as string, dest as client, ex as absuser, source as client, from as string, s as string, cmd as CL)
		  Dim data as string
		  Dim range as integer = -1
		  data = sprintf("%s:%s:%s",from,toc,s)
		  if toc.Left(1) = "@" and source<>Nil then
		    range = source.getrange()
		  end
		  sendpacket(dest,source,ex,getbroad(toc),range,cmd,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendmetar(who as client, data as string)
		  sendpacket(who,NIL,NIL,CLIENT_ALL,-1,CL.REPACARS,sprintf("server:%s:METAR:%s",who.callsign,data))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendnowx(who as client, station as string)
		  for each temp as absuser in users
		    if temp isa cluser then
		      Dim ctemp as cluser = cluser(temp)
		      if ctemp.thisclient = who then
		        Dim errC as integer= ctemp.showerror(ERR.NOWEATHER,station)
		        exit
		      end
		    end
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpacket(dest as client, source as client, exclude as absuser, broad as integer, range as integer, cmd as fsdServer.cl, data as string)
		  if dest <> nil then
		    if dest.location <> myserver then
		      return
		    end
		  end
		  for each tmp as absuser in users
		    if tmp.killFlag = 0 then
		      if tmp isa cluser then
		        Dim c as client = cluser(tmp).thisclient
		        if c = nil then
		          continue
		        end
		        if exclude = tmp then
		          continue
		        end
		        if dest<>nil and c<>dest then
		          continue
		        end
		        if c.type=0 and broad = 0 then
		          continue
		        end
		        if source<>nil and (range<>-1 or cmd=cl.PILOTPOS or cmd=cl.ATCPOS) then
		          Dim checkrange as integer = calcrange(source,c,cmd,range)
		          Dim distance as double = c.distance(source)
		          if distance <>-1 or distance >checkrange then
		            continue
		          end
		        end
		        Dim sendp as integer = 0
		        if cmd=cl.ATCPOS or cmd = cl.PILOTPOS then
		          sendp=1
		        end
		        
		        
		        tmp.USLPrintf("%s%s\r\n",1,clcmdnames(cmd),data)
		      end
		    end
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpilotpos(who as client, ex as absuser)
		  dim data as string
		  data = sprintf("%s:%s:%d:%d:%.5f:%.5f:%d:%d:%u:%d",who.identflag,who.callsign,who.transponder,who.rating,who.lat,who.lon,who.altitude,who.groundspeed,who.pbh,who.flags)
		  sendpacket(NIL,who,ex,CLIENT_ALL, -1,CL.PILOTPOS,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendplan(dest as client, who as client, range as integer)
		  Dim data as string
		  Dim cs as string = "*A"
		  if dest <> Nil then
		    cs = dest.callsign
		  end
		  Dim plan as flightplan = who.plan
		  data = sprintf("%s:%s:%c:%s:%d:%s:%d:%d:%s:%s:%d:%d:%d:%d:%s:%s:%s",who.callsign,cs,plan.type,plan.aircraft,plan.tascruise,plan.depairport,plan.deptime,plan.actualdeptime,plan.alt,plan.destairport,plan.hrsenroute,plan.minenroute,plan.hrsfuel,plan.minfuel,plan.altairport,plan.remarks,plan.route)
		  sendpacket(dest,nil,nil,CLIENT_ATC, range, cl.PLAN,data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendweather(who as client, p as wprofile)
		  Dim buf as string
		  Dim part as string
		  p.fix(who.lat,who.lon)
		  buf = sprintf("%s:%s","server",who.callsign)
		  for x as integer = 0 to 3
		    Dim l as templayer = p.Temps(x)
		    part= sprintf(":%d:%d",l.ceiling,l.temp)
		    buf = buf + part
		  next
		  part = sprintf(":%d",p.Barometer)
		  buf=buf+part
		  sendpacket(who,nil,nil,CLIENT_ALL,-1,cl.TEMPDATA,buf)
		  buf = sprintf("%s:%s","server",who.callsign)
		  for x as integer = 0 to 3
		    Dim l as windlayer = p.Winds(x)
		    part = sprintf(":%d:%d:%d:%d:%d:%d",l.ceiling,l.floor,l.direction,l.speed,l.gusting,l.turbulence)
		    buf = buf + part
		  next
		  sendpacket(who,Nil,Nil,CLIENT_ALL,-1,cl.WINDDATA,buf)
		  buf = sprintf("%s:%s","server",who.callsign)
		  for x as integer = 0 to 2
		    Dim c as cloudlayer
		    if x=2 then
		      c = p.TStorm
		    else
		      c=p.Clouds(x)
		    end
		    part=Sprintf(":%d:%d:%d:%d:%d",c.ceiling,c.floor,c.coverage,c.icing,c.turbulence)
		    buf=buf+part
		  next
		  part=Sprintf(":%.2f",p.Visibility)
		  buf = buf+part
		  sendpacket(who,nil,nil,CLIENT_ALL,-1,cl.CLOUDDATA,buf)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendwinddelta()
		  Dim buf as string
		  Dim speed as integer = (MRand() mod 11) -5
		  Dim direction as integer = (MRand() mod 21) - 10
		  buf =Sprintf("SERVER:*:%d:%d",speed,direction)
		  sendpacket(Nil,nil,nil,CLIENT_ALL,-1,cl.WDELTA,buf)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private prevwinddelta As Integer
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
