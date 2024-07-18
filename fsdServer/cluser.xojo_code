#tag Class
Protected Class cluser
Inherits fsdServer.absuser
	#tag Method, Flags = &h0
		Function callsignok(name as string, cid as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checklogin(id as string, password as string, req as integer) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checksource(from as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fd as integer, p as clinterface, pn as string, portnum as integer, gg as integer)
		  //ToDo Add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub doparse(s as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execaa(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execacars(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execap(s() as string, count as integer)
		  //ToDo add functionalityexecapexecap
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execatcpos(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execcq(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execd(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execfp(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execkill(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execmulticast(s() as string, count as integer, cnd as integer, nargs as integer, multiok as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execpilotpos(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub execweather(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getcomm(s as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parse(s() as string)
		  //ToDo Add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub readmotd()
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function showerror(num as integer, env as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		thisclient As client
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
