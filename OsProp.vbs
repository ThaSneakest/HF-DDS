On Error Resume Next

Set dtmConvertedDate = CreateObject("WbemScripting.SWbemDateTime")
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objLogFile = objFSO.OpenTextFile("Attach.txt", 2, True)



objLogFile.Write ( vbCrLf _
   & "UNLESS SPECIFICALLY INSTRUCTED, DO NOT POST THIS LOG." & vbCrLf _
   & "IF REQUESTED, ZIP IT UP & ATTACH IT" & vbCrLf _
   & vbCrLf _
   & "DDS (Ver_2012-11-20.01)" & vbCrLf _
   & vbCrLf  )



For Each os in objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
   dtmConvertedDate.Value = os.InstallDate
   dtmInstallDate = dtmConvertedDate.GetVarDate
   
   dtmBootup = os.LastBootUpTime
   dtmConvertedDate.Value = os.LastBootUpTime
   dtmLastBootupTime = dtmConvertedDate.GetVarDate
   
   dtmSystemUptime = DateDiff("h", dtmLastBootUpTime, Now)
   objLogFile.Write ( os.Caption & vbCrLf _
      & "Boot Device: " & os.BootDevice & vbCrLf _
      & "Install Date: " & dtmInstallDate & vbCrLf _
      & "System Uptime: " & dtmLastBootupTime _
         & " (" & dtmSystemUptime & " hours ago)" _ 
      & vbCrLf )
Next



For Each Mobo in objWMIService.ExecQuery("Select * from Win32_BaseBoard")
   objLogFile.Write ( vbCrLf _
      & "Motherboard: " & Mobo.Manufacturer & " | " _
         & Mobo.Model & " | " _
         & Mobo.Product _
         & vbCrLf )
Next



For Each Processor in objWMIService.ExecQuery("Select * from Win32_Processor")
   objLogFile.Write ( "Processor: " & Processor.Name & " | " _
      & Processor.SocketDesignation & " | " _
      & Processor.CurrentClockSpeed & "/" _
      & Processor.ExtClock & "mhz" _
      & vbCrLf )
Next





objLogFile.Write ( vbCrLf _
   & "==== Disk Partitions =========================" _
   & vbCrLf _
   & vbCrLf )


For Each disk in objWMIService.ExecQuery ("Select * from Win32_LogicalDisk")
   Select Case disk.DriveType
   Case 1
   objLogFile.Write disk.DeviceID _
      & " - No root directory. Drive type could not be determined." _
      & vbCrLf
   Case 2
   objLogFile.Write disk.DeviceID _
      & " is Removable" _
      & vbCrLf
   Case 3
   objLogFile.Write disk.DeviceID _
      & " is FIXED (" & disk.FileSystem & ") - " _
      & Round(disk.Size/1073741824 ,0) & " GiB total, " _
      & Round(disk.FreeSpace/1073741824 ,3) & " GiB free." _
      & vbCrLf
   Case 4
   objLogFile.Write disk.DeviceID _
      & " is NetworkDisk (" & disk.FileSystem & ") - " _
      & Round(disk.Size/1073741824 ,0) & " GiB total, " _
      & Round(disk.FreeSpace/1073741824 ,3) & " GiB free." _
      & vbCrLf
   Case 5
   objLogFile.Write disk.DeviceID _
      & " is CDROM (" & disk.FileSystem & ")" _
      & vbCrLf
   Case 6
   objLogFile.Write disk.DeviceID _
      & vbTab &  "RAMDisk" & vbTab & disk.FileSystem & vbTab  _
      & Round(disk.Size/1073741824 ,0) & " GiB total, " _
      & Round(disk.FreeSpace/1073741824 ,3) & " GiB free." _
      & vbCrLf
   Case Else
   objLogFile.Write disk.DeviceID & " is UNKNOWN" _
      & vbCrLf
End Select
Next




objLogFile.Write ( vbCrLf _
   & "==== Disabled Device Manager Items =============" _
   & vbCrLf )


Set colDevMgr = objWMIService.ExecQuery _
   ("Select * from Win32_PnPEntity " & "WHERE ConfigManagerErrorCode <> 0")

For Each device in colDevMgr
   objLogFile.Write ( vbCrLf _
      & "Class GUID: " & device.ClassGuid & vbCrLf _
      & "Description: " & device.Description & vbCrLf _
      & "Device ID: " & device.DeviceID & vbCrLf _
      & "Manufacturer: " & device.Manufacturer & vbCrLf _
      & "Name: " & device.Name & vbCrLf _
      & "PNP Device ID: " & device.PNPDeviceID & vbCrLf _
      & "Service: " & device.Service _
      & vbCrLf )
Next




objLogFile.Write ( vbCrLf _
   & "==== System Restore Points ===================" & vbCrLf _
   & vbCrLf )


Set colSR = GetObject("winmgmts:root/default").InstancesOf ("SystemRestore")

If colSR.Count = 0 Then
   objLogFile.Write ("No restore point in system." _
      & vbCrLf )
Else
   For Each RP in colSR
      dtmConvertedDate.Value = RP.CreationTime
      dtmCreationTime = dtmConvertedDate.GetVarDate
      objLogFile.Write ( "RP" _
         & RP.SequenceNumber _
         & ": " & dtmCreationTime _
         & " - " & RP.Description _
         & vbCrLf )
   Next
End If


objLogFile.Close




Set objLogFile = objFSO.OpenTextFile("Event.txt", 2, True)
DateToCheck = Date - 7
dtmConvertedDate.SetVarDate DateToCheck, True


Set colEvent = objWMIService.ExecQuery ("Select * from Win32_NTLogEvent " _
   & "Where Logfile = 'System' " _
   & " and TimeWritten >= '" & dtmConvertedDate & "'" _
   & " and Type = 'error'" _
   & " and EventCode <> '7'" _
   & " and EventCode <> '16'" _
   & " and EventCode <> '29'" _
   & " and EventCode <> '54'" _
   & " and EventCode <> '1000'" _
   & " and EventCode <> '10010'" _
   & " and EventCode <> '15016'" _
   & " and EventCode <> '8032'" )


For Each obj in colEvent
   dtmConvertedDate.Value = obj.TimeWritten
   dtmTimeWritten = dtmConvertedDate.GetVarDate
   objLogFile.Write ( dtmTimeWritten & ", " _
      & obj.Type & ": " _
      & obj.SourceName _
      & " [" & obj.EventCode & "] " & " - " _
      & obj.Message  _
      & vbCrLf )
Next


Set colEvent = objWMIService.ExecQuery ("Select * from Win32_NTLogEvent " _
   & "Where Logfile = 'System' " _
   & " and TimeWritten >= '" & dtmConvertedDate & "'" _
   & " and SourceName = 'Windows File Protection'" )

For Each obj in colEvent
   dtmConvertedDate.Value = obj.TimeWritten
   dtmTimeWritten = dtmConvertedDate.GetVarDate
   objLogFile.Write ( dtmTimeWritten & ", " _
      & obj.Type & ": " _
      & obj.SourceName _
      & " [" & obj.EventCode & "] " _
      & " - " & obj.Message _
      & vbCrLf )
Next
objLogFile.Close

Wscript.Quit
