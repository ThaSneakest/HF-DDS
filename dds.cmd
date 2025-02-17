@ECHO OFF
PROMPT $
TITLE D.D.S.

@IF EXIST MISC\ GOTO :EOF
@IF /I "%~1" EQU "/SUPP" GOTO SUPP
IF NOT EXIST SETPATH_N.CMD GOTO :EOF

REM @IF NOT EXIST RunSilent.dat TYPE Screentxt


SET "WD=%CD%"
SET "PATH=%SystemRoot%\system32;%PATH%"
CALL SETPATH_N.CMD >NUL 2>&1

SET "ExecX=bak1|bak2|bat|cmd|com|dll|ini2|pif|reg|ren|scr|sys|vbs|vir|exe|bin|wsf|vbe|dat|zip|drv"
SET "ExecXB=%ExecX%|tmp"


REM CALL :ScrText


IF EXIST %SysDir%\CSCRIPT.EXE (
	SET "ScriptEngine_=%SysDir%\CSCRIPT.EXE"
) ELSE IF EXIST %SysDir%\WSCRIPT.EXE (
	SET "ScriptEngine_=%SysDir%\CSCRIPT.EXE"
) ELSE SET "ScriptEngine_=REM "

%ScriptEngine_% //NOLOGO //E:VBSCRIPT //B //T:15 osidDDS.vbs

IF EXIST Process.vbs (
	%ScriptEngine_% //NOLOGO //E:VBSCRIPT //B //T:15 Process.vbs
	ECHO.
	)


REM CALL :ScrText


@FINDSTR.EXE -LC:"= Running Processes =" DDS.txt >NUL 2>&1 ||(
	ECHO.>>DDS.txt
	ECHO.============== Running Processes ================>>DDS.txt
	ECHO.>>DDS.txt
	@(
	ECHO.%system%\svchost.exe
	ECHO.%system%\cmd.exe
	ECHO.%system%\lsass.exe
	ECHO.%system%\winlogon.exe
	ECHO.%system%\services.exe
	ECHO.%system%\csrss.exe
	ECHO.system32\smss.exe
	ECHO."%EXEPATH%"
	ECHO."%CD%"
	)>temp00

	SED.DAT "s/\x22//g" temp00 > temp01
	ECHO.::::::>>temp01
	PEV.DAT PLIST >ProcessList.txt
	FINDSTR.EXE -LIVG:temp01 ProcessList.txt >>DDS.txt
	PEV.DAT CLIST | FINDSTR.EXE -BLI "%system%\svchost.exe" >>DDS.txt
	DEL /A/F ProcessList.txt temp00 temp01
	)



:Last30
CALL :WhtDir
IF EXIST W6432.dat (
	SED.DAT -r "s/\x22//g; s/(.*)%system:\=\\%(.*)/&\n\1%SysDir:\=\\%\2/I; s/(.*)%programW6432:\=\\% \(x86\)(.*)/&\n\1%programW6432:\=\\%\2/I" WhiteDir00 >WhiteDir
	) ELSE SED.DAT "s/\x22//g" WhiteDir00 >WhiteDir
DEL WhiteDir00



@(
ECHO.%Systemroot:\=\\%\\\$ntuninstall[^^\\]*$
ECHO.%Systemroot:\=\\%\\\$ntservicepackuninstall[^^\\]*$
ECHO.%Systemroot:\=\\%\\\$msi31uninstall[^^\\]*$
ECHO.%Systemroot:\=\\%\\erdnt$
ECHO.:\\autorun.inf$
ECHO.:\\.*:\\.
ECHO.\\Desktop.ini$
)>whitedirB


@PEV.DAT -sDcdate -rtd --c:##c#  AND { %systemroot% OR %systemroot%\tasks } -output:temp00
@SED.DAT -r "$!N; s/:.*\n([^:]*):.*/|\1/;" temp00 >InstallDate
DEL /Q temp0? >NUL 2>&1


SET "ExecXx=bak[12]|bat|cmd|ini2|pif|reg|ren|vbs|vir|wsf|vbe|zip|msi|msp"


IF EXIST NOWHTLIST (
   ECHO.::::>WhiteDirB
   ECHO.::::>WhiteDir
   SET "EXECX=.*"
   SET "EXECXx=.*"
   SET "EXECXB=.*"
   ) ELSE IF EXIST W8.mac (
	ECHO.: NoActiveDesktopChanges = dword:1
	ECHO.: NoActiveDesktop = dword:1
	ECHO.: ConsentPromptBehaviorAdmin = dword:5
	ECHO.: EnableUIADesktopToggle = dword:0
	ECHO.: EnableCursorSuppression = dword:1
	ECHO.: ConsentPromptBehaviorUser = dword:3
	)>>policies.exe


SET "Created_DDS=1M"
SET "Created_=30"
SET "Modified_DDS=3M"

IF EXIST Time2x.dat (
	SET "Created_DDS=2M"
	SET "Created_=60"
	SET "Modified_DDS=6M"
	)

@(
ECHO.
ECHO.=============== Created Last %Created_% ================
ECHO.
)>>FILES00


PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%Systemdrive%\*" >Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%Systemroot%\*" >>Created00

REM CALL :ScrText

PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%system%\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%ProgFiles%\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%CommonProgFiles%\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%userprofile%\*" >>Created00
IF NOT EXIST Vista.krl PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%AllUsersprofile%\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%LocalAppData%\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%AppData%\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%CommonAppData%\*" >>Created00


REM CALL :ScrText


PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -td or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%Systemroot%\system\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -td or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%system%\wbem\*" >>Created00

REM CALL :ScrText

PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -td or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" } "%system%\drivers\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# "%system%\GroupPolicy\Machine\Scripts\Shutdown\*" not *.ini >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# "%system%\GroupPolicy\User\Scripts\Logoff\*" not *.ini >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tpmz "%system%\Spool\prtprocs\w32x86\*" >>Created00
REM PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemdrive%\temp\*" >>Created00
IF EXIST "%system%\dllcache\*" PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%system%\dllcache\*" >>Created00


REM CALL :ScrText


PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp)$" } "%AppData%\Microsoft\*" >>Created00
PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp)$" } "%CommonAppData%\Microsoft\*" >>Created00


REM CALL :ScrText


FOR %%G IN (
"ComPlus Applications"
"DVD Maker"
"Internet Explorer"
"Messenger"
"Microsoft Games"
"Movie Maker"
"Mozilla Firefox"
"MSBuild"
"MSN Gaming Zone"
"MSN"
"NetMeeting"
"Online Services"
"Outlook Express"
"Uninstall Information"
"Windows Defender"
"Windows Journal"
"Windows Mail"
"Windows Media Player"
"Windows NT"
"Windows Photo Viewer"
"Windows Portable Devices"
"Windows Sidebar"
"WindowsUpdate"
"xerox"
) DO IF EXIST "%ProgFiles%\%%~G\*" PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%ProgFiles%\%%~G\*" >>Created00


REM CALL :ScrText

FOR %%G IN (
"InstallShield"
"Microsoft Shared"
"MSSoap"
"ODBC"
"Services"
"System"
"Windows Live"
"WindowsLiveInstaller"
) DO IF EXIST "%CommonProgFiles%\%%~G\*" PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%CommonProgFiles%\%%~G\*" >>Created00


REM CALL :ScrText


IF EXIST W6432.dat (
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%SysDir%\*" >>Created00
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%ProgramFiles%\*" >>Created00
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -rtd or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%CommonProgramFiles%\*" >>Created00
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -td or -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%SysDir%\drivers\*" >>Created00
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# { -td or -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp)$" } "%SysDir%\wbem\*" >>Created00
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# "%SysDir%\GroupPolicy\Machine\Scripts\Shutdown\*" not *.ini >>Created00
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# "%SysDir%\GroupPolicy\User\Scripts\Logoff\*" not *.ini >>Created00
	PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tf -tpmz "%SysDir%\Spool\prtprocs\x64\*" >>Created00

	REM CALL :ScrText

	FOR %%G IN (
	"ComPlus Applications"
	"DVD Maker"
	"Internet Explorer"
	"Messenger"
	"Microsoft Games"
	"Movie Maker"
	"Mozilla Firefox"
	"MSBuild"
	"MSN Gaming Zone"
	"MSN"
	"NetMeeting"
	"Online Services"
	"Outlook Express"
	"Uninstall Information"
	"Windows Defender"
	"Windows Journal"
	"Windows Mail"
	"Windows Media Player"
	"Windows NT"
	"Windows Photo Viewer"
	"Windows Portable Devices"
	"Windows Sidebar"
	"WindowsUpdate"
	"xerox"
	) DO IF EXIST "%ProgramFiles%\%%~G\*" PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%ProgramFiles%\%%~G\*" >>Created00

REM CALL :ScrText

	FOR %%G IN (
	"InstallShield"
	"Microsoft Shared"
	"MSSoap"
	"ODBC"
	"Services"
	"System"
	"Windows Live"
	"WindowsLiveInstaller"
	) DO IF EXIST "%CommonProgramFiles%\%%~G\*" PEV.DAT -dcg%Created_DDS% -c:##c#b#u#b#t#b#f# -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%CommonProgramFiles%\%%~G\*" >>Created00
	)


REM CALL :ScrText

IF NOT EXIST NOWHTLIST IF EXIST Created00 (
	SORT.exe /M 65536 /R Created00  /T %TMP% /O temp00
	FOR /F "TOKENS=*" %%G IN ( InstallDate ) DO @SED.DAT -r "/(%%G)/,$d" temp00 >temp01
	SED.DAT -n -r ":a;$!N;s/\n/&/12;tz;$!ba;p;q;:z;s/^(.{17}).*\1[^\n]*\'/&/;tc;P;D;:c;N;s/^(.{17}).*\1[^\n]*\'/&/;tc;s/^(.*)\n([^\n]*)\'/\2/;P" temp01 >temp02
	FINDSTR.EXE -EVILG:WhiteDir temp02 >Created00
	DEL /Q temp0?
	)>NUL 2>&1


FINDSTR.EXE -EVILG:whiteDir Created00 | FINDSTR.EXE -ERIV "\.log \.txt" | FINDSTR.EXE -VIG:whitedirB  | FINDSTR.EXE -LIVC:"%CD%" >temp01
SORT.exe /M 65536 /R temp01  /T %TMP% >>FILES00
DEL /Q temp0? InstallDate




:Find3M

@(
ECHO.
ECHO.==================== Find%Modified_DDS%  ====================
ECHO.
)>>FILES00


@ECHO.>f3m0.dat



PEV.DAT -c:##m#b#u#b#t#b#f# -rtf { -tpmz or -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%ProgFiles%\*" >f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -rtf { -tpmz or -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%CommonProgFiles%\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%AppData%\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%CommonAppData%\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%Systemdrive%\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%Systemroot%\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%system%\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%UserProfile%\*" >>f3m0.dat
IF NOT EXIST Vista.krl PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%AllUsersProfile%\*" >>f3m0.dat


PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf { -tpmz or -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%system%\drivers\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf { -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp)$" } "%Systemroot%\system\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf { -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp)$" } "%system%\wbem\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%system%\GroupPolicy\Machine\Scripts\Shutdown\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%system%\GroupPolicy\User\Scripts\Logoff\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf -tpmz "%system%\Spool\prtprocs\w32x86\*" >>f3m0.dat


REM CALL :ScrText


IF EXIST W6432.dat (
	PEV.DAT -c:##m#b#u#b#t#b#f# -rtf { -tpmz or -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%ProgramFiles%\*" >>f3m0.dat
	PEV.DAT -c:##m#b#u#b#t#b#f# -rtf { -tpmz or -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%CommonProgramFiles%\*" >>f3m0.dat
	PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf { -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" or -preg"\.(bak\d|bat|cmd|com|ini2|pif|reg|ren|vbs|vir|wsf|vbe|zip|msi|msp|tmp)$" } "%SysDir%\drivers\*" >>f3m0.dat
	PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -rtf { -tpmz or -tf -preg"\.(bat|cmd|reg|vbs|wsf|vbe|msi|msp|com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|drv)$" } "%SysDir%\*" >>f3m0.dat
	PEV.DAT -c:##m#b#u#b#t#b#f# -DG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%SysDir%\wbem\*" >>f3m0.dat
	)


REM CALL :ScrText


PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\java\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\msapps\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\pif\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\Registration\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\help\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\web\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\pchealth\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\srchasst\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\tasks\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\apppatch\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\Internet Logs\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\Media\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\prefetch\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%Systemroot%\cursors\*" >>f3m0.dat
PEV.DAT -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" "%SystemRoot%\inf\*" not -preg"\\(unregmp2\.exe|regl3acm\.exe|\.reg)$" >>f3m0.dat


IF DEFINED Fonts PEV.DAT -s+1500 -c:##m#b#u#b#t#b#f# -dG%Modified_DDS% and { -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" or -tf -s+1 -s-2000 } "%fonts%\*" >>f3m0.dat

DEL WhiteDirB


IF NOT EXIST NOWHTLIST SET "Limit_=100q;"
TYPE WhiteDir created00 2>NUL | SED.DAT -r "s/.*(.:\\.*)/\1/; s/\\/\\&/g; s/.*(.{127})$/\1/" >temp00
ECHO.::::>>temp00
FINDSTR.EXE -EVILG:temp00 f3m0.dat >temp01
SORT.exe /M 65536 /r temp01  /T %TMP% /O temp02
SED.DAT -n -r ":a;$!N;s/\n/&/12;tz;$!ba;p;q;:z;s/^(.{17}).*\1[^\n]*\'/&/;tc;P;D;:c;N;s/^(.{17}).*\1[^\n]*\'/&/;tc;s/^(.*)\n([^\n]*)\'/\2/;P" temp02 >temp03
SED.DAT -r "%Limit_% /^$/d;" temp03 >>FILES00
DEL /Q temp0? WhiteDir created00 f3m0.dat >NUL 2>&1


REM CALL :ScrText


PEV.DAT -tf -tpmz -preg"\.(com|pif|ren|vir|tmp|dll|scr|sys|exe|bin|dat|drv)$" -tsh -dl3M -c:##m#b#u#b#t#b#f# "%SystemRoot%\*" -skip"%SystemRoot%\Winsxs" not *.mui >>FILES00


REM CALL :ScrText




:HJT
IF EXIST NOWHTLIST (
	TYPE HJT#1.txt >>DDS02
	) ELSE IF EXIST W6432.dat (
		FINDSTR.EXE -IV "://[^/]*\.microsoft\.com/ ://[^/]*\.msn\.com/ %%Systemroot\%%\\system32\\blank\.htm %System:\=\\%\\blank\.htm %SysDir:\=\\%\\blank\.htm ProxyOverride.=.\*\.local" HJT#1.txt >>DDS02
		) ELSE FINDSTR.EXE -IV "://[^/]*\.microsoft\.com/ ://[^/]*\.msn\.com/ %%Systemroot\%%\\system32\\blank\.htm %System:\=\\%\\blank\.htm ProxyOverride.=.\*\.local" HJT#1.txt >>DDS02




FINDSTR.EXE -LIVG:MSClsid.EXE HJT#2.txt >>DDS02

@ECHO.Winlogon: Shell = Explorer.exe>>wlgn.dat
@ECHO.Winlogon: UIHost = logonui.exe>>wlgn.dat
@ECHO.Winlogon: Taskman = Taskmgr.exe>>wlgn.dat
@ECHO.Winlogon: SFCDisable = dword:0>>wlgn.dat
@ECHO.Winlogon: Userinit = %SysDir%\userinit.exe,>>wlgn.dat
IF EXIST NOWHTLIST ECHO.::::>wlgn.dat

FINDSTR.EXE -ELIVG:wlgn.dat HJT#3.txt >>DDS02
FINDSTR.EXE -LIVG:MSClsid.EXE HJT#4.txt >>DDS02
TYPE HJT#5.txt >>DDS02

IF EXIST StartUp (
	SED.DAT -r "/^$/Id; s/./StartupFolder: &/" StartUp >>DDS02
	DEL StartUp
	)


FINDSTR.EXE -virg:policies.exe HJT#6.txt >>DDS02
TYPE HJT#7.txt >>DDS02



@(
ECHO.^%SystemRoot^%\system32\rsvpsp.dll
ECHO.^%SystemRoot^%\system32\winrnr.dll
ECHO.^%SystemRoot^%\system32\mswsock.dll
ECHO.^%SystemRoot^%\system32\msafd.dll
)>MSDLL_.dat


@IF EXIST vista.krl (
ECHO.^%SystemRoot^%\system32\NLAapi.dll
ECHO.^%SystemRoot^%\system32\napinsp.dll
ECHO.^%SystemRoot^%\system32\pnrpnsp.dll
)>>MSDLL_.dat


IF EXIST NOWHTLIST ECHO.::::>MSDLL_.dat



REGEDIT.EXE /A LSP00 "HKEY_LOCAL_MACHINE\system\currentcontrolset\services\winsock2\parameters\protocol_catalog9\catalog_entries"
IF EXIST LSP00 (
SED.DAT ":a; $!N;s/\\\n  //;ta;P;D" LSP00 >LSP01
SED.DAT -r "/^\x22.*hex:/I!d; s///; s/00..*//" LSP01 >LSP02
SED.DAT -r -n "G; s/\n/&&/; /^([ -~]*\n).*\n\1/d; s/\n//; h; P" LSP02 >LSP03
SED.DAT "s/20,/ /Ig;s/21,/!/Ig;s/22,/\x22/Ig;s/23,/#/Ig;s/24,/$/Ig;s/25,/%%/Ig;s/26,/\&/Ig;s/27,/'/Ig;s/28,/(/Ig;s/29,/)/Ig;s/2A,/*/Ig;s/2B,/+/Ig;s/2C,//Ig;s/2D,/-/Ig;s/2E,/./Ig;s/2F,/\//Ig;s/30,/0/Ig;s/31,/1/Ig;s/32,/2/Ig;s/33,/3/Ig;s/34,/4/Ig;s/35,/5/Ig;s/36,/6/Ig;s/37,/7/Ig;s/38,/8/Ig;s/39,/9/Ig;s/3A,/:/Ig;s/3B,/;/Ig;s/3C,/</Ig;s/3D,/=/Ig;s/3E,/>/Ig;s/3F,/?/Ig;s/40,/@/Ig;s/41,/A/Ig;s/42,/B/Ig;s/43,/C/Ig;s/44,/D/Ig;s/45,/E/Ig;s/46,/F/Ig;s/47,/G/Ig;s/48,/H/Ig;s/49,/I/Ig;s/4A,/J/Ig;s/4B,/K/Ig;s/4C,/L/Ig;s/4D,/M/Ig;s/4E,/N/Ig;s/4F,/O/Ig;s/50,/P/Ig;s/51,/Q/Ig;s/52,/R/Ig;s/53,/S/Ig;s/54,/T/Ig;s/55,/U/Ig;s/56,/V/Ig;s/57,/W/Ig;s/58,/X/Ig;s/59,/Y/Ig;s/5A,/Z/Ig;s/5B,/[/Ig;s/5C,/\\/Ig;s/5D,/]/Ig;s/5E,/^/Ig;s/5F,/_/Ig;s/60,/`/Ig;s/61,/a/Ig;s/62,/b/Ig;s/63,/c/Ig;s/64,/d/Ig;s/65,/e/Ig;s/66,/f/Ig;s/67,/g/Ig;s/68,/h/Ig;s/69,/i/Ig;s/6A,/j/Ig;s/6B,/k/Ig;s/6C,/l/Ig;s/6D,/m/Ig;s/6E,/n/Ig;s/6F,/o/Ig;s/70,/p/Ig;s/71,/q/Ig;s/72,/r/Ig;s/73,/s/Ig;s/74,/t/Ig;s/75,/u/Ig;s/76,/v/Ig;s/77,/w/Ig;s/78,/x/Ig;s/79,/y/Ig;s/7A,/z/Ig;s/7B,/{/Ig;s/7C,/|/Ig;s/7D,/}/Ig;s/7E,/~/Ig;s/./LSP: &/" LSP03 >LSP04
FINDSTR.EXE -VILG:MSDLL_.dat LSP04 >>DDS02
DEL /Q LSP0? MSDLL_.dat
)


TYPE HJT#8.txt >>DDS02
FINDSTR.EXE -LIVG:MSClsid.EXE HJT#9.txt >>DDS02


@(
ECHO.Notify: crypt32chain - crypt32.dll
ECHO.Notify: cryptnet - cryptnet.dll
ECHO.Notify: cscdll - cscdll.dll
ECHO.Notify: dimsntfy - %SYSTEM%\dimsntfy.dll
ECHO.Notify: ScCertProp - wlnotify.dll
ECHO.Notify: Schedule - wlnotify.dll
ECHO.Notify: sclgntfy - sclgntfy.dll
ECHO.Notify: SensLogn - WlNotify.dll
ECHO.Notify: termsrv - wlnotify.dll
ECHO.Notify: TPSvc - TPSvc.dll
ECHO.Notify: WgaLogon - WgaLogon.dll
ECHO.Notify: wlballoon - wlnotify.dll
)>notifykeysB.com

IF EXIST NOWHTLIST ECHO.::::> notifykeysB.com

FINDSTR.EXE -ELIVG:notifykeysB.com HJT#10.txt >>DDS02
FINDSTR.EXE -LIVG:MSClsid.EXE HJT#11.txt >>DDS02


@(
ECHO.SecurityProviders: SecurityProviders = msapsspc.dll, schannel.dll, digest.dll, msnsspc.dll
ECHO.SecurityProviders: SecurityProviders = msapsspc.dll, schannel.dll, digest.dll, msnsspc.dll, credssp.dll
ECHO.SecurityProviders: SecurityProviders = credssp.dll
ECHO.LSA: Authentication Packages =  msv1_0
ECHO.LSA: Notification Packages =  scecli
ECHO.LSA: Security Packages =  kerberos msv1_0 schannel
ECHO.LSA: Security Packages =  kerberos msv1_0 schannel wdigest
ECHO.LSA: Security Packages =  kerberos msv1_0 schannel wdigest  tspkg
ECHO.LSA: Security Packages =  kerberos msv1_0 schannel wdigest tspkg pku2u
ECHO.LSA: Security Packages =  kerberos msv1_0 schannel wdigest tspkg pku2u livessp
ECHO.SubSystems: Windows = basesrv,1 winsrv:UserServerDllInitialization,3 winsrv:ConServerDllInitialization,2
ECHO.SubSystems: Windows = basesrv,1 winsrv:UserServerDllInitialization,3 winsrv:ConServerDllInitialization,2 sxssrv,4
IF EXIST W8.mac ECHO.SubSystems: Windows = basesrv,1 winsrv:UserServerDllInitialization,3 sxssrv,4
ECHO.CLSID: {603D3801-BD81-11d0-A3A5-00C04FD706EC} - %SYSDIR%\browseui.dll
ECHO.CLSID: {603D3801-BD81-11d0-A3A5-00C04FD706EC} - %SYSDIR%\shell32.dll
)>notifykeysC.com

IF EXIST NOWHTLIST ECHO.::::> notifykeysC.com

@ECHO.%system%\ieudinit.exe>>active_setup.dat
@ECHO.%systemroot%\inf\unregmp2.exe>>active_setup.dat
@ECHO.rundll32 iedkcs32.dll>>active_setup.dat
@ECHO.%systemroot%\system32\shmgrate.exe>>active_setup.dat
@ECHO.%SYSTEMROOT%\system32\themeui.dll>>active_setup.dat
@ECHO.%%ProgFiles%%\outlook express\setup50.exe>>active_setup.dat
@ECHO.%ProgFiles%\outlook express\setup50.exe>>active_setup.dat
@ECHO.%systemroot%\inf\msnetmtg.inf>>active_setup.dat
@ECHO.%systemroot%\inf\msmsgs.inf>>active_setup.dat
@ECHO.%systemroot%\inf\wmp.inf>>active_setup.dat
@ECHO.regsvr32.exe /s /n /i:u shell32.dll>>active_setup.dat
@ECHO.regsvr32.exe /s /n /i:u %systemroot%\system32\shell32.dll>>active_setup.dat
@ECHO.%system%\mscories.dll>>active_setup.dat
@ECHO.%system%\ie4uinit.exe>>active_setup.dat
@ECHO.%systemroot%\inf\wmp10.inf>>active_setup.dat
@ECHO.%ProgFiles%\Messenger\msgsc.dll>>active_setup.dat
@ECHO.%systemroot%\inf\fxsocm.inf>>active_setup.dat
@ECHO.%system%\setup\fxsocm.dll>>active_setup.dat
@ECHO.%systemroot%\inf\mswmp.inf>>active_setup.dat
@ECHO.%ProgFiles%\messenger\msgsc.dll>>active_setup.dat
@ECHO.%SYSTEMROOT%\system32\updcrl.exe>>active_setup.dat
@ECHO.%system%\setup\wmpocm.exe>>active_setup.dat
@ECHO.%systemroot%\INF\mplayer2.inf>>active_setup.dat
@ECHO.%SYSTEMROOT%\system32\ie4uinit.exe>>active_setup.dat
@ECHO.regsvr32.exe /s /n /i:"S 2 true 3 true 4 true 5 true 6 true 7 true" initpki.dll>>active_setup.dat
@ECHO.%SYSTEMROOT%\inf\ie.inf>>active_setup.dat
@ECHO.%systemroot%\INF\wmp11.inf>>active_setup.dat
@ECHO.%SYSTEMROOT%\INF\msmsgs.inf>>active_setup.dat
@ECHO.%SYSTEMROOT%\INF\wpie4x86.inf>>active_setup.dat
@ECHO.%SYSTEMROOT%\inf\mcdftreg.inf>>active_setup.dat
@ECHO.%systemroot%\INF\EasyCDBlock.inf>>active_setup.dat
@ECHO.rundll32 iesetup.dll>>active_setup.dat
@ECHO.RunDLL setupx.dll>>active_setup.dat
@ECHO.%%ProgFiles%%\windows mail\winmail.exe>>active_setup.dat
@ECHO.%ProgFiles%\windows mail\winmail.exe>>active_setup.dat
@ECHO.%system%\iedkcs32.dll>>active_setup.dat


@IF EXIST Vista.krl (
	ECHO.%system%\unregmp2.exe
	ECHO.%SYSTEMROOT%\system32\unregmp2.exe
	IF EXIST W6432.dat (
		ECHO.%SYSTEM%\ie4uinit.exe
		ECHO.%SYSTEM%\iedkcs32.dll
		ECHO.%SYSDIR%\iedkcs32.dll
		ECHO.%ProgramFiles^(x86^)%\Windows Mail\WinMail.exe
		ECHO.%SYSTEM%\mscories.dll
		ECHO.%SYSDIR%\mscories.dll
		))>>active_setup.dat


IF EXIST NOWHTLIST ECHO.::::::>active_setup.dat

FINDSTR.EXE -ELIVG:notifykeysC.com HJT#12.txt | FINDSTR.EXE -LIVG:active_setup.dat  >>DDS02
IF EXIST IFEO.txt FINDSTR.EXE -LIVC:"IFEO: Your Image File Name Here without a path - ntsd -d" IFEO.txt | SED.DAT 5q  >>DDS02
DEL /Q HJT#??.txt

IF NOT EXIST W6432.dat GOTO NOTX64


IF EXIST NOWHTLIST (
	TYPE x64-HJT#1.txt >>DDS02
 ) ELSE FINDSTR.EXE -IV "://[^/]*\.microsoft\.com/ ://[^/]*\.msn\.com/ %%Systemroot\%%\\system32\\blank\.htm %SysDir:\=\\%\\blank\.htm" x64-HJT#1.txt >>DDS02
		


FINDSTR.EXE -LIVG:MSClsid.EXE x64-HJT#2.txt >>DDS02

FINDSTR.EXE -ELIVG:wlgn.dat x64-HJT#3.txt >>DDS02
FINDSTR.EXE -LIVG:MSClsid.EXE x64-HJT#4.txt >>DDS02
TYPE x64-HJT#5.txt >>DDS02



FINDSTR.EXE -virg:policies.exe x64-HJT#6.txt >>DDS02
TYPE x64-HJT#7.txt >>DDS02
FINDSTR.EXE -LIVG:MSClsid.EXE x64-HJT#9.txt >>DDS02
FINDSTR.EXE -ELIVG:notifykeysB.com x64-HJT#10.txt >>DDS02
FINDSTR.EXE -LIVG:MSClsid.EXE x64-HJT#11.txt >>DDS02
FINDSTR.EXE -ELIVG:notifykeysC.com x64-HJT#12.txt | FINDSTR.EXE -LIVG:active_setup.dat  >>DDS02

DEL /Q x64-HJT#??.txt notifykeys?.com wlgn.dat Policies.exe MSClsid.EXE


:NotX64
IF EXIST x64-IFEO.txt (
	SED.DAT 5q x64-IFEO.txt >>DDS02
	TYPE x64-IFEO.txt >>IFEO.txt
	DEL x64-IFEO.txt
	)

IF EXIST IFEO.txt "%SystemRoot%\system32\Find.exe" /C "IFEO: " IFEO.txt | "%SystemRoot%\system32\FINDSTR.exe" -REC:": [0-5]" >NUL 2>&1 &&(
	DEL /A/F IFEO.txt
	)||(
	ECHO.
	ECHO.Note: multiple IFEO entries found. Please refer to Attach.txt
	)>>DDS02


FOR /F "TOKENS=*" %%G IN ( DBPath.txt ) DO @CALL SET "DBPath=%%~G\Hosts"
DEL /A/F DbPath.txt

IF NOT EXIST "%DBPath%\" IF EXIST "%DBPath%" (
	SED.DAT -R "/^ *127.0.0.1.*\.(microsoft|symantec|mcafee|f-secure|kaspersky|sophos|trendmicro|viruslist|virustotal|avast|avira|bitdefender|bleepingcomputer|eset|majorgeeks|free-av|avg|grisoft|geekstogo|pandasecurity|spywareinfo|sunbeltsecurity|techspot|techsupportforum|whatthetech|wilderssecurity)\.com\s*$/I!d;  s/./Hosts: &/" "%DBPath%" >Hosts
	SED.DAT -R "/^ *\d/!d; /127\.0\.0\.1/d; s/./Hosts: &/" "%DBPath%" >>Hosts
	)

SET DbPath=


IF EXIST Hosts (
	SED.DAT "5q;s/  */ /g" Hosts
	"%SystemRoot%\system32\Find.exe" /C "Hosts: " Hosts | "%SystemRoot%\system32\FINDSTR.exe" -REC:": [0-5]" >NUL 2>&1 &&(
		DEL /A/F Hosts >NUL 2>&1
		)||(
		ECHO.
		ECHO.Note: multiple HOSTS entries found. Please refer to Attach.txt
		))>>DDS02


DEL /A/F/Q temp0? active_setup.dat >NUL 2>&1






@(
ECHO.
ECHO.============== Pseudo HJT Report ===============
ECHO.
)>>DDS00
SED.DAT -r "/^([dum]URLSearchHooks|TB|SEH): : \{/Is//\1: N\/A: {/" DDS02 >>DDS00
DEL DDS02



:FireFox
IF NOT EXIST FFRoot.txt GOTO SVC
SED.DAT "s/\\$//" FFRoot.txt >FFRootB
DEL FFRoot.txt
FOR /F "TOKENS=*" %%G IN ( FFRootB ) DO @SET "FF_Root=%%G\"

IF NOT EXIST "%FF_Root%Firefox.exe" GOTO SVC

@(
ECHO.
ECHO.================= FIREFOX ===================
ECHO.
)>>DDS00


For %%G in (
"%FF_Root%components\browserdirprovider.dll"
"%FF_Root%components\brwsrcmp.dll"
"%FF_Root%components\jar50.dll"
"%FF_Root%components\jsd3250.dll"
"%FF_Root%components\myspell.dll"
"%FF_Root%components\NsThunderLoader.dll"
"%FF_Root%components\spellchk.dll"
"%FF_Root%components\ThunderComponent.dll"
"%FF_Root%components\WRSForFireFox.dll"
"%FF_Root%components\xpinstal.dll"
"%FF_Root%plugins\np-mswmp.dll"
"%FF_Root%plugins\np_gp.dll"
"%FF_Root%plugins\np_prizm32.dll"
"%FF_Root%plugins\np_prizmprint.dll"
"%FF_Root%plugins\np32dsw.dll"
"%FF_Root%plugins\npalambik.dll"
"%FF_Root%plugins\npaxelplayer.dll"
"%FF_Root%plugins\npbitcometagent.dll"
"%FF_Root%plugins\npcpc32.dll"
"%FF_Root%plugins\npdapctrlfirefox.dll"
"%FF_Root%plugins\npdeploytk.dll"
"%FF_Root%plugins\npdevalvr.dll"
"%FF_Root%plugins\npdivx32.dll"
"%FF_Root%plugins\npdivxplayerplugin.dll"
"%FF_Root%plugins\npexview.dll"
"%FF_Root%plugins\npffpreviewer.dll"
"%FF_Root%plugins\npflux.dll"
"%FF_Root%plugins\nphypercosm.dll"
"%FF_Root%plugins\npjp2.dll"
"%FF_Root%plugins\nplegitcheckplugin.dll"
"%FF_Root%plugins\npmapv32.dll"
"%FF_Root%plugins\npmngplg.dll"
"%FF_Root%plugins\npnanoinstaller.dll"
"%FF_Root%plugins\npnanoscanner.dll"
"%FF_Root%plugins\npnul32.dll"
"%FF_Root%plugins\npnwcw32.dll"
"%FF_Root%plugins\npoff12.dll"
"%FF_Root%plugins\npoffice.dll"
"%FF_Root%plugins\nppdf32.dll"
"%FF_Root%plugins\nppl3260.dll"
"%FF_Root%plugins\npqtplugin.dll"
"%FF_Root%plugins\npqtplugin2.dll"
"%FF_Root%plugins\npqtplugin3.dll"
"%FF_Root%plugins\npqtplugin4.dll"
"%FF_Root%plugins\npqtplugin5.dll"
"%FF_Root%plugins\npqtplugin6.dll"
"%FF_Root%plugins\npqtplugin7.dll"
"%FF_Root%plugins\nprescue.dll"
"%FF_Root%plugins\nprjplug.dll"
"%FF_Root%plugins\nprpjplug.dll"
"%FF_Root%plugins\npsibelius.dll"
"%FF_Root%plugins\npswf32.dll"
"%FF_Root%plugins\npupd62.dll"
"%FF_Root%plugins\npxarac.dll"
"%FF_Root%plugins\npym32.dll"
"%FF_Root%plugins\npzzatif.dll"
"%ProgFiles%\curl corporation\surge\plugins\np-curl-surge-6-0.dll"
"%ProgFiles%\curl corporation\surge\plugins\np-curl-surge.dll"
"%ProgFiles%\divx\divx content uploader\npUpload.dll"
"%ProgFiles%\divx\divx player\npdivxplayerplugin.dll"
"%ProgFiles%\divx\divx web player\npdivx32.dll"
"%ProgFiles%\dna\plugins\npbtdna.dll"
"%ProgFiles%\garmin gps plugin\npgarmin.dll"
"%ProgFiles%\hypercosm\hypercosm player\components\nphypercosm.dll"
"%ProgFiles%\itunes\mozilla plugins\npitunes.dll"
"%ProgFiles%\Java\jre6\bin\new_plugin\npdeploytk.dll"
"%ProgFiles%\Java\jre6\bin\new_plugin\npjp2.dll"
"%ProgFiles%\microsoft silverlight\npctrl.dll"
"%ProgFiles%\netscape6\nppl3260.dll"
"%ProgFiles%\netscape6\nprjplug.dll"
"%ProgFiles%\netscape6\nprpjplug.dll"
"%ProgFiles%\opera\program\plugins\npdsplay.dll"
"%ProgFiles%\opera\program\plugins\NPOFF12.DLL"
"%ProgFiles%\opera\program\plugins\npoffice.dll"
"%ProgFiles%\opera\program\plugins\npqtplugin.dll"
"%ProgFiles%\opera\program\plugins\npqtplugin2.dll"
"%ProgFiles%\opera\program\plugins\npqtplugin3.dll"
"%ProgFiles%\opera\program\plugins\npqtplugin4.dll"
"%ProgFiles%\opera\program\plugins\npqtplugin5.dll"
"%ProgFiles%\opera\program\plugins\npqtplugin6.dll"
"%ProgFiles%\opera\program\plugins\npqtplugin7.dll"
"%ProgFiles%\opera\program\plugins\npswf32.dll"
"%ProgFiles%\opera\program\plugins\npwmsdrm.dll"
"%ProgFiles%\panda security\activescan 2.0\npwrapper.dll"
"%ProgFiles%\quicktime\plugins\npqtplugin.dll"
"%ProgFiles%\quicktime\plugins\npqtplugin2.dll"
"%ProgFiles%\quicktime\plugins\npqtplugin3.dll"
"%ProgFiles%\quicktime\plugins\npqtplugin4.dll"
"%ProgFiles%\quicktime\plugins\npqtplugin5.dll"
"%ProgFiles%\quicktime\plugins\npqtplugin6.dll"
"%ProgFiles%\quicktime\plugins\npqtplugin7.dll"
"%ProgFiles%\real alternative\browser\plugins\nppl3260.dll"
"%ProgFiles%\real alternative\browser\plugins\nprpjplug.dll"
"%ProgFiles%\real\realplayer\netscape6\nppl3260.dll"
"%ProgFiles%\real\realplayer\netscape6\nprjplug.dll"
"%ProgFiles%\real\realplayer\netscape6\nprpjplug.dll"
"%ProgFiles%\real\rhapsodyplayerengine\nprhapengine.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\nppl3260.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\npqtplugin.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\npqtplugin2.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\npqtplugin3.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\npqtplugin4.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\npqtplugin5.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\npqtplugin6.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\npqtplugin7.dll"
"%ProgFiles%\ringz studio\storm codec\plugins\nprpjplug.dll"
"%ProgFiles%\Siber Systems\AI RoboForm\Firefox\components\rfproxy_27.dll"
"%ProgFiles%\videolan\vlc\npvlc.dll"
"%ProgFiles%\windows media player\npdrmv2.dll"
"%ProgFiles%\windows media player\npdsplay.dll"
"%ProgFiles%\windows media player\npwmsdrm.dll"
"%SystemRoot%\system32\adobe\director\np32dsw.dll"
"%SystemRoot%\system32\macromed\flash\npswf32.dll"
"%Systemroot:~1%\Microsoft.NET\Framework\v3.5\Windows Presentation Foundation\NPWPF.dll"
"\extensions\\{1650a312-02bc-40ee-977e-83f158701739\}\components\FFHook.dll"
"\extensions\\{77b819fa-95ad-4f2c-ac7c-486b356188a9\}\plugins\npietab.dll"
"\extensions\\{b13721c7-f507-4982-b2e5-502a71474fed\}\components\NPComponent.dll"
"\extensions\\{b13721c7-f507-4982-b2e5-502a71474fed\}\components\PNRComponent.dll"
"\extensions\\{FFA36170-80B1-4535-B0E3-A4569E497DD0\}\platform\WINNT_x86-msvc\components\mgMouseService.dll"
"\extensions\moveplayer@movenetworks.com\platform\winnt_x86-msvc\plugins\npmnqmp07103010.dll"
"\extensions\\{3112ca9c-de6d-4884-a869-9855de68056c\}\components\googletoolbarloader.dll"
"\extensions\\{3112ca9c-de6d-4884-a869-9855de68056c\}\components\metricsloader.dll"
"extensions\\{CF40ACC5-E1BB-4aff-AC72-04C2F616BCA7\}\plugins\np_gp.dll"

"%ProgFiles%\yahoo!\common\npyaxmpb.dll"
"%ProgFiles%\mozilla firefox\plugins\npcpbrk7.dll"
"%ProgFiles%\mozilla firefox\plugins\NPCpnMgr.dll"
"%ProgFiles%\mozilla firefox\plugins\npsnapfish.dll"
"%ProgFiles%\yahoo!\shared\npYState.dll"
) DO @ECHO.%%~G>>FPlugins


@echo:%ProgFiles:\=\\%\\java\\jre1.6.0_[0-1][0-9]\\bin\\npjava1[1-4].dll>FPluginsB
@echo:%ProgFiles:\=\\%\\java\\jre1.6.0_[0-1][0-9]\\bin\\npjava32.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\java\\jre1.6.0_[0-1][0-9]\\bin\\npjpi160_[0-9][0-9].dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\java\\jre1.6.0_[0-1][0-9]\\bin\\npoji610.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\adobe\\reader [^^\\]*\\reader\\browser\\nppdf32.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\microsoft silverlight\\npctrl.1.0.3[0-9.]*.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\microsoft silverlight\\[^^\\]*\\npctrl.1.0.3[0-9.]*.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\microsoft silverlight\\[^^\\]*\\npctrl.dll>>FPluginsB
@echo:\\Google\\Update\\[^^\\]*\\npGoogleOneClick6.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\google\\google updater\\[^^\\]*\\npCIDetect11.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\adobe\\acrobat [^^\\]*\\reader\\browser\\nppdf32.dll>>FPluginsB
@echo:%ProgFiles:\=\\%\\adobe\\acrobat [^^\\]*\\acrobat\\browser\\nppdf32.dll>>FPluginsB


IF EXIST NOWHTLIST (
	ECHO::::>FPlugins
	ECHO::::>FPluginsB
	)


REM CALL :ScrText


PEV.DAT -samdate --limit1 -tf "%AppData%\Mozilla\Firefox\Profiles\*" -preg"%AppData:\=\\%\\Mozilla\\Firefox\\Profiles\\[^\\]*\\prefs.js" >temp00
FOR /F "TOKENS=*" %%G IN ( temp00 ) DO @SET "FF_UserRoot=%%~DPG"


SET "FF_A=browser.search.defaulturl|browser.startup.homepage|browser.search.selectedEngine|keyword.URL|keyword.enabled"
SET "FF_B=network.proxy.type|network.proxy.ftp|network.proxy.http|network.proxy.socks|network.proxy.ssl|network.proxy.gopher"




ECHO.FF - ProfilePath - "%FF_UserRoot%"| SED.DAT "s/\x22//g" >>DDS00 2>NUL
SED.DAT -r "/user_pref\(\x22(%FF_A%)\x22, (.*)\);/I!d; s//FF - prefs.js: \1 - \2/; s.htt(p|ps)://.hxx\1://.I; s/\x22//g" "%FF_UserRoot%prefs.js" >>DDS00 2>NUL
FINDSTR.EXE -LI network.proxy.type "%FF_UserRoot%prefs.js" >NUL &&(
	SED.DAT -r "/^.*(\x22(%FF_B%)(\x22|_port\x22))/I!d; s//FF - prefs.js: \1/; s/\x22, / - /; s/\);//I; s/\x22//g" "%FF_UserRoot%prefs.js"
	)>>DDS00 2>NUL


SED.DAT "/:\\/!d; s/|.*//; s/./FF - plugin: &/" "%FF_UserRoot%pluginreg.dat" >temp04 2>NUL
SED.DAT -r "/((^rel|abs:).*\.dll),[0-9]{13}$/I!d; s//\1/; s/.*abs://; s/rel:/%FF_Root:\=\\%components\\/I; s/./FF - component: &/" "%FF_UserRoot%compreg.dat" >>temp04 2>NUL
FINDSTR.EXE -LIVEG:FPlugins temp04 | FINDSTR.EXE -RIVG:FPluginsB >temp05
SORT.exe /M 65536 temp05  /T %TMP% >>DDS00


IF EXIST "%FF_UserRoot%extensions.sqlite" (
		IF EXIST result.txt DEL /A/F result.txt
		IF EXIST NOWHTLIST (
			SED.DAT -r "/864000|type not like/Id" FFext.dll > FFext.dll.tmp
			MOVE /Y FFext.dll.tmp FFext.dll
			)
		COPY /Y "%FF_UserRoot%extensions.sqlite"
		sqlite3.DAT extensions.sqlite < FFext.dll
		SED.DAT -R "/^(\d\d\d\d-[^;]*):..; /!d; s//FF - ExtSQL: \1; /" result.txt >>DDS00
		SED.DAT -R "/^0; (\d\d\d\d-[^;]*):..; /!d; s//FF - ExtSQL: !HIDDEN! \1; /" result.txt >>DDS00
		DEL /A/F result.txt extensions.sqlite
)>NUL 2>&1 ELSE IF EXIST "%FF_UserRoot%extensions.cache" (
	IF NOT EXIST NOWHTLIST (
		SED.DAT -r "/user_pref\(.extensions.enabledItems., +/I!d; s///; s/\x22//g; s/:[^:]*$//; s/:[^:]*,/\n/g" "%FF_UserRoot%prefs.js" >enabledExtensions
		ECHO.::::::>>enabledExtensions
		FINDSTR.EXE -ig:enabledExtensions "%FF_UserRoot%extensions.cache" | SED.DAT -r "s/^app-global	(.*	)rel%%/\1%FF_Root:\=\\%extensions\\/I; s/^app-profile	(.*	)rel%%/\1.\\extensions\\/I; s/^winreg.*	(.*	)abs%%(.:\\)/\1\2/I; s/	[^\\]*$//" >temp09
	) ELSE SED.DAT -r "s/^app-global	(.*	)rel%%/\1%FF_Root:\=\\%extensions\\/I; s/^app-profile	(.*	)rel%%/\1.\\extensions\\/I; s/^winreg.*	(.*	)abs%%(.:\\)/\1\2/I; s/	[^\\]*$//" "%FF_UserRoot%extensions.cache" >temp09
	PUSHD "%FF_UserRoot%"
	FOR /F "USEBACKQ TOKENS=1* DELIMS=	" %%H IN ( "%WD%\temp09" ) DO @IF EXIST "%%~I\install.rdf"  (
		"%WD%\SED.DAT" -r "/em:(requires|localized)/I,/\/em:(requires|localized)>/Id; /em:name/I!d; s/\s+//; s/<\/.*//; s/.*em:name(>|=\x22)//; s/\x22//g;" "%%~I\install.rdf" >"%WD%\temp0As"
		FOR /F "USEBACKQ TOKENS=*" %%K IN ( "%WD%\temp0As" ) DO @ECHO.FF - Ext: %%K: %%H - %%I>>"%WD%\DDS0K"
		DEL /A/F "%WD%\temp0As"
		)
	POPD
	)>NUL 2>&1


IF EXIST DDS0K (
	SED.DAT -r "/.:\\/!{s/ - .\\extensions\\/ - %%profile%%\\extensions\\/;}" DDS0K >> DDS00
	DEL /A/F DDS0K
	)


IF EXIST "%FF_UserRoot%user.js" (
	SED.DAT -r "s/user_pref\(\x22([^\x22]*)\x22, (.*)\);/FF - user.js: \1 - \2/I; s.htt(p|ps)://.hxx\1://.I; s/\x22//g" "%FF_UserRoot%user.js"
	)>FFPolicyB


IF EXIST FFPolicyB FINDSTR . FFPolicyB >NUL &&(
	ECHO.
	ECHO.---- FIREFOX POLICIES ----
	TYPE FFpolicyB
	)>>DDS00 2>NUL






DEL /Q temp?? FPlugins? FFPolicy FFPolicyB enabledExtensions >NUL 2>&1
SET FF_A=
SET FF_B=
SET FF_Root=


:SVC
DEL FFRoot FFRootB
@(
ECHO.
ECHO.============= SERVICES / DRIVERS ===============
ECHO.
)>>DDS00


IF EXIST Vista.krl Type SvcWhtDDSVista.dll >>SvcWhtDDS.dll
IF EXIST W7.mac (
	Type SvcWhtDDSW7.dll
)>>SvcWhtDDS.dll ELSE IF EXIST W8.mac (
	Type SvcWhtDDSW7.dll
	Type SvcWhtDDSW8.dll
)>>SvcWhtDDS.dll

IF NOT EXIST svclist.dat CALL :SvcDrvB


IF EXIST svclist.dat (
	FINDSTR.EXE -LIVG:SvcWhtDDS.dll svclist.dat >temp00
	SORT.exe /M 65536 temp00  /T %TMP% /O temp01
	SED.DAT "s/	/ /" temp01 >>DDS00
	DEL temp00 temp01 Svclist.dat
	)


IF EXIST NOWHTLIST (
	ECHO.::::>Assocs
) ELSE (
ECHO.: batfile="%%1" %%*
ECHO.: cmdfile="%%1" %%*
ECHO.: comfile="%%1" %%*
ECHO.: exefile="%%1" %%*
ECHO.: piffile="%%1" %%*
ECHO.: scrfile="%%1" /S
ECHO.: regedit=regedit.exe %%1
ECHO.: regedit=regedit.exe "%%1"
ECHO.: regedit="regedit.exe" "%%1"
ECHO.: regedit=%systemroot%\regedit.exe %%1
ECHO.: regfile=regedit.exe "%%1"
ECHO.: regfile=%systemroot%\regedit.exe %%1
ECHO.: txtfile=NOTEPAD.EXE %%1
ECHO.: txtfile=%SysDir%\NOTEPAD.EXE %%1
ECHO.: chm.file="%SystemRoot%\hh.exe" %%1
ECHO.: inffile=NOTEPAD.EXE %%1
ECHO.: inffile=%SysDir%\NOTEPAD.EXE %%1
ECHO.: inifile=NOTEPAD.EXE %%1
ECHO.: inifile=%SysDir%\NOTEPAD.EXE %%1
)>Assocs

@(
ECHO.File=WScript.exe "%%1" %%*
ECHO.File=%SysDir%\WScript.exe "%%1" %%*
ECHO.File="%SysDir%\WScript.exe" "%%1" %%*
ECHO.File=CScript.exe "%%1" %%*
ECHO.File=%SysDir%\CScript.exe "%%1" %%*
ECHO.File="%SysDir%\CScript.exe" "%%1" %%*
)>AssocsB

SED.DAT -r "/: (js|jse|vbe|vbs|wsf)file=/Id" FileExtension.TXT | FINDSTR.EXE -LIEVG:Assocs > AssocsB.txt
SED.DAT -r "/: (js|jse|vbe|vbs|wsf)file=/I!d" FileExtension.TXT | FINDSTR.EXE -LIEVG:AssocsB >> AssocsB.txt

IF EXIST NOWHTLIST (
	TYPE ShellExec.txt >> AssocsB.txt
) ELSE SED.DAT -r "/^ShellExec: [^:]*\.exe/I!d; /: ([^:]*): [^=]*=(\1|.*\x22[^\x22]*\\\1\x22|.*\\\1) /Id" ShellExec.txt >> AssocsB.txt


FINDSTR.EXE . AssocsB.txt >NUL &&@(
ECHO.
ECHO.=============== File Associations ===============
ECHO.
TYPE AssocsB.txt
)>>DDS00
DEL /A AssocsB.txt Assocs



:LOGA
TYPE FILES00 >>DDS00
DEL FILES00 2>NUL


IF EXIST RunMbr.dat IF NOT EXIST W6432.dat (
	MBR.DAT -U
	MBR.DAT -t -s >MBR.txt
	IF EXIST MBR.txt FINDSTR -R "MBR.rootkit.infection.detected user.!=.kernel.MBR.!!! TDL4.rootkit \\Driver\\Disk\[.*->.IRP_MJ_CREATE.->  \\Driver\\[^\\]*DriverStartIo.-> \\Device\\.*->.*device.not.found" MBR.txt &&(
		ECHO.
		ECHO.=================== ROOTKIT  ====================
		ECHO.
		TYPE MBR.TXT
		)>>DDS00
	DEL MBR.TXT
	DEL MBR.LOG
	)>NUL 2>&1


@(
IF EXIST W6432.dat (	SED.DAT -r "s/%SysDir:\=\\%/%sysdir:\=\\%/Ig" DDS00
	) ELSE SED.DAT -r "s/(.:\\.*)(\\[^\\]*)/\L\1\E\2/" DDS00
ECHO.
ECHO.============= FINISH: %TIME% ===============
)>>DDS.txt


IF EXIST ..\DDS.txt DEL /A/F ..\DDS.txt >NUL 2>&1
SED.DAT "s/^$/./" DDS.txt > ..\DDS.txt
DEL /Q temp0? DDS00 W6432.dat Vista.krl Vista.mac W?.mac XP.mac SvcWhtDDS*.DLL MSClsid.EXE policies.exe notifykeysB.com NOWHTLIST >NUL 2>&1


REM CALL :ScrText

EXIT


:SUPP
@IF EXIST IFEO.txt (
	ECHO.
	ECHO.==== Image File Execution Options =============
	ECHO.
	TYPE IFEO.txt
	)>>Attach.txt


@IF EXIST HOSTS (
	ECHO.
	ECHO.==== Hosts File Hijack ======================
	ECHO.
	TYPE HOSTS
	)>>Attach.txt



@(
ECHO.
ECHO.==== Installed Programs ======================
ECHO.
)>>Attach.txt


IF EXIST UninstallList.txt (
SORT.exe /M 65536 UninstallList.txt  /T %TMP% /O temp02
SED.DAT "$!N; /^\(.*\)\n\1$/I!P; D" temp02 >>Attach.txt
DEL /Q temp0? UninstallList.txt
)>NUL 2>&1

IF EXIST Event.txt FINDSTR.EXE . Event.txt >NUL &&(
ECHO.>>Attach.txt
ECHO.==== Event Viewer Messages From Past Week ========>>Attach.txt
ECHO.>>Attach.txt
SED.DAT "/^$/d;" Event.txt | SED.DAT -R ":a; $!N; s/\n([^\d])/ \1/;ta;P;D" >temp00
SED.DAT -r -n "G; s/\n/&&/; /^([ -~]*)(\]  - [ -~]*\n).*\n[^\n]*\2/d; s/\n//; h; P" temp00 >temp01
SORT.EXE /M 65536 /R temp01  /T %TMP% >>Attach.txt
)>NUL 2>&1



@(
ECHO.
ECHO.==== End Of File ===========================
)>>Attach.txt


SED.DAT "s/^$/./" Attach.txt > ..\Attach.txt

EXIT


:WhtDir
@DIR Vista.mac W7.mac >NUL 2>&1 &&@(
ECHO."%commonappdata%\Templates"
ECHO."%commonappdata%\Start Menu"
ECHO."%commonappdata%\Favorites"
ECHO."%commonappdata%\Documents"
ECHO."%commonappdata%\Desktop"
ECHO."%commonappdata%\Application Data"
ECHO."%userprofile%\Contacts"
ECHO."%userprofile%\Documents"
ECHO."%userprofile%\Downloads"
ECHO."%userprofile%\Links"
ECHO."%userprofile%\Music"
ECHO."%userprofile%\Pictures"
ECHO."%userprofile%\Saved Games"
ECHO."%userprofile%\Videos"
ECHO."%userprofile%\AppData"
ECHO."%userprofile%\Searches"
)>WhiteDir00


@>>WhiteDir00 (
ECHO."%allusersprofile%\application data"
ECHO."%allusersprofile%\cookies"
ECHO."%allusersprofile%\desktop"
ECHO."%allusersprofile%\favorites"
ECHO."%allusersprofile%\local settings"
ECHO."%allusersprofile%\my documents"
ECHO."%allusersprofile%\nethood"
ECHO."%allusersprofile%\ntuser.dat"
ECHO."%allusersprofile%\printhood"
ECHO."%allusersprofile%\recent"
ECHO."%allusersprofile%\sendto"
ECHO."%allusersprofile%\start menu"
ECHO."%allusersprofile%\templates"
ECHO."%appdata%\acccore"
ECHO."%appdata%\Acronis"
ECHO."%appdata%\Active Disk"
ECHO."%appdata%\Adobe"
ECHO."%appdata%\AdobeUM"
ECHO."%appdata%\Ahead"
ECHO."%appdata%\Aim"
ECHO."%appdata%\AltrixSoft"
ECHO."%appdata%\Apple Computer"
ECHO."%appdata%\ArcSoft"
ECHO."%appdata%\ATI"
ECHO."%appdata%\Common Files"
ECHO."%appdata%\Corel"
ECHO."%appdata%\Creative"
ECHO."%appdata%\CyberLink"
ECHO."%appdata%\DivX"
ECHO."%appdata%\dvdcss"
ECHO."%appdata%\EPSON"
ECHO."%appdata%\FileZilla"
ECHO."%appdata%\FUJIFILM"
ECHO."%appdata%\Google"
ECHO."%appdata%\GTek"
ECHO."%appdata%\gtk-2.0"
ECHO."%appdata%\Help"
ECHO."%appdata%\Hewlett-Packard"
ECHO."%appdata%\HP"
ECHO."%appdata%\HPappdata"
ECHO."%appdata%\IceChat"
ECHO."%appdata%\Identities"
ECHO."%appdata%\Image Zone Express"
ECHO."%appdata%\ImgBurn"
ECHO."%appdata%\InstallShield"
ECHO."%appdata%\interMute"
ECHO."%appdata%\InterVideo"
ECHO."%appdata%\Ipswitch"
ECHO."%appdata%\Lavasoft"
ECHO."%appdata%\Leadertech"
ECHO."%appdata%\Learn2.com"
ECHO."%appdata%\Logitech"
ECHO."%appdata%\Macromedia"
ECHO."%appdata%\Media Center Programs"
ECHO."%appdata%\Media Player Classic"
ECHO."%appdata%\Microsoft Web Folders"
ECHO."%appdata%\Microsoft"
ECHO."%appdata%\Motive"
ECHO."%appdata%\Mozilla"
ECHO."%appdata%\muvee Technologies"
ECHO."%appdata%\Nero"
ECHO."%appdata%\Notepad++"
ECHO."%appdata%\OpenOffice.org2"
ECHO."%appdata%\Opera"
ECHO."%appdata%\Orbit"
ECHO."%appdata%\Panasonic"
ECHO."%appdata%\Real"
ECHO."%appdata%\Roxio"
ECHO."%appdata%\SampleView"
ECHO."%appdata%\SecuROM"
ECHO."%appdata%\Share-to-Web Upload Folder"
ECHO."%appdata%\Skype"
ECHO."%appdata%\skypePM"
ECHO."%appdata%\SmartFTP"
ECHO."%appdata%\Sonic"
ECHO."%appdata%\Sun"
ECHO."%appdata%\Talkback"
ECHO."%appdata%\teamspeak2"
ECHO."%appdata%\Template"
ECHO."%appdata%\Thunderbird"
ECHO."%appdata%\Toshiba"
ECHO."%appdata%\U3"
ECHO."%appdata%\Ventrilo"
ECHO."%appdata%\VMware"
ECHO."%appdata%\Winamp"
ECHO."%appdata%\WinRAR"
ECHO."%appdata%\Yahoo! Messenger"
ECHO."%appdata%\Yahoo!"
ECHO."%commonappdata%\Acronis"
ECHO."%commonappdata%\Adobe Systems"
ECHO."%commonappdata%\Adobe"
ECHO."%commonappdata%\AOL Downloads"
ECHO."%commonappdata%\AOL OCP"
ECHO."%commonappdata%\AOL"
ECHO."%commonappdata%\Apple Computer"
ECHO."%commonappdata%\Apple"
ECHO."%commonappdata%\Bluetooth"
ECHO."%commonappdata%\CanonBJ"
ECHO."%commonappdata%\CyberLink"
ECHO."%commonappdata%\ESET"
ECHO."%commonappdata%\FLEXnet"
ECHO."%commonappdata%\Google Updater"
ECHO."%commonappdata%\Google"
ECHO."%commonappdata%\GTek"
ECHO."%commonappdata%\Help"
ECHO."%commonappdata%\Hewlett-Packard"
ECHO."%commonappdata%\HP Product Assistant"
ECHO."%commonappdata%\HP"
ECHO."%commonappdata%\HPSSUPPLY"
ECHO."%commonappdata%\Identities"
ECHO."%commonappdata%\InstallShield"
ECHO."%commonappdata%\Logishrd"
ECHO."%commonappdata%\Logitech"
ECHO."%commonappdata%\Macromedia"
ECHO."%commonappdata%\MailFrontier"
ECHO."%commonappdata%\McAfee"
ECHO."%commonappdata%\Microsoft Help"
ECHO."%commonappdata%\Microsoft"
ECHO."%commonappdata%\Motive"
ECHO."%commonappdata%\Mozilla"
ECHO."%commonappdata%\muvee Technologies"
ECHO."%commonappdata%\NOS"
ECHO."%commonappdata%\NVIDIA"
ECHO."%commonappdata%\Office Genuine Advantage"
ECHO."%commonappdata%\Opera"
ECHO."%commonappdata%\QuickTime"
ECHO."%commonappdata%\Raxco"
ECHO."%commonappdata%\Razer"
ECHO."%commonappdata%\Real"
ECHO."%commonappdata%\RoboForm"
ECHO."%commonappdata%\Roxio"
ECHO."%commonappdata%\SiteAdvisor"
ECHO."%commonappdata%\Skype"
ECHO."%commonappdata%\Sonic"
ECHO."%commonappdata%\Sun"
ECHO."%commonappdata%\Support.com"
ECHO."%commonappdata%\TechSmith"
ECHO."%commonappdata%\TEMP"
ECHO."%commonappdata%\Toshiba"
ECHO."%commonappdata%\ToshibaEurope"
ECHO."%commonappdata%\Ulead Systems"
ECHO."%commonappdata%\VMware"
ECHO."%commonappdata%\Windows Genuine Advantage"
ECHO."%commonappdata%\WindowsSearch"
ECHO."%commonappdata%\WinRAR"
ECHO."%commonappdata%\WLInstaller"
ECHO."%commonappdata%\Yahoo! Companion"
ECHO."%commonappdata%\yahoo!"
ECHO."%commonappdata%\Yahoo"
ECHO."%commonProgFiles%"
ECHO."%commonProgFiles%\Adobe"
ECHO."%commonProgFiles%\designer"
ECHO."%commonProgFiles%\Java"
ECHO."%commonProgFiles%\Logishrd"
ECHO."%commonProgFiles%\microsoft shared"
ECHO."%commonProgFiles%\Nero"
ECHO."%commonProgFiles%\services"
ECHO."%commonProgFiles%\system"
ECHO."%ProgFiles%\7-Zip"
ECHO."%ProgFiles%\Acronis"
ECHO."%ProgFiles%\adobe"
ECHO."%ProgFiles%\AGEIA Technologies"
ECHO."%ProgFiles%\Ahead"
ECHO."%ProgFiles%\Alwil Software"
ECHO."%ProgFiles%\antivir personaledition classic"
ECHO."%ProgFiles%\aol"
ECHO."%ProgFiles%\Apple Software Update"
ECHO."%ProgFiles%\ArcSoft"
ECHO."%ProgFiles%\Aspell"
ECHO."%ProgFiles%\Borland"
ECHO."%ProgFiles%\CanonBJ"
ECHO."%ProgFiles%\common files\Acronis"
ECHO."%ProgFiles%\common files\Adobe AIR"
ECHO."%ProgFiles%\common files\Ahead"
ECHO."%ProgFiles%\common files\Apple"
ECHO."%ProgFiles%\common files\ArcSoft"
ECHO."%ProgFiles%\common files\InstallShield"
ECHO."%ProgFiles%\common files\LightScribe"
ECHO."%ProgFiles%\common files\Roxio Shared"
ECHO."%ProgFiles%\complus applications"
ECHO."%ProgFiles%\CyberLink"
ECHO."%ProgFiles%\Debugging Tools for Windows"
ECHO."%ProgFiles%\DIFX"
ECHO."%ProgFiles%\Electronic Arts"
ECHO."%ProgFiles%\FileZilla FTP Client"
ECHO."%ProgFiles%\FinePixViewer"
ECHO."%ProgFiles%\Gabest"
ECHO."%ProgFiles%\GameSpy"
ECHO."%ProgFiles%\Google"
ECHO."%ProgFiles%\grisoft"
ECHO."%ProgFiles%\Hewlett-Packard"
ECHO."%ProgFiles%\hijackthis"
ECHO."%ProgFiles%\ieak"
ECHO."%ProgFiles%\ImgBurn"
ECHO."%ProgFiles%\InstallShield Installation Information"
ECHO."%ProgFiles%\Intel"
ECHO."%ProgFiles%\internet explorer"
ECHO."%ProgFiles%\Java"
ECHO."%ProgFiles%\Logitech"
ECHO."%ProgFiles%\microsoft frontpage"
ECHO."%ProgFiles%\Microsoft LifeChat"
ECHO."%ProgFiles%\microsoft office"
ECHO."%ProgFiles%\Microsoft Silverlight"
ECHO."%ProgFiles%\Microsoft Sync Framework"
ECHO."%ProgFiles%\Microsoft Visual Studio .NET 2003"
ECHO."%ProgFiles%\Microsoft Visual Studio ^8"
ECHO."%ProgFiles%\microsoft visual studio"
ECHO."%ProgFiles%\Microsoft Works"
ECHO."%ProgFiles%\Microsoft.NET"
ECHO."%ProgFiles%\Movie Maker"
ECHO."%ProgFiles%\mozilla firefox"
ECHO."%ProgFiles%\Mozilla Thunderbird"
ECHO."%ProgFiles%\MSBuild"
ECHO."%ProgFiles%\msn"
ECHO."%ProgFiles%\Nero ^9"
ECHO."%ProgFiles%\netmeeting"
ECHO."%ProgFiles%\NOS"
ECHO."%ProgFiles%\Notepad++"
ECHO."%ProgFiles%\Opera"
ECHO."%ProgFiles%\orktools"
ECHO."%ProgFiles%\outlook express"
ECHO."%ProgFiles%\Panasonic"
ECHO."%ProgFiles%\Pawsoft"
ECHO."%ProgFiles%\pepimk software"
ECHO."%ProgFiles%\PuTTY"
ECHO."%ProgFiles%\QuickTime"
ECHO."%ProgFiles%\Razer"
ECHO."%ProgFiles%\Recuva"
ECHO."%ProgFiles%\Reference Assemblies"
ECHO."%ProgFiles%\registry mechanic"
ECHO."%ProgFiles%\Smart Projects"
ECHO."%ProgFiles%\TechSmith"
ECHO."%ProgFiles%\Trillian"
ECHO."%ProgFiles%\Ubisoft"
ECHO."%ProgFiles%\uninstall information"
ECHO."%ProgFiles%\Warcraft III"
ECHO."%ProgFiles%\Winamp"
ECHO."%ProgFiles%\Windows Calendar"
ECHO."%ProgFiles%\Windows Defender"
ECHO."%ProgFiles%\Windows Live Safety Center"
ECHO."%ProgFiles%\Windows Live"
ECHO."%ProgFiles%\Windows Mail"
ECHO."%ProgFiles%\Windows Media Connect ^2"
ECHO."%ProgFiles%\windows media player"
ECHO."%ProgFiles%\Windows Photo Gallery"
ECHO."%ProgFiles%\Windows Sidebar"
ECHO."%ProgFiles%\winrar"
ECHO."%ProgFiles%\winzip"
ECHO."%ProgFiles%\xerox"
ECHO."%ProgFiles%\Zune"
ECHO."%System%\%KMD%"
ECHO."%System%\actskin4.ocx"
ECHO."%System%\advpack.dll"
ECHO."%System%\asuninst.exe"
ECHO."%System%\aswBoot.exe"
ECHO."%System%\AvastSS.scr"
ECHO."%System%\avsda.dll"
ECHO."%System%\bassmod.dll"
ECHO."%System%\browseui.dll"
ECHO."%System%\CanonIJ Uninstaller Information"
ECHO."%System%\capicom.dll"
ECHO."%System%\cdfview.dll"
ECHO."%System%\cdm.dll"
ECHO."%System%\d3dx9_24.dll"
ECHO."%System%\d3dx9_25.dll"
ECHO."%System%\d3dx9_27.dll"
ECHO."%System%\d3dx9_28.dll"
ECHO."%System%\d3dx9_29.dll"
ECHO."%System%\d3dx9_30.dll"
ECHO."%System%\danim.dll"
ECHO."%System%\dfrgntfs.exe"
ECHO."%System%\dhcpcsvc.dll"
ECHO."%System%\dllhost.exe"
ECHO."%System%\dnsapi.dll"
ECHO."%System%\drivers\aavmker4.sys"
ECHO."%System%\drivers\apt.sys"
ECHO."%System%\drivers\aswFsBlk.sys"
ECHO."%System%\drivers\aswmon.sys"
ECHO."%System%\drivers\aswmon2.sys"
ECHO."%System%\drivers\aswRdr.sys"
ECHO."%System%\drivers\aswSP.sys"
ECHO."%System%\drivers\aswTdi.sys"
ECHO."%System%\drivers\avg7core.sys"
ECHO."%System%\drivers\avg7rsw.sys"
ECHO."%System%\drivers\avg7rsxp.sys"
ECHO."%System%\drivers\avgclean.sys"
ECHO."%System%\drivers\avgmfx86.sys"
ECHO."%System%\drivers\avgntdd.sys"
ECHO."%System%\drivers\avgntmgr.sys"
ECHO."%System%\drivers\avgtdi.sys"
ECHO."%System%\drivers\avipbb.sys"
ECHO."%System%\drivers\cmdmon.sys"
ECHO."%System%\drivers\gmer.sys"
ECHO."%System%\drivers\inspect.sys"
ECHO."%System%\drivers\klick.sys"
ECHO."%System%\drivers\klif.sys"
ECHO."%System%\drivers\klin.sys"
ECHO."%System%\drivers\pxcom.sys"
ECHO."%System%\drivers\pxemu.sys"
ECHO."%System%\drivers\pxfsf.sys"
ECHO."%System%\drivers\pxrd.sys"
ECHO."%System%\drivers\pxscrmbl.sys"
ECHO."%System%\drivers\pxtdi.sys"
ECHO."%System%\drivers\rrspy.sys"
ECHO."%System%\drivers\rrspy64.sys"
ECHO."%System%\drivers\ssmdrv.sys"
ECHO."%System%\drivers\UMDF"
ECHO."%System%\drivers\USBSTOR.SYS"
ECHO."%System%\DRVSTORE"
ECHO."%System%\dxtmsft.dll"
ECHO."%System%\dxtrans.dll"
ECHO."%System%\en-us"
ECHO."%System%\extmgr.dll"
ECHO."%System%\fntcache.dat"
ECHO."%System%\hal.dll"
ECHO."%System%\icardie.dll"
ECHO."%System%\ie4uinit.exe"
ECHO."%System%\ieakeng.dll"
ECHO."%System%\ieaksie.dll"
ECHO."%System%\ieakui.dll"
ECHO."%System%\ieapfltr.dat"
ECHO."%System%\ieapfltr.dll"
ECHO."%System%\iedkcs32.dll"
ECHO."%System%\ieframe.dll"
ECHO."%System%\iepeers.dll"
ECHO."%System%\iernonce.dll"
ECHO."%System%\iertutil.dll"
ECHO."%System%\ieudinit.exe"
ECHO."%System%\ieui.dll"
ECHO."%System%\imon1.dat"
ECHO."%System%\inseng.dll"
ECHO."%System%\iphlpapi.dll"
ECHO."%System%\java.exe"
ECHO."%System%\javaw.exe"
ECHO."%System%\javaws.exe"
ECHO."%System%\jgdw400.dll"
ECHO."%System%\jgpl400.dll"
ECHO."%System%\jscript.dll"
ECHO."%System%\jsproxy.dll"
ECHO."%System%\kbdaze.dll"
ECHO."%System%\kbdblr.dll"
ECHO."%System%\kbdbu.dll"
ECHO."%System%\kbdkaz.dll"
ECHO."%System%\kbdru.dll"
ECHO."%System%\kbdru1.dll"
ECHO."%System%\kbdtat.dll"
ECHO."%System%\kbdur.dll"
ECHO."%System%\kbduzb.dll"
ECHO."%System%\kbdycc.dll"
ECHO."%System%\kernel32.dll"
ECHO."%System%\legitcheckcontrol.dll"
ECHO."%System%\libeay32_0.9.6l.dll"
ECHO."%System%\Macromed"
ECHO."%System%\mapi32.dll"
ECHO."%System%\mrt.exe"
ECHO."%System%\msfeeds.dll"
ECHO."%System%\msfeedsbs.dll"
ECHO."%System%\msfeedssync.exe"
ECHO."%System%\msftedit.dll"
ECHO."%System%\mshtml.dll"
ECHO."%System%\mshtmled.dll"
ECHO."%System%\msrating.dll"
ECHO."%System%\mstime.dll"
ECHO."%System%\netapi32.dll"
ECHO."%System%\occache.dll"
ECHO."%System%\perfc009.dat"
ECHO."%System%\perfh009.dat"
ECHO."%System%\pncrt.dll"
ECHO."%System%\pndx5016.dll"
ECHO."%System%\pndx5032.dll"
ECHO."%System%\pngfilt.dll"
ECHO."%System%\px.dll"
ECHO."%System%\pxcpya64.exe"
ECHO."%System%\pxdrv.dll"
ECHO."%System%\pxhpinst.exe"
ECHO."%System%\pxinsa64.exe"
ECHO."%System%\pxinst.dll"
ECHO."%System%\pxmas.dll"
ECHO."%System%\pxsfs.dll"
ECHO."%System%\pxwave.dll"
ECHO."%System%\rasadhlp.dll"
ECHO."%System%\rasmans.dll"
ECHO."%System%\riched20.dll"
ECHO."%System%\rmoc3260.dll"
ECHO."%System%\rrsec.dll"
ECHO."%System%\rrsec2k.exe"
ECHO."%System%\shdocvw.dll"
ECHO."%System%\shell32.dll"
ECHO."%System%\shlwapi.dll"
ECHO."%System%\shsvcs.dll"
ECHO."%System%\sp2res.dll"
ECHO."%System%\spmsg.dll"
ECHO."%System%\ssiefr.EXE"
ECHO."%System%\STKIT432.DLL"
ECHO."%System%\streamhlp.dll"
ECHO."%System%\SWSC.exe"
ECHO."%System%\tzchange.exe"
ECHO."%System%\url.dll"
ECHO."%System%\urlmon.dll"
ECHO."%System%\vsdata.dll"
ECHO."%System%\vsdatant.sys"
ECHO."%System%\vsinit.dll"
ECHO."%System%\vsmonapi.dll"
ECHO."%System%\vspubapi.dll"
ECHO."%System%\vsregexp.dll"
ECHO."%System%\vsutil.dll"
ECHO."%System%\vswmi.dll"
ECHO."%System%\vsxml.dll"
ECHO."%System%\vxblock.dll"
ECHO."%System%\webcheck.dll"
ECHO."%System%\WgaLogon.dll"
ECHO."%System%\wgatray.exe"
ECHO."%System%\wiaservc.dll"
ECHO."%System%\windowspowershell"
ECHO."%System%\winfxdocobj.exe"
ECHO."%System%\wmp.dll"
ECHO."%System%\wmvcore.dll"
ECHO."%System%\SWREG.exe"
ECHO."%System%\WRLogonNtf.dll"
ECHO."%System%\wrlzma.dll"
ECHO."%System%\wuapi.dll"
ECHO."%System%\wuauclt.exe"
ECHO."%System%\wuaueng.dll"
ECHO."%System%\wucltui.dll"
ECHO."%System%\wups.dll"
ECHO."%System%\wups2.dll"
ECHO."%System%\wuweb.dll"
ECHO."%System%\x3daudio1_0.dll"
ECHO."%System%\xactengine2_0.dll"
ECHO."%System%\xactengine2_1.dll"
ECHO."%System%\xactengine2_2.dll"
ECHO."%System%\xinput1_1.dll"
ECHO."%System%\xinput9_1_0.dll"
ECHO."%System%\xmllite.dll"
ECHO."%System%\xpsp3res.dll"
ECHO."%System%\zlcomm.dll"
ECHO."%System%\zlcommdb.dll"
ECHO."%System%\ZPORT4AS.dll"
ECHO."%Systemdrive%\32788R22FWJFW"
ECHO."%Systemdrive%\autoexec.bat"
ECHO."%Systemdrive%\Avenger"
ECHO."%Systemdrive%\boot.bak"
ECHO."%Systemdrive%\boot.ini"
ECHO."%Systemdrive%\cmldr"
ECHO."%Systemdrive%\Config.Msi"
ECHO."%Systemdrive%\config.sys"
ECHO."%Systemdrive%\hiberfil.sys"
ECHO."%Systemdrive%\io.sys"
ECHO."%Systemdrive%\msdos.sys"
ECHO."%Systemdrive%\MSOCache"
ECHO."%Systemdrive%\ntdetect.com"
ECHO."%Systemdrive%\pagefile.sys"
ECHO."%Systemdrive%\Qoobox"
ECHO."%Systemdrive%\RECYCLER"
ECHO."%Systemdrive%\rsit"
ECHO."%Systemdrive%\System Volume Information"
ECHO."%SystemRoot%\arclib.dll"
ECHO."%SystemRoot%\assembly"
ECHO."%SystemRoot%\avxoscan"
ECHO."%SystemRoot%\BDOSCAN8"
ECHO."%SystemRoot%\bootstat.dat"
ECHO."%SystemRoot%\CSC"
ECHO."%SystemRoot%\Debug"
ECHO."%SystemRoot%\SED.DAT"
ECHO."%SystemRoot%\fdsv.exe"
ECHO."%SystemRoot%\gmer.bat"
ECHO."%SystemRoot%\gmer.dll"
ECHO."%SystemRoot%\gmer.exe"
ECHO."%SystemRoot%\gmer.reg"
ECHO."%SystemRoot%\gmer_uninstall.cmd"
ECHO."%SystemRoot%\grep.exe"
ECHO."%SystemRoot%\History"
ECHO."%SystemRoot%\ie7"
ECHO."%SystemRoot%\ie7updates"
ECHO."%SystemRoot%\LastGood"
ECHO."%SystemRoot%\libeay32.dll"
ECHO."%SystemRoot%\microsoft.net"
ECHO."%SystemRoot%\Minidump"
ECHO."%SystemRoot%\NIRCMD.exe"
ECHO."%SystemRoot%\nsreg.dat"
ECHO."%SystemRoot%\pchealth\helpctr\Config\Cntstore.bin"
ECHO."%SystemRoot%\pchealth\helpctr\PackageStore\SkuStore.bin"
ECHO."%SystemRoot%\Prefetch"
ECHO."%SystemRoot%\psexesvc.exe"
ECHO."%SystemRoot%\SoftwareDistribution"
ECHO."%SystemRoot%\ssleay32.dll"
ECHO."%SystemRoot%\streamhlp.dll"
ECHO."%SystemRoot%\Sun"
ECHO."%SystemRoot%\SWSC.exe"
ECHO."%SystemRoot%\SWXCACLS.exe"
ECHO."%SystemRoot%\symbols"
ECHO."%SystemRoot%\temp"
ECHO."%SystemRoot%\Temporary Internet Files"
ECHO."%SystemRoot%\VFIND.exe"
ECHO."%SystemRoot%\wbem"
ECHO."%SystemRoot%\SWREG.exe"
ECHO."%SystemRoot%\WRUninstall.dll"
ECHO."%SystemRoot%\zip.exe"
ECHO."%userprofile%\application data"
ECHO."%userprofile%\cookies"
ECHO."%userprofile%\desktop"
ECHO."%userprofile%\favorites"
ECHO."%userprofile%\local settings"
ECHO."%userprofile%\my documents"
ECHO."%userprofile%\nethood"
ECHO."%userprofile%\ntuser.dat"
ECHO."%userprofile%\printhood"
ECHO."%userprofile%\recent"
ECHO."%userprofile%\sendto"
ECHO."%userprofile%\start menu"
ECHO."%userprofile%\templates"
ECHO."%commonappdata%\BenQ"
ECHO."%commonappdata%\DVD Shrink"
ECHO."%commonappdata%\nView_Profiles"
ECHO."%commonappdata%\OLYMPUS"
ECHO."%commonappdata%\Pinnacle"
ECHO."%commonProgFiles%\Skype"
ECHO."%appdata%\Alien Skin"
ECHO."%appdata%\Gearbox Software"
ECHO."%appdata%\GlobalSCAPE"
ECHO."%appdata%\Snapfish"
ECHO."%appdata%\Sony Corporation"
ECHO."%ProgFiles%\ERUNT"
ECHO."%ProgFiles%\Safari"
ECHO."%appdata%\3M"
ECHO."%appdata%\Amazon"
ECHO."%appdata%\Audacity"
ECHO."%appdata%\Bioshock"
ECHO."%appdata%\Canon"
ECHO."%appdata%\DAEMON Tools"
ECHO."%appdata%\Datalayer"
ECHO."%appdata%\DeepBurner"
ECHO."%appdata%\Download Manager"
ECHO."%appdata%\Eltima Software"
ECHO."%appdata%\FileMaker"
ECHO."%appdata%\FVSTemp"
ECHO."%appdata%\Games"
ECHO."%appdata%\GEAR Video 8.01"
ECHO."%appdata%\GRETECH"
ECHO."%appdata%\Hamachi"
ECHO."%appdata%\HotSync"
ECHO."%appdata%\ICQ"
ECHO."%appdata%\IDMComp"
ECHO."%appdata%\IFViewer"
ECHO."%appdata%\IGN_DLM"
ECHO."%appdata%\Imagenomic"
ECHO."%appdata%\InstallShield Installation Information"
ECHO."%appdata%\InterTrust"
ECHO."%appdata%\Jasc Software Inc"
ECHO."%appdata%\Move Networks"
ECHO."%appdata%\MSN6"
ECHO."%appdata%\Music Recognition"
ECHO."%appdata%\Musicmatch"
ECHO."%appdata%\NCH Swift Sound"
ECHO."%appdata%\Netscape"
ECHO."%appdata%\Nikon"
ECHO."%appdata%\Nitro PDF"
ECHO."%appdata%\Nokia Multimedia Player"
ECHO."%appdata%\Nokia"
ECHO."%appdata%\OfficeUpdate12"
ECHO."%appdata%\Oracle"
ECHO."%appdata%\OurPictures"
ECHO."%appdata%\PC Suite"
ECHO."%appdata%\pdf995"
ECHO."%appdata%\PlayFirst"
ECHO."%appdata%\Publish Providers"
ECHO."%appdata%\RecordPad"
ECHO."%appdata%\ScanSoft"
ECHO."%appdata%\SecondLife"
ECHO."%appdata%\SlySoft"
ECHO."%appdata%\Snapfish"
ECHO."%appdata%\Sony Setup"
ECHO."%appdata%\Sony"
ECHO."%appdata%\SoundSpectrum"
ECHO."%appdata%\SPORE Creature Creator"
ECHO."%appdata%\Syntrillium"
ECHO."%appdata%\SystemRequirementsLab"
ECHO."%appdata%\tunebite"
ECHO."%appdata%\VERITAS"
ECHO."%appdata%\Vidalia"
ECHO."%appdata%\Viewpoint"
ECHO."%appdata%\vlc"
ECHO."%appdata%\VoipStunt"
ECHO."%appdata%\Vso"
ECHO."%commonappdata%\{3276BE95_AF08_429F_A64F_CA64CB79BCF6}"
ECHO."%commonappdata%\1Click DVD Copy Pro"
ECHO."%commonappdata%\Ahead"
ECHO."%commonappdata%\Autodesk"
ECHO."%commonappdata%\Avery"
ECHO."%commonappdata%\Avg7"
ECHO."%commonappdata%\BVRP Software"
ECHO."%commonappdata%\Creative"
ECHO."%commonappdata%\Dell"
ECHO."%commonappdata%\DIGStream"
ECHO."%commonappdata%\EnterNHelp"
ECHO."%commonappdata%\Fallout3"
ECHO."%commonappdata%\HotSync"
ECHO."%commonappdata%\Installations"
ECHO."%commonappdata%\Ipswitch"
ECHO."%commonappdata%\Lavasoft"
ECHO."%commonappdata%\Macrovision"
ECHO."%commonappdata%\Microsoft Corporation"
ECHO."%commonappdata%\MSN6"
ECHO."%commonappdata%\NCH Software"
ECHO."%commonappdata%\NCH Swift Sound"
ECHO."%commonappdata%\Nikon"
ECHO."%commonappdata%\Nitro PDF"
ECHO."%commonappdata%\PC Suite"
ECHO."%commonappdata%\PlayFirst"
ECHO."%commonappdata%\ScanSoft"
ECHO."%commonappdata%\SlySoft"
ECHO."%commonappdata%\Sony"
ECHO."%commonappdata%\Storm"
ECHO."%commonappdata%\SupportSoft"
ECHO."%commonappdata%\TrackMania United"
ECHO."%commonappdata%\TrackMania"
ECHO."%commonappdata%\Ultima_T15"
ECHO."%commonappdata%\Windows Live Toolbar"
ECHO."%commonappdata%\Winferno"
ECHO."%commonappdata%\WinZip"
ECHO."%ProgFiles%\CDBurnerXP"
ECHO."%ProgFiles%\FLV Player"
ECHO."%ProgFiles%\Microsoft SDKs"
ECHO."%ProgFiles%\Microsoft Visual Studio 9.0"
ECHO."%ProgFiles%\RegCure"
ECHO."%ProgFiles%\Registry Fix 3.0.2"
ECHO."%commonappdata%\Intel"
ECHO."%ProgFiles%\OpenECU"
ECHO."%ProgFiles%\Real"
ECHO."%appdata%\ijjigame"
ECHO."%appdata%\Ulead Systems"
ECHO."%commonappdata%\ATI"
ECHO."%commonappdata%\Ubisoft"
ECHO."%ProgFiles%\Adobe Media Player"
ECHO."%ProgFiles%\EphPod"
ECHO."%ProgFiles%\Photomatix"
)

@GOTO :EOF


:SvcDrvB
IF NOT EXIST %System%\SC.exe GOTO :EOF
SC.EXE queryex type= all state= all >temp0A
SED.DAT -r "/^SERVICE|^DISPLAY_NAME|^ *STATE +/I!d; s///; /^: [0-4]/s/  .*//;" temp0A >temp0B
SED.DAT ":a; $!N; s/\n: /;/;ta;P;D;" temp0B >temp0C
SED.DAT -R "s/^_NAME: (.*;.*);(\d)/\2\t\1/; s/^1/R?/; s/^4/S?/;" temp0C >svclist.dat
@DEL temp0A temp0B temp0c
@GOTO :EOF


:ScrText
@GOTO :EOF
@IF EXIST RunSilent.dat GOTO :EOF
@SET "Scrtxt_=%Scrtxt_%####"
@CLS
@TYPE Screentxt
@ECHO. %Scrtxt_%
@GOTO :EOF



