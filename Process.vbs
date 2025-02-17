
On Error Resume Next

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set Shell = CreateObject("WScript.Shell")
Set objLogFile = objFSO.OpenTextFile("DDS.txt", 8, True)
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")

SysDir = Shell.ExpandEnvironmentStrings("%systemroot%") + "\System32\"
ExePath = Shell.ExpandEnvironmentStrings("%EXEPATH%")

objLogFile.Write ( vbCrLf _
   & "============== Running Processes ===============" _
   & vbCrLf _
   & VbCrlF )


For each Process in objWMIService.ExecQuery("Select * from Win32_Process")
   If LCase(Process.Name) = "svchost.exe" Then
      If Process.CommandLine <> "0" Then
         objLogFile.Write Process.CommandLine & vbCrLf
      Else objLogFile.Write Process.Name  & vbCrLf
      End If
          
   ElseIf Process.ExecutablePath <> "0" Then
      If LCase(Process.Name) <> "PEV.DAT" _
         and InStr(1, Process.ExecutablePath, ExePath , 1) = 0 _
         and InStr(1, Process.ExecutablePath, SysDir +"cmd.exe" , 1) = 0 _
         and InStr(1, Process.ExecutablePath, SysDir +"smss.exe" , 1) = 0 _
         and InStr(1, Process.ExecutablePath, SysDir +"lsass.exe" , 1) = 0 _
         and InStr(1, Process.ExecutablePath, SysDir +"services.exe" , 1) = 0 _
         and InStr(1, Process.ExecutablePath, SysDir +"winlogon.exe" , 1) = 0 _
         and InStr(1, Process.ExecutablePath, ExePath  , 1) = 0 _
         and InStr(1, Process.ExecutablePath, SysDir +"csrss.exe" , 1) = 0 Then
         
             If objFSO.FileExists("Vista.krl") Then
                 If InStr(1, Process.ExecutablePath, SysDir +"wininit.exe" , 1) = 0 _
                 and InStr(1, Process.ExecutablePath, SysDir +"dllhost.exe" , 1) = 0 _
                 and InStr(1, Process.ExecutablePath, SysDir +"conhost.exe" , 1) = 0 Then
                     objLogFile.Write Process.ExecutablePath & vbCrLf
                 End If
            Else objLogFile.Write Process.ExecutablePath & vbCrLf   
            End If
       End If
      
   ElseIf LCase(Process.Name) = "System" or LCase(Process.Name) = "System Idle Process" Then
      objLogFile.Write Process.Name & vbCrLf
   End If
   
Next
objLogFile.Close


