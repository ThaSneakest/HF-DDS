
On Error Resume Next

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set Shell = CreateObject("WScript.Shell")
Set objLogFile = objFSO.OpenTextFile("DDS.txt", 8, True)
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
Set oWMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\SecurityCenter")
Set oWMI2 = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\SecurityCenter2")

If objFSO.FileExists("attach.txt") then objFSO.DeleteFile("Attach.txt")



For each os in GetObject("winmgmts:").InstancesOf ("Win32_OperatingSystem")
   objLogFile.Write(os.Caption & "  " _
      & os.Version _
      & "." & os.ServicePackMajorVersion _
      & "." & os.CodeSet _
      & "." & os.CountryCode _
      & "." & os.OSLanguage _
      & "." & os.OSType _
      & "." & Round(os.TotalVisibleMemorySize/1024 ,0) _
      & "."  & Round(os.FreePhysicalMemory/1024 ,0) _
      &  " [GMT " & os.CurrentTimeZone/60 & ":" & right("00" & os.CurrentTimeZone mod 60, 2) & "]" _
      & vbCrLf  _
      & vbCrLf )
Next


If objFSO.FileExists("Vista.krl") Then
   For Each obj in oWMI2.ExecQuery("Select * from AntiVirusProduct")
       If InStr(2, Hex(obj.productState), "1", 0) = 2 Then enabled = " *Enabled" Else enabled = " *Disabled"
       If InStr(4, Hex(obj.productState), "0", 0) = 4 Then updated = "/Updated* " Else updated = "/Outdated* "
       objLogFile.Write("AV: " _
           & obj.displayName _
           & Enabled _
           & Updated _
           & obj.instanceGuid _
           & vbCrLf )
   Next
   For Each obj in oWMI2.ExecQuery("Select * from AntiSpywareProduct")
      If InStr(2, Hex(obj.productState), "1", 1) = 2 Then enabled = " *Enabled" Else enabled = " *Disabled"
       If InStr(4, Hex(obj.productState), "0", 1) = 4 Then updated = "/Updated* " Else updated = "/Outdated* "
       objLogFile.Write("SP: " _
           & obj.displayName _
           & Enabled _
           & Updated _
           & obj.instanceGuid _
           & vbCrLf )
   Next
   For Each obj in oWMI2.ExecQuery("Select * from FirewallProduct")
       If InStr(2, Hex(obj.productState), "1", 1) = 2 Then enabled = " *Enabled* " Else enabled = " *Disabled* "
       objLogFile.Write("FW: " _
           & obj.displayName _
           & Enabled _
           & obj.instanceGuid _
           & vbCrLf )
   Next
   
ELSE

   For Each obj in oWMI.ExecQuery("Select * from AntiVirusProduct")
       If obj.onAccessScanningEnabled = 0 Then enabled = " *Disabled" Else enabled = " *Enabled"
       If obj.productUptoDate = 0 Then updated = "/Outdated* " Else updated = "/Updated* "
       objLogFile.Write("AV: " _
           & obj.displayName _
           & enabled _
           & updated _
           & obj.InstanceGuid _
           & vbCrLf )
   Next
   For Each obj in oWMI.ExecQuery("Select * from AntiSpywareProduct")
       If obj.ProductEnabled = 0 Then enabled = " *Disabled" Else enabled = " *Enabled" 
       If obj.productUptoDate = 0 Then updated = "/Outdated* " Else updated = "/Updated* "
       objLogFile.Write("SP: " _
           & obj.displayName _
           & enabled _
           & updated _
           & obj.instanceGuid _
           & vbCrLf )
   Next
   For Each obj in oWMI.ExecQuery("Select * from FirewallProduct")
       If obj.Enabled = 0 Then enabled = " *Disabled* " Else enabled = " *Enabled* "
       objLogFile.Write("FW: " _
           & obj.displayName _
           & enabled _
           & objInstanceGuid _
           & vbCrLf )
   Next
   
END IF
objLogFile.Close


SysDir = Shell.ExpandEnvironmentStrings("%systemroot%") + "\System32\"

Set objLogFile = objFSO.OpenTextFile("StartUp", 2, True)
Set objFolder = objFSO.GetFolder(Shell.SpecialFolders("Startup"))
EnumStartup
Set objFolder = objFSO.GetFolder(Shell.SpecialFolders("AllUsersStartup"))
EnumStartup
objLogFile.Close



Set objLogFile = objFSO.OpenTextFile("svclist.dat", 2, True)
Set colSvcs = objWMIService.ExecQuery("Select * from " & "Win32_SystemDriver",,48 )
EnumSvc
Set colSvcs = objWMIService.ExecQuery("Select * from Win32_Service",,48)
EnumSvc
objLogFile.Close

Wscript.Quit


Sub EnumStartup
    Set colFiles = objFolder.Files
    For each File In colFiles
       Ext = objFSO.GetExtensionName(File)
       Name = objFSO.GetFileName(File)
       If LCase(Ext) = "lnk" Then
          Target = Shell.CreateShortcut(File).targetpath
          objLogFile.Write File.ShortPath & " - " & Target & vbCrLf
       ElseIf LCase(Name) <> "desktop.ini" Then
          objLogFile.Write File.Path & vbCrLf
       End If
    Next
ShowSubFolders
End Sub

Sub ShowSubFolders
   For each Subfolder in objFolder.SubFolders
      Set objFolder = objFSO.GetFolder(Subfolder.Path)
      EnumStartup
      ShowSubFolders Subfolder
   Next
End Sub


Sub EnumSvc
On Error Resume Next
For Each Svc in colSvcs
   Select Case Svc.State
      Case "Running" State = "R"
      Case "Stopped" State = "S"
      Case "Paused" State = "P"
      Case "Start Pending" State = "R?"
      Case "Stop Pending" State = "S?"
      Case "Continue Pending" State = "C?"
      Case "Pause Pending" State = "P?"
      Case Else  State = "Unknown"
   End Select
      Select Case Svc.StartMode
      Case "Disabled" StartMode = "4"
      Case "Manual" StartMode = "3"
      Case "Auto" StartMode = "2"
      Case "System" StartMode = "1"
      Case "Boot" StartMode = "0"
      Case Else StartMode = "Unknown"
   End Select
   If Svc.PathName <> "0" Then
      g = ""
      e = ""
      z = ""
      f = Svc.PathName
      z = Instr(1, f, Chr(34) + " ", 1)
      If z > "0" then f = Left(f, z)
      f = (Replace(f, Chr(34), vbNullString))
      f = (Replace(f,"\??\", vbNullString))
      If InStr(1, f, SysDir +"svchost.exe -k " , 1) <> 0 then f = Left(f, (Instr(1, f, " -k ", 1)))
      z = Instr(1, f, " /", 1)
      If z > "0" then f = Left(f, z)
      e = objfso.GetFile(f)
      If e > "0" Then
         g = DatePart("yyyy", objfso.GetFile(f).datecreated) _
            & "-" & DatePart("m", objfso.GetFile(f).datecreated) _
            & "-" & DatePart("d", objfso.GetFile(f).datecreated) _
            & " " & objfso.GetFile(f).size
         If g = "0" Then g = " [?]" Else g = " [" & g & "]"
         If InStr(1, e, SysDir +"svchost" , 1) <> 0 Then e = Svc.PathName
      Else
         e = Svc.PathName & " --> " & f
         g = " [?]"
      End If
      objLogFile.Write( State & StartMode & vbTab _
         & Svc.Name & ";" & Svc.DisplayName & ";" & e & g  & vbCrLF )
   ELSE objLogFile.Write( State & StartMode & vbTab _
      & Svc.Name & ";" & Svc.DisplayName & ";" & " [x]" & vbCrLF )
   END IF
Next
End Sub

