#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\Downloads\Stefanini_Globe.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_HiDpi=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm /pe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\Desktop\Stefanini_Globe.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_HiDpi=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm /pe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Erik Cesar de Oliveira - ERIKOLIV
				 Rodrigo Chaves Neto - RCNETO

 Script Function:
	Backup e instalação de impressoras.

#ce ----------------------------------------------------------------------------

wParam()

#AutoIt3Wrapper_Run_Debug_Mode=n

#include "..\UDF\UDF_Embedded.au3"

;Extrai arquivos necessária para utilização no software
_LogoStefanini(True)
_Extract_PrinterBackup(True)

;Necessario para o Select do banco
Global $aSelect, $iRows, $iColumns

;Define de variáveis globais
Global $sIsAllChecked = False
Global $sIsAllChecked2 = False
Global $sWhatListView

;Variavel janela disable
Global $hWnd_Disable

;=======================================================================Creating the GUI===============================================================================
;!Highly recommended for improved overall performance and responsiveness of the GUI effects etc.! (after compiling):

;YOU NEED TO EXCLUDE FOLLOWING FUNCTIONS FROM AU3STRIPPER, OTHERWISE IT WON'T WORK:
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
;Please not that Au3Stripper will show errors. You can ignore them as long as you use the above Au3Stripper_Ignore_Funcs parameters.

;Required if you want High DPI scaling enabled. (Also requries _Metro_EnableHighDPIScaling())

;Enable high DPI support: Detects the users DPI settings and resizes GUI and all controls to look perfectly sharp.
_Metro_EnableHighDPIScaling() ; Note: Requries "#AutoIt3Wrapper_Res_HiDpi=y" for compiling. To see visible changes without compiling, you have to disable dpi scaling in compatibility settings of Autoit3.exe

;Criação do Form Principal
_SetTheme("RolloutAssistant")
$Form1 = _Metro_CreateGUI("Printer Backup 2.0", 960, 600, -1, -1)
GUISetFont(10, 400, 0, "Segoe UI")
GUISetBkColor($GUIThemeColor)
_RoundCorners($Form1, 3, 3, 20, 20)

;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, False, True, False, False) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]


$iLogoApp = _GUICtrlCreateGIF(@TempDir & '\LogoAppPrinterBackup.png', '', 30, 5, 235, 60)
_GUICtrlCreateGIF(_PrinterImgExtract(True), '', 440, 200, 100, 131)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT + $GUI_DOCKTOP)
$iLogoStefanini = _GUICtrlCreateGIF(@TempDir & '\LogoStefanini.png', '', 815, 560, 110, 25)

;Criação das ListViews
$ListView_InstalledPrinters = GUICtrlCreateListView("    Impressoras instaladas - " & @ComputerName, 33, 60, 380, 406, $WS_BORDER, $LVS_EX_FULLROWSELECT + $LVS_EX_CHECKBOXES)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 400)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 400)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 400)
;~ GUICtrlSetBkColor(-1, $GUIThemeColor)
;~ GUICtrlSetColor(-1, $FontThemeColor)
$ListView_BackupedPrinters = GUICtrlCreateListView("    Impressoras salvas para este usuário - " & StringUpper($userName), 547, 60, 380, 406, $WS_BORDER, $LVS_EX_FULLROWSELECT + $LVS_EX_CHECKBOXES)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 400)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 400)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 400)
;~ GUICtrlSetBkColor(-1, $GUIThemeColor)
;~ GUICtrlSetColor(-1, $FontThemeColor)

;Criação dos Botões
$btnSavePrinters = _Metro_CreateButtonEx2("Salvar Impressoras", 157, 476, 120, 45)
$btnInstallPrinters = _Metro_CreateButtonEx2("Instalar impressoras", 680, 476, 120, 45)

;Criação do CheckBox1 para dar Check em todos os CheckBoxes
$Form_1 = GUICreate('', 13, 17, 555, 68, $WS_POPUP, $WS_EX_MDICHILD + $WS_EX_LAYERED, $Form1)
GUISetBkColor(0xABCDEF)
_WinAPI_SetLayeredWindowAttributes($Form_1, 0xABCDEF)
$idCheck_All_Saved = GUICtrlCreateCheckbox('', 0, 0, 100, 17)
GUISetState(@SW_SHOWNA)
GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)

;Criação do CheckBox2 para dar Check em todos os CheckBoxes
$Form_2 = GUICreate('', 13, 17, 41, 68, $WS_POPUP, $WS_EX_MDICHILD + $WS_EX_LAYERED, $Form1)
GUISetBkColor(0xABCDEF)
_WinAPI_SetLayeredWindowAttributes($Form_2, 0xABCDEF)
$idCheck_All_Installed = GUICtrlCreateCheckbox('', 0, 0, 100, 17)
GUISetState(@SW_SHOWNA)
GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)

GUISetState(@SW_SHOW, $Form1)
;======================================================================= End Creating the GUI===============================================================================

;Funções principais
_installedPrintersLoad()
_GUICtrlListView_SetColumnWidth($ListView_InstalledPrinters, 0, $LVSCW_AUTOSIZE_USEHEADER)
_backupedPrintersLoad()
_GUICtrlListView_SetColumnWidth($ListView_BackupedPrinters, 0, $LVSCW_AUTOSIZE_USEHEADER)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_CLOSE_BUTTON
			if MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION, "Printer Backup", "Deseja realmente sair?") = 6 Then
				_Metro_GUIDelete($Form1)
				Exit
			EndIf
			
		Case $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $Form1)

		Case $btnSavePrinters
			_registerPrinterOnDB()

		Case $btnInstallPrinters
			_installPrinter()

		Case $idCheck_All_Saved
			$sWhatListView = "Saved"
			_CheckAllItens()

		Case $idCheck_All_Installed
			$sWhatListView = "Installed"
			_CheckAllItens()

	EndSwitch
WEnd

Func _CheckAllItens()
	If $sWhatListView = "Saved" Then
		$iCount = _GUICtrlListView_GetItemCount($ListView_BackupedPrinters)
		If $iCount > 0 Then
			If $sIsAllChecked = False Then
				For $i = 0 To $iCount
					_GUICtrlListView_SetItemChecked($ListView_BackupedPrinters, $i)
				Next
				$sIsAllChecked = True
			Else
				For $i = 0 To $iCount
					_GUICtrlListView_SetItemChecked($ListView_BackupedPrinters, $i, False)
				Next
				$sIsAllChecked = False
			EndIf
		EndIf
	EndIf

	If $sWhatListView = "Installed" Then
		$iCount = _GUICtrlListView_GetItemCount($ListView_InstalledPrinters)
		If $iCount > 0 Then
			If $sIsAllChecked2 = False Then
				For $i = 0 To $iCount
					_GUICtrlListView_SetItemChecked($ListView_InstalledPrinters, $i)
				Next
				$sIsAllChecked2 = True
			Else
				For $i = 0 To $iCount
					_GUICtrlListView_SetItemChecked($ListView_InstalledPrinters, $i, False)
				Next
				$sIsAllChecked2 = False
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_CheckAllItens

Func _installPrinter()
	$sCount = _GUICtrlListView_GetItemCount($ListView_BackupedPrinters)
	If $sCount <> '' And $sCount > 0 Then
		if MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION, "Printer Backup", "Deseja realmente instalar a(as) impressora(as)?") = 6 Then
			Local $aGetPos = WinGetPos($Form1)
			Local $hWnd_FormStatus = GUICreate("", 461, 235, -1, -1, $WS_POPUPWINDOW)
			Local $aGetPos = WinGetPos($hWnd_FormStatus)
			GUISetBkColor($COLOR_WHITE)
			GUISetFont(10, 400, 0, "Segoe UI")
			$lblInstall = GUICtrlCreateLabel("Instalando", 0, 80, $aGetPos[2] - 2, 50, $SS_CENTER)
			Local $idProgress1 = GUICtrlCreateProgress(104, 121, 252, 11, 0x8, $WS_EX_LAYOUTRTL)
			_SendMessage(GUICtrlGetHandle($idProgress1), $PBM_SETMARQUEE, 1, 30)
			;~ WinSetTrans($Form1, '', 150)
			GUISetState(@SW_SHOW)
			
			For $i = 0 To $sCount
				$sCheck = _GUICtrlListView_GetItemChecked($ListView_BackupedPrinters, $i)
				If $sCheck = True Then
					$sPrinterItem = _GUICtrlListView_GetItemText($ListView_BackupedPrinters, $i, 0)
					
					GUICtrlSetData($lblInstall, "Instalando" & @CRLF & $sPrinterItem)
					_PrintMgr_AddWindowsPrinterConnection($sPrinterItem)

					$aPrinterList = _PrintMgr_EnumPrinter()
					For $i2 = 1 To $aPrinterList[0]
						If $aPrinterList[$i2] = $sPrinterItem Then
							GUICtrlCreateListViewItem($sPrinterItem, $ListView_InstalledPrinters)
							ExitLoop
						EndIf
					Next
				EndIf
			Next

			Sleep(2000)
			GUIDelete($hWnd_FormStatus)
			_GUIDisable($Form1, '')
			;~ WinSetTrans($Form1, '', 255)
			WinActivate($Form1)
		EndIf
	EndIf

EndFunc   ;==>_installPrinter

Func _registerPrinterOnDB()
	$sCount = _GUICtrlListView_GetItemCount($ListView_InstalledPrinters)
	If $sCount <> '' And $sCount > 0 Then
		if MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION, "Printer Backup", "Deseja realmente salvar a(as) impressora(as)?") = 6 Then

			Local $aGetPos = WinGetPos($Form1)
			Local $hWnd_FormStatus = GUICreate("", 461, 235, -1, -1, $WS_POPUPWINDOW)
			Local $aGetPos = WinGetPos($hWnd_FormStatus)
			GUISetBkColor($COLOR_WHITE)
			GUISetFont(10, 400, 0, "Segoe UI")
			$lblInstall = GUICtrlCreateLabel("Salvando", 0, 80, $aGetPos[2] - 2, 50, $SS_CENTER)
			Local $idProgress1 = GUICtrlCreateProgress(104, 121, 252, 11, 0x8)
			_SendMessage(GUICtrlGetHandle($idProgress1), $PBM_SETMARQUEE, 1, 30)
			;~ WinSetTrans($Form1, '', 150)
			GUISetState(@SW_SHOW)

			For $i = 0 To $sCount
				$sCheck = _GUICtrlListView_GetItemChecked($ListView_InstalledPrinters, $i)
				If $sCheck = True Then
					$sPrinterItem = _GUICtrlListView_GetItemText($ListView_InstalledPrinters, $i, 0)
					
					GUICtrlSetData($lblInstall, "Salvando" & @CRLF & $sPrinterItem)
					_DBStart()
					_SQLite_GetTable2d(-1, 'Select Printer from Printers Where UserName = "' & StringUpper($userName) & '" AND AnalystName = "' & StringUpper($analystName) & '"', $aSelect, $iRows, $iColumns)
					_DBStop()

					$sCheckExist = False
					For $i2 = 1 To UBound($aSelect) - 1
						If $sPrinterItem = $aSelect[$i2][0] Then
							$sCheckExist = True
							ExitLoop
						EndIf
					Next

					If $sCheckExist = False Then
						_DBStart()
						_SQLite_Exec(-1, StringFormat("Insert Into Printers VALUES('%s', '%s', '%s')", $sPrinterItem, StringUpper($userName), StringUpper($analystName)))
						_DBStop()
						GUICtrlCreateListViewItem($sPrinterItem, $ListView_BackupedPrinters)
					EndIf

				EndIf
			Next
			Sleep(2000)
			GUIDelete($hWnd_FormStatus)
			_GUIDisable($Form1, '')
			;~ WinSetTrans($Form1, '', 255)
			WinActivate($Form1)
		EndIf
	EndIf
EndFunc   ;==>_registerPrinterOnDB

Func _installedPrintersLoad()
	_GUICtrlListView_DeleteAllItems($ListView_InstalledPrinters)
	$aPrinterList = _PrintMgr_EnumPrinter()
	For $i = 1 To $aPrinterList[0]
		If StringInStr($aPrinterList[$i], "\\") Then
			GUICtrlCreateListViewItem($aPrinterList[$i], $ListView_InstalledPrinters)
		EndIf
	Next
EndFunc   ;==>_installedPrintersLoad

Func _backupedPrintersLoad()
	_GUICtrlListView_DeleteAllItems($ListView_BackupedPrinters)
	_DBStart()
	_SQLite_GetTable2d(-1, 'Select Printer from Printers Where UserName = "' & StringUpper($userName) & '"', $aSelect, $iRows, $iColumns)
	_DBStop()

	For $i = 1 To UBound($aSelect) - 1
		GUICtrlCreateListViewItem($aSelect[$i][0], $ListView_BackupedPrinters)
	Next
EndFunc   ;==>_backupedPrintersLoad

Func _GUIDisable($hByRef, $iMode = Default)
	If $iMode <> Default Then
		GUIDelete($hWnd_Disable)
		GUISetState(@SW_ENABLE, $hByRef)
;~ WinSetTrans($hByRef, '', 255)
		Return 0
	EndIf
	Local $aGetPos = WinGetPos($hByRef)
	GUISetState(@SW_DISABLE, $hByRef)
	$hWnd_Disable = GUICreate('', $aGetPos[2] - 15, $aGetPos[3] - 8, -5, -35, $WS_POPUP, $WS_EX_MDICHILD, $hByRef)
	GUISetBkColor($COLOR_BLACK)
	;~ WinSetTrans($hWnd_Disable, '', 240)
	GUISetState(@SW_SHOW, $hWnd_Disable)
	GUISetState(@SW_DISABLE, $hWnd_Disable)
EndFunc   ;==>_GUIDisable

Func wParam()
	If UBound($CmdLine) - 1 > 0 Then
		Switch $CmdLine[1]
			Case "/execPrinterBackup"
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