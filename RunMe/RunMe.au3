#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Backup Erik\Desktop\Empacotamentos\Icons\Stefanini_Globe.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Rodrigo Chaves Neto - RCNETO
				 Erik Cesar de Oliveira - ERIKOLIV

 Script Function:
	RunMe
	02/2022

#ce ----------------------------------------------------------------------------
#AutoIt3Wrapper_Run_Debug_Mode=n

#include "..\UDF\UDF_Embedded.au3"

wParam()
Opt("GUIOnEventMode", 1)
_LogoApp(True)
_LogoStefanini(True)
_Extract_ShadowRunMe(True)
_SQLiteDLL(True)

;Necessario para a sugestao de pesquisa
Global $hList, $aWords = ''
Global $sChosen, $idCurInput, $sCurrInput = "", $hListGUI = -1

;Variaveis para a GUI de atualizacao do RunMe
Global $hWnd_Update = ''

;Variaveis para a GUI de MultiInstalacao
Global $hWnd_MultiInstall = ''
Global $ListView2, $idDelete, $idRemover, $idBtn_Instalar_M
Global $sLabel_Status, $idProgress_Status

;Variaveis da janela de edicao de programas
Global $hWnd_Edit = ''
Global $idInput_Software, $idInput_Versao, $idInput_Descricao, $idInput_Path, $idInput_Parametro
Global $idBtn_Path, $idBtn_Salvar
Global $sByRefMode

;Variavel janela disable
Global $hWnd_Disable

;Define o repositorio de arquivo local
Global $sRepository = '\\sjkfs13\pacotes$\Rollout Assistant\Binaries'
;~ Global $sRepository = @ScriptDir

;Inicia o AutoItObject
_AutoItObject_Startup()

;Cria objeto
Global $oApp = newObject()
;Cria propriedades para o objeto
addProperty($oApp, 'nome', '')
addProperty($oApp, 'versao', '')
addProperty($oApp, 'descricao', '')
addProperty($oApp, 'path', '')
addProperty($oApp, 'parametro', '')

;=======================================================================Creating the GUI===============================================================================
;Enable high DPI support: Detects the users DPI settings and resizes GUI and all controls to look perfectly sharp.
; Note: Requries "#AutoIt3Wrapper_Res_HiDpi=y" for compiling. To see visible changes without compiling, you have to disable dpi scaling in compatibility settings of Autoit3.exe

;Mostra o logo inicial
_GDIPlus_Startup()


;Cria a GUI
$hWnd_Main = _Metro_CreateGUI("RunMe", 960, 630, -1, -1)
GUISetFont(10, 400, 0, "Segoe UI")
GUISetBkColor($GUIThemeColor)
_RoundCorners($hWnd_Main, 3, 3, 20, 20)

;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, False, True, False, False) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
GUICtrlSetOnEvent($GUI_CLOSE_BUTTON, "SpecialEvents")
GUICtrlSetOnEvent($GUI_MINIMIZE_BUTTON, "SpecialEvents")

;Define um logo no topo da GUI
$iLogoApp = _GUICtrlCreateGIF(@TempDir & '\LogoApp.png', '', 10, 0, 168, 80)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT + $GUI_DOCKTOP)
GUICtrlSetStyle(-1, -1, $GUI_WS_EX_PARENTDRAG)

$idBtn_Instalar = _Metro_CreateButtonEx2("Instalar", 36, 588, 99, 25)
GUICtrlSetOnEvent(-1, "instalar")
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE)
$idBtn_Atualizar = _Metro_CreateButtonEx2("Atualizar", 138, 588, 99, 25)
GUICtrlSetOnEvent(-1, "_LoadData")
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE)
$idBtn_Lista = _Metro_CreateButtonEx2("Lista", 240, 588, 99, 25)
GUICtrlSetOnEvent(-1, "hWnd_MultiInstall")
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE)
$idBtn_Adicionar = _Metro_CreateButtonEx2("Adicionar", 342, 588, 99, 25)
GUICtrlSetOnEvent(-1, "novoItem")
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE)
$idBtn_Remover = _Metro_CreateButtonEx2("Remover", 444, 588, 99, 25)
GUICtrlSetOnEvent(-1, "remover")
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE)
$ListView1 = GUICtrlCreateListView("Software|Versão|Descrição", 33, 60, 894, 522, BitOR($WS_EX_CLIENTEDGE, $LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_DOUBLEBUFFER))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 150)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 200)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 400)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
;~ GUICtrlSetBkColor(-1, $GUIThemeColor)
;~ GUICtrlSetColor(-1, $FontThemeColor)

;Area de pesquisa
$idInput_Pesquisar = GUICtrlCreateInput("", 271, 18, 415, 25)
GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKTOP + $GUI_DOCKSIZE)
$idBtn_Pesquisar = _Metro_CreateButtonEx2("Pesquisar", 690, 18, 99, 25)
GUICtrlSetOnEvent(-1, "pesquisar")
GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKTOP + $GUI_DOCKSIZE)

;ContextMenu
$hContextMenu = GUICtrlCreateContextMenu($ListView1)
$idAdicionar = GUICtrlCreateMenuItem("Adicionar", $hContextMenu)
GUICtrlSetOnEvent(-1, "novoItem")
$idRemover = GUICtrlCreateMenuItem("Remover", $hContextMenu)
GUICtrlSetOnEvent(-1, "remover")
GUICtrlCreateMenuItem("", $hContextMenu)
$idEditar = GUICtrlCreateMenuItem("Detalhes", $hContextMenu)
GUICtrlSetOnEvent(-1, "abrirDetalhes")

;Logo Stefanini no rodape
$iLogoStefanini = _GUICtrlCreateGIF(@TempDir & '\LogoStefanini.png', '', 815, 588, 110, 25)
GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)

;Inicia a caixa de sugestao de pesquisa
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

;Carrega a lista de programas
_LoadData()

_GDIPlus_Shutdown()
;~ GUIDelete($hWnd_ShowApp)

;Inicia os eventos de controle da GUI
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
GUISetOnEvent($GUI_EVENT_RESTORE, "SpecialEvents")

;Exibe a GUI principal
shadowApp()
GUISetState(@SW_SHOW, $hWnd_Main)



While 1
	Sleep(10)
WEnd

;////// Atualizacao de repositorio e database
Func atualizarRunMe()
	$hWnd_Update = GUICreate("Atualização do RunMe", 655, 517, 200, 10, BitOR($WS_CAPTION, $WS_SYSMENU), $WS_EX_MDICHILD, $hWnd_Main)
	GUISetOnEvent($GUI_EVENT_CLOSE, "event_Close_Update")
	GUISetFont(10, 400, 0, "Segoe UI")
	Local $ListView_Update = GUICtrlCreateListView("Atualizações desta versão", 23, 12, 604, 192)
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 350)
	GUICtrlCreateLabel("Detalhes", 23, 210, 54, 21)
	Local $Edit1 = GUICtrlCreateEdit("", 23, 234, 605, 209)
	Local $idBtn_AtualizarRunMe = GUICtrlCreateButton("Atualizar", 558, 462, 75, 25)
	GUISetState(@SW_SHOW)
	$aSelect = ''

	_DBStart()
	_SQLite_GetTable2d(-1, "Select * from UpdateRunMe Order By Version ASC", $aSelect, $iRows, $iColumns)
	_DBStop()

	If IsArray($aSelect) Then
		Local $sLocalVersion = FileGetVersion(@ScriptName)
		Local $sServerVersion = $aSelect[1][0]
		If $sServerVersion > $sLocalVersion Then
			Local $aFeatures = StringSplit($aSelect[1][1], ';', 1)
			Local $aDescriptions = StringSplit($aSelect[1][2], ';', 1)
			If IsArray($aFeatures) Then
				For $i = 1 To UBound($aFeatures) - 1
					GUICtrlCreateListViewItem($aFeatures[$i], $ListView_Update)
				Next
				For $i = 1 To UBound($aDescriptions) - 1
					GUICtrlSetData($Edit1, $aDescriptions[$i] & @CRLF, 1)
				Next
			EndIf

		EndIf
	EndIf
;~ _ArrayDisplay($aSelect)
EndFunc   ;==>atualizarRunMe

;////// Eventos da janela principal
;Pesquisar
Func pesquisar()
	GUICtrlSetState($ListView1, $GUI_HIDE)
	Local $sParam = GUICtrlRead($idInput_Pesquisar)
	GUICtrlSetData($idInput_Pesquisar, $sParam & ' ')
	$aSelect = ''
	If StringMid($sParam, 1, 2) = '0x' Then
		MsgBox(262144 + 64, 'RunMe', '..' & BinaryToString($sParam))
		GUICtrlSetData($idInput_Pesquisar, '')
		Return 0
	EndIf
	_GUICtrlListView_DeleteAllItems($ListView1)
	_DBStart()
	_SQLite_GetTable2d(-1, "Select * from Softwares Where Name like '%" & $sParam & "%' Or Version like '%" & $sParam & "%' Or Description like '%" & $sParam & "%'", $aSelect, $iRows, $iColumns)
	_DBStop()

	If IsArray($aSelect) Then
		If UBound($aSelect) - 1 > 0 Then
			$hImage = _GUIImageList_Create(32, 32)
			GUICtrlSetState($ListView1, $GUI_HIDE)
			_GUICtrlListView_DeleteAllItems($ListView1)
			For $i = 1 To UBound($aSelect) - 1
;~ Local $aExe = StringSplit($aSelect[$i][3], ' ', 1)
;~ If IsArray($aExe) Then
;~ 	$aExe = $aExe[1]
;~ Else
;~ 	$aExe = $aSelect[$i][3]
;~ EndIf

				_ExtractIconFromExe($sRepository & $aSelect[$i][3], @TempDir & '\' & $i & '.bmp')
				_GUIImageList_AddBitmap($hImage, @TempDir & '\' & $i & '.bmp')
				_GUICtrlListView_SetImageList($ListView1, $hImage, 1)
				$iIndex = _GUICtrlListView_AddItem($ListView1, $aSelect[$i][0], $i - 1)
				_GUICtrlListView_AddSubItem($ListView1, $iIndex, $aSelect[$i][1], 1)
				_GUICtrlListView_AddSubItem($ListView1, $iIndex, $aSelect[$i][2], 2)
				If Not IsArray($aWords) Then $aWords &= $aSelect[$i][0] & @CRLF
				If Not IsArray($aWords) Then $aWords &= $aSelect[$i][1] & @CRLF
				If Not IsArray($aWords) Then $aWords &= $aSelect[$i][2] & @CRLF
			Next
			If Not IsArray($aWords) Then $aWords = StringSplit($aWords, @CRLF, 1)
			GUICtrlSetData($ListView1, 'Software (' & _GUICtrlListView_GetItemCount($ListView1) & ')|Versão|Descrição')
			GUICtrlSetState($ListView1, $GUI_SHOW)
		Else
			GUICtrlSetData($ListView1, 'Software (' & _GUICtrlListView_GetItemCount($ListView1) & ')|Versão|Descrição')
		EndIf
	Else
		GUICtrlSetData($ListView1, 'Software (' & _GUICtrlListView_GetItemCount($ListView1) & ')|Versão|Descrição')
	EndIf
	GUICtrlSetState($ListView1, $GUI_SHOW)
EndFunc   ;==>pesquisar

;Adicionar
Func novoItem()
	$sByRefMode = 'Adicionar novo Software'
	hWnd_Edit()
EndFunc   ;==>novoItem

;Remover
Func remover()
	Local $aGetItem = _GUICtrlListView_GetItemTextArray($ListView1)
	Local $aIndex = _GUICtrlListView_GetSelectedIndices($ListView1)
	If $aGetItem[1] <> '' And $aGetItem[2] <> '' Then
		_DBStart()
		_SQLite_GetTable2d(-1, "Select UserName from Softwares Where Name like '%" & $aGetItem[1] & "%' AND Version like '%" & $aGetItem[2] & "%'", $aSelect, $iRows, $iColumns)
		_DBStop()
		If $aSelect[1][0] = "SYSTEM" Then
			_AD_Open()
			If _AD_IsMemberOf("SJK-DM") Then
				Local $sTarget = StringFormat("\" & $sRepository & '\Repository\%s_%s', $aGetItem[1], $aGetItem[2])
				Local $iQuestion = MsgBox(262144 + 32 + 4, 'RunMe', 'Tem certeza que deseja remover o item ' & $aGetItem[1] & '?', 30, $hWnd_Main)
				If $iQuestion = 6 Then
					DirRemove($sTarget, 1)
					If Not FileExists($sTarget) Then
						_DBStart()
						_SQLite_Exec(-1, StringFormat("Delete from Softwares Where Name like '%s' And Version like '%s'", $aGetItem[1], $aGetItem[2]))
						_DBStop()
						_GUICtrlListView_DeleteItemsSelected($ListView1)
						GUICtrlSetData($ListView1, 'Software (' & _GUICtrlListView_GetItemCount($ListView1) & ')|Versão|Descrição')
					Else
						MsgBox(262144 + 16, 'RunMe', 'Houve um erro ao tentar remover o item selecionado', 30, $hWnd_Main)
					EndIf
				EndIf
			Else
				MsgBox($MB_ICONINFORMATION + $MB_TOPMOST, "RunMe", "Você não possui permissão para deletar este item!")
			EndIf
			_AD_Close()
		Else
			Local $sTarget = StringFormat("\" & $sRepository & '\Repository\%s_%s', $aGetItem[1], $aGetItem[2])
			Local $iQuestion = MsgBox(262144 + 32 + 4, 'RunMe', 'Tem certeza que deseja remover o item ' & $aGetItem[1] & '?', 30, $hWnd_Main)
			If $iQuestion = 6 Then
				DirRemove($sTarget, 1)
				If Not FileExists($sTarget) Then
					_DBStart()
					_SQLite_Exec(-1, StringFormat("Delete from Softwares Where Name like '%s' And Version like '%s'", $aGetItem[1], $aGetItem[2]))
					_DBStop()
					_GUICtrlListView_DeleteItemsSelected($ListView1)
					GUICtrlSetData($ListView1, 'Software (' & _GUICtrlListView_GetItemCount($ListView1) & ')|Versão|Descrição')
				Else
					MsgBox(262144 + 16, 'RunMe', 'Houve um erro ao tentar remover o item selecionado', 30, $hWnd_Main)
				EndIf
			EndIf
		EndIf
		
	EndIf
EndFunc   ;==>remover

;Atualizar
Func atualizar()
	_LoadData()
EndFunc   ;==>atualizar

;Instalar
Func instalar()
	Local $aGetItem = _GUICtrlListView_GetItemTextArray($ListView1)
	Local $aIndex = _GUICtrlListView_GetSelectedIndices($ListView1)
	If $aGetItem[1] <> '' Then
		$aSelect = ''
		_DBStart()
		_SQLite_GetTable2d(-1, StringFormat("Select Repository, UserName from Softwares Where Name Like '%s' And Version Like '%s'", $aGetItem[1], $aGetItem[2]), $aSelect, $iRows, $iColumns)
		_DBStop()
		If UBound($aSelect) - 1 > 0 Then

			Local $aGetPos = WinGetPos($hWnd_Main)
			Local $hWnd_FormStatus = GUICreate("", 461, 235, 250, 197, $WS_POPUPWINDOW, $WS_EX_MDICHILD, $hWnd_Main)
			Local $aGetPos = WinGetPos($hWnd_FormStatus)
			GUISetBkColor($COLOR_WHITE)
			GUISetFont(10, 400, 0, "Segoe UI")
			GUICtrlCreateLabel(StringFormat("Instalando %s.....", $aGetItem[1]), 0, 91, $aGetPos[2] - 2, 21, $SS_CENTER)
			Local $idProgress1 = GUICtrlCreateProgress(104, 121, 252, 11, 0x8)
			_SendMessage(GUICtrlGetHandle($idProgress1), $PBM_SETMARQUEE, 1, 30)

			GUISetState(@SW_SHOW)
			Sleep(2000)

			If $aSelect[1][1] = "SYSTEM" Then
				RunWait(StringFormat('%s%s', $sRepository, $aSelect[1][0] & " /singleInstall"), "", @SW_HIDE)
			Else
				$sInstall = $sRepository & $aSelect[1][0]
				$sStringSearch = StringInStr($sInstall, ".lnk")
				
				If $sStringSearch = 0 Then
					RunWait(StringFormat('%s%s', $sRepository, $aSelect[1][0] & " /singleInstall"))
				Else
					RunWait(@ComSpec & " /c " & StringFormat('"%s%s"', $sRepository, $aSelect[1][0]))
				EndIf
			EndIf

			GUIDelete($hWnd_FormStatus)
			WinActivate($hWnd_Main)

		EndIf
	EndIf
EndFunc   ;==>instalar

;Carrega a lista de programas
Func _LoadData()

	_DBStart()
	_SQLite_GetTable2d(-1, "SELECT * FROM Softwares Where UserName ='SYSTEM' or UserName = '" & StringUpper(@UserName) & "';", $aSelect, $iRows, $iColumns)
	_DBStop()
	If IsArray($aSelect) Then
		If UBound($aSelect) - 1 > 0 Then

			$hImage = _GUIImageList_Create(32, 32)
			GUICtrlSetState($ListView1, $GUI_HIDE)
			_GUICtrlListView_DeleteAllItems($ListView1)
			GUICtrlSetData($idInput_Pesquisar, '')
			For $i = 1 To UBound($aSelect) - 1
				_ExtractIconFromExe($sRepository & $aSelect[$i][3], @TempDir & '\' & $i & '.bmp')
				_GUIImageList_AddBitmap($hImage, @TempDir & '\' & $i & '.bmp')
				_GUICtrlListView_SetImageList($ListView1, $hImage, 1)

				;Começa a popular a ListView
				$iIndex = _GUICtrlListView_AddItem($ListView1, $aSelect[$i][0], $i - 1)
				_GUICtrlListView_AddSubItem($ListView1, $iIndex, $aSelect[$i][1], 1)
				_GUICtrlListView_AddSubItem($ListView1, $iIndex, $aSelect[$i][2], 2)
				If Not IsArray($aWords) Then $aWords &= $aSelect[$i][0] & @CRLF
				If Not IsArray($aWords) Then $aWords &= $aSelect[$i][1] & @CRLF
				If Not IsArray($aWords) Then $aWords &= $aSelect[$i][2] & @CRLF
			Next
			If Not IsArray($aWords) Then $aWords = StringSplit($aWords, @CRLF, 1)
			GUICtrlSetData($ListView1, 'Software (' & _GUICtrlListView_GetItemCount($ListView1) & ')|Versão|Descrição')
			GUICtrlSetState($ListView1, $GUI_SHOW)
		EndIf
	EndIf
EndFunc   ;==>_LoadData

;////// Janela de MultiInstalacao
Func hWnd_MultiInstall()
	$hWnd_MultiInstall = GUICreate("Multiplas instalações", 605, 460, 600, 80, BitOR($WS_SYSMENU, $WS_MAXIMIZEBOX, $WS_SIZEBOX), $WS_EX_MDICHILD, $hWnd_Main)
	GUISetOnEvent($GUI_EVENT_CLOSE, "event_Close_MultiInstall")
	$ListView2 = GUICtrlCreateListView("Software|Versão|Descrição", 0, 0, 605, 385)
	GUICtrlSetState(-1, $GUI_DROPACCEPTED)
	GUISetOnEvent($GUI_EVENT_DROPPED, "onDrop")
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 200)
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 130)
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 250)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
	;ContextMenu
	$hContextMenu = GUICtrlCreateContextMenu($ListView2)
	$idDelete = GUICtrlCreateMenuItem("Remover", $hContextMenu)
	GUICtrlSetOnEvent(-1, "delete")

	$sLabel_Status = GUICtrlCreateLabel("", 18, 386, 300, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKLEFT)
	$idProgress_Status = GUICtrlCreateProgress(18, 402, 210, 11)
	GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKLEFT)
	GUICtrlSetState(-1, $GUI_HIDE)

	$idBtn_Remover_M = GUICtrlCreateButton("Remover", 436, 396, 75, 25)
	GUICtrlSetOnEvent(-1, "delete")
	GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)
	$idBtn_Instalar_M = GUICtrlCreateButton("Instalar", 516, 396, 75, 25)
	GUICtrlSetOnEvent(-1, "instalarLista")
	GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)
	GUISetState(@SW_SHOW)
EndFunc   ;==>hWnd_MultiInstall

Func onDrop()
	; If the value of @GUI_DropId is $idLabel, then set the label of the dragged file.
	Local $aGetItem = _GUICtrlListView_GetItemTextArray($ListView1)
	Local $aIndex = _GUICtrlListView_GetSelectedIndices($ListView1)
	Local $aReturn = _GUICtrlListView_CreateArray($ListView2)
	If IsArray($aGetItem) Then
		For $i = 1 To UBound($aReturn) - 1
			If $aReturn[$i][0] = $aGetItem[1] Then
				MsgBox(262144 + 16, 'RunMe', 'Este item já está na lista', 30, $hWnd_MultiInstall)
				Return 0
			EndIf
		Next
		GUICtrlCreateListViewItem($aGetItem[1] & '|' & $aGetItem[2] & '|' & $aGetItem[3], $ListView2)
		_GUICtrlListView_DeleteItemsSelected($ListView1)
		GUICtrlSetData($ListView1, 'Software (' & _GUICtrlListView_GetItemCount($ListView1) & ')|Versão|Descrição')
		GUICtrlSetData($ListView2, 'Software (' & _GUICtrlListView_GetItemCount($ListView2) & ')|Versão|Descrição')
	EndIf
EndFunc   ;==>onDrop

Func instalarLista()
	GUICtrlSetState($idBtn_Instalar, $GUI_DISABLE)
	GUICtrlSetState($idBtn_Instalar_M, $GUI_DISABLE)
	Local $aReturn = _GUICtrlListView_CreateArray($ListView2)
	If IsArray($aReturn) Then
;~ _GUIDisable($hWnd_Main)
		WinActivate($hWnd_MultiInstall)
		GUICtrlSetData($idProgress_Status, 0)
		GUICtrlSetState($idProgress_Status, $GUI_SHOW)

		Local $aResult[1][3] = [['Nome', 'Versão', 'Descrição']]

		For $i = 1 To UBound($aReturn) - 1
			_DBStart()
			_SQLite_GetTable2d(-1, StringFormat("Select Name, Version, Repository, UserName from Softwares Where Name Like '%s' And Version Like '%s'", $aReturn[$i][0], $aReturn[$i][1]), $aSelect, $iRows, $iColumns)
			_DBStop()
			GUICtrlSetData($sLabel_Status, StringFormat('Instalando o %s', $aSelect[1][0]))
			$iPID = Run($sRepository & $aSelect[1][2] & " /MultipleInstall", "", @SW_HIDE, $STDOUT_CHILD)
			ProcessWaitClose($iPID)
			$sOutput = StdoutRead($iPID)
			
			If $aSelect[1][3] = "SYSTEM" Then
				If StringInStr($sOutput, "True") Then
					_ArrayAdd($aResult, $aReturn[$i][0] & '|' & $aReturn[$i][1] & '|' & "Sucesso")
				Else
					_ArrayAdd($aResult, $aReturn[$i][0] & '|' & $aReturn[$i][1] & '|' & "Falha")
				EndIf
			Else
				_ArrayAdd($aResult, $aReturn[$i][0] & '|' & $aReturn[$i][1] & '|' & "Executado")
			EndIf

			$p = ($i * 100) / (UBound($aReturn) - 1)
			GUICtrlSetData($idProgress_Status, $p)
		Next

	EndIf
	Sleep(1500)
	GUICtrlSetData($sLabel_Status, "")
	GUICtrlSetState($idProgress_Status, $GUI_HIDE)
	GUICtrlSetState($idBtn_Instalar, $GUI_ENABLE)
	GUICtrlSetState($idBtn_Instalar_M, $GUI_ENABLE)
	_ArrayDisplay($aResult, "RunMe", "1:", 4 + 64, "", "Nome | Versão | Status")
EndFunc   ;==>instalarLista

Func delete()
	Local $aGetItem = _GUICtrlListView_GetItemTextArray($ListView2)
	Local $aIndex = _GUICtrlListView_GetSelectedIndices($ListView2)
	If $aGetItem[1] <> '' Then
		_GUICtrlListView_DeleteItemsSelected($ListView2)
		GUICtrlSetData($ListView2, 'Software (' & _GUICtrlListView_GetItemCount($ListView2) & ')|Versão|Descrição')
	EndIf
EndFunc   ;==>delete

;////// Janela de edicao de programas
Func hWnd_Edit()
	$hWnd_Edit = GUICreate($sByRefMode, 615, 350, 173, 140, $WS_SYSMENU, $WS_EX_MDICHILD, $hWnd_Main)
	GUISetFont(10, 400, 0, "Segoe UI")
;~ GUISetBkColor($GUIThemeColor)
	GUICtrlCreateLabel("Software", 30, 48, 55, 21)
	$idInput_Software = GUICtrlCreateInput($oApp.nome, 30, 72, 385, 25)
	GUICtrlSetOnEvent(-1, "coletarInputSoftware")
	GUICtrlCreateLabel("Versão", 426, 48, 45, 21)
	$idInput_Versao = GUICtrlCreateInput($oApp.versao, 426, 72, 121, 25)
	GUICtrlSetOnEvent(-1, "coletarInputVersao")
	GUICtrlCreateLabel("Descrição", 30, 114, 61, 21)
	$idInput_Descricao = GUICtrlCreateInput($oApp.descricao, 30, 138, 517, 25)
	GUICtrlSetOnEvent(-1, "coletarInputDescricao")
	GUICtrlCreateLabel("Diretório", 30, 180, 61, 21)
	$idInput_Path = GUICtrlCreateInput(StringToBinary($oApp.path), 30, 204, 517, 25, $ES_READONLY)
	GUICtrlSetOnEvent(-1, "coletarInputPath")
	$sLabel_Parametro = GUICtrlCreateLabel("Parametro", 30, 252, 65, 21)
	$idInput_Parametro = GUICtrlCreateInput("", 30, 276, 181, 25)
	GUICtrlSetOnEvent(-1, "coletarInputParametro")
	$idBtn_Path = GUICtrlCreateButton("Pesquisar", 390, 270, 75, 25)
	GUICtrlSetOnEvent(-1, "path")
	$idBtn_Salvar = GUICtrlCreateButton("Salvar", 468, 270, 75, 25)
	GUICtrlSetOnEvent(-1, "salvar")
	If $sByRefMode = 'Detalhes' Then
		GUICtrlSetState($idBtn_Path, $GUI_HIDE)
		GUICtrlSetState($idBtn_Salvar, $GUI_HIDE)
		GUICtrlSetState($idInput_Parametro, $GUI_HIDE)
		GUICtrlSetState($sLabel_Parametro, $GUI_HIDE)
		GUICtrlSetStyle($idInput_Software, $ES_READONLY)
		GUICtrlSetStyle($idInput_Versao, $ES_READONLY)
		GUICtrlSetStyle($idInput_Descricao, $ES_READONLY)
	EndIf
	GUISetState(@SW_SHOW)
	;Inicia os eventos de controle da GUI
	GUISetOnEvent($GUI_EVENT_CLOSE, "event_Close_Edit")
EndFunc   ;==>hWnd_Edit

Func abrirDetalhes()
	Local $aGetItem = _GUICtrlListView_GetItemTextArray($ListView1)
	Local $aIndex = _GUICtrlListView_GetSelectedIndices($ListView1)
	$aSelect = ''
	If IsArray($aGetItem) Then
		If $aGetItem[1] <> '' Then
			_DBStart()
			_SQLite_GetTable2d(-1, StringFormat("Select * from Softwares Where Name like '%s' And Version like '%s'", $aGetItem[1], $aGetItem[2]), $aSelect, $iRows, $iColumns)
			_DBStop()
			If IsArray($aSelect) Then
				$oApp.nome = $aSelect[1][0]
				$oApp.versao = $aSelect[1][1]
				$oApp.descricao = $aSelect[1][2]
				$oApp.path = $aSelect[1][3]
				$sByRefMode = 'Detalhes'
				hWnd_Edit()
			EndIf
		EndIf
	EndIf
EndFunc   ;==>abrirDetalhes

;Path
Func path()
	Local $iFolderSave = FileSaveDialog('RunMe', '::{450D8FBA-AD25-11D0-98A8-0800361B1103}', 'Todos os arquivos (*.*)', 0, '', $hWnd_Edit)
	If $iFolderSave <> '' Then
		$oApp.path = $iFolderSave
		GUICtrlSetData($idInput_Path, $oApp.path)
	EndIf
EndFunc   ;==>path

;Salvar
Func salvar()
	If $sByRefMode = 'Adicionar novo Software' Then
		Local $sErro = ''
		If $oApp.nome = '' Then $sErro = 'Software' & @CRLF
		If $oApp.versao = '' Then $sErro &= 'Versão' & @CRLF
		If $oApp.descricao = '' Then $sErro &= 'Descrição' & @CRLF
		If $oApp.path = '' Then $sErro &= 'Path' & @CRLF
		If StringLen($sErro) > 0 Then
			MsgBox(262144 + 16, 'RunMe', 'Os seguintes campos devem ser preenchidos' & @CRLF & @CRLF & $sErro, 30, $hWnd_Main)
			Return 1
		Else
			_DBStart()
			_SQLite_GetTable2d(-1, "Select * from Softwares Where Name like '" & $oApp.nome & "' And Version like '" & $oApp.versao & "'", $aSelect, $iRows, $iColumns)
			_DBStop()
			If UBound($aSelect) - 1 = 0 Then
				GUICtrlSetState($idBtn_Path, $GUI_DISABLE)
				GUICtrlSetState($idBtn_Salvar, $GUI_DISABLE)
				
				Local $sQuestion = False
				
				_AD_Open()
				_DBStart()
				If _AD_IsMemberOf("SJK-DM") Then
					$sQuestion = MsgBox($MB_ICONQUESTION + $MB_TOPMOST + $MB_YESNO, "RunMe", "Gostaria de copiar também todo o conteudo da pasta onde se encontra o executável?")
				EndIf
				_DBStop()
				_AD_Close()
				
				Local $hWnd_FormStatus = GUICreate("", 461, 235, 77, 58, $WS_POPUPWINDOW, $WS_EX_MDICHILD, $hWnd_Edit)
				Local $aGetPos = WinGetPos($hWnd_FormStatus)
				GUISetBkColor($COLOR_WHITE)
				GUISetFont(10, 400, 0, "Segoe UI")
				GUICtrlCreateLabel("Importando dados.....", 0, 91, $aGetPos[2] - 2, 21, $SS_CENTER)
				Local $idProgress1 = GUICtrlCreateProgress(104, 121, 252, 11, 0x8)
				_SendMessage(GUICtrlGetHandle($idProgress1), $PBM_SETMARQUEE, 1, 30)
				GUISetState(@SW_SHOW)
				Sleep(2000)
				Local $sRepoDest = $sRepository & '\Repository\' & $oApp.nome & '_' & $oApp.versao
				Local $bCreateDir = DirCreate($sRepoDest)
				Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""
				Local $aPathSplit = _PathSplit($oApp.path, $sDrive, $sDir, $sFileName, $sExtension)
				Local $sParameter = $oApp.parametro
				Local $sSoftware = $sFileName & $sExtension
				Local $sCleanSoftware = $sFileName & $sExtension
				If $oApp.parametro <> '' Then
					$sSoftware &= ' ' & $oApp.parametro
				EndIf

				If $sQuestion = $IDYES Then
					RunWait(@ComSpec & ' /c xcopy /Y /E /C "' & $sDrive & StringTrimRight($sDir, 1) & '" "' & $sRepoDest & '"', '', @SW_HIDE)
					_AD_Open()
					_DBStart()
					If _AD_IsMemberOf("SJK-DM") Then
						_SQLite_Exec(-1, StringFormat("Insert Into Softwares VALUES('%s', '%s', '%s', '\Repository\%s_%s\%s', '%s')", $oApp.nome, $oApp.versao, $oApp.descricao, $oApp.nome, $oApp.versao, $sSoftware, "SYSTEM"))
					Else
						_SQLite_Exec(-1, StringFormat("Insert Into Softwares VALUES('%s', '%s', '%s', '\Repository\%s_%s\%s', '%s')", $oApp.nome, $oApp.versao, $oApp.descricao, $oApp.nome, $oApp.versao, $sSoftware, StringUpper(@UserName)))
					EndIf
					_DBStop()
					_AD_Close()
				EndIf
				
				If $sQuestion = $IDNO Then
					FileCopy($sDrive & $sDir & $sFileName & $sExtension, $sRepository & '\Repository\' & $oApp.nome & '_' & $oApp.versao & '\' & $sFileName & $sExtension, 9)
					_AD_Open()
					_DBStart()
					If _AD_IsMemberOf("SJK-DM") Then
						_SQLite_Exec(-1, StringFormat("Insert Into Softwares VALUES('%s', '%s', '%s', '\Repository\%s_%s\%s', '%s')", $oApp.nome, $oApp.versao, $oApp.descricao, $oApp.nome, $oApp.versao, $sSoftware, "SYSTEM"))
					Else
						_SQLite_Exec(-1, StringFormat("Insert Into Softwares VALUES('%s', '%s', '%s', '\Repository\%s_%s\%s', '%s')", $oApp.nome, $oApp.versao, $oApp.descricao, $oApp.nome, $oApp.versao, $sSoftware, StringUpper(@UserName)))
					EndIf
					_DBStop()
					_AD_Close()
				EndIf

				If $sQuestion = False Then
					DirCreate($sRepository & '\Repository\' & $oApp.nome & '_' & $oApp.versao)
					FileCreateShortcut($sDrive & $sDir & $sFileName & $sExtension, $sRepository & '\Repository\' & $oApp.nome & '_' & $oApp.versao & '\' & $sFileName & ".lnk")
					$sShortcut = '\Repository\' & $oApp.nome & '_' & $oApp.versao & '\' & $sFileName & ".lnk"
					_AD_Open()
					_DBStart()
					If _AD_IsMemberOf("SJK-DM") Then
						_SQLite_Exec(-1, StringFormat("Insert Into Softwares VALUES('%s', '%s', '%s', '%s', '%s')", $oApp.nome, $oApp.versao, $oApp.descricao, $sShortcut, "SYSTEM"))
					Else
						_SQLite_Exec(-1, StringFormat("Insert Into Softwares VALUES('%s', '%s', '%s', '%s', '%s')", $oApp.nome, $oApp.versao, $oApp.descricao, $sShortcut, StringUpper(@UserName)))
					EndIf
					_DBStop()
					_AD_Close()
				EndIf

				redefinirVariavelApp()
				GUIDelete($hWnd_FormStatus)
				GUIDelete($hWnd_Edit)
				$hWnd_Edit = ''
				WinActivate($hWnd_Main)
				_LoadData()
				Return 0
			Else
				MsgBox(262144 + 16, 'RunMe', 'Este software já está cadastrado', 30, $hWnd_Main)
				Return 1
			EndIf
		EndIf
	EndIf
EndFunc   ;==>salvar

;////// Eventos da janela editar
Func redefinirVariavelApp()
	$oApp.nome = ''
	$oApp.versao = ''
	$oApp.descricao = ''
	$oApp.path = ''
	$oApp.parametro = ''
EndFunc   ;==>redefinirVariavelApp

Func coletarInputSoftware()
	$oApp.nome = GUICtrlRead($idInput_Software)
EndFunc   ;==>coletarInputSoftware

Func coletarInputVersao()
	$oApp.versao = GUICtrlRead($idInput_Versao)
EndFunc   ;==>coletarInputVersao

Func coletarInputDescricao()
	$oApp.descricao = GUICtrlRead($idInput_Descricao)
EndFunc   ;==>coletarInputDescricao

Func coletarInputPath()
	$oApp.path = GUICtrlRead($idInput_Path)
EndFunc   ;==>coletarInputPath

Func coletarInputParametro()
	$oApp.parametro = GUICtrlRead($idInput_Parametro)
EndFunc   ;==>coletarInputParametro

;####Funcoes internas
Func WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
	Local $IdFrom = BitAND($wParam, 0x0000FFFF)
	Local $iCode = BitShift($wParam, 16)
	Switch $IdFrom
		Case $idInput_Pesquisar
			Switch $iCode
				Case $EN_UPDATE
					$idCurInput = $IdFrom
					_Update($idCurInput)
			EndSwitch
		Case $hList
			_Update($idCurInput)
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func _Update($_input)
	If GUICtrlRead($_input) <> $sCurrInput Then
		$sCurrInput = GUICtrlRead($_input)
		If $hListGUI <> -1 Then         ; List is visible.
			GUIDelete($hListGUI)
			$hListGUI = -1
		EndIf

		Local $_array
		Switch $_input
			Case $idInput_Pesquisar
				$_array = $aWords
		EndSwitch

		$hList = _PopupSelector($hWnd_Main, $hListGUI, $_input, _CheckInputText($_input, $_array))
	EndIf

	If $hList <> -1 Then $sChosen = GUICtrlRead($hList)
	If $sChosen <> "" Then
		GUICtrlSetData($_input, $sChosen)
		$sCurrInput = GUICtrlRead($_input)
		GUIDelete($hListGUI)
		$hListGUI = -1
		$sChosen = ""
	EndIf
EndFunc   ;==>_Update

Func _PopupSelector($hMainGUI, ByRef $hListGUI, $_input, $sCurr_List)
	Local $hList = -1
	If $sCurr_List = "" Then Return $hList

	Local $pos = ControlGetPos($hMainGUI, "", $_input)
	Local $aGetPos = WinGetPos($hWnd_Main)
	$hListGUI = GUICreate("", 416, 100, 273, 39, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, $WS_EX_MDICHILD), $hMainGUI)
	GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKTOP + $GUI_DOCKSIZE)
	$hList = GUICtrlCreateList("", 0, 0, 460, 150, BitOR(0x00100000, 0x00200000))
	GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
	GUICtrlSetResizing(-1, $GUI_DOCKHCENTER + $GUI_DOCKTOP + $GUI_DOCKSIZE)

	StringReplace($sCurr_List, "|", "|")
	Local $iCurrHeight = @extended * GUICtrlSendMsg($hList, $LB_GETITEMHEIGHT, 0, 0) + 10
	WinMove($hListGUI, "", Default, Default, Default, $iCurrHeight)
	GUICtrlSetResizing($hListGUI, $GUI_DOCKHCENTER + $GUI_DOCKTOP + $GUI_DOCKSIZE)
	GUICtrlSetPos($hList, 0, 0, 460, $iCurrHeight)
	GUICtrlSetResizing($hList, $GUI_DOCKHCENTER + $GUI_DOCKTOP + $GUI_DOCKSIZE)

	GUICtrlSetData($hList, $sCurr_List)
	GUISetControlsVisible($hListGUI)     ; To Make Control Visible And Window Invisible.
	GUISetState(@SW_SHOWNOACTIVATE, $hListGUI)
	Return $hList
EndFunc   ;==>_PopupSelector

Func _CheckInputText($_input, $array)
	Local $sPartialData = ""
	$aSelected = _GetSelectionPointers($_input)
	If (IsArray($aSelected)) And ($aSelected[0] <= $aSelected[1]) Then
		$sCurrInput = GUICtrlRead($_input)
		Local $aSplit = StringSplit(StringLeft($sCurrInput, $aSelected[0]), " ")
		$aSelected[0] -= StringLen($aSplit[$aSplit[0]])
		If $aSplit[$aSplit[0]] <> "" Then
			For $A = 0 To UBound($array) - 1
				If StringLeft($array[$A], StringLen($aSplit[$aSplit[0]])) = $aSplit[$aSplit[0]] _
						And $array[$A] <> $aSplit[$aSplit[0]] Then
					$sPartialData &= $array[$A] & "|"
				EndIf
			Next
		EndIf
	EndIf
	Return $sPartialData
EndFunc   ;==>_CheckInputText

Func _GetSelectionPointers($hEdit)
	Local $aReturn[2] = [0, 0]
	Local $aSelected = GUICtrlRecvMsg($hEdit, 0x00B0)     ; $EM_GETSEL.
	If IsArray($aSelected) Then
		$aReturn[0] = $aSelected[0]
		$aReturn[1] = $aSelected[1]
	EndIf
	Return $aReturn
EndFunc   ;==>_GetSelectionPointers

Func GUISetControlsVisible($hWnd)
	Local $aControlGetPos = 0, $hCreateRect = 0, $hRectRgn = _WinAPI_CreateRectRgn(0, 0, 0, 0)
	Local $iLastControlID = _WinAPI_GetDlgCtrlID(GUICtrlGetHandle(-1))
	For $i = 3 To $iLastControlID
		$aControlGetPos = ControlGetPos($hWnd, '', $i)
		If IsArray($aControlGetPos) = 0 Then ContinueLoop
		$hCreateRect = _WinAPI_CreateRectRgn($aControlGetPos[0], $aControlGetPos[1], $aControlGetPos[0] + $aControlGetPos[2], $aControlGetPos[1] + $aControlGetPos[3])
		_WinAPI_CombineRgn($hRectRgn, $hCreateRect, $hRectRgn, 2)
		_WinAPI_DeleteObject($hCreateRect)
	Next
	_WinAPI_SetWindowRgn($hWnd, $hRectRgn, True)
	_WinAPI_DeleteObject($hRectRgn)
EndFunc   ;==>GUISetControlsVisible

Func _ExtractIconFromExe($source, $outsource, $iconnumber = 0)
	$Ret = DllCall("shell32", "long", "ExtractAssociatedIcon", "int", 0, "str", $source, "int*", $iconnumber)
	$hIcon = $Ret[0]
	_GDIPlus_Startup()
	$pBitmapdll = DllCall($__g_hGDIPDll, "int", "GdipCreateBitmapFromHICON", "ptr", $hIcon, "int*", 0)
	$pBitmap = $pBitmapdll[2]

	_WinAPI_DestroyIcon($Ret[0])
	_GDIPlus_ImageSaveToFileEx($pBitmap, $outsource, "{557CF400-1A04-11D3-9A73-0000F81EF32E}")
	_GDIPlus_ImageDispose($pBitmap)
	_GDIPlus_Shutdown()
EndFunc   ;==>_ExtractIconFromExe

Func newObject()
	Local $oThis = _AutoItObject_Create()
	_AutoItObject_AddMethod($oThis, "AddProperty", "_Object_AddProperty")
	_AutoItObject_AddMethod($oThis, "AddMethod", "_Object_AddMethod")
	_AutoItObject_AddMethod($oThis, "Create", "_Object_Create")
	_AutoItObject_AddProperty($oThis, "Object", $ELSCOPE_PUBLIC, 0)
	_AutoItObject_AddProperty($oThis, "Parent", $ELSCOPE_PUBLIC, 0)
	Return $oThis
EndFunc   ;==>newObject

Func addProperty($obj, $sByRefProperty, $sByRefContent = 0)
	Return _AutoItObject_AddProperty($obj, $sByRefProperty, $ELSCOPE_PUBLIC, $sByRefContent)
EndFunc   ;==>addProperty

Func _GUIDisable($hByRef, $iMode = Default)
	If $iMode <> Default Then
		GUIDelete($hWnd_Disable)
		GUISetState(@SW_ENABLE, $hByRef)
;~ WinSetTrans($hByRef, '', 255)
		Return 0
	EndIf
	Local $aGetPos = WinGetPos($hByRef)
	GUISetState(@SW_DISABLE, $hByRef)
	$hWnd_Disable = GUICreate('', $aGetPos[2] - 15, $aGetPos[3] - 8, -1, -1, $WS_POPUP, $WS_EX_MDICHILD, $hByRef)
	GUISetBkColor($COLOR_BLACK)
;~ WinSetTrans($hWnd_Disable, '', 240)
	GUISetState(@SW_SHOW, $hWnd_Disable)
	GUISetState(@SW_DISABLE, $hWnd_Disable)
EndFunc   ;==>_GUIDisable

Func _GUICtrlListView_CreateArray($hListView, $sDelimeter = '|')
	Local $iColumnCount = _GUICtrlListView_GetColumnCount($hListView), $iDim = 0, $iItemCount = _GUICtrlListView_GetItemCount($hListView)
	If $iColumnCount < 3 Then
		$iDim = 3 - $iColumnCount
	EndIf
	If $sDelimeter = Default Then
		$sDelimeter = '|'
	EndIf

	Local $aColumns = 0, $aReturn[$iItemCount + 1][$iColumnCount + $iDim] = [[$iItemCount, $iColumnCount, '']]
	For $i = 0 To $iColumnCount - 1
		$aColumns = _GUICtrlListView_GetColumn($hListView, $i)
		$aReturn[0][2] &= $aColumns[5] & $sDelimeter
	Next
	$aReturn[0][2] = StringTrimRight($aReturn[0][2], StringLen($sDelimeter))

	For $i = 0 To $iItemCount - 1
		For $j = 0 To $iColumnCount - 1
			$aReturn[$i + 1][$j] = _GUICtrlListView_GetItemText($hListView, $i, $j)
		Next
	Next
	Return SetError(Number($aReturn[0][0] = 0), 0, $aReturn)
EndFunc   ;==>_GUICtrlListView_CreateArray

Func event_Close_MultiInstall()
	If $hWnd_MultiInstall <> '' Then
		GUIDelete($hWnd_MultiInstall)
		WinActivate($hWnd_Main)
		$hWnd_MultiInstall = ''
		$aSelect = ''
		_SQLite_GetTable2d(-1, "Select * from Softwares", $aSelect, $iRows, $iColumns)
		If $iRows <> _GUICtrlListView_GetItemCount($ListView1) Then _LoadData()
	EndIf
EndFunc   ;==>event_Close_MultiInstall

Func event_Close_Update()
	If $hWnd_Update <> '' Then
		GUIDelete($hWnd_Update)
		$hWnd_Update = ''
		WinActivate($hWnd_Main)
	EndIf
EndFunc   ;==>event_Close_Update

Func event_Close_Edit()
	If $hWnd_Edit <> '' Then
		GUIDelete($hWnd_Edit)
		$hWnd_Edit = ''
		redefinirVariavelApp()
		WinActivate($hWnd_Main)
	EndIf
EndFunc   ;==>event_Close_Edit

Func SpecialEvents()
	Select
		Case @GUI_CtrlId = $GUI_CLOSE_BUTTON
			If $hWnd_Edit = '' And $hWnd_MultiInstall = '' And $hWnd_Update = '' Then
				Local $iQuestion = MsgBox(262144 + 32 + 4, 'RunMe', 'Deseja realmente sair?', 30, $hWnd_Main)
				If $iQuestion = 6 Then
					_SQLite_Close($dbConfig)
					_SQLite_Shutdown()
					_Metro_GUIDelete($hWnd_Main)
					Exit
				EndIf
			EndIf

			If $hWnd_Update <> '' Then
				GUIDelete($hWnd_Update)
				$hWnd_Update = ''
				WinActivate($hWnd_Main)
			EndIf
			If $hWnd_Edit <> '' Then
				GUIDelete($hWnd_Edit)
				$hWnd_Edit = ''
				redefinirVariavelApp()
				WinActivate($hWnd_Main)
			EndIf
			If $hWnd_MultiInstall <> '' Then
				GUIDelete($hWnd_MultiInstall)
				WinActivate($hWnd_Main)
				$hWnd_MultiInstall = ''
				$aSelect = ''
				_SQLite_GetTable2d(-1, "Select * from Softwares", $aSelect, $iRows, $iColumns)
				If $iRows <> _GUICtrlListView_GetItemCount($ListView1) Then _LoadData()
			EndIf

		Case @GUI_CtrlId = $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $hWnd_Main)

		Case @GUI_CtrlId = $GUI_EVENT_RESTORE
			GUISetState(@SW_RESTORE, $hWnd_Main)

	EndSelect
EndFunc   ;==>SpecialEvents

Func shadowApp()
	$hWnd_ShadowApp = GUICreate("", 1022, 692, -19, -19, $WS_POPUP, $WS_EX_MDICHILD + $WS_EX_LAYERED, $hWnd_Main)
	FileDelete(@TempDir & "\ShadowApp.png")
	Local $iSplashShadowApp = _GDIPlus_ImageLoadFromFile(@TempDir & "\Shadow.png")
	For $i = 0 To 255 Step 10
		drawPNG($i, $hWnd_ShadowApp, $iSplashShadowApp)
	Next
	GUISetState(@SW_SHOWNA)
	GUISetState(@SW_DISABLE)
EndFunc   ;==>shadowApp

Func wParam()
	If StringRight(@ScriptName, 3) <> 'au3' Then
		If UBound($CmdLine) - 1 > 0 Then
			Switch $CmdLine[1]
				Case "/execRunMe"
					Return 0
				Case Else
					MsgBox($MB_ICONINFORMATION + $MB_TOPMOST, "Rollout Assistant", "Esta aplicação não pode ser executada separadamente!")
					Exit
			EndSwitch
		Else
			MsgBox($MB_ICONINFORMATION + $MB_TOPMOST, "Rollout Assistant", "Esta aplicação não pode ser executada separadamente!")
			Exit
		EndIf
	EndIf
EndFunc   ;==>wParam
