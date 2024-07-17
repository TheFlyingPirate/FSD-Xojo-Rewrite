#tag Class
Protected Class cluser
Inherits absuser
	#tag Method, Flags = &h21
		Private Function callsignok(name as string, cid as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function checklogin(id as string, password as string, req as integer) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function checksource(from as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fd as integer, p as clinterface, pn as string, portnum as integer, gg as integer)
		  //ToDo Add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(u as user)
		  //ToDo Add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub doparse(s as string)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execaa(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execacars(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execap(s() as string, count as integer)
		  //ToDo add functionalityexecapexecap
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execatcpos(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execcq(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execd(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execfp(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execkill(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execmulticast(s() as string, count as integer, cnd as integer, nargs as integer, multiok as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execpilotpos(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub execweather(s() as string, count as integer)
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getcomm(s as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parse(s() as string)
		  //ToDo Add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub readmotd()
		  //ToDo add functionality
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function showerror(num as integer, env as string) As integer
		  //ToDo add functionality
		End Function
	#tag EndMethod


End Class
#tag EndClass
