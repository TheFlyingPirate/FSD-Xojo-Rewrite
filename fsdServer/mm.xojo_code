#tag Class
Protected Class mm
Inherits process
	#tag Method, Flags = &h0
		Sub addq(dest as String, metar as string, parsed as integer, fd as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub buildlist()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub check()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkmetarfile()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub delq(p as mmq)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dodownload()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub doparse(qassmmq)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getline(line as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getvariation(num as integer, min as integer, max as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub prepareline(line as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub requestmetar(client as string, metar as string, parsed as string, fd as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setupnewfile()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub startdownload()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub stopdownload()
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		
		Metar Manager
	#tag EndNote


	#tag Property, Flags = &h0
		datareadsock As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		datasock As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		downloading As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ftpemail As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ioin As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		ioout As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		metardir As string
	#tag EndProperty

	#tag Property, Flags = &h0
		metarfiletime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		metarhost As string
	#tag EndProperty

	#tag Property, Flags = &h0
		metarsize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		newfileready As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		nstations As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		passivemode As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevdownload As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevhour As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		sock As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		sockrecvbuffer As string
	#tag EndProperty

	#tag Property, Flags = &h0
		sockrecvbufferlen As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		source As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		stationlist() As station
	#tag EndProperty

	#tag Property, Flags = &h0
		variation() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varprev As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varstations As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		vartotal As Integer
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
