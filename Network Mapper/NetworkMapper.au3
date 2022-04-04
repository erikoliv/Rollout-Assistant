#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Backup Erik\Desktop\Empacotamentos\Icons\Stefanini_Globe.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\Desktop\Stefanini_Globe.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Erik Cesar de Oliveira - ERIKOLIV
				 Rodrigo Chaves Neto - RCNETO

 Script Function:
	Backup e mapeamento automático de drives de rede.

#ce ----------------------------------------------------------------------------

;~ #include <UDF_Embedded.au3>
#include "..\UDF\UDF_Embedded.au3"
wParam()
_Extract_NetworkMapper(True)
_ShadowAppNetworkMapper(True)

Global $hWnd_Listview
Global $aNetworkDrive[0]
Global $i2 = 0

$hWnd_NetworkMap = _Metro_CreateGUI("", 960, 437, -1, -1)
GUISetBkColor($GUIThemeColor)
GUISetFont(10, 400, 0, "Segoe UI")

$iLogoApp = _GUICtrlCreateGIF(@TempDir & '\NetworkMapperLogo.png', '', 30, 15, 230, 45)

;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, False, True, False, False) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True
;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]


GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
$sLabel_Msg = GUICtrlCreateLabel('Clique em "Salvar" para realizar o backup dos mapeamentos atuais do usuário.' & @CRLF & @CRLF & 'Clique em "Mapear" para mapear os drives de rede salvos anteriormente para este usuário (' & StringUpper($userName) & ').', 180, 140, 744, 205)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
GUICtrlSetBkColor(-1, -2)
$Graphic1 = GUICtrlCreateGraphic(28, 360, 904, 2)
GUICtrlSetBkColor(-1, 0xc9c9c9)
$idBtn_Salvar = _Metro_CreateButtonEx2("Salvar", 32, 376, 91, 33)
$idBtn_Mapear = _Metro_CreateButtonEx2("Mapear", 152, 376, 91, 33)
_RoundCorners($hWnd_NetworkMap, 3, 3, 20, 20)

_SetTheme('RolloutAssistant')

GUISetState(@SW_SHOW)

shadowApp()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
			If $hWnd_Listview <> '' Then
				GUIDelete($hWnd_Listview)
				$hWnd_Listview = ''
			Else
				If MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION, "Network Mapper", "Deseja realmente sair?", "", $hWnd_NetworkMap) = 6 Then Exit

			EndIf

		Case $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $hWnd_NetworkMap)

		Case $idBtn_Salvar
			If MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION, "Network Mapper", "Deseja realmente salvar os drives de rede?", "", $hWnd_NetworkMap) = 6 Then
				_GetAllNetworkDrivers()
				hWnd_Listview()
			EndIf

		Case $idBtn_Mapear
			If MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION, "Network Mapper", "Deseja realmente mapear os drives de rede?", "", $hWnd_NetworkMap) = 6 Then
				_SetAllNetworkDrivers()
			EndIf

	EndSwitch
WEnd

Func hWnd_Listview()
	$hWnd_Listview = GUICreate("Mapeamentos salvos - " & StringUpper($userName), 405, 380, -1, -1)
	Local $ListView1 = GUICtrlCreateListView("Mapeamentos", -1, -1, 405, 380)
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 300)
	_GUICtrlListView_DeleteAllItems($hWnd_Listview)
	GUISetState(@SW_SHOW)

	_DBStart()
	_SQLite_GetTable2d(-1, 'Select DriveLetter, DrivePath from NetworkDrive Where UserName = "' & StringUpper($userName) & '"', $aSelect, $iRows, $iColumns)
	_DBStop()


	For $i = 1 To UBound($aSelect) - 1
		GUICtrlCreateListViewItem($aSelect[$i][0] & $aSelect[$i][1], $ListView1)
	Next

EndFunc   ;==>hWnd_Listview

Func shadowApp()
	$hWnd_ShadowApp = GUICreate("", 1013, 594, 26, 14, $WS_POPUP, $WS_EX_MDICHILD + $WS_EX_LAYERED, $hWnd_NetworkMap)
;~ FileDelete(@ScriptDir & "\ShadowApp_.png")
	Local $iSplashShadowApp = _GDIPlus_ImageLoadFromFile(@TempDir & "\ShadowAppNetworkMapper.png")
	For $i = 0 To 255 Step 10
		drawPNG($i, $hWnd_ShadowApp, $iSplashShadowApp)
	Next
	GUISetState(@SW_SHOWNA)
;~ GUISetState(@SW_DISABLE)
EndFunc   ;==>shadowApp

Func _SetAllNetworkDrivers()

	Local $aGetPos = WinGetPos($hWnd_NetworkMap)
	Local $hWnd_FormStatus = GUICreate("", 461, 235, -1, -1, $WS_POPUPWINDOW)
	Local $aGetPos = WinGetPos($hWnd_FormStatus)
	GUISetBkColor($COLOR_WHITE)
	GUISetFont(10, 400, 0, "Segoe UI")
	$lblInstall = GUICtrlCreateLabel("Mapeando", 0, 80, $aGetPos[2] - 2, 50, $SS_CENTER)
	Local $idProgress1 = GUICtrlCreateProgress(104, 121, 252, 11, 0x8)
	_SendMessage(GUICtrlGetHandle($idProgress1), $PBM_SETMARQUEE, 1, 30)
	GUISetState(@SW_SHOW)

	RunWait(@ComSpec & " /c " & "net use * /delete /y", "", @SW_HIDE)

	_DBStart()
	$aListDrives = _SQLite_GetTable2d(-1, 'Select DriveLetter, DrivePath from NetworkDrive Where UserName = "' & StringUpper($userName) & '"', $aSelect, $iRows, $iColumns)
	_DBStop()

	If UBound($aSelect) - 1 < 1 Then
		MsgBox($MB_OK + $MB_TOPMOST + $MB_ICONWARNING, 'Network Mapper', 'Não foi encontrado nenhum drive de rede salvo para este usuário (' & $userName & ')')
	Else
		For $i = 1 To $iRows
			Sleep(1000)
			GUICtrlSetData($lblInstall, "Mapeando" & @CRLF & $aSelect[$i][0] & $aSelect[$i][1])
			DriveMapAdd($aSelect[$i][0], $aSelect[$i][1], $DMA_PERSISTENT)
		Next
	EndIf
	
	GUIDelete($hWnd_FormStatus)
	Run(@ComSpec & " /c " & "explorer file:\\", "", @SW_HIDE)
EndFunc   ;==>_SetAllNetworkDrivers

Func _GetAllNetworkDrivers()

	Local $aGetPos = WinGetPos($hWnd_NetworkMap)
	Local $hWnd_FormStatus = GUICreate("", 461, 235, -1, -1, $WS_POPUPWINDOW)
	Local $aGetPos = WinGetPos($hWnd_FormStatus)
	GUISetBkColor($COLOR_WHITE)
	GUISetFont(10, 400, 0, "Segoe UI")
	$lblInstall = GUICtrlCreateLabel("Salvando", 0, 80, $aGetPos[2] - 2, 50, $SS_CENTER)
	Local $idProgress1 = GUICtrlCreateProgress(104, 121, 252, 11, 0x8)
	_SendMessage(GUICtrlGetHandle($idProgress1), $PBM_SETMARQUEE, 1, 30)
	GUISetState(@SW_SHOW)

	For $i = 65 To 90
		If DriveMapGet(Chr($i) & ":") <> "" Then

			_ArrayAdd($aNetworkDrive, DriveMapGet(Chr($i) & ":"))

			_DBStart()
			_SQLite_GetTable2d(-1, 'Select DriveLetter, DrivePath from NetworkDrive Where UserName = "' & StringUpper($userName) & '"', $aSelect, $iRows, $iColumns)
			_DBStop()

			$sCheckExist = False
			For $i3 = 1 To UBound($aSelect) - 1
				If StringUpper(Chr($i) & ":") & StringUpper($aNetworkDrive[$i2]) = $aSelect[$i3][0] & $aSelect[$i3][1] Then
					$sCheckExist = True
					ExitLoop
				EndIf
			Next

			If $sCheckExist = False Then
				GUICtrlSetData($lblInstall, "Salvando" & @CRLF & StringUpper(Chr($i) & ":") & StringUpper($aNetworkDrive[$i2]))
				_DBStart()
				_SQLite_Exec(-1, StringFormat("Insert Into NetworkDrive (DriveLetter, DrivePath, AnalystName, UserName) VALUES('%s', '%s', '%s', '%s')", StringUpper(Chr($i) & ":"), StringUpper($aNetworkDrive[$i2]), StringUpper($analystName), StringUpper($userName)))
				_DBStop()
			EndIf

			$i2 += 1

		EndIf
	Next
	GUIDelete($hWnd_FormStatus)
EndFunc   ;==>_GetAllNetworkDrivers

Func wParam()
	If UBound($CmdLine) - 1 > 0 Then
		Switch $CmdLine[1]
			Case "/execNetworkMapper"
				Return 0
			Case Else
				MsgBox($MB_ICONINFORMATION + $MB_TOPMOST, "Rollout Assistant", "Esta aplicação não pode ser executada separadamente!")
				Exit
		EndSwitch
	Else
		MsgBox($MB_ICONINFORMATION + $MB_TOPMOST, "Rollout Assistant", "Esta aplicação não pode ser executada separadamente!")
		Exit
	EndIf
EndFunc   ;==>wParam
