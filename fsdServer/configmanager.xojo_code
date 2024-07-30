#tag Class
Protected Class configmanager
Inherits fsdServer.process
	#tag Method, Flags = &h0
		Sub Constructor(name as string)
		  filename = name.Uppercase
		  ngroups = 0
		  changed = 1
		  Dim fname as integer = manager.addvar("config.filename",ATT_VARCHAR)
		  manager.setvar(fname,name)
		  varaccess = manager.addvar("config.lastread",ATT_DATE)
		  parsefile()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function creategroup(name as String) As configgroup
		  groups.add(new configgroup(name))
		  return groups(groups.LastIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getgroup(name as string) As configgroup
		  for each cg as configgroup in groups
		    if cg.name = name then
		      return cg
		    end
		  next
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parsefile()
		  Dim line as string
		  Dim io as TextInputStream
		  Dim file as new FolderItem(filename)
		  Dim current as configgroup = nil
		  if not file.Exists then return
		  io=TextInputStream(file)
		  manager.setvar(varaccess,DateTime.Now.SecondsFrom1970)
		  while not io.EndOfFile
		    line = io.ReadLine.Trim()
		    if line = ""  or line.Left(1) = "#" then continue
		    if line.Left(1) = "[" then
		      Dim p as integer = line.IndexOf("]")
		      if p > - 1 then
		        line = line.left(p)
		        current = getgroup(line.Middle(1))
		        if current = nil then current = creategroup(line.Middle(1))
		      End If
		      Continue
		    End If
		    If current is nil then Continue
		    Dim sep as integer = line.IndexOf("=")
		    if sep > -1 then
		      Dim varName as string = line.left(sep).trim
		      Dim varvalue as string = line.Right(sep+1).trim
		      current.handleentry(varname,varvalue)
		      if current.changed = 1 then changed = 1
		    End if
		    
		  wend
		  io.Close
		  prevcheck= MTime()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As integer
		  if mtime-prevcheck<CONFIGINTERVAL then return 0
		  prevcheck = mtime()
		  Dim file as new FolderItem(filename)
		  if not file.Exists then return 0
		  Dim lastModified as Double = file.ModificationDateTime.SecondsFrom1970
		  if lastModified = lastmodify then return 0
		  lastmodify = lastmodified
		  ParseFile()
		  Return 0
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		changed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		filename As String
	#tag EndProperty

	#tag Property, Flags = &h0
		groups() As configgroup
	#tag EndProperty

	#tag Property, Flags = &h0
		lastmodify As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ngroups As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		prevcheck As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		varaccess As Integer
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
		#tag ViewProperty
			Name="filename"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ngroups"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="varaccess"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="changed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="prevcheck"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastmodify"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
