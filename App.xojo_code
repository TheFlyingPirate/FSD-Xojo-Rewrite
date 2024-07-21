#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  fsdServer.Initilize()
		  Dim sv as new fsdServer.server("1","Main","127.0.0.1","1.0.0",1,"ll")
		  Dim cl as new fsdServer.client("12",sv,"AAL222",1,1,"1.0.0","Sascha",11)
		  Dim ci as new fsdServer.clinterface(999,"mmm","Kkk")
		  Dim cu as new fsdServer.cluser(1,ci,"21",21,21)
		  cu.thisclient = cl
		  ci.sendap(cl,nil)
		  
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
