#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\Downloads\Stefanini_Globe.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\Desktop\Stefanini_Globe.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Erik Cesar de Oliveira - ERIKOLIV
				 Rodrigo Chaves Neto - RCNETO

 Script Function:

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include "..\UDF\UDF_Embedded.au3"
_SessionClean()
Opt("GUIOnEventMode", 1)
_LogoStefanini(True)
_BaseButton(True)
_BaseShadowForm(True)

;Define de variáveis globais
Global $idBtn[10], $iP = 0
Global $idBtn_RunMe = 0x1

_DBStart()
    _SQLite_Exec(-1, StringFormat("Insert Into LoggedInUsers VALUES('%s', '%s', '%s', '%s')", StringUpper($analystName), StringUpper(@ComputerName), StringUpper(_Now()), @YDAY))
_DBStop()

hwnd_Main()

While 1
	Sleep(10)
WEnd

Func hwnd_Main()
	$hwnd_Main = _Metro_CreateGUI("Rollout Assistant", 960, 536, -1, -1)
	GUISetBkColor($GUIThemeColor)
	GUISetFont(10, 400, 0, "Segoe UI")
	Local $aGetPos = WinGetPos($hwnd_Main)

	;Add/create control buttons to the GUI
	$Control_Buttons = _Metro_AddControlButtons(True, False, True, False, False) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

	;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
	$GUI_CLOSE_BUTTON = $Control_Buttons[0]
	$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
	GUICtrlSetOnEvent($GUI_CLOSE_BUTTON, "SpecialEvents")
	GUICtrlSetOnEvent($GUI_MINIMIZE_BUTTON, "SpecialEvents")

	$sLabel_Title = GUICtrlCreateLabel("Rollout Assistant", 0, 50, $aGetPos[2] - 1, 50, $SS_CENTER)
	GUICtrlSetFont(-1, 24, 800, 0, "Segoe UI")

	$iLogoStefanini = _GUICtrlCreateGIF(@TempDir & '\LogoStefanini.png', "", 390, 450, 140, 30)
	GUICtrlSetState(-1, $GUI_DISABLE)

	createButton("event_Execute_RunMe", "RunMe", "Instalação automatizada de softwares", 72, 164)
	createButton("event_Execute_Printers", "Printer Backup", "Backup e instalação automatizada de impressoras", 349, 164)
	createButton("event_Execute_Network", "Network Mapper", "Backup e mapeamento automatizado de redes", 626, 164)

	_RoundCorners($hwnd_Main, 3, 3, 20, 20)

	Sleep(1000)
	GUISetState(@SW_SHOW)
	shadowApp()
EndFunc   ;==>hwnd_Main

Func event_Execute_RunMe()
Run(@ScriptDir & '/Binaries/Runme.exe /execRunMe')
	;~ Run('C:\Users\erikoliv\OneDrive - Embraer\Projetos Stefanini\Rollout Assistant\RunMe\Runme.exe /execRunMe')
EndFunc   ;==>event_Execute_RunMe

Func event_Execute_Printers()
	Run(@ScriptDir & '/Binaries/PrinterBackup.exe /execPrinterBackup')
EndFunc   ;==>event_Execute_Printers

Func event_Execute_Network()
	Run(@ScriptDir & '/Binaries/NetworkMapper.exe /execNetworkMapper')
EndFunc   ;==>event_Execute_Network

Func createButton($sProgram, $sTitle, $sDescription, $x, $y, $sButtonName = 'Abrir')
	_GUICtrlCreateGIF(@TempDir & '\botao.png', '', $x, $y, 257, 180)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$sLabel_Title = GUICtrlCreateLabel($sTitle, $x, $y + 10, 257, 30, $SS_CENTER)
	GUICtrlSetFont(-1, 14, 800, 0, "Segoe UI")
	GUICtrlSetBkColor(-1, -2)
	$sLabel_Desc = GUICtrlCreateLabel($sDescription, $x + 5, $y + 45, 245, 55, $SS_CENTER)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetBkColor(-1, -2)
	$idBtn[$iP] = _Metro_CreateButtonEx2($sButtonName, $x + 73, $y + 133, 105, 30)
	GUICtrlSetOnEvent(-1, $sProgram)
	$iP += 1

EndFunc   ;==>createButton

Func shadowApp()
	$hWnd_ShadowApp = GUICreate("", 1014, 594, -12, -15, $WS_POPUP, $WS_EX_MDICHILD + $WS_EX_LAYERED, $hwnd_Main)
	;~ FileDelete(@TempDir & "\ShadowApp.png")
	Local $iSplashShadowApp = _GDIPlus_ImageLoadFromFile(@TempDir & "\ShadowForm.png")
	For $i = 0 To 255 Step 10
		drawPNG($i, $hWnd_ShadowApp, $iSplashShadowApp)
	Next
	GUISetState(@SW_SHOWNA)
	GUISetState(@SW_DISABLE)
	If IniRead(@ScriptDir & '\GUIOption.ini', 'Global', 'Window', 'Normal') = 'Max' Then
		$bControlWindow = True
		GUISetState(@SW_HIDE, $hWnd_ShadowApp)
		GUISetState(@SW_MAXIMIZE, $hwnd_Main)
	EndIf
EndFunc   ;==>shadowApp

Func SpecialEvents()
	Select
		Case @GUI_CtrlId = $GUI_CLOSE_BUTTON
			If MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION, "Rollout Assistant", "Deseja realmente sair?") = 6 Then
				_DBStart()
    				_SQLite_Exec(-1, 'DELETE FROM LoggedInUsers where AnalystName = "' & $analystName & '" AND HostName = "' & @ComputerName &'"')
				_DBStop()
				Exit
			EndIf

		Case @GUI_CtrlId = $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $hwnd_Main)

	EndSelect
EndFunc   ;==>SpecialEvents

Func _SessionClean()
	_DBStart()
		_SQLite_Exec(-1, 'DELETE FROM LoggedInUsers where YearDay < "'&  @YDAY & '"')
	_DBStop()
EndFunc


