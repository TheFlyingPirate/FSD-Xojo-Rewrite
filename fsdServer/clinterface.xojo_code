#tag Class
Protected Class clinterface
	#tag Method, Flags = &h0
		Function calcrange(from as client, to as client, type as integer, range as integer) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getbroad(s as string) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub handlekill(who as client, reason as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendaa(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendap(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendatcpos(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendda(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub senddp(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendgeneric(to as string, dest as client, ex as absuser, source as client, from as string, s as string, cmd as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendmetar(who as client, d as data)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendnowx(who as client, station as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpacket(dest as client, source as clientexclude as absuser, broad as integer, range as integer, cmd as integer, data as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendpilotpos(who as client, ex as absuser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendplan(dest as client, who as client, range as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendweather(who as client, p as wprofile)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendwinddelta()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private prevwinddelta As DateTime
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
