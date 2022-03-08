
#AutoIt3Wrapper_Run_AU3Check=Y
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7

#CS
	HISTORY and RELASE NOTES
	2013/10/17 @jguinch
	* creation of this UDF

	2016/07/28 @jguinch
	* added - EnumPrinter()
    * added - Pause()
    * added - PrinterExists()
    * added - PrintTestPage()
    * added - RenamePrinter()
    * added - Resume()

	2016/08/19 @jguinch
	* fixed - in _PrintMgr_EnumPrinter()

	2016/08/24 @jguinch
	* fixed - in _PrintMgr_SetDefaultPrinter()

	2016/10/24 @Joboy2k
	* fixed in _PrintMgr_RemovePrinter()

	2017/01/31
	* added - _PrintMgr_AddLPRPort()
	* added - _PrintMgr_RemoveLPRPort()

	2017/02/04 @jguinch and @Danyfirex
	* added - _Printmgr_EnumPorts()
	* added - _Printmgr_PortExists()
	* added - _Printmgr_PrinterSetDriver()
	* added - _Printmgr_PrinterSetPort()

	2017/02/05 @jguinch
	* added -  _Printmgr_PrinterSetComment()
	* added - _Printmgr_PrinterShare()

	2017/04/09 @Raceraut
	* fixed in _PrintMgr_AddWindowsPrinterConnection

	2020/09/22 @mlipok
	* changed - little refactor to be compilant with Au3Check

	2020/09/24 @jguinch
	* fixed - issue which @mLipok found thanks to Au3Check - .SpawnInstance _
	* fixed - in _PrintMgr_RemoveLPRPort() function header/documentation _AddLocalPrinterPort >> _PrintMgr_AddLPRPort

	2020/09/25 @mlipok
	* added - HISTORY and RELASE NOTES
	* fixed - in _PrintMgr_RemoveLocalPort() function header/documentation _AddLocalPrinterPort >> _PrintMgr_AddLocalPort
	* changed - proper functions name _Printmgr_* >> _PrintMgr_*
	* changed - modified example - fixed for Au3Check compilance and fixed function names

	2020/10/04 @jguinch
	* changed - HISTORY and RELASE NOTES

	2020/11/17 @maniootek
	* added - $PRINTMGR_* constants in _PrintMgr_EnumPrinterProperties, _PrintMgr_EnumPrinterConfiguration, _PrintMgr_EnumPrinterDriver and _PrintMgr_EnumTCPIPPrinterPort

	2021/12/20 @jguinch
	* added - _PrintMgr_CancelPrintJob
	* added - _PrintMgr_EnumPrintJobs

	2022/01/20 @jguinch
	* fixed - functions using a printerName parameter didn't work when the specified value was containing backslashes (ex : \\printserver\printers*)
#CE

#CS
	https://www.autoitscript.com/forum/topic/155485-printers-management-udf/
	UDF title : Printmgr.au3

	Available functions :
	_PrintMgr_AddLocalPort
	_PrintMgr_AddLPRPort
	_PrintMgr_AddPrinter
	_PrintMgr_AddPrinterDriver
	_PrintMgr_AddTCPIPPrinterPort
	_PrintMgr_AddWindowsPrinterConnection
	_PrintMgr_CancelAllJobs
	_PrintMgr_CancelPrintJob
	_PrintMgr_EnumPorts
	_PrintMgr_EnumPrinter
	_PrintMgr_EnumPrinterConfiguration
	_PrintMgr_EnumPrinterDriver
	_PrintMgr_EnumPrinterProperties
	_PrintMgr_EnumPrintJobs
	_PrintMgr_EnumTCPIPPrinterPort
	_PrintMgr_Pause
	_PrintMgr_PortExists
	_PrintMgr_PrinterExists
	_PrintMgr_PrinterSetComment
	_PrintMgr_PrinterSetDriver
	_PrintMgr_PrinterSetPort
	_PrintMgr_PrinterShare
	_PrintMgr_PrintTestPage
	_PrintMgr_RemoveLocalPort
	_PrintMgr_RemoveLPRPort
	_PrintMgr_RemovePrinter
	_PrintMgr_RemovePrinterDriver
	_PrintMgr_RemoveTCPIPPrinterPort
	_PrintMgr_RenamePrinter
	_PrintMgr_Resume
	_PrintMgr_SetDefaultPrinter
#CE

#Include <Array.au3>
;~ Global $aPrinters = _PrintMgr_EnumPrinter("HP*")
;~ _ArrayDisplay($aPrinters)

Global Const $PRINTMGR_PROPERTY_ATTRIBUTES = 0
Global Const $PRINTMGR_PROPERTY_AVAILABILITY = 1
Global Const $PRINTMGR_PROPERTY_AVAILABLEJOBSHEETS = 2
Global Const $PRINTMGR_PROPERTY_AVERAGEPAGESPERMINUTE = 3
Global Const $PRINTMGR_PROPERTY_CAPABILITIES = 4
Global Const $PRINTMGR_PROPERTY_CAPABILITYDESCRIPTIONS = 5
Global Const $PRINTMGR_PROPERTY_CAPTION = 6
Global Const $PRINTMGR_PROPERTY_CHARSETSSUPPORTED = 7
Global Const $PRINTMGR_PROPERTY_COMMENT = 8
Global Const $PRINTMGR_PROPERTY_CONFIGMANAGERERRORCODE = 9
Global Const $PRINTMGR_PROPERTY_CONFIGMANAGERUSERCONFIG = 10
Global Const $PRINTMGR_PROPERTY_CREATIONCLASSNAME = 11
Global Const $PRINTMGR_PROPERTY_CURRENTCAPABILITIES = 12
Global Const $PRINTMGR_PROPERTY_CURRENTCHARSET = 13
Global Const $PRINTMGR_PROPERTY_CURRENTLANGUAGE = 14
Global Const $PRINTMGR_PROPERTY_CURRENTMIMETYPE = 15
Global Const $PRINTMGR_PROPERTY_CURRENTNATURALLANGUAGE = 16
Global Const $PRINTMGR_PROPERTY_CURRENTPAPERTYPE = 17
Global Const $PRINTMGR_PROPERTY_DEFAULT = 18
Global Const $PRINTMGR_PROPERTY_DEFAULTCAPABILITIES = 19
Global Const $PRINTMGR_PROPERTY_DEFAULTCOPIES = 20
Global Const $PRINTMGR_PROPERTY_DEFAULTLANGUAGE = 21
Global Const $PRINTMGR_PROPERTY_DEFAULTMIMETYPE = 22
Global Const $PRINTMGR_PROPERTY_DEFAULTNUMBERUP = 23
Global Const $PRINTMGR_PROPERTY_DEFAULTPAPERTYPE = 24
Global Const $PRINTMGR_PROPERTY_DEFAULTPRIORITY = 25
Global Const $PRINTMGR_PROPERTY_DESCRIPTION = 26
Global Const $PRINTMGR_PROPERTY_DETECTEDERRORSTATE = 27
Global Const $PRINTMGR_PROPERTY_DEVICEID = 28
Global Const $PRINTMGR_PROPERTY_DIRECT = 29
Global Const $PRINTMGR_PROPERTY_DOCOMPLETEFIRST = 30
Global Const $PRINTMGR_PROPERTY_DRIVERNAME = 31
Global Const $PRINTMGR_PROPERTY_ENABLEBIDI = 32
Global Const $PRINTMGR_PROPERTY_ENABLEDEVQUERYPRINT = 33
Global Const $PRINTMGR_PROPERTY_ERRORCLEARED = 34
Global Const $PRINTMGR_PROPERTY_ERRORDESCRIPTION = 35
Global Const $PRINTMGR_PROPERTY_ERRORINFORMATION = 36
Global Const $PRINTMGR_PROPERTY_EXTENDEDDETECTEDERRORSTATE = 37
Global Const $PRINTMGR_PROPERTY_EXTENDEDPRINTERSTATUS = 38
Global Const $PRINTMGR_PROPERTY_HIDDEN = 39
Global Const $PRINTMGR_PROPERTY_HORIZONTALRESOLUTION = 40
Global Const $PRINTMGR_PROPERTY_INSTALLDATE = 41
Global Const $PRINTMGR_PROPERTY_JOBCOUNTSINCELASTRESET = 42
Global Const $PRINTMGR_PROPERTY_KEEPPRINTEDJOBS = 43
Global Const $PRINTMGR_PROPERTY_LANGUAGESSUPPORTED = 44
Global Const $PRINTMGR_PROPERTY_LASTERRORCODE = 45
Global Const $PRINTMGR_PROPERTY_LOCAL = 46
Global Const $PRINTMGR_PROPERTY_LOCATION = 47
Global Const $PRINTMGR_PROPERTY_MARKINGTECHNOLOGY = 48
Global Const $PRINTMGR_PROPERTY_MAXCOPIES = 49
Global Const $PRINTMGR_PROPERTY_MAXNUMBERUP = 50
Global Const $PRINTMGR_PROPERTY_MAXSIZESUPPORTED = 51
Global Const $PRINTMGR_PROPERTY_MIMETYPESSUPPORTED = 52
Global Const $PRINTMGR_PROPERTY_NAME = 53
Global Const $PRINTMGR_PROPERTY_NATURALLANGUAGESSUPPORTED = 54
Global Const $PRINTMGR_PROPERTY_NETWORK = 55
Global Const $PRINTMGR_PROPERTY_PAPERSIZESSUPPORTED = 56
Global Const $PRINTMGR_PROPERTY_PAPERTYPESAVAILABLE = 57
Global Const $PRINTMGR_PROPERTY_PARAMETERS = 58
Global Const $PRINTMGR_PROPERTY_PNPDEVICEID = 59
Global Const $PRINTMGR_PROPERTY_PORTNAME = 60
Global Const $PRINTMGR_PROPERTY_POWERMANAGEMENTCAPABILITIES = 61
Global Const $PRINTMGR_PROPERTY_POWERMANAGEMENTSUPPORTED = 62
Global Const $PRINTMGR_PROPERTY_PRINTERPAPERNAMES = 63
Global Const $PRINTMGR_PROPERTY_PRINTERSTATE = 64
Global Const $PRINTMGR_PROPERTY_PRINTERSTATUS = 65
Global Const $PRINTMGR_PROPERTY_PRINTJOBDATATYPE = 66
Global Const $PRINTMGR_PROPERTY_PRINTPROCESSOR = 67
Global Const $PRINTMGR_PROPERTY_PRIORITY = 68
Global Const $PRINTMGR_PROPERTY_PUBLISHED = 69
Global Const $PRINTMGR_PROPERTY_QUEUED = 70
Global Const $PRINTMGR_PROPERTY_RAWONLY = 71
Global Const $PRINTMGR_PROPERTY_SEPARATORFILE = 72
Global Const $PRINTMGR_PROPERTY_SERVERNAME = 73
Global Const $PRINTMGR_PROPERTY_SHARED = 74
Global Const $PRINTMGR_PROPERTY_SHARENAME = 75
Global Const $PRINTMGR_PROPERTY_SPOOLENABLED = 76
Global Const $PRINTMGR_PROPERTY_STARTTIME = 77
Global Const $PRINTMGR_PROPERTY_STATUS = 78
Global Const $PRINTMGR_PROPERTY_STATUSINFO = 79
Global Const $PRINTMGR_PROPERTY_SYSTEMCREATIONCLASSNAME = 80
Global Const $PRINTMGR_PROPERTY_SYSTEMNAME = 81
Global Const $PRINTMGR_PROPERTY_TIMEOFLASTRESET = 82
Global Const $PRINTMGR_PROPERTY_UNTILTIME = 83
Global Const $PRINTMGR_PROPERTY_VERTICALRESOLUTION = 84
Global Const $PRINTMGR_PROPERTY_WORKOFFLINE = 85

Global Const $PRINTMGR_CONFIGURATION_BITSPERPEL = 0
Global Const $PRINTMGR_CONFIGURATION_CAPTION = 1
Global Const $PRINTMGR_CONFIGURATION_COLLATE = 2
Global Const $PRINTMGR_CONFIGURATION_COLOR = 3
Global Const $PRINTMGR_CONFIGURATION_COPIES = 4
Global Const $PRINTMGR_CONFIGURATION_DESCRIPTION = 5
Global Const $PRINTMGR_CONFIGURATION_DEVICENAME = 6
Global Const $PRINTMGR_CONFIGURATION_DISPLAYFLAGS = 7
Global Const $PRINTMGR_CONFIGURATION_DISPLAYFREQUENCY = 8
Global Const $PRINTMGR_CONFIGURATION_DITHERTYPE = 9
Global Const $PRINTMGR_CONFIGURATION_DRIVERVERSION = 10
Global Const $PRINTMGR_CONFIGURATION_DUPLEX = 11
Global Const $PRINTMGR_CONFIGURATION_FORMNAME = 12
Global Const $PRINTMGR_CONFIGURATION_HORIZONTALRESOLUTION = 13
Global Const $PRINTMGR_CONFIGURATION_ICMINTENT = 14
Global Const $PRINTMGR_CONFIGURATION_ICMMETHOD = 15
Global Const $PRINTMGR_CONFIGURATION_LOGPIXELS = 16
Global Const $PRINTMGR_CONFIGURATION_MEDIATYPE = 17
Global Const $PRINTMGR_CONFIGURATION_NAME = 18
Global Const $PRINTMGR_CONFIGURATION_ORIENTATION = 19
Global Const $PRINTMGR_CONFIGURATION_PAPERLENGTH = 20
Global Const $PRINTMGR_CONFIGURATION_PAPERSIZE = 21
Global Const $PRINTMGR_CONFIGURATION_PAPERWIDTH = 22
Global Const $PRINTMGR_CONFIGURATION_PELSHEIGHT = 23
Global Const $PRINTMGR_CONFIGURATION_PELSWIDTH = 24
Global Const $PRINTMGR_CONFIGURATION_PRINTQUALITY = 25
Global Const $PRINTMGR_CONFIGURATION_SCALE = 26
Global Const $PRINTMGR_CONFIGURATION_SETTINGID = 27
Global Const $PRINTMGR_CONFIGURATION_SPECIFICATIONVERSION = 28
Global Const $PRINTMGR_CONFIGURATION_TTOPTION = 29
Global Const $PRINTMGR_CONFIGURATION_VERTICALRESOLUTION = 30
Global Const $PRINTMGR_CONFIGURATION_XRESOLUTION = 31
Global Const $PRINTMGR_CONFIGURATION_YRESOLUTION = 32

Global Const $PRINTMGR_DRIVER_CONFIGFILE = 0
Global Const $PRINTMGR_DRIVER_DATAFILE = 1
Global Const $PRINTMGR_DRIVER_DRIVERPATH = 2
Global Const $PRINTMGR_DRIVER_DEPENDENTFILES = 3
Global Const $PRINTMGR_DRIVER_HELPFILE = 4
Global Const $PRINTMGR_DRIVER_MONITORNAME = 5
Global Const $PRINTMGR_DRIVER_NAME = 6
Global Const $PRINTMGR_DRIVER_SUPPORTEDPLATFORM = 7

Global Const $PRINTMGR_JOB_COLOR = 0
Global Const $PRINTMGR_JOB_DATATYPE = 1
Global Const $PRINTMGR_JOB_DESCRIPTION = 1
Global Const $PRINTMGR_JOB_DOCUMENT = 3
Global Const $PRINTMGR_JOB_DRIVERNAME = 4
Global Const $PRINTMGR_JOB_ELAPSEDTIME = 5
Global Const $PRINTMGR_JOB_HOSTPRINTQUEUE = 6
Global Const $PRINTMGR_JOB_INSTALLDATE = 7
Global Const $PRINTMGR_JOB_JOBID = 8
Global Const $PRINTMGR_JOB_JOBSTATUS = 9
Global Const $PRINTMGR_JOB_NAME = 10
Global Const $PRINTMGR_JOB_NOTIFY = 11
Global Const $PRINTMGR_JOB_OWNER = 12
Global Const $PRINTMGR_JOB_PAGESPRINTED = 13
Global Const $PRINTMGR_JOB_PAPERLENGTH = 14
Global Const $PRINTMGR_JOB_PAPERSIZE = 15
Global Const $PRINTMGR_JOB_PAPERWIDTH = 16
Global Const $PRINTMGR_JOB_PARAMETERS = 17
Global Const $PRINTMGR_JOB_PRINTPROCESSOR = 18
Global Const $PRINTMGR_JOB_PRIORITY = 19
Global Const $PRINTMGR_JOB_SIZE = 20
Global Const $PRINTMGR_JOB_SIZEHIGH = 21
Global Const $PRINTMGR_JOB_STARTTIME = 22
Global Const $PRINTMGR_JOB_STATUS = 23
Global Const $PRINTMGR_JOB_STATUSMASK = 24
Global Const $PRINTMGR_JOB_TIMESUBMITTED = 25
Global Const $PRINTMGR_JOB_TOTALPAGES = 26
Global Const $PRINTMGR_JOB_UNTILTIME = 27

Global Const $PRINTMGR_TCPPORT_NAME = 0
Global Const $PRINTMGR_TCPPORT_HOSTADDRESS = 1
Global Const $PRINTMGR_TCPPORT_PORTNUMBER = 2

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_AddLocalPort
; Description ...: Add a local port (for printing into a file)
; Syntax.........:  _PrintMgr_AddLocalPort($sFileName)
; Parameters ....: $sFileName - Full file name (the directory must exist).
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_AddLocalPort($sFileName)
	If Not IsAdmin() Then Return SetError(1, 0, 0)
	Local $sDir = StringRegExpReplace($sFileName, "\\[^\\]+$", "")
	If $sDir = $sFileName Then $sDir = @ScriptDir
	If StringRegExp($sFileName, "\Q\/:*?""<>|\E") Then Return SetError(1, 0, 0)
	If Not FileExists($sDir) Then Return SetError(1, 0, 0)
	Local $oShell = ObjCreate("shell.application")
	If Not IsObj($oShell) Then Return SetError(1, 0, 0)
	$oShell.ServiceStop("spooler", False)
	Local $iRet = RegWrite("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Ports", $sFileName, "REG_SZ", "")
	$oShell.ServiceStart("spooler", False)
	Return $iRet
EndFunc   ;==>_PrintMgr_AddLocalPort

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_AddLPRPort
; Description ...: Add a local port (for printing into a file)
; Syntax.........:  _PrintMgr_AddLPRPort($sFileName)
; Parameters ....: $sFileName - Full file name (the directory must exist).
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_AddLPRPort($sLPRServer, $sPrinterName)
	If Not IsAdmin() Then Return SetError(1, 0, 0)
	Local $sPortName = $sLPRServer & ":" & $sPrinterName
	Local $sRegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Print\Monitors\LPR Port\Ports"
	Local $aValues = [["", "EnableBannerPage", "REG_DWORD", 0], _
			["", "HpUxCompatibility", "REG_DWORD", 0], _
			["", "OldSunCompatibility", "REG_DWORD", 0], _
			["", "Printer Name", "REG_SZ", $sPrinterName], _
			["", "Server Name", "REG_SZ", $sLPRServer], _
			["\Timeouts", "CommandTimeout", "REG_DWORD", 120], _
			["\Timeouts", "DataTimeout", "REG_DWORD", 300]]

	If RegRead($sRegKey & "\" & $sPortName, "Printer Name") Then Return SetError(2, 0, 0)
	Local $oShell = ObjCreate("shell.application")
	If Not IsObj($oShell) Then Return SetError(1, 0, 0)
	$oShell.ServiceStop("spooler", False)
	Local $iRet = 0
	For $i = 0 To UBound($aValues) - 1
		$iRet += RegWrite($sRegKey & "\" & $sPortName & $aValues[$i][0], $aValues[$i][1], $aValues[$i][2], $aValues[$i][3])
	Next
	If Not $iRet Then Return SetError(3, 0, 0)
	$oShell.ServiceStart("spooler", False)
	Return 1
EndFunc   ;==>_PrintMgr_AddLPRPort

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_AddPrinter
; Description ...: Adds a Windows printer.
; Syntax.........: _PrintMgr_AddPrinter($sPrinterName, $sDriverName, $sPortName, $sLocation = '', $sComment = '')
; Parameters ....: $sPrinterName - Unique identifier of the printer on the system
;                  $sDriverName - Name of the Windows printer driver.
;                  $sPortName - Port that is used to transmit data to a printer
;                  $sLocation - Physical location of the printer (Example: Bldg. 38, Room 1164)
;                  $sComment - Comment for a print queue
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_AddPrinter($sPrinterName, $sDriverName, $sPortName, $sLocation = '', $sComment = '')
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinter = $oWMIService.Get("Win32_Printer").SpawnInstance_
	If Not IsObj($oPrinter) Then Return SetError(1, 0, 0)
	$oPrinter.DriverName = $sDriverName
	$oPrinter.PortName = $sPortName
	$oPrinter.DeviceID = $sPrinterName
	$oPrinter.Location = $sLocation
	$oPrinter.Comment = $sComment
	Execute("$oPrinter.Put_")
	Return _PrintMgr_PrinterExists($sPrinterName)
EndFunc   ;==>_PrintMgr_AddPrinter

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_AddPrinterDriver
; Description ...: Adds a printer driver.
; Syntax.........: _PrintMgr_AddPrinterDriver($sDriverName, $sDriverPlatform, $sDriverPath, $sDriverInfName, $sVersion)
; Parameters ....: $sDriverName - Driver name for this printer
;                  $sDriverPlatform - Operating environments that the driver is intended for (Example: "Windows NT x86")
;                  $sDriverPath - Path for this printer driver -Example: "C:\\drivers\\pscript.dll")
;                  $sDriverInfName - Name of the INF file being used
;                  $sVersion - Operating system version for the printer driver
;                       0 = Win9x
;                       1 = Win351
;                       2 = NT40
;                       3 = Win2k
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_AddPrinterDriver($sDriverName, $sDriverPlatform, $sDriverPath, $sDriverInfName, $sVersion = "3")
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	If Not StringRegExp($sVersion, "^[1-3]$") Then Return SetError(1, 0, 0)
	$oWMIService.Security_.Privileges.AddAsString("SeLoadDriverPrivilege", True)
	Local $oDriver = $oWMIService.Get("Win32_PrinterDriver")
	If Not IsObj($oDriver) Then Return SetError(1, 0, 0)
	$oDriver.Name = $sDriverName
	$oDriver.SupportedPlatform = $sDriverPlatform
	$oDriver.Version = $sVersion
	$oDriver.DriverPath = $sDriverPath
	$oDriver.Infname = $sDriverInfName
	Local $iRet = $oDriver.AddPrinterDriver($oDriver)
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_AddPrinterDriver

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_AddTCPIPPrinterPort
; Description ...: Adds a TCP printer port.
; Syntax.........: _PrintMgr_AddTCPIPPrinterPort($sPortName, $sPortIP, $sPortNunber)
; Parameters ....: $sPortName - Name of the port to create
;                  $sPortIP - IP Address of the port
;                  $sPortNumber - Port number
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_AddTCPIPPrinterPort($sPortName, $sPortIP, $sPortNumber)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oNewPort = $oWMIService.Get("Win32_TCPIPPrinterPort").SpawnInstance_
	If Not IsObj($oNewPort) Then Return SetError(1, 0, 0)
	$oNewPort.Name = $sPortName
	$oNewPort.Protocol = 1
	$oNewPort.HostAddress = $sPortIP
	$oNewPort.PortNumber = $sPortNumber
	$oNewPort.SNMPEnabled = True
	Local $ret = $oNewPort.Put_
	#forceref $ret
	Return 1
EndFunc   ;==>_PrintMgr_AddTCPIPPrinterPort

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_AddWindowsPrinterConnection
; Description ...: Provides a connection to an existing printer on the network, and adds it to the list of available printers.
; Syntax.........: _AddWindowsPrinterConnection($sPrinterPath)
; Parameters ....: $sPrinterPath - Path to the printer connection (must be an UNC path)
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_AddWindowsPrinterConnection($sPrinterPath)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinter = $oWMIService.Get("Win32_Printer")
	If Not IsObj($oPrinter) Then Return SetError(1, 0, 0)
	Local $iRet = $oPrinter.AddPrinterConnection($sPrinterPath)
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_AddWindowsPrinterConnection

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_CancelAllJobs
; Description ...: Removes all jobs, including the one currently printing from the queue
; Syntax.........:  _PrintMgr_CancelAllJobs($sPrinterName)
; Parameters ....: $sPrinterName - Name of the printer to removes all jobs from
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_CancelAllJobs($sPrinterName)
	Local $iRet = 1
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iRet = $oPrinter.CancelAllJobs()
	Next
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_CancelAllJobs

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_CancelPrintJob
; Description ...: Cancel the specified print job
; Syntax.........:  _PrintMgr_CancelPrintJob($idJob)
; Parameters ....: $idJob - Job ID. See remarks.
; Return values .: Success - Returns 1
;                  Failure - Returns 0
; Remarks .......: The Job ID can be retrieved by calling _PrintMgr_EnumPrintJobs
; =================================================================================================
Func _PrintMgr_CancelPrintJob($idJob)
	Local $iRet = 1
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	If Not IsNumber($idJob) Then Return SetError(1, 0, 0)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrintJobs = $oWMIService.ExecQuery("Select * from Win32_PrintJob Where JobId=" & $idJob, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrintJobs) Then Return SetError(1, 0, 0)
	For $oPrintJob In $oPrintJobs
		$oPrintJob.Delete_()
	Next
	$oPrintJobs = $oWMIService.ExecQuery("Select * from Win32_PrintJob Where JobId=" & $idJob, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrintJobs) Then Return SetError(1, 0, 0)
	For $oPrintJob In $oPrintJobs
		$iRet = 0
	Next
	Return $iRet
EndFunc   ;==>_PrintMgr_CancelPrintJob

; #FUNCTION# ====================================================================================================================
; Name ..........: _PrintMgr_EnumPorts
; Description ...: Enumerates the ports that are available for printing on a specified server.
; Syntax ........: _PrintMgr_EnumPorts()
; Parameters ....: None
; Return values .: Success - Returns a 2D array containing ports informations :
;                    $array[0][0] : 1st port name
;                    $array[0][1] : 1st monitor name
;                    $array[0][2] : 1st port description
;                    $array[0][3] : 1st port type (see remarks)
;                    $array[1][0] : 2nd port name
;                    $array[1][1] : ...
; Author ........: Danyfirex, jguinch
; Remarks .......: A port type can be a combination of the following values :
;                   PORT_TYPE_WRITE         (1)
;                   PORT_TYPE_READ          (2)
;                   PORT_TYPE_REDIRECTED    (4)
;                   PORT_TYPE_NET_ATTACHED  (8)
; ===============================================================================================================================
Func _PrintMgr_EnumPorts()
	Local $ERROR_INSUFFICIENT_BUFFER = 122
	Local $tag_PORT_INFO_2 = "ptr pPortName;ptr pMonitorName;ptr pDescription;dword PortType;dword Reserved"
	Local $aRet = DllCall("winspool.drv", "bool", "EnumPortsW", "wstr", "", "dword", 2, "ptr", Null, "dword", 0, "dword*", 0, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Local $aRetError = DllCall("kernel32.dll", "dword", "GetLastError")
	If @error Or $aRetError[0] <> $ERROR_INSUFFICIENT_BUFFER Then Return SetError(@error, @extended, 0)
	Local $iSizeNeeded = $aRet[5]
	Local $tPortInfoArray = DllStructCreate("byte[" & $iSizeNeeded & "]")
	Local $pPortInfoArray = DllStructGetPtr($tPortInfoArray)
	$aRet = DllCall("winspool.drv", "bool", "EnumPortsW", "wstr", "", "dword", 2, "ptr", $pPortInfoArray, "dword", $iSizeNeeded, "dword*", 0, "dword*", 0)
	If @error Or Not $aRet[6] Then Return SetError(@error, @extended, 0)
	Local $iNumberOfPortInfoStructures = $aRet[6]
	Local $aPorts[$iNumberOfPortInfoStructures][4]
	Local $t_PORT_INFO_2 = DllStructCreate($tag_PORT_INFO_2)
	Local $iPortInfoSize = DllStructGetSize($t_PORT_INFO_2)
	Local $tPortName, $tMonitorName, $tPortDesc
	For $i = 0 To $iNumberOfPortInfoStructures - 1
		$t_PORT_INFO_2 = DllStructCreate($tag_PORT_INFO_2, $pPortInfoArray + ($i * $iPortInfoSize))
		$tPortName = DllStructCreate("wchar Data[512]", DllStructGetData($t_PORT_INFO_2, 1))
		$tMonitorName = DllStructCreate("wchar Data[256]", DllStructGetData($t_PORT_INFO_2, 2))
		$tPortDesc = DllStructCreate("wchar Data[256]", DllStructGetData($t_PORT_INFO_2, 3))
		$aPorts[$i][0] = DllStructGetData($tPortName, 1)
		$aPorts[$i][1] = DllStructGetData($tMonitorName, 1)
		$aPorts[$i][2] = DllStructGetData($tPortDesc, 1)
		$aPorts[$i][3] = DllStructGetData($t_PORT_INFO_2, 4)
		If $aPorts[$i][1] == 0 Then $aPorts[$i][1] = ""
		If $aPorts[$i][2] == 0 Then $aPorts[$i][2] = ""
	Next
	Return $aPorts
EndFunc   ;==>_PrintMgr_EnumPorts

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_EnumPrinter
; Description ...: Enumerates all installed printers
; Syntax.........:  _PrintMgr_EnumPrinter([$sPrinterName])
; Parameters ....: $sPrinterName - Name of the printer to list.
;                  Defaut "" returns the list of all printers.
;                  $sPrinterName can be a part of a printer name like "HP*"
; Return values .: Success - Returns an array containing the printer list. See remarks.
;                  Failure - Returns 0 and set @error to non zero value
; Remarks........: The zeroth array element contains the number of printers.
;                  The function returns all installed printers for the user running the script.
; =================================================================================================
Func _PrintMgr_EnumPrinter($sPrinterName = "")
	Local $aRet[10], $sFilter, $iCount = 0
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	If $sPrinterName <> "" Then $sFilter = StringReplace(" Where Name like '" & StringReplace($sPrinterName, "\", "\\") & "'", "*", "%")
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer" & $sFilter, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iCount += 1
		If $iCount >= UBound($aRet) Then ReDim $aRet[UBound($aRet) * 2]
		$aRet[$iCount] = $oPrinter.Name
	Next
	ReDim $aRet[$iCount + 1]
	$aRet[0] = $iCount
	Return $aRet
EndFunc   ;==>_PrintMgr_EnumPrinter

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_EnumPrinterConfiguration
; Description ...: Enumerates the configuration of printers
; Syntax.........:  _PrintMgr_EnumPrinterConfiguration([$sPrinterName])
; Parameters ....: $sPrinterName - Name of the printer to retrieve configuration.
;                  Defaut "" returns configuration for all printers
;                  $sPrinterName can be a part of a printer name like "HP*"
; Return values .: Success - Returns an array containing the configuration properties in this form :
;                    $aRet[0][$PRINTMGR_CONFIGURATION_BITSPERPEL] ; BITSPERPEL value for the 1st printer
;                    $aRet[0][$PRINTMGR_CONFIGURATION_COLOR]      ; COLOR value for the 1st printer
;                    $aRet[1][$PRINTMGR_CONFIGURATION_BITSPERPEL] ; BITSPERPEL values for the 2nd printer
;                    ...
;                  Failure - Returns 0 and set @error to non zero value
; Remarks .......: See $PRINTMGR_CONFIGURATION_* variables for all available properties
;                  See Win32_PrinterConfiguration for a description of all properties : https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-printerconfiguration
; =================================================================================================
Func _PrintMgr_EnumPrinterConfiguration($sPrinterName = "")
	Local $nbCols = 33, $aRet[1][$nbCols], $sFilter, $i = 0, $iCount = 0
	#forceref $i
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	If $sPrinterName <> "" Then $sFilter = StringReplace(" Where Name like '" & StringReplace($sPrinterName, "\", "\\") & "'", "*", "%")
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrintersCfg = $oWMIService.ExecQuery("Select * from Win32_PrinterConfiguration" & $sFilter, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrintersCfg) Then Return SetError(1, 0, 0)
	For $oCfg In $oPrintersCfg
		$iCount += 1
		If $iCount > UBound($aRet) Then ReDim $aRet[UBound($aRet) * 2][$nbCols]
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_BITSPERPEL] = $oCfg.BitsPerPel
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_CAPTION] = $oCfg.Caption
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_COLLATE] = $oCfg.Collate
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_COLOR] = $oCfg.Color
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_COPIES] = $oCfg.Copies
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_DESCRIPTION] = $oCfg.Description
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_DEVICENAME] = $oCfg.DeviceName
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_DISPLAYFLAGS] = $oCfg.DisplayFlags
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_DISPLAYFREQUENCY] = $oCfg.DisplayFrequency
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_DITHERTYPE] = $oCfg.DitherType
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_DRIVERVERSION] = $oCfg.DriverVersion
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_DUPLEX] = $oCfg.Duplex
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_FORMNAME] = $oCfg.FormName
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_HORIZONTALRESOLUTION] = $oCfg.HorizontalResolution
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_ICMINTENT] = $oCfg.ICMIntent
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_ICMMETHOD] = $oCfg.ICMMethod
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_LOGPIXELS] = $oCfg.LogPixels
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_MEDIATYPE] = $oCfg.MediaType
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_NAME] = $oCfg.Name
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_ORIENTATION] = $oCfg.Orientation
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_PAPERLENGTH] = $oCfg.PaperLength
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_PAPERSIZE] = $oCfg.PaperSize
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_PAPERWIDTH] = $oCfg.PaperWidth
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_PELSHEIGHT] = $oCfg.PelsHeight
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_PELSWIDTH] = $oCfg.PelsWidth
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_PRINTQUALITY] = $oCfg.PrintQuality
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_SCALE] = $oCfg.Scale
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_SETTINGID] = $oCfg.SettingID
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_SPECIFICATIONVERSION] = $oCfg.SpecificationVersion
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_TTOPTION] = $oCfg.TTOption
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_VERTICALRESOLUTION] = $oCfg.VerticalResolution
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_XRESOLUTION] = $oCfg.XResolution
		$aRet[$iCount - 1][$PRINTMGR_CONFIGURATION_YRESOLUTION] = $oCfg.YResolution
	Next
	ReDim $aRet[$iCount][$nbCols]
	Return $aRet
EndFunc   ;==>_PrintMgr_EnumPrinterConfiguration

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_EnumPrinterDriver
; Description ...: Enumerates all installed printer drivers.
; Syntax.........: _PrintMgr_EnumPrinterDriver([$sPrinterName])
; Parameters ....: $sDriverName - Name of the driver to retrieve informations.
;                  Defaut "" returns informations for all drivers
;                  $sPrinterName can be a part of a printer name like "HP*"
; Return values .: Success - Returns an array containing the printer(s) driver properties in this form :
;                    $aRet[0][$PRINTMGR_DRIVER_NAME]       ; NAME value for the 1st printer driver
;                    $aRet[0][$PRINTMGR_DRIVER_DRIVERPATH] ; DRIVERPATH value for the 1st printer driver
;                    $aRet[1][$PRINTMGR_DRIVER_NAME]       ; NAME value for the 2dn printer driver
;                    ...
;                  Failure - Returns 0 and set @error to non zero value
; Remarks .......: See $PRINTMGR_DRIVER_* variables for all available properties
;                  See Win32_PrinterDriver for a description of all properties : https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-printerdriver
; =================================================================================================
Func _PrintMgr_EnumPrinterDriver($sDriverName = "")
	Local $nbCols = 8, $aRet[1][$nbCols], $sFilter, $iCount = 0
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	If $sDriverName <> "" Then $sFilter = StringReplace(" Where Name = '" & $sDriverName & "' Or Name Like '" & $sDriverName & ",%'", "*", "%")
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrintersDrv = $oWMIService.ExecQuery("Select * from Win32_PrinterDriver" & $sFilter, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrintersDrv) Then Return SetError(1, 0, 0)
	For $oDrv In $oPrintersDrv
		$iCount += 1
		If $iCount > UBound($aRet) Then ReDim $aRet[UBound($aRet) * 2][$nbCols]
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_CONFIGFILE] = $oDrv.ConfigFile
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_DATAFILE] = $oDrv.DataFile
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_DRIVERPATH] = $oDrv.DriverPath
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_DEPENDENTFILES] = __StringUnSplit($oDrv.DependentFiles)
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_HELPFILE] = $oDrv.HelpFile
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_MONITORNAME] = $oDrv.MonitorName
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_NAME] = $oDrv.Name
		$aRet[$iCount - 1][$PRINTMGR_DRIVER_SUPPORTEDPLATFORM] = $oDrv.SupportedPlatform
	Next
	ReDim $aRet[$iCount][$nbCols]
	Return $aRet
EndFunc   ;==>_PrintMgr_EnumPrinterDriver

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_EnumPrinterProperties
; Description ...: Enumerates all installed printers for the user executing the script.
; Syntax.........: _PrintMgr_EnumPrinterProperties([$sPrinterName])
; Parameters ....: $sPrinterName - Name of the printer to retrieve informations.
;                  Defaut "" returns informations for all printers
;                  $sPrinterName can be a part of a printer name like "HP*"
; Return values .: Success - Returns an array containing the printer(s) properties in this form :
;                    $aRet[0][$PRINTMGR_PROPERTY_ATTRIBUTES]     ; ATTRIBUTES value for the 1st printer
;                    $aRet[0][$PRINTMGR_PROPERTY_COMMENT]        ; COMMENT value for the 1st printer
;                    $aRet[1][$PRINTMGR_PROPERTY_ATTRIBUTES]     ; ATTRIBUTES value for the 2nd printer
;                    ...
;                  Failure - Returns 0 and set @error to non zero value
; Remarks .......: See $PRINTMGR_PROPERTY_* variables for all available properties
;                  See Win32_Printer for a description of all properties : https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-printer
; =================================================================================================
Func _PrintMgr_EnumPrinterProperties($sPrinterName = "")
	Local $nbCols = 86, $aRet[1][$nbCols], $sFilter, $iCount = 0
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	If $sPrinterName <> "" Then $sFilter = StringReplace(" Where Name like '" & StringReplace($sPrinterName, "\", "\\") & "'", "*", "%")
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer" & $sFilter, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iCount += 1
		If $iCount > UBound($aRet) Then ReDim $aRet[UBound($aRet) * 2][$nbCols]
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_ATTRIBUTES] = $oPrinter.Attributes
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_AVAILABILITY] = $oPrinter.Availability
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_AVAILABLEJOBSHEETS] = __StringUnSplit($oPrinter.AvailableJobSheets)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_AVERAGEPAGESPERMINUTE] = $oPrinter.AveragePagesPerMinute
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CAPABILITIES] = __StringUnSplit($oPrinter.Capabilities)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CAPABILITYDESCRIPTIONS] = __StringUnSplit($oPrinter.CapabilityDescriptions)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CAPTION] = $oPrinter.Caption
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CHARSETSSUPPORTED] = __StringUnSplit($oPrinter.CharSetsSupported)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_COMMENT] = $oPrinter.Comment
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CONFIGMANAGERERRORCODE] = $oPrinter.ConfigManagerErrorCode
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CONFIGMANAGERUSERCONFIG] = $oPrinter.ConfigManagerUserConfig
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CREATIONCLASSNAME] = $oPrinter.CreationClassName
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CURRENTCAPABILITIES] = __StringUnSplit($oPrinter.CurrentCapabilities)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CURRENTCHARSET] = $oPrinter.CurrentCharSet
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CURRENTLANGUAGE] = $oPrinter.CurrentLanguage
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CURRENTMIMETYPE] = $oPrinter.CurrentMimeType
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CURRENTNATURALLANGUAGE] = $oPrinter.CurrentNaturalLanguage
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_CURRENTPAPERTYPE] = $oPrinter.CurrentPaperType
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULT] = $oPrinter.Default
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULTCAPABILITIES] = __StringUnSplit($oPrinter.DefaultCapabilities)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULTCOPIES] = $oPrinter.DefaultCopies
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULTLANGUAGE] = $oPrinter.DefaultLanguage
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULTMIMETYPE] = $oPrinter.DefaultMimeType
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULTNUMBERUP] = $oPrinter.DefaultNumberUp
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULTPAPERTYPE] = $oPrinter.DefaultPaperType
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEFAULTPRIORITY] = $oPrinter.DefaultPriority
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DESCRIPTION] = $oPrinter.Description
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DETECTEDERRORSTATE] = $oPrinter.DetectedErrorState
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DEVICEID] = $oPrinter.DeviceID
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DIRECT] = $oPrinter.Direct
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DOCOMPLETEFIRST] = $oPrinter.DoCompleteFirst
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_DRIVERNAME] = $oPrinter.DriverName
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_ENABLEBIDI] = $oPrinter.EnableBIDI
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_ENABLEDEVQUERYPRINT] = $oPrinter.EnableDevQueryPrint
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_ERRORCLEARED] = $oPrinter.ErrorCleared
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_ERRORDESCRIPTION] = $oPrinter.ErrorDescription
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_ERRORINFORMATION] = __StringUnSplit($oPrinter.ErrorInformation)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_EXTENDEDDETECTEDERRORSTATE] = $oPrinter.ExtendedDetectedErrorState
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_EXTENDEDPRINTERSTATUS] = $oPrinter.ExtendedPrinterStatus
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_HIDDEN] = $oPrinter.Hidden
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_HORIZONTALRESOLUTION] = $oPrinter.HorizontalResolution
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_INSTALLDATE] = $oPrinter.InstallDate
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_JOBCOUNTSINCELASTRESET] = $oPrinter.JobCountSinceLastReset
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_KEEPPRINTEDJOBS] = $oPrinter.KeepPrintedJobs
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_LANGUAGESSUPPORTED] = __StringUnSplit($oPrinter.LanguagesSupported)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_LASTERRORCODE] = $oPrinter.LastErrorCode
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_LOCAL] = $oPrinter.Local
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_LOCATION] = $oPrinter.Location
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_MARKINGTECHNOLOGY] = $oPrinter.MarkingTechnology
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_MAXCOPIES] = $oPrinter.MaxCopies
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_MAXNUMBERUP] = $oPrinter.MaxNumberUp
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_MAXSIZESUPPORTED] = $oPrinter.MaxSizeSupported
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_MIMETYPESSUPPORTED] = __StringUnSplit($oPrinter.MimeTypesSupported)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_NAME] = $oPrinter.Name
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_NATURALLANGUAGESSUPPORTED] = __StringUnSplit($oPrinter.NaturalLanguagesSupported)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_NETWORK] = $oPrinter.Network
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PAPERSIZESSUPPORTED] = __StringUnSplit($oPrinter.PaperSizesSupported)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PAPERTYPESAVAILABLE] = __StringUnSplit($oPrinter.PaperTypesAvailable)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PARAMETERS] = $oPrinter.Parameters
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PNPDEVICEID] = $oPrinter.PNPDeviceID
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PORTNAME] = $oPrinter.PortName
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_POWERMANAGEMENTCAPABILITIES] = __StringUnSplit($oPrinter.PowerManagementCapabilities)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_POWERMANAGEMENTSUPPORTED] = $oPrinter.PowerManagementSupported
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PRINTERPAPERNAMES] = __StringUnSplit($oPrinter.PrinterPaperNames)
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PRINTERSTATE] = $oPrinter.PrinterState
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PRINTERSTATUS] = $oPrinter.PrinterStatus
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PRINTJOBDATATYPE] = $oPrinter.PrintJobDataType
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PRINTPROCESSOR] = $oPrinter.PrintProcessor
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PRIORITY] = $oPrinter.Priority
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_PUBLISHED] = $oPrinter.Published
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_QUEUED] = $oPrinter.Queued
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_RAWONLY] = $oPrinter.RawOnly
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_SEPARATORFILE] = $oPrinter.SeparatorFile
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_SERVERNAME] = $oPrinter.ServerName
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_SHARED] = $oPrinter.Shared
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_SHARENAME] = $oPrinter.ShareName
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_SPOOLENABLED] = $oPrinter.SpoolEnabled
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_STARTTIME] = $oPrinter.StartTime
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_STATUS] = $oPrinter.Status
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_STATUSINFO] = $oPrinter.StatusInfo
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_SYSTEMCREATIONCLASSNAME] = $oPrinter.SystemCreationClassName
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_SYSTEMNAME] = $oPrinter.SystemName
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_TIMEOFLASTRESET] = $oPrinter.TimeOfLastReset
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_UNTILTIME] = $oPrinter.UntilTime
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_VERTICALRESOLUTION] = $oPrinter.VerticalResolution
		$aRet[$iCount - 1][$PRINTMGR_PROPERTY_WORKOFFLINE] = $oPrinter.WorkOffline
	Next
	ReDim $aRet[$iCount][$nbCols]
	Return $aRet
EndFunc   ;==>_PrintMgr_EnumPrinterProperties

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_EnumPrintJobs
; Description ...: Enumerates all print jobs for the specified printer
; Syntax.........:  _PrintMgr_EnumPrintJobs([$sPrinterName])
; Parameters ....: $sPrinterName - Name of the printer to list print jobs
;                  Defaut "" returns the print jobs for all printers.
;                  $sPrinterName can be a part of a printer name like "HP*"
; Return values .: Success - Returns an array containing the print jobs in this form :
;                    $aRet[0][$PRINTMGR_JOB_COLOR]        ; COLOR value for the 1st print job
;                    $aRet[0][$PRINTMGR_JOB_DATATYPE]     ; DATATYPE value for the 1st printer
;                    $aRet[1][$PRINTMGR_JOB_COLOR]        ; COLOR values for the 2nd rint job
;                    ...
;                  Failure - Returns 0 and set @error to non zero value
; Remarks .......: See $PRINTMGR_JOB_* variables for all available properties
;                  See Win32_PrintJob for a description of all properties : https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-printer
; =================================================================================================
Func _PrintMgr_EnumPrintJobs($sPrinterName = "")
	Local $nbCols = 28, $aRet[10][$nbCols], $sFilter, $iCount = 0
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	If $sPrinterName <> "" Then $sFilter = StringReplace(" Where Name like '" & StringReplace($sPrinterName, "\", "\\") & ", %'", "*", "%")
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrintJobs = $oWMIService.ExecQuery("Select * from Win32_PrintJob" & $sFilter, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrintJobs) Then Return SetError(1, 0, 0)
	For $oPrintJob In $oPrintJobs
		$iCount += 1
		If $iCount >= UBound($aRet) Then ReDim $aRet[UBound($aRet) * 2][$nbCols]
		$aRet[$iCount - 1][$PRINTMGR_JOB_COLOR]          = $oPrintJob.Color
		$aRet[$iCount - 1][$PRINTMGR_JOB_DATATYPE]       = $oPrintJob.Datatype
		$aRet[$iCount - 1][$PRINTMGR_JOB_DESCRIPTION]    = $oPrintJob.Description
		$aRet[$iCount - 1][$PRINTMGR_JOB_DOCUMENT]       = $oPrintJob.Document
		$aRet[$iCount - 1][$PRINTMGR_JOB_DRIVERNAME]     = $oPrintJob.Drivername
		$aRet[$iCount - 1][$PRINTMGR_JOB_ELAPSEDTIME]    = __WMIDateStringToDate($oPrintJob.ElapsedTime)
		$aRet[$iCount - 1][$PRINTMGR_JOB_HOSTPRINTQUEUE] = $oPrintJob.HostPrintQueue
		$aRet[$iCount - 1][$PRINTMGR_JOB_INSTALLDATE]    = $oPrintJob.InstallDate
		$aRet[$iCount - 1][$PRINTMGR_JOB_JOBID]          = $oPrintJob.JobId
		$aRet[$iCount - 1][$PRINTMGR_JOB_JOBSTATUS]      = $oPrintJob.JobStatus
		$aRet[$iCount - 1][$PRINTMGR_JOB_NAME]           = $oPrintJob.Name
		$aRet[$iCount - 1][$PRINTMGR_JOB_NOTIFY]         = $oPrintJob.Notify
		$aRet[$iCount - 1][$PRINTMGR_JOB_OWNER]          = $oPrintJob.Owner
		$aRet[$iCount - 1][$PRINTMGR_JOB_PAGESPRINTED]   = $oPrintJob.PagesPrinted
		$aRet[$iCount - 1][$PRINTMGR_JOB_PAPERLENGTH]    = $oPrintJob.PaperLength
		$aRet[$iCount - 1][$PRINTMGR_JOB_PAPERSIZE]      = $oPrintJob.PaperSize
		$aRet[$iCount - 1][$PRINTMGR_JOB_PAPERWIDTH]     = $oPrintJob.PaperWidth
		$aRet[$iCount - 1][$PRINTMGR_JOB_PARAMETERS]     = $oPrintJob.Parameters
		$aRet[$iCount - 1][$PRINTMGR_JOB_PRINTPROCESSOR] = $oPrintJob.PrintProcessor
		$aRet[$iCount - 1][$PRINTMGR_JOB_PRIORITY]       = $oPrintJob.Priority
		$aRet[$iCount - 1][$PRINTMGR_JOB_SIZE]           = $oPrintJob.Size
		$aRet[$iCount - 1][$PRINTMGR_JOB_SIZEHIGH]       = $oPrintJob.SizeHigh
		$aRet[$iCount - 1][$PRINTMGR_JOB_STARTTIME]      = __WMIDateStringToDate($oPrintJob.StartTime)
		$aRet[$iCount - 1][$PRINTMGR_JOB_STATUS]         = $oPrintJob.Status
		$aRet[$iCount - 1][$PRINTMGR_JOB_STATUSMASK]     = $oPrintJob.StatusMask
		$aRet[$iCount - 1][$PRINTMGR_JOB_TIMESUBMITTED]  = __WMIDateStringToDate($oPrintJob.TimeSubmitted)
		$aRet[$iCount - 1][$PRINTMGR_JOB_TOTALPAGES]     = $oPrintJob.TotalPages
		$aRet[$iCount - 1][$PRINTMGR_JOB_UNTILTIME]      = __WMIDateStringToDate($oPrintJob.UntilTime)
	Next
	ReDim $aRet[$iCount][$nbCols]
	Return $aRet
EndFunc   ;==>_PrintMgr_EnumPrintJobs

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_EnumTCPIPPrinterPort
; Description ...: Enumerates all defined TCP printer ports.
; Syntax.........: _PrintMgr_EnumTCPIPPrinterPort()
; Parameters ....: None
; Return values .: Success - Returns a 2D array containing all informations, in this form :
;                    $aRet[0][$PRINTMGR_TCPPORT_NAME] : 1st port name
;                    $aRet[0][$PRINTMGR_TCPPORT_HOSTADDRESS] : 1st host address
;                    $aRet[0][$PRINTMGR_TCPPORT_PORTNUMBER] : 1st port number
;                    $aRet[1][$PRINTMGR_TCPPORT_NAME] : 2nd port name
;                    ...
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_EnumTCPIPPrinterPort()
	Local $aRet[1][3], $i = 0
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinterPorts = $oWMIService.ExecQuery("Select * from Win32_TCPIPPrinterPort")
	If Not IsObj($oPrinterPorts) Then Return SetError(1, 0, 0)
	For $oPort In $oPrinterPorts
		ReDim $aRet[$i + 1][3]
		$aRet[$i][$PRINTMGR_TCPPORT_NAME] = $oPort.Name
		$aRet[$i][$PRINTMGR_TCPPORT_HOSTADDRESS] = $oPort.HostAddress
		$aRet[$i][$PRINTMGR_TCPPORT_PORTNUMBER] = $oPort.PortNumber
		$i += 1
	Next
	If $i = 0 Then Return SetError(2, 0, 0)
	Return $aRet
EndFunc   ;==>_PrintMgr_EnumTCPIPPrinterPort

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_Pause
; Description ...: Pauses the print queue. No jobs can print until the queue is resumed.
; Syntax.........:  _PrintMgr_Pause($sPrinterName)
; Parameters ....: $sPrinterName - Name of the printer
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_Pause($sPrinterName)
	Local $iRet = 1
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iRet = $oPrinter.Pause()
	Next
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_Pause

; #FUNCTION# ====================================================================================================================
; Name ..........: _PrintMgr_PortExists
; Description ...: Checks if the specified printer port name exists.
; Syntax ........: _PrintMgr_PortExists($sPortName)
; Parameters ....: $sPortName           - Port name.
; Return values .: Success - Returns 1
;                  Failure - Returns 0
; ===============================================================================================================================
Func _PrintMgr_PortExists($sPortName)
	Local $aPorts = _PrintMgr_EnumPorts()
	If @error Then Return SetError(@error, 0, 0)
	For $i = 0 To UBound($aPorts) - 1
		If $aPorts[$i][0] = $sPortName Then Return 1
	Next
	Return 0
EndFunc   ;==>_PrintMgr_PortExists

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_PrinterExists
; Description ...: Checks if the specified printer exists
; Syntax.........:  _PrintMgr_PrinterExists($sPrinterName)
; Parameters ....: $sPrinterName - Name of the printer
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_PrinterExists($sPrinterName)
	Local $iRet = 0
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iRet = 1
	Next
	Return $iRet
EndFunc   ;==>_PrintMgr_PrinterExists

; #FUNCTION# ====================================================================================================================
; Name ..........: _PrintMgr_PrinterSetComment
; Description ...: Sets the comment for a print queue.
; Syntax ........: _PrintMgr_PrinterSetComment($sPrinterName, $sDriverName)
; Parameters ....: $sPrinterName        - Name of the printer.
;                  $sComment            - Comment
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; ===============================================================================================================================
Func _PrintMgr_PrinterSetComment($sPrinterName, $sComment)
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(2, 0, 0)
	$oWMIService.Security_.Privileges.AddAsString("SeLoadDriverPrivilege", True)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(3, 0, 0)
	For $oPrinter In $oPrinters
		$oPrinter.Comment = $sComment
		Execute("$oPrinter.Put_")
		ExitLoop
	Next

	$oPrinter = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "' And Comment = '" & $sComment & "'", "WQL")
	Return $oPrinter.Count
EndFunc   ;==>_PrintMgr_PrinterSetComment

; #FUNCTION# ====================================================================================================================
; Name ..........: _PrintMgr_PrinterSetDriver
; Description ...: Sets the driver of the specified printer to the specified driver name.
; Syntax ........: _PrintMgr_PrinterSetDriver($sPrinterName, $sDriverName)
; Parameters ....: $sPrinterName        - Name of the printer.
;                  $sDriverName         - Name of the driver.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; ===============================================================================================================================
Func _PrintMgr_PrinterSetDriver($sPrinterName, $sDriverName)
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(2, 0, 0)
	$oWMIService.Security_.Privileges.AddAsString("SeLoadDriverPrivilege", True)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(3, 0, 0)
	For $oPrinter In $oPrinters
		$oPrinter.DriverName = $sDriverName
		Execute("$oPrinter.Put_")
		ExitLoop
	Next

	$oPrinter = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "' And DriverName = '" & $sDriverName & "'", "WQL")
	Return $oPrinter.Count
EndFunc   ;==>_PrintMgr_PrinterSetDriver

; #FUNCTION# ====================================================================================================================
; Name ..........: _PrintMgr_PrinterSetPort
; Description ...: Set the port of the specified printer to the specified port name.
; Syntax ........: _PrintMgr_PrinterSetPort($sPrinterName, $sPortName)
; Parameters ....: $sPrinterName        - Name of the printer.
;                  $sPortName           - Name of the printer port.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; ===============================================================================================================================
Func _PrintMgr_PrinterSetPort($sPrinterName, $sPortName)
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(2, 0, 0)
	$oWMIService.Security_.Privileges.AddAsString("SeLoadDriverPrivilege", True)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(3, 0, 0)
	For $oPrinter In $oPrinters
		$oPrinter.PortName = $sPortName
		Execute("$oPrinter.Put_")
		ExitLoop
	Next

	$oPrinter = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "' And PortName like '" & $sPortName & "'", "WQL")
	Return $oPrinter.Count
EndFunc   ;==>_PrintMgr_PrinterSetPort

; #FUNCTION# ====================================================================================================================
; Name ..........: _PrintMgr_PrinterShare
; Description ...: Set the printer as shared or not shared.
; Syntax ........: _PrintMgr_PrinterShare($sPrinterName, $iShared, $sShareName)
; Parameters ....: $sPrinterName        - Name of the printer.
;                  $iShared             - State of the share :
;                                          1 - Shared
;                                          0 - Not shared
;                  $sShareName          - Share name of the printer. Leave empty if $iShared = 0
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; ===============================================================================================================================
Func _PrintMgr_PrinterShare($sPrinterName, $iShared, $sShareName)
	$iShared = $iShared ? True : False
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(2, 0, 0)
	$oWMIService.Security_.Privileges.AddAsString("SeLoadDriverPrivilege", True)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(3, 0, 0)
	For $oPrinter In $oPrinters
		$oPrinter.Shared = $iShared
		If $iShared Then $oPrinter.ShareName = $sShareName
		Execute("$oPrinter.Put_")
		ExitLoop
	Next

	Local $sQuery = "Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "' And Shared = " & $iShared
	If $iShared Then $sQuery &= " and ShareName = '" & $sShareName & "'"
	$oPrinter = $oWMIService.ExecQuery($sQuery, "WQL")
	Return $oPrinter.Count
EndFunc   ;==>_PrintMgr_PrinterShare


; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_PrintTestPage
; Description ...: Prints a test page using the specifed printer
; Syntax.........:  _PrintMgr_PrintTestPage($sPrinterName)
; Parameters ....: $sPrinterName - Name of the printer
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_PrintTestPage($sPrinterName)
	Local $iRet = 1
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iRet = $oPrinter.PrintTestPage()
	Next
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_PrintTestPage

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_RemoveLocalPort
; Description ...: Removes a local port (created with _PrintMgr_AddLocalPort)
; Syntax.........:  _PrintMgr_RemoveLocalPort($sPortName)
; Parameters ....: $sPortName - Port name.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_RemoveLocalPort($sPortName)
	If Not IsAdmin() Then Return SetError(1, 0, 0)
	If StringRegExp($sPortName, ":$") Then Return SetError(2, 0, 0)
	Local $oShell = ObjCreate("shell.application")
	If Not IsObj($oShell) Then Return SetError(3, 0, 0)
	$oShell.ServiceStop("spooler", False)
	Local $iRet = RegDelete("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Ports", $sPortName)
	$oShell.ServiceStart("spooler", False)
	Return $iRet
EndFunc   ;==>_PrintMgr_RemoveLocalPort

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_RemoveLPRPort
; Description ...: Removes a LPR port (created with _PrintMgr_AddLPRPort)
; Syntax.........:  _PrintMgr_RemoveLPRPort($sPortName)
; Parameters ....: $sPortName - LPR Port name.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_RemoveLPRPort($sPortName)
	If Not IsAdmin() Then Return SetError(1, 0, 0)
	Local $sRegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Print\Monitors\LPR Port\Ports"
	Local $oShell = ObjCreate("shell.application")
	If Not IsObj($oShell) Then Return SetError(2, 0, 0)
	$oShell.ServiceStop("spooler", False)
	Local $iRet = RegDelete($sRegKey & "\" & $sPortName)
	$oShell.ServiceStart("spooler", False)
	Return $iRet
EndFunc   ;==>_PrintMgr_RemoveLPRPort

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_RemovePrinter
; Description ...: Removes a printer.
; Syntax.........:  _PrintMgr_RemovePrinter($sPrinterName)
; Parameters ....: $sPrinterName - Name of the printer to remove (use \\server\printerShare for shared printers)
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_RemovePrinter($sPrinterName)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'")
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$oPrinter.Delete_()
	Next
	Return (_PrintMgr_PrinterExists($sPrinterName) ? 0 : 1)
EndFunc   ;==>_PrintMgr_RemovePrinter

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_RemovePrinterDriver
; Description ...: Removes a printer driver.
; Syntax.........:  _PrintMgr_RemovePrinterDriver($sDriverName)
; Parameters ....: $sDriverName - Name of the printer driver
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_RemovePrinterDriver($sDriverName)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrintersDrv = $oWMIService.ExecQuery("Select * from Win32_PrinterDriver Where Name like '" & $sDriverName & ",%'")
	If Not IsObj($oPrintersDrv) Then Return SetError(1, 0, 0)
	For $oDrv In $oPrintersDrv
		$oDrv.Delete_()
	Next
	Return 1
EndFunc   ;==>_PrintMgr_RemovePrinterDriver

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_RemoveTCPIPPrinterPort
; Description ...: Removes a TCP printer port.
; Syntax.........: _PrintMgr_RemoveTCPIPPrinterPort($sPortName)
; Parameters ....: $sPortName - Name of the port to remove
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_RemoveTCPIPPrinterPort($sPortName)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinterPorts = $oWMIService.ExecQuery("Select * from Win32_TCPIPPrinterPort where Name = '" & $sPortName & "'")
	If Not IsObj($oPrinterPorts) Then Return SetError(1, 0, 0)
	For $oPort In $oPrinterPorts
		$oPort.Delete_()
	Next
	Return 1
EndFunc   ;==>_PrintMgr_RemoveTCPIPPrinterPort

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_RenamePrinter
; Description ...: Remames a printer.
; Syntax.........:  _PrintMgr_RenamePrinter($sPrinterName, $sPrinterNewName)
; Parameters ....: $sPrinterName - Name of the printer to rename
;                  $sPrinterNewName - New printer name
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_RenamePrinter($sPrinterName, $sPrinterNewName)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'")
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	Local $iRet
	For $oPrinter In $oPrinters
		$iRet = $oPrinter.RenamePrinter($sPrinterNewName)
	Next
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_RenamePrinter

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_Resume
; Description ...: Resumes a paused print queue.
; Syntax.........:  _PrintMgr_Resume($sPrinterName)
; Parameters ....: $sPrinterName - Name of the printer
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_Resume($sPrinterName)
	Local $iRet = 1
	Local Const $wbemFlagReturnImmediately = 0x10, $wbemFlagForwardOnly = 0x20
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer Where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iRet = $oPrinter.Resume()
	Next
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_Resume

; #FUNCTION# ======================================================================================
; Name...........: _PrintMgr_SetDefaultPrinter
; Description ...: Sets the default system printer
; Syntax.........: _PrintMgr_SetDefaultPrinter($sPrinterName)
; Parameters ....: $sPrinterName - Name of the printer
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and set @error to non zero value
; =================================================================================================
Func _PrintMgr_SetDefaultPrinter($sPrinterName)
	Local $iRet = 1
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If Not IsObj($oWMIService) Then Return SetError(1, 0, 0)
	Local $oPrinters = $oWMIService.ExecQuery("Select * from Win32_Printer where Name = '" & StringReplace($sPrinterName, "\", "\\") & "'")
	If Not IsObj($oPrinters) Then Return SetError(1, 0, 0)
	For $oPrinter In $oPrinters
		$iRet = $oPrinter.SetDefaultPrinter()
	Next
	Return ($iRet = 0 ? 1 : SetError($iRet, 0, 0))
EndFunc   ;==>_PrintMgr_SetDefaultPrinter

; #INTERNAL_USE_ONLY# ===========================================================================================================
Func __StringUnSplit($aVal, $sSep = ";")
	If Not IsArray($aVal) Then Return SetError(1, 0, 0)
	Local $sReturn = ""
	For $i = 0 To UBound($aVal) - 1
		If $i = 0 Then
			$sReturn = $aVal[$i]
		Else
			$sReturn &= $sSep & $aVal[$i]
		EndIf
	Next
	Return $sReturn
EndFunc   ;==>__StringUnSplit

; #INTERNAL_USE_ONLY# ===========================================================================================================
Func __WMIDateStringToDate($sDate)
    Local $sRet = StringRegExpReplace($sDate, "(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})\.\d{5,}\+\d{3}", "$1/$2/$3 $4:$5:$6")
	Return StringRegExp($sRet, "^[0.:]+$") ? "" : $sRet
EndFunc   ;==>__WMIDateStringToDate
