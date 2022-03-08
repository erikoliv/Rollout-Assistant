#NoTrayIcon
_1sb()
Global $0[11]
Global Const $1 = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($2, $3, $4)
If $0[3] = $0[4] Then
If Not $0[7] Then
$0[5] *= -1
$0[7] = 1
EndIf
Else
$0[7] = 1
EndIf
$0[6] = $0[3]
Local $5 = _a($4, $2, $0[3])
Local $6 = _a($4, $3, $0[3])
If $0[8] = 1 Then
If(StringIsFloat($5) Or StringIsInt($5)) Then $5 = Number($5)
If(StringIsFloat($6) Or StringIsInt($6)) Then $6 = Number($6)
EndIf
Local $7
If $0[8] < 2 Then
$7 = 0
If $5 < $6 Then
$7 = -1
ElseIf $5 > $6 Then
$7 = 1
EndIf
Else
$7 = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $5, 'wstr', $6)[0]
EndIf
$7 = $7 * $0[5]
Return $7
EndFunc
Func _a($4, $8, $9 = 0)
Local $a = DllStructCreate("wchar Text[4096]")
Local $b = DllStructGetPtr($a)
Local $c = DllStructCreate($1)
DllStructSetData($c, "SubItem", $9)
DllStructSetData($c, "TextMax", 4096)
DllStructSetData($c, "Text", $b)
If IsHWnd($4) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $4, "uint", 0x1073, "wparam", $8, "struct*", $c)
Else
Local $d = DllStructGetPtr($c)
GUICtrlSendMsg($4, 0x1073, $8, $d)
EndIf
Return DllStructGetData($a, "Text")
EndFunc
Global Enum $e, $f, $g, $h, $i, $j, $k, $l
Func _e(ByRef $m, $n, $o = 0, $p = "|", $q = @CRLF, $r = $e)
If $o = Default Then $o = 0
If $p = Default Then $p = "|"
If $q = Default Then $q = @CRLF
If $r = Default Then $r = $e
If Not IsArray($m) Then Return SetError(1, 0, -1)
Local $s = UBound($m, 1)
Local $t = 0
Switch $r
Case $g
$t = Int
Case $h
$t = Number
Case $i
$t = Ptr
Case $j
$t = Hwnd
Case $k
$t = String
Case $l
$t = "Boolean"
EndSwitch
Switch UBound($m, 0)
Case 1
If $r = $f Then
ReDim $m[$s + 1]
$m[$s] = $n
Return $s
EndIf
If IsArray($n) Then
If UBound($n, 0) <> 1 Then Return SetError(5, 0, -1)
$t = 0
Else
Local $u = StringSplit($n, $p, 2 + 1)
If UBound($u, 1) = 1 Then
$u[0] = $n
EndIf
$n = $u
EndIf
Local $v = UBound($n, 1)
ReDim $m[$s + $v]
For $w = 0 To $v - 1
If String($t) = "Boolean" Then
Switch $n[$w]
Case "True", "1"
$m[$s + $w] = True
Case "False", "0", ""
$m[$s + $w] = False
EndSwitch
ElseIf IsFunc($t) Then
$m[$s + $w] = $t($n[$w])
Else
$m[$s + $w] = $n[$w]
EndIf
Next
Return $s + $v - 1
Case 2
Local $x = UBound($m, 2)
If $o < 0 Or $o > $x - 1 Then Return SetError(4, 0, -1)
Local $y, $0z = 0, $10
If IsArray($n) Then
If UBound($n, 0) <> 2 Then Return SetError(5, 0, -1)
$y = UBound($n, 1)
$0z = UBound($n, 2)
$t = 0
Else
Local $11 = StringSplit($n, $q, 2 + 1)
$y = UBound($11, 1)
Local $u[$y][0], $12
For $w = 0 To $y - 1
$12 = StringSplit($11[$w], $p, 2 + 1)
$10 = UBound($12)
If $10 > $0z Then
$0z = $10
ReDim $u[$y][$0z]
EndIf
For $13 = 0 To $10 - 1
$u[$w][$13] = $12[$13]
Next
Next
$n = $u
EndIf
If UBound($n, 2) + $o > UBound($m, 2) Then Return SetError(3, 0, -1)
ReDim $m[$s + $y][$x]
For $14 = 0 To $y - 1
For $13 = 0 To $x - 1
If $13 < $o Then
$m[$14 + $s][$13] = ""
ElseIf $13 - $o > $0z - 1 Then
$m[$14 + $s][$13] = ""
Else
If String($t) = "Boolean" Then
Switch $n[$14][$13 - $o]
Case "True", "1"
$m[$14 + $s][$13] = True
Case "False", "0", ""
$m[$14 + $s][$13] = False
EndSwitch
ElseIf IsFunc($t) Then
$m[$14 + $s][$13] = $t($n[$14][$13 - $o])
Else
$m[$14 + $s][$13] = $n[$14][$13 - $o]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($m, 1) - 1
EndFunc
Func _k(ByRef $m, $15)
If Not IsArray($m) Then Return SetError(1, 0, -1)
Local $s = UBound($m, 1) - 1
If IsArray($15) Then
If UBound($15, 0) <> 1 Or UBound($15, 1) < 2 Then Return SetError(4, 0, -1)
Else
Local $16, $11, $12
$15 = StringStripWS($15, 8)
$11 = StringSplit($15, ";")
$15 = ""
For $w = 1 To $11[0]
If Not StringRegExp($11[$w], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
$12 = StringSplit($11[$w], "-")
Switch $12[0]
Case 1
$15 &= $12[1] & ";"
Case 2
If Number($12[2]) >= Number($12[1]) Then
$16 = $12[1] - 1
Do
$16 += 1
$15 &= $16 & ";"
Until $16 = $12[2]
EndIf
EndSwitch
Next
$15 = StringSplit(StringTrimRight($15, 1), ";")
EndIf
If $15[1] < 0 Or $15[$15[0]] > $s Then Return SetError(5, 0, -1)
Local $17 = 0
Switch UBound($m, 0)
Case 1
For $w = 1 To $15[0]
$m[$15[$w]] = ChrW(0xFAB1)
Next
For $18 = 0 To $s
If $m[$18] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $18 <> $17 Then
$m[$17] = $m[$18]
EndIf
$17 += 1
EndIf
Next
ReDim $m[$s - $15[0] + 1]
Case 2
Local $x = UBound($m, 2) - 1
For $w = 1 To $15[0]
$m[$15[$w]][0] = ChrW(0xFAB1)
Next
For $18 = 0 To $s
If $m[$18][0] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $18 <> $17 Then
For $13 = 0 To $x
$m[$17][$13] = $m[$18][$13]
Next
EndIf
$17 += 1
EndIf
Next
ReDim $m[$s - $15[0] + 1][$x + 1]
Case Else
Return SetError(2, 0, False)
EndSwitch
Return UBound($m, 1)
EndFunc
Func _x(Const ByRef $m, $n, $o = 0, $19 = 0, $1a = 0, $1b = 0, $1c = 1, $9 = -1, $1d = False)
If $o = Default Then $o = 0
If $19 = Default Then $19 = 0
If $1a = Default Then $1a = 0
If $1b = Default Then $1b = 0
If $1c = Default Then $1c = 1
If $9 = Default Then $9 = -1
If $1d = Default Then $1d = False
If Not IsArray($m) Then Return SetError(1, 0, -1)
Local $s = UBound($m) - 1
If $s = -1 Then Return SetError(3, 0, -1)
Local $x = UBound($m, 2) - 1
Local $1e = False
If $1b = 2 Then
$1b = 0
$1e = True
EndIf
If $1d Then
If UBound($m, 0) = 1 Then Return SetError(5, 0, -1)
If $19 < 1 Or $19 > $x Then $19 = $x
If $o < 0 Then $o = 0
If $o > $19 Then Return SetError(4, 0, -1)
Else
If $19 < 1 Or $19 > $s Then $19 = $s
If $o < 0 Then $o = 0
If $o > $19 Then Return SetError(4, 0, -1)
EndIf
Local $1f = 1
If Not $1c Then
Local $1g = $o
$o = $19
$19 = $1g
$1f = -1
EndIf
Switch UBound($m, 0)
Case 1
If Not $1b Then
If Not $1a Then
For $w = $o To $19 Step $1f
If $1e And VarGetType($m[$w]) <> VarGetType($n) Then ContinueLoop
If $m[$w] = $n Then Return $w
Next
Else
For $w = $o To $19 Step $1f
If $1e And VarGetType($m[$w]) <> VarGetType($n) Then ContinueLoop
If $m[$w] == $n Then Return $w
Next
EndIf
Else
For $w = $o To $19 Step $1f
If $1b = 3 Then
If StringRegExp($m[$w], $n) Then Return $w
Else
If StringInStr($m[$w], $n, $1a) > 0 Then Return $w
EndIf
Next
EndIf
Case 2
Local $1h
If $1d Then
$1h = $s
If $9 > $1h Then $9 = $1h
If $9 < 0 Then
$9 = 0
Else
$1h = $9
EndIf
Else
$1h = $x
If $9 > $1h Then $9 = $1h
If $9 < 0 Then
$9 = 0
Else
$1h = $9
EndIf
EndIf
For $13 = $9 To $1h
If Not $1b Then
If Not $1a Then
For $w = $o To $19 Step $1f
If $1d Then
If $1e And VarGetType($m[$13][$w]) <> VarGetType($n) Then ContinueLoop
If $m[$13][$w] = $n Then Return $w
Else
If $1e And VarGetType($m[$w][$13]) <> VarGetType($n) Then ContinueLoop
If $m[$w][$13] = $n Then Return $w
EndIf
Next
Else
For $w = $o To $19 Step $1f
If $1d Then
If $1e And VarGetType($m[$13][$w]) <> VarGetType($n) Then ContinueLoop
If $m[$13][$w] == $n Then Return $w
Else
If $1e And VarGetType($m[$w][$13]) <> VarGetType($n) Then ContinueLoop
If $m[$w][$13] == $n Then Return $w
EndIf
Next
EndIf
Else
For $w = $o To $19 Step $1f
If $1b = 3 Then
If $1d Then
If StringRegExp($m[$13][$w], $n) Then Return $w
Else
If StringRegExp($m[$w][$13], $n) Then Return $w
EndIf
Else
If $1d Then
If StringInStr($m[$13][$w], $n, $1a) > 0 Then Return $w
Else
If StringInStr($m[$w][$13], $n, $1a) > 0 Then Return $w
EndIf
EndIf
Next
EndIf
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return SetError(6, 0, -1)
EndFunc
Func _1n($1i)
Local $1j = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
If Not IsObj($1j) Then Return SetError(1, 0, 0)
Local $1k = $1j.Get("Win32_Printer")
If Not IsObj($1k) Then Return SetError(1, 0, 0)
Local $1l = $1k.AddPrinterConnection($1i)
Return($1l = 0 ? 1 : SetError($1l, 0, 0))
EndFunc
Func _1r($1m = "")
Local $1n[10], $1o, $1p = 0
Local Const $1q = 0x10, $1r = 0x20
If $1m <> "" Then $1o = StringReplace(" Where Name like '" & StringReplace($1m, "\", "\\") & "'", "*", "%")
Local $1j = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
If Not IsObj($1j) Then Return SetError(1, 0, 0)
Local $1s = $1j.ExecQuery("Select * from Win32_Printer" & $1o, "WQL", $1q + $1r)
If Not IsObj($1s) Then Return SetError(1, 0, 0)
For $1k In $1s
$1p += 1
If $1p >= UBound($1n) Then ReDim $1n[UBound($1n) * 2]
$1n[$1p] = $1k.Name
Next
ReDim $1n[$1p + 1]
$1n[0] = $1p
Return $1n
EndFunc
Global Const $1t =(0x1000 + 9)
Global Const $1u =(0x1000 + 5)
Global Const $1v =(0x1000 + 75)
Global Const $1w =(0x1000 + 4)
Global Const $1x =(0x1000 + 45)
Global Const $1y =(0x1000 + 115)
Global Const $1z = 0x2000 + 6
Global Const $20 =(0x1000 + 30)
Global Const $21 =(0x1000 + 6)
Global Const $22 =(0x1000 + 76)
Global Const $23 = 0X400
Global Const $24 = $23 + 10
Global $25 = "0x252525"
Global $26 = "0xFFFFFF"
Global $27 = "0x2D2D2D"
Global $28 = "0x125bad"
Global $29 = "0xFFFFFF"
Global $2a = "0xFFFFFF"
Global $2b = "MeuAtivo"
Global $2c = "0xD8D8D8"
Global $2d = "0x1a1a1a"
Global $2e = "0x504f4f"
Global $2f = 0x404040
Global $2g = 0x272727
Global $2h = 0x125bad
Global $2i = 0x125bad
Global $2j = 0x252525
Global $2k = 0xffffff
Func _2f($2l = "MeuAtivo")
$2b = $2l
Switch($2l)
Case "Dark"
$25 = 0x252525
$26 = "0xFFFFFF"
$27 = "0x2D2D2D"
$28 = "0x125bad"
$29 = "0xFFFFFF"
$2a = "0xFFFFFF"
$2c = "0xD8D8D8"
$2d = "0x1a1a1a"
$2e = "0x504f4f"
$2f = 0x404040
$2g = 0x272727
$2h = 0x125bad
$2i = 0x125bad
$2j = 0x252525
$2k = 0xffffff
Case "Light"
$25 = 0xdddddd
$26 = "0x252525"
$27 = "0x2D2D2D"
$28 = "0x125bad"
$29 = "0xFFFFFF"
$2a = "0xFFFFFF"
$2c = "0x7e7e7e"
$2d = "0x1a1a1a"
$2e = "0x504f4f"
$2f = 0x202020
$2g = 0xc0bfbf
$2h = 0x125bad
$2i = 0x125bad
$2j = 0x252525
$2k = 0x2c8fff
Case "RolloutAssistant"
$25 = 0xF0F0F0
$26 = "0x252525"
$27 = "0x2D2D2D"
$28 = "0x125bad"
$29 = "0xFFFFFF"
$2a = "0xFFFFFF"
$2c = "0x7e7e7e"
$2d = "0x1a1a1a"
$2e = "0x504f4f"
$2f = 0x202020
$2g = 0xc0bfbf
$2h = 0x125bad
$2i = 0x125bad
$2j = 0x252525
$2k = 0x2c8fff
Case Else
ConsoleWrite("Metro-UDF-Error: Theme not found, using default theme." & @CRLF)
$25 = 0x252525
$26 = "0xFFFFFF"
$27 = "0x2D2D2D"
$28 = "0x125bad"
$29 = "0xFFFFFF"
$2a = "0xFFFFFF"
$2c = "0x252525"
$2d = "0x1a1a1a"
$2e = "0x504f4f"
$2f = 0x404040
$2g = 0x272727
$2h = 0x125bad
$2i = 0x125bad
$2j = 0x252525
$2k = 0xffffff
EndSwitch
EndFunc
Global Const $2m = 0x0026200A
Global Const $2n = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $2o = "struct;float X;float Y;float Width;float Height;endstruct"
Global Const $2p = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $2q = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
Global Const $2r = "uint length;uint flags;uint showCmd;long ptMinPosition[2];long ptMaxPosition[2];long rcNormalPosition[4]"
Global $2s, $2t = 0
Global Const $2u = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $2v = _34()
Func _2k($2w)
Local $2x = DllCall("kernel32.dll", "bool", "FreeLibrary", "handle", $2w)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _2m($4)
Local $2x = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $4)
If @error Then Return SetError(@error, @extended, 0)
Return $2x[0]
EndFunc
Func _2r($2y)
Local $2x = DllCall("kernel32.dll", "handle", "LoadLibraryW", "wstr", $2y)
If @error Then Return SetError(@error, @extended, 0)
Return $2x[0]
EndFunc
Func _32(ByRef $2z, $30 = 100)
Select
Case UBound($2z, 2)
If $30 < 0 Then
ReDim $2z[$2z[0][0] + 1][UBound($2z, 2)]
Else
$2z[0][0] += 1
If $2z[0][0] > UBound($2z) - 1 Then
ReDim $2z[$2z[0][0] + $30][UBound($2z, 2)]
EndIf
EndIf
Case UBound($2z, 1)
If $30 < 0 Then
ReDim $2z[$2z[0] + 1]
Else
$2z[0] += 1
If $2z[0] > UBound($2z) - 1 Then
ReDim $2z[$2z[0] + $30]
EndIf
EndIf
Case Else
Return 0
EndSelect
Return 1
EndFunc
Func _34()
Local $31 = DllStructCreate($2u)
DllStructSetData($31, 1, DllStructGetSize($31))
Local $1n = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $31)
If @error Or Not $1n[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($31, 2), -8), DllStructGetData($31, 3))
EndFunc
Func _4q(Const $32 = @error, Const $33 = @extended)
Local $2x = DllCall("kernel32.dll", "dword", "GetLastError")
Return SetError($32, $33, $2x[0])
EndFunc
Func _50($34)
Local $2x = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $34)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _5l($35, $36)
Local $1n = DllCall('kernel32.dll', 'bool', 'IsBadReadPtr', 'struct*', $35, 'uint_ptr', $36)
If @error Then Return SetError(@error, @extended, False)
Return $1n[0]
EndFunc
Func _5n($35, $36)
Local $1n = DllCall('kernel32.dll', 'bool', 'IsBadWritePtr', 'struct*', $35, 'uint_ptr', $36)
If @error Then Return SetError(@error, @extended, False)
Return $1n[0]
EndFunc
Func _5q($37, $38, $36)
If _5l($38, $36) Then Return SetError(10, @extended, 0)
If _5n($37, $36) Then Return SetError(11, @extended, 0)
DllCall('ntdll.dll', 'none', 'RtlMoveMemory', 'struct*', $37, 'struct*', $38, 'ulong_ptr', $36)
If @error Then Return SetError(@error, @extended, 0)
Return 1
EndFunc
Func _a8($39 = 0, $3a = 0)
Local $3b = DllCallbackRegister('_ek', 'bool', 'handle;handle;ptr;lparam')
Dim $2s[101][2] = [[0]]
Local $1n = DllCall('user32.dll', 'bool', 'EnumDisplayMonitors', 'handle', $39, 'struct*', $3a, 'ptr', DllCallbackGetPtr($3b), 'lparam', 0)
If @error Or Not $1n[0] Or Not $2s[0][0] Then
$2s = @error + 10
EndIf
DllCallbackFree($3b)
If $2s Then Return SetError($2s, 0, 0)
_32($2s, -1)
Return $2s
EndFunc
Func _bh($3a)
Local $2x[4]
For $w = 0 To 3
$2x[$w] = DllStructGetData($3a, $w + 1)
If @error Then Return SetError(@error, @extended, 0)
Next
For $w = 2 To 3
$2x[$w] -= $2x[$w - 2]
Next
Return $2x
EndFunc
Func _cg($4, $3c = 1)
Local $1n = DllCall('user32.dll', 'handle', 'MonitorFromWindow', 'hwnd', $4, 'dword', $3c)
If @error Then Return SetError(@error, @extended, 0)
Return $1n[0]
EndFunc
Func _ek($3d, $39, $3e, $3f)
#forceref $39, $3f
_32($2s)
$2s[$2s[0][0]][0] = $3d
If Not $3e Then
$2s[$2s[0][0]][1] = 0
Else
$2s[$2s[0][0]][1] = DllStructCreate($2n)
If Not _5q(DllStructGetPtr($2s[$2s[0][0]][1]), $3e, 16) Then Return 0
EndIf
Return 1
EndFunc
Global $3g = 0
Global $3h = 0
Global $3i = 0
Global $3j = 0
Global $3k = 0
Global $3l = True
Func _f4($3m, $3n, $3o = $2m, $3p = 0, $3q = 0)
Local $2x = DllCall($3h, "uint", "GdipCreateBitmapFromScan0", "int", $3m, "int", $3n, "int", $3p, "int", $3o, "struct*", $3q, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[6]
EndFunc
Func _f6($3r, $3s = 0xFF000000)
Local $2x = DllCall($3h, "int", "GdipCreateHBITMAPFromBitmap", "handle", $3r, "handle*", 0, "dword", $3s)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[2]
EndFunc
Func _f7($3r)
Local $2x = DllCall($3h, "int", "GdipDisposeImage", "handle", $3r)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _fg($3s = 0xFF000000)
Local $2x = DllCall($3h, "int", "GdipCreateSolidFill", "int", $3s, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[2]
EndFunc
Func _fh($3t)
Local $2x = DllCall($3h, "int", "GdipDeleteBrush", "handle", $3t)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _g6($3u, $3v, $3w = 0, $3x = 3)
Local $2x = DllCall($3h, "int", "GdipCreateFont", "handle", $3u, "float", $3v, "int", $3w, "int", $3x, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[5]
EndFunc
Func _g7($3y)
Local $2x = DllCall($3h, "int", "GdipDeleteFont", "handle", $3y)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _g8($3z, $40 = 0)
Local $2x = DllCall($3h, "int", "GdipCreateFontFamilyFromName", "wstr", $3z, "ptr", $40, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[3]
EndFunc
Func _ga($3u)
Local $2x = DllCall($3h, "int", "GdipDeleteFontFamily", "handle", $3u)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _gk($41, $3s = 0xFF000000)
Local $2x = DllCall($3h, "int", "GdipGraphicsClear", "handle", $41, "dword", $3s)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _gm($4)
Local $2x = DllCall($3h, "int", "GdipCreateFromHWND", "hwnd", $4, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[2]
EndFunc
Func _gn($41)
Local $2x = DllCall($3h, "int", "GdipDeleteGraphics", "handle", $41)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _gz($41, $42, $43, $44, $45, $46 = 0)
_ne($46)
Local $2x = DllCall($3h, "int", "GdipDrawLine", "handle", $41, "handle", $46, "float", $42, "float", $43, "float", $44, "float", $45)
_nf()
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _h3($41, $47, $48, $49, $4a, $46 = 0)
_ne($46)
Local $2x = DllCall($3h, "int", "GdipDrawRectangle", "handle", $41, "handle", $46, "float", $47, "float", $48, "float", $49, "float", $4a)
_nf()
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _h5($41, $4b, $3y, $4c, $4d, $3t)
Local $2x = DllCall($3h, "int", "GdipDrawString", "handle", $41, "wstr", $4b, "int", -1, "handle", $3y, "struct*", $4c, "handle", $4d, "handle", $3t)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _h9($41, $4e, $3t = 0)
_na($3t)
Local $2x = DllCall($3h, "int", "GdipFillPath", "handle", $41, "handle", $3t, "handle", $4e)
_nb()
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _hc($41, $47, $48, $49, $4a, $3t = 0)
_na($3t)
Local $2x = DllCall($3h, "int", "GdipFillRectangle", "handle", $41, "handle", $3t, "float", $47, "float", $48, "float", $49, "float", $4a)
_nb()
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _i0($41, $4f)
If $4f < 0 Or $4f > 5 Then $4f = 0
Local $2x = DllCall($3h, "int", "GdipSetSmoothingMode", "handle", $41, "int", $4f)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _i1($41, $4g)
Local $2x = DllCall($3h, "int", "GdipSetTextRenderingHint", "handle", $41, "int", $4g)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _ii($4h)
Local $2x = DllCall($3h, "int", "GdipGetImageGraphicsContext", "handle", $4h, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[2]
EndFunc
Func _k0($4e, $47, $48, $49, $4a, $4i, $4j)
Local $2x = DllCall($3h, "int", "GdipAddPathArc", "handle", $4e, "float", $47, "float", $48, "float", $49, "float", $4a, "float", $4i, "float", $4j)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _l1($4e)
Local $2x = DllCall($3h, "int", "GdipClosePathFigure", "handle", $4e)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _l2($4k = 0)
Local $2x = DllCall($3h, "int", "GdipCreatePath", "int", $4k, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[2]
EndFunc
Func _l4($4e)
Local $2x = DllCall($3h, "int", "GdipDeletePath", "handle", $4e)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _lt($3s = 0xFF000000, $49 = 1, $3x = 2)
Local $2x = DllCall($3h, "int", "GdipCreatePen1", "dword", $3s, "float", $49, "int", $3x, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[4]
EndFunc
Func _lv($46)
Local $2x = DllCall($3h, "int", "GdipDeletePen", "handle", $46)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _mk($47 = 0, $48 = 0, $49 = 0, $4a = 0)
Local $4l = DllStructCreate($2o)
DllStructSetData($4l, "X", $47)
DllStructSetData($4l, "Y", $48)
DllStructSetData($4l, "Width", $49)
DllStructSetData($4l, "Height", $4a)
Return $4l
EndFunc
Func _mz()
If $3h = 0 Then Return SetError(-1, -1, False)
$3j -= 1
If $3j = 0 Then
DllCall($3h, "none", "GdiplusShutdown", "ulong_ptr", $3k)
DllClose($3h)
$3h = 0
EndIf
Return True
EndFunc
Func _n0($4m = Default, $4n = False)
$3j += 1
If $3j > 1 Then Return True
If $4m = Default Then $4m = "gdiplus.dll"
$3h = DllOpen($4m)
If $3h = -1 Then
$3j = 0
Return SetError(1, 2, False)
EndIf
Local $4o = FileGetVersion($4m)
$4o = StringSplit($4o, ".")
If $4o[1] > 5 Then $3l = False
Local $4p = DllStructCreate($2p)
Local $4q = DllStructCreate("ulong_ptr Data")
DllStructSetData($4p, "Version", 1)
Local $2x = DllCall($3h, "int", "GdiplusStartup", "struct*", $4q, "struct*", $4p, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
$3k = DllStructGetData($4q, "Data")
If $4n Then Return $3h
Return SetExtended($4o[1], True)
EndFunc
Func _n1($4r = 0, $4s = 0)
Local $2x = DllCall($3h, "int", "GdipCreateStringFormat", "int", $4r, "word", $4s, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return SetError(10, $2x[0], 0)
Return $2x[3]
EndFunc
Func _n2($4d)
Local $2x = DllCall($3h, "int", "GdipDeleteStringFormat", "handle", $4d)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _n4($4t, $3c)
Local $2x = DllCall($3h, "int", "GdipSetStringFormatAlign", "handle", $4t, "int", $3c)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _n5($4t, $4u)
Local $2x = DllCall($3h, "int", "GdipSetStringFormatLineAlign", "handle", $4t, "int", $4u)
If @error Then Return SetError(@error, @extended, False)
If $2x[0] Then Return SetError(10, $2x[0], False)
Return True
EndFunc
Func _na(ByRef $3t)
If $3t = 0 Then
$3g = _fg()
$3t = $3g
EndIf
EndFunc
Func _nb($4v = @error, $4w = @extended)
If $3g <> 0 Then
_fh($3g)
$3g = 0
EndIf
Return SetError($4v, $4w)
EndFunc
Func _ne(ByRef $46)
If $46 = 0 Then
$3i = _lt()
$46 = $3i
EndIf
EndFunc
Func _nf($4v = @error, $4w = @extended)
If $3i <> 0 Then
_lv($3i)
$3i = 0
EndIf
Return SetError($4v, $4w)
EndFunc
Func _o7($4, $4x, $4y = 0, $3f = 0, $4z = 0, $50 = "wparam", $51 = "lparam", $52 = "lresult")
Local $2x = DllCall("user32.dll", $52, "SendMessageW", "hwnd", $4, "uint", $4x, $50, $4y, $51, $3f)
If @error Then Return SetError(@error, @extended, "")
If $4z >= 0 And $4z <= 4 Then Return $2x[$4z]
Return $2x
EndFunc
Global $53[64][2] = [[0, 0]]
Func _oj($4)
Local $2x = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $4)
If @error Then Return SetError(@error, @extended, 0)
Return $2x[0]
EndFunc
Func _or($4, ByRef $54)
Local $2x = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $4, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
$54 = $2x[2]
Return $2x[0]
EndFunc
Func _ot($4, ByRef $55)
If $4 = $55 Then Return True
For $56 = $53[0][0] To 1 Step -1
If $4 = $53[$56][0] Then
If $53[$56][1] Then
$55 = $4
Return True
Else
Return False
EndIf
EndIf
Next
Local $54
_or($4, $54)
Local $1p = $53[0][0] + 1
If $1p >= 64 Then $1p = 1
$53[0][0] = $1p
$53[$1p][0] = $4
$53[$1p][1] =($54 = @AutoItPID)
Return $53[$1p][1]
EndFunc
Func _p2($4, $57, $58, $59, $5a, $5b, $5c)
Local $2x = DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $4, "hwnd", $57, "int", $58, "int", $59, "int", $5a, "int", $5b, "uint", $5c)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _pa($4, $5c, $5d = 1000)
Local $1n = DllCall('user32.dll', 'bool', 'AnimateWindow', 'hwnd', $4, 'dword', $5d, 'dword', $5c)
If @error Then Return SetError(@error, @extended, False)
Return $1n[0]
EndFunc
Func _qc($4)
Local $5e = DllStructCreate($2r)
DllStructSetData($5e, "length", DllStructGetSize($5e))
Local $1n = DllCall("user32.dll", "bool", "GetWindowPlacement", "hwnd", $4, "struct*", $5e)
If @error Or Not $1n[0] Then Return SetError(@error + 10, @extended, 0)
Return $5e
EndFunc
Func _qs($4, $5f, $5g = 255, $5c = 0x03, $5h = False)
If $5c = Default Or $5c = "" Or $5c < 0 Then $5c = 0x03
If Not $5h Then
$5f = Int(BinaryMid($5f, 3, 1) & BinaryMid($5f, 2, 1) & BinaryMid($5f, 1, 1))
EndIf
Local $2x = DllCall("user32.dll", "bool", "SetLayeredWindowAttributes", "hwnd", $4, "INT", $5f, "byte", $5g, "dword", $5c)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _qy($4, $5e)
Local $2x = DllCall("user32.dll", "bool", "SetWindowPlacement", "hwnd", $4, "struct*", $5e)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _s7($2w, $5i)
Local $5j = "str"
If IsNumber($5i) Then $5j = "word"
Local $2x = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", $2w, $5j, $5i)
If @error Or Not $2x[0] Then Return SetError(@error, @extended, 0)
Return $2x[0]
EndFunc
Func _ta()
Local $2x = DllCall("user32.dll", "bool", "ReleaseCapture")
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _td($4)
Local $2x = DllCall("user32.dll", "hwnd", "SetCapture", "hwnd", $4)
If @error Then Return SetError(@error, @extended, 0)
Return $2x[0]
EndFunc
Global Enum $5k = 0, $5l, $5m, $5n
Func _tz($5o, $5p, $5q, $5r, $5s = 0, $5t = 0)
Local $5u = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $5o, "bool", $5p, "struct*", $5q, "dword", $5r, "struct*", $5s, "struct*", $5t)
If @error Then Return SetError(@error, @extended, False)
Return Not($5u[0] = 0)
EndFunc
Func _u5($5v = $5m)
Local $5u = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $5v)
If @error Then Return SetError(@error, @extended, False)
Return Not($5u[0] = 0)
EndFunc
Func _u9($5w, $5x)
Local $5u = DllCall("advapi32.dll", "bool", "LookupPrivilegeValueW", "wstr", $5w, "wstr", $5x, "int64*", 0)
If @error Or Not $5u[0] Then Return SetError(@error, @extended, 0)
Return $5u[3]
EndFunc
Func _ub($5y, $5z = 0, $60 = False)
If $5z = 0 Then
Local $2x = DllCall("kernel32.dll", "handle", "GetCurrentThread")
If @error Then Return SetError(@error + 10, @extended, 0)
$5z = $2x[0]
EndIf
Local $5u = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $5z, "dword", $5y, "bool", $60, "handle*", 0)
If @error Or Not $5u[0] Then Return SetError(@error, @extended, 0)
Return $5u[4]
EndFunc
Func _uc($5y, $5z = 0, $60 = False)
Local $5o = _ub($5y, $5z, $60)
If $5o = 0 Then
Local Const $61 = 1008
If _4q() <> $61 Then Return SetError(20, _4q(), 0)
If Not _u5() Then Return SetError(@error + 10, _4q(), 0)
$5o = _ub($5y, $5z, $60)
If $5o = 0 Then Return SetError(@error, _4q(), 0)
EndIf
Return $5o
EndFunc
Func _ud($5o, $62, $63)
Local $64 = _u9("", $62)
If $64 = 0 Then Return SetError(@error + 10, @extended, False)
Local Const $65 = "dword Count;align 4;int64 LUID;dword Attributes"
Local $66 = DllStructCreate($65)
Local $67 = DllStructGetSize($66)
Local $5s = DllStructCreate($65)
Local $68 = DllStructGetSize($5s)
Local $69 = DllStructCreate("int Data")
DllStructSetData($66, "Count", 1)
DllStructSetData($66, "LUID", $64)
If Not _tz($5o, False, $66, $67, $5s, $69) Then Return SetError(2, @error, False)
DllStructSetData($5s, "Count", 1)
DllStructSetData($5s, "LUID", $64)
Local $6a = DllStructGetData($5s, "Attributes")
If $63 Then
$6a = BitOR($6a, 0x00000002)
Else
$6a = BitAND($6a, BitNOT(0x00000002))
EndIf
DllStructSetData($5s, "Attributes", $6a)
If Not _tz($5o, False, $5s, $68, $66, $69) Then Return SetError(3, @error, False)
Return True
EndFunc
Global Const $6b = Ptr(-1)
Global Const $6c = Ptr(-1)
Global Const $6d = BitShift(0x0100, 8)
Global Const $6e = BitShift(0x2000, 8)
Global Const $6f = BitShift(0x8000, 8)
Func _w6($4, $4x, $4y, $3f)
Local $1n = DllCall('comctl32.dll', 'lresult', 'DefSubclassProc', 'hwnd', $4, 'uint', $4x, 'wparam', $4y, 'lparam', $3f)
If @error Then Return SetError(@error, @extended, 0)
Return $1n[0]
EndFunc
Func _wc($4, $6g, $6h)
Local $1n = DllCall('comctl32.dll', 'bool', 'RemoveWindowSubclass', 'hwnd', $4, 'ptr', $6g, 'uint_ptr', $6h)
If @error Then Return SetError(@error, @extended, False)
Return $1n[0]
EndFunc
Func _we($4, $6g, $6h, $6i = 0)
Local $1n = DllCall('comctl32.dll', 'bool', 'SetWindowSubclass', 'hwnd', $4, 'ptr', $6g, 'uint_ptr', $6h, 'dword_ptr', $6i)
If @error Then Return SetError(@error, @extended, 0)
Return $1n[0]
EndFunc
Local $6j[0]
Local Const $6k = _2r('comctl32.dll')
_14s($6k <> 0, 'This UDF requires comctl32.dll')
Local Const $6l = _s7($6k, 'DefSubclassProc')
Local Const $6m = DllCallbackRegister('_14e', 'NONE', 'HWND;UINT;WPARAM;LPARAM;DWORD')
Local Const $6n = DllCallbackGetPtr($6m)
OnAutoItExitRegister("_14r")
Local Const $6o = Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86')
Local Const $6p = DllCall('kernel32.dll', 'HANDLE', 'HeapCreate', 'DWORD', 0x00040000, 'ULONG_PTR', 0, 'ULONG_PTR', 0)[0]
_14s($6p <> 0, 'Failed to create executable heap object')
Local Const $6q = _14p(Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86'))
Func _14d($6r, $6s = '', $6t = '', $6u = '', $6v = '', $6w = 0,$6x = 0,$6y = '')
Local $4 = GUICtrlGetHandle($6r)
If(Not(IsHWnd($4))) Then Return SetError(1, 0, -1)
Local $6z = _14t($4)
Local $2z[13]
$2z[0] = $4
$2z[1] = $6r
$2z[3] = $6s
$2z[4] = $6w
$2z[5] = $6t
$2z[6] = $6w
$2z[7] = $6y
$2z[8] = $6x
$2z[9] = $6u
$2z[10] = $6x
$2z[11] = $6v
$2z[12] = $6x
$6j[$6z] = $2z
_we($4, $6q, $4, $6z)
Return $6z
EndFunc
Func _14e($4, $70, $4y, $3f, $71)
Switch $70
Case 0x0200
GUISetCursor(2, 1)
_14g($6j[$71], $4, $70, $4y, $3f)
Case 0x0201
_14f($6j[$71], $4, $70, $4y, $3f)
Case 0x0202
_14h($6j[$71], $4, $70, $4y, $3f)
Return False
Case 0x0203
_14i($6j[$71], $4, $70, $4y, $3f)
Case 0x0204
_14j($6j[$71], $4, $70, $4y, $3f)
Case 0x02A3
_14k($6j[$71], $4, $70, $4y, $3f)
Case 0x0082
_14q($71, $4)
EndSwitch
Return True
EndFunc
Func _14f(ByRef $72, $4, $70, ByRef $4y, ByRef $3f)
_td($4)
_14l($72, 9)
EndFunc
Func _14g(ByRef $72, $4, $70, ByRef $4y, ByRef $3f)
If(_14u() = $4) Then
Local $73 = _14n($4, $3f)
If Not $72[2] Then
If $73 Then
$72[2] = 1
_14l($72, 9)
EndIf
Else
If Not $73 Then
$72[2] = 0
_14l($72, 3)
EndIf
EndIf
ElseIf Not $72[2] Then
$72[2] = 1
_14l($72, 5)
Local $74 = DllStructCreate('DWORD;DWORD;HWND;DWORD')
DllStructSetData($74, 1, DllStructGetSize($74))
DllStructSetData($74, 2, 2)
DllStructSetData($74, 3, $4)
DllCall('user32.dll', 'BOOL', 'TrackMouseEvent', 'STRUCT*', $74)
EndIf
EndFunc
Func _14h(ByRef $72, $4, $70, ByRef $4y, ByRef $3f)
Local $75 = _w6($4, $70, $4y, $3f)
If(_14u() = $4) Then
_ta()
If _14n($4, $3f) Then
_14l($72, 9)
EndIf
EndIf
Return $75
EndFunc
Func _14i(ByRef $72, $4, $70, ByRef $4y, ByRef $3f)
_14l($72, 11)
EndFunc
Func _14j(ByRef $72, $4, $70, ByRef $4y, ByRef $3f)
_14l($72, 7)
EndFunc
Func _14k(ByRef $72, $4, $70, ByRef $4y, ByRef $3f)
$72[2] = 0
_14l($72, 3)
EndFunc
Func _14l(ByRef $72, $76)
Call($72[$76], $72[1], $72[$76 + 1])
EndFunc
Func _14m(ByRef $77, Const $78 = Default, Const $79 = Default, Const $7a = Default, Const $7b = Default, Const $7c = Default)
While(UBound($77) <($77[0] + @NumParams))
ReDim $77[UBound($77) * 2]
WEnd
If Not($78 = Default) Then
$77[0] += 1
$77[$77[0]] = $78
EndIf
If Not($79 = Default) Then
$77[0] += 1
$77[$77[0]] = $79
EndIf
If Not($7a = Default) Then
$77[0] += 1
$77[$77[0]] = $7a
EndIf
If Not($7b = Default) Then
$77[0] += 1
$77[$77[0]] = $7b
EndIf
If Not($7c = Default) Then
$77[0] += 1
$77[$77[0]] = $7c
EndIf
EndFunc
Func _14n($4, $3f)
Local $58 = BitShift(BitShift($3f, -16), 16)
Local $59 = BitShift($3f, 16)
Local $7d = WinGetClientSize($4)
Return Not($58 < 0 Or $59 < 0 Or $58 > $7d[0] Or $59 > $7d[1])
EndFunc
Func _cHvr_CSCP_X86()
Local $7e = 'align 1;'
Local $7f[100]
$7f[0] = 0
Local $7g[5]
Local $7h[5]
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x55)
_14m($7f, 0x8B, 0xEC)
$7e &= 'BYTE;'
_14m($7f, 0x53)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x8B, 0x5D, 16)
$7e &= 'BYTE;'
_14m($7f, 0x56)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x8B, 0x75, 12)
$7e &= 'BYTE;'
_14m($7f, 0x57)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x8B, 0x7D, 20)
$7e &= 'BYTE;BYTE;DWORD;'
_14m($7f, 0x81, 0xFE, 0x82)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x74, 0)
$7g[0] = DllStructGetSize(DllStructCreate($7e))
$7h[0] = $7f[0]
$7e &= 'BYTE;BYTE;DWORD;'
_14m($7f, 0x81, 0xFE, 0x2A3)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x74, 0)
$7g[1] = DllStructGetSize(DllStructCreate($7e))
$7h[1] = $7f[0]
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x8D, 0x86, -0x200)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x83, 0xF8, 3)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x77, 0)
$7g[2] = DllStructGetSize(DllStructCreate($7e))
$7h[2] = $7f[0]
$7f[$7h[0]] = $7g[2] - $7g[0]
$7f[$7h[1]] = $7g[2] - $7g[1]
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x8B, 0x4D, 28)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x8B, 0x55, 8)
$7e &= 'BYTE;'
_14m($7f, 0x51)
$7e &= 'BYTE;'
_14m($7f, 0x57)
$7e &= 'BYTE;'
_14m($7f, 0x53)
$7e &= 'BYTE;'
_14m($7f, 0x56)
$7e &= 'BYTE;'
_14m($7f, 0x52)
$7e &= 'BYTE;PTR;'
_14m($7f, 0xB8, $6n)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0xFF, 0xD0)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x85, 0xC0)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x74, 0)
$7g[3] = DllStructGetSize(DllStructCreate($7e))
$7h[3] = $7f[0]
$7f[$7h[2]] = $7g[3] - $7g[2]
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x8B, 0x45, 8)
$7e &= 'BYTE;'
_14m($7f, 0x57)
$7e &= 'BYTE;'
_14m($7f, 0x53)
$7e &= 'BYTE;'
_14m($7f, 0x56)
$7e &= 'BYTE;'
_14m($7f, 0x50)
$7e &= 'BYTE;PTR;'
_14m($7f, 0xB8, $6l)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0xFF, 0xD0)
$7g[4] = DllStructGetSize(DllStructCreate($7e))
$7f[$7h[3]] = $7g[4] - $7g[3]
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x5F)
_14m($7f, 0x5E)
_14m($7f, 0x5B)
$7e &= 'BYTE;BYTE;BYTE;WORD'
_14m($7f, 0x5D)
_14m($7f, 0xC2, 24)
Return _14o($7e, $7f)
EndFunc
Func _cHvr_CSCP_X64()
Local $7e = 'align 1;'
Local $7f[100]
$7f[0] = 0
Local $7g[5]
Local $7h[5]
$7e &= 'BYTE;BYTE;DWORD;'
_14m($7f, 0x81, 0xFA, 0x82)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x74, 0)
$7g[0] = DllStructGetSize(DllStructCreate($7e))
$7h[0] = $7f[0]
$7e &= 'BYTE;BYTE;DWORD;'
_14m($7f, 0x81, 0xFA, 0x2A3)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x74, 0)
$7g[1] = DllStructGetSize(DllStructCreate($7e))
$7h[1] = $7f[0]
$7e &= 'BYTE;BYTE;DWORD;'
_14m($7f, 0x8D, 0x82, -0x200)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x83, 0xF8, 3)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x77, 0)
$7g[2] = DllStructGetSize(DllStructCreate($7e))
$7h[2] = $7f[0]
$7f[$7h[0]] = $7g[2] - $7g[0]
$7f[$7h[1]] = $7g[2] - $7g[1]
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x89, 0x5C, 0x24, 8)
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x89, 0x6C, 0x24, 16)
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x89, 0x74, 0x24, 24)
$7e &= 'BYTE;'
_14m($7f, 0x57)
$7e &= 'BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x83, 0xEC, 48)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x49, 0x8B, 0xF9)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x49, 0x8B, 0xF0)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x8B, 0xDA)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x8B, 0xE9)
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x8B, 0x44, 0x24, 104)
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x89, 0x44, 0x24, 32)
$7e &= 'BYTE;BYTE;PTR;'
_14m($7f, 0x48, 0xB8, $6n)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0xFF, 0xD0)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x85, 0xC0)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x74, 0)
$7g[3] = DllStructGetSize(DllStructCreate($7e))
$7h[3] = $7f[0]
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x4C, 0x8B, 0xCF)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x4C, 0x8B, 0xC6)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x8B, 0xD3)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x8B, 0xCD)
$7f[$7h[3]] = DllStructGetSize(DllStructCreate($7e)) - $7g[3]
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x8B, 0x5C, 0x24, 64)
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x8B, 0x6C, 0x24, 72)
$7e &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x8B, 0x74, 0x24, 80)
$7e &= 'BYTE;BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x83, 0xc4, 48)
$7e &= 'BYTE;'
_14m($7f, 0x5F)
$7e &= 'BYTE;BYTE;BYTE;'
_14m($7f, 0x48, 0x85, 0xC0)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0x74, 0)
$7g[4] = DllStructGetSize(DllStructCreate($7e))
$7h[4] = $7f[0]
$7f[$7h[2]] = DllStructGetSize(DllStructCreate($7e)) - $7g[2]
$7e &= 'BYTE;BYTE;PTR;'
_14m($7f, 0x48, 0xB8, $6l)
$7e &= 'BYTE;BYTE;'
_14m($7f, 0xFF, 0xE0)
$7f[$7h[4]] = DllStructGetSize(DllStructCreate($7e)) - $7g[4]
$7e &= 'BYTE;'
_14m($7f, 0xC3)
Return _14o($7e, $7f)
EndFunc
Func _14o(ByRef $7e, ByRef $7f)
Local $7i = DllStructCreate($7e)
_14s(@error = 0, 'DllStrucCreate Failed With Error = ' & @error)
For $w = 1 To $7f[0]
DllStructSetData($7i, $w, $7f[$w])
Next
Return $7i
EndFunc
Func _14p($7i)
Local $7j = DllCall('kernel32.dll', 'PTR', 'HeapAlloc', 'HANDLE', $6p, 'DWORD', 8, 'ULONG_PTR', DllStructGetSize($7i))[0]
_14s($7j <> 0, 'Allocate memory failed')
DllCall("kernel32.dll", "none", "RtlMoveMemory", "PTR", $7j, "PTR", DllStructGetPtr($7i), "ULONG_PTR", DllStructGetSize($7i))
_14s(@error = 0, 'Failed to copy memory')
Return $7j
EndFunc
Func _14q($71, $4)
_wc($4, $6q, $4)
Local $2z=$6j[$71]
$6j[$71] = 0
Call( "_iControlDelete",$2z[1])
EndFunc
Func _14r()
DllCallbackFree($6m)
_2k($6k)
If($6p <> 0) Then
If($6q <> 0) Then
DllCall('kernel32.dll', 'BOOL', 'HeapFree', 'HANDLE', $6p, 'DWORD', 0, 'PTR', $6q)
EndIf
DllCall('kernel32.dll', 'BOOL', 'HeapDestroy', 'HANDLE', $6p)
EndIf
EndFunc
Func _14s($7k, $7l = '', $7m = @ScriptName, $7n = @ScriptFullPath, $7o = @ScriptLineNumber, $7p = @error, $7q = @extended)
If(Not($7k)) Then
MsgBox(BitOR(1, 0x10), 'Assertion Error!', @CRLF & 'Script' & @TAB & ': ' & $7m & @CRLF & 'Path' & @TAB & ': ' & $7n & @CRLF & 'Line' & @TAB & ': ' & $7o & @CRLF & 'Error' & @TAB & ': ' &($7p > 0x7FFF ? Hex($7p) : $7p) &($7q <> 0 ? '  (Extended : ' &($7q > 0x7FFF ? Hex($7q) : $7q) & ')' : '') & @CRLF & 'Message' & @TAB & ': ' & $7l & @CRLF & @CRLF & 'OK: Exit Script' & @TAB & 'Cancel: Continue')
Exit
EndIf
EndFunc
Func _14t($4)
For $w = 0 To UBound($6j) - 1 Step +1
If Not IsArray($6j[$w]) Then
Return $w
EndIf
Next
ReDim $6j[UBound($6j) + 1]
Return UBound($6j) - 1
EndFunc
Func _14u()
Return DllCall("user32.dll", "HWND", "GetCapture")[0]
EndFunc
_n0()
Opt("WinWaitDelay", 0)
Global $7r = _168()[2], $7s = _16f()
Global $7t[0], $7u[0]
Global $7v = Number(29 * $7s, 1) + Number(10 * $7s, 1)
Global Const $7w = DllCallbackRegister('_16h', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
Global Const $7x = DllCallbackGetPtr($7w)
OnAutoItExitRegister('_16i')
Global Const $7y = 4 * $7s
Global $7z = False
Global $80 = True
Global $81 = False
If Opt("GUIOnEventMode", 0) Then
Opt("GUIOnEventMode", 1)
$81 = True
EndIf
Func _14v($82, $83, $84, $85 = -1, $86 = -1, $87 = True, $88 = "")
Local $89
If $7z Then
$83 = Round($83 * $7s)
$84 = Round($84 * $7s)
EndIf
Local $8a
If $87 Then
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$89 = GUICreate($82, $83, $84, $85, $86, BitOR(0x00040000, 0x00020000, 0x00010000), -1, $88)
$8a = _14w($89, True, True, $83, $84)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Else
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$89 = GUICreate($82, $83, $84, $85, $86, -1, -1, $88)
$8a = _14w($89, True, False, $83, $84)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
EndIf
_we($89, $7x, 1010, $8a)
WinMove($89, "", Default, Default, $83, $84)
If Not $88 Then
Local $8b = _16j($89)
If($85 = -1) And($86 = -1) Then
WinMove($89, "",($8b[2] - $83) / 2,($8b[3] - $84) / 2, $83, $84)
EndIf
Else
If($85 = -1) And($86 = -1) Then
Local $8c = _16e($88, $83, $84)
WinMove($89, "", $8c[0], $8c[1], $83, $84)
EndIf
EndIf
GUISetBkColor($25)
_16d($89, $83, $84, $27)
Return($89)
EndFunc
Func _14w($8d, $8e = True, $87 = False, $8f = "", $8g = "")
Local $8h
For $8i = 0 To UBound($7u) - 1 Step +1
If $7u[$8i][0] = $8d Then
$8h = $8i
ExitLoop
EndIf
Next
If($8h == "") Then
$8h = UBound($7u)
ReDim $7u[$8h + 1][16]
EndIf
$7u[$8h][0] = $8d
$7u[$8h][1] = $8e
$7u[$8h][2] = $87
If $87 Then
If $8f = "" Then
$8f = WinGetPos($8d, "")
If @error Then
$8f = 80 * $7s
Else
$8f = $8f[2]
EndIf
EndIf
If $8g = "" Then
$8g = WinGetPos($8d, "")
If @error Then
$8g = 50 * $7s
Else
$8g = $8g[3]
EndIf
EndIf
$7u[$8h][3] = $8f
$7u[$8h][4] = $8g
EndIf
Return $8h
EndFunc
Func _14x($8j)
GUISetState(@SW_HIDE, $8j)
_wc($8j, $7x, 1010)
GUIDelete($8j)
Local $8k[0]
For $8l = 0 To UBound($7u) - 1 Step +1
If $7u[$8l][0] <> $8j Then
ReDim $8k[UBound($8k) + 1][16]
For $8m = 0 To 11 Step +1
$8k[UBound($8k) - 1][$8m] = $7u[$8l][$8m]
Next
EndIf
Next
$7u = $8k
EndFunc
Func _iControlDelete($8n)
For $w = 0 To UBound($7t) - 1
If $7t[$w][0] = $8n Then
Switch($7t[$w][3])
Case "5", "7"
_50($7t[$w][5])
_50($7t[$w][6])
_50($7t[$w][7])
_50($7t[$w][8])
Case "6"
_50($7t[$w][5])
_50($7t[$w][6])
_50($7t[$w][7])
_50($7t[$w][8])
_50($7t[$w][9])
_50($7t[$w][10])
_50($7t[$w][11])
_50($7t[$w][12])
_50($7t[$w][13])
_50($7t[$w][14])
Case Else
_50($7t[$w][5])
_50($7t[$w][6])
EndSwitch
For $8o = 0 To UBound($7t, 2) - 1
$7t[$w][$8o] = ""
Next
ExitLoop
EndIf
Next
EndFunc
Func _14y($8p = True, $8q = True, $8r = True, $8s = False, $8t = False, $8u = $25, $8v = $26, $8w = 2)
Local $8x[5]
$8x[0] = $8p
$8x[1] = $8q
$8x[2] = $8r
$8x[3] = $8s
$8x[4] = $8t
$8u = "0xFF" & Hex($8u, 6)
$8v = "0xFF" & Hex($8v, 6)
Return _156($8x, $8u, $8v, False, $8w)
EndFunc
Func _14z($8y = True)
$7z = $8y
EndFunc
Func _151($8d)
GUISetState(@SW_SHOW, $8d)
Local $8h = _16k($8d)
If($8h == "") Then
ConsoleWrite("Fullscreen-Toggle failed: GUI not registered. Not created with _Metro_CreateGUI ?" & @CRLF)
Return SetError(1)
EndIf
If Not $7u[$8h][2] Then
ConsoleWrite("Fullscreen-Toggle failed: GUI is not registered for resizing. Please use _Metro_SetGUIOption to enable resizing." & @CRLF)
Return SetError(2)
EndIf
Local $8z = WinGetState($8d)
Local $90 = _qc($8d)
Local $91 = _16j($8d, True)
Local $92 = WinGetPos($8d)
Local $93 = _16g("3", $8d)
Local $94 = _16g("4", $8d)
Local $8s = _16g("9", $8d)
Local $95 = _16g("10", $8d)
If $7u[$8h][11] Then
$7u[$8h][11] = False
If(BitAND($7u[$8h][9], 32) = 32) Then
GUISetState(@SW_MAXIMIZE)
$90 = $7u[$8h][10]
DllStructSetData($90, "rcNormalPosition", $7u[$8h][5], 1)
DllStructSetData($90, "rcNormalPosition", $7u[$8h][6], 2)
DllStructSetData($90, "rcNormalPosition", $7u[$8h][7], 3)
DllStructSetData($90, "rcNormalPosition", $7u[$8h][8], 4)
_qy($8d, $90)
If $93 Then
GUICtrlSetState($93, 32)
GUICtrlSetState($94, 16)
EndIf
Else
WinMove($8d, "", $7u[$8h][5], $7u[$8h][6], $7u[$8h][7], $7u[$8h][8])
If $93 Then
GUICtrlSetState($94, 32)
GUICtrlSetState($93, 16)
EndIf
EndIf
GUICtrlSetState($95, 32)
GUICtrlSetState($8s, 16)
Else
If(BitAND($8z, 32) = 32) Then
$92[0] = DllStructGetData($90, "rcNormalPosition", 1)
$92[1] = DllStructGetData($90, "rcNormalPosition", 2)
$92[2] = DllStructGetData($90, "rcNormalPosition", 3)
$92[3] = DllStructGetData($90, "rcNormalPosition", 4)
DllStructSetData($90, "rcNormalPosition", $91[0], 1)
DllStructSetData($90, "rcNormalPosition", $91[1], 2)
DllStructSetData($90, "rcNormalPosition", $91[0] + $91[2], 3)
DllStructSetData($90, "rcNormalPosition", $91[1] + $91[3], 4)
_qy($8d, $90)
Sleep(50)
$7u[$8h][10] = $90
GUISetState(@SW_RESTORE)
Else
Sleep(50)
WinMove($8d, "", $91[0], $91[1], $91[2], $91[3])
EndIf
$7u[$8h][11] = True
GUICtrlSetState($8s, 32)
If $93 Then
GUICtrlSetState($93, 32)
GUICtrlSetState($94, 32)
EndIf
GUICtrlSetState($95, 16)
$7u[$8h][5] = $92[0]
$7u[$8h][6] = $92[1]
$7u[$8h][7] = $92[2]
$7u[$8h][8] = $92[3]
$7u[$8h][9] = $8z
WinActivate("[CLASS:Shell_TrayWnd]")
WinActivate($8d)
EndIf
EndFunc
Func _156($8x, $8u = $25, $8v = "0xFFFFFF", $96 = False, $8w = 2)
Local $97 = _165()
Local $98 = Round(1 * $97), $99
If StringInStr($2b, "Light") Then
$99 = StringReplace(_16b($8u, -20), "0x", "0xFF")
Else
$99 = StringReplace(_16b($8u, +20), "0x", "0xFF")
EndIf
Local $46 = _lt($8v, Round(1 * $97))
Local $9a = _lt($8v, Round(1 * $97))
Local $9b = _lt("0x228B22", Round(1 * $97))
If StringInStr($2b, "Light") Then
Local $9c = _lt(StringReplace(_16b($8v, +90), "0x", "0xFF"), $98)
Else
Local $9c = _lt(StringReplace(_16b($8v, -80), "0x", "0xFF"), $98)
EndIf
Local $9d = _lt(StringReplace(_16b("0x228B22", -80), "0x", "0xFF"), $98)
If $8u <> 0 Then
$8u = "0xFF" & Hex($8u, 6)
EndIf
Local $3t = _fg($8u), $9e = _fg($99)
Local $9f[16]
Local $9g[16]
Local $9h[16]
Local $9i[16]
Local $9j[16]
Local $9k[16]
Local $9l[16]
Local $9m[16]
Local $9n = Number(45 * $97, 1)
Local $9o = Number(29 * $97, 1)
Local $9p = Number($8w * $97, 1)
Local $9q = _164()
Local $9r = WinGetPos($9q)
Local $9s = 0
If $8x[0] Then
$9s = $9s + 1
$9g[0] = GUICtrlCreatePic("", $9r[2] - $9p -($9n * $9s), $9p, $9n, $9o)
$9g[1] = False
$9g[2] = False
$9g[3] = "0"
$9g[15] = $9q
EndIf
If $8x[1] Then
$9s = $9s + 1
$9i[0] = GUICtrlCreatePic("", $9r[2] - $9p -($9n * $9s), $9p, $9n, $9o)
$9i[1] = False
$9i[2] = False
$9i[3] = "3"
$9i[8] = True
$9i[15] = $9q
$9j[0] = GUICtrlCreatePic("", $9r[2] - $9p -($9n * $9s), $9p, $9n, $9o)
$9j[1] = False
$9j[2] = False
$9j[3] = "4"
$9j[8] = True
$9j[15] = $9q
If $8x[3] Then
$9m[0] = GUICtrlCreatePic("", $9r[2] - $9p -($9n * $9s), $9p, $9n, $9o)
$9m[1] = False
$9m[2] = False
$9m[3] = "10"
$9m[15] = $9q
EndIf
EndIf
If $8x[2] Then
$9s = $9s + 1
$9h[0] = GUICtrlCreatePic("", $9r[2] - $9p -($9n * $9s), $9p, $9n, $9o)
$9h[1] = False
$9h[2] = False
$9h[3] = "0"
$9h[15] = $9q
EndIf
If $8x[3] Then
$9s = $9s + 1
$9l[0] = GUICtrlCreatePic("", $9r[2] - $9p -($9n * $9s), $9p, $9n, $9o)
$9l[1] = False
$9l[2] = False
$9l[3] = "9"
$9l[15] = $9q
If $9m[15] <> $9q Then
$9m[0] = GUICtrlCreatePic("", $9r[2] - $9p -($9n * $9s), $9p, $9n, $9o)
$9m[1] = False
$9m[2] = False
$9m[3] = "10"
$9m[15] = $9q
EndIf
EndIf
If $8x[4] Then
$9k[0] = GUICtrlCreatePic("", $9p, $9p, $9n, $9o)
$9k[1] = False
$9k[2] = False
$9k[3] = "8"
$9k[15] = $9q
EndIf
If $8x[0] Then
Local $9t = _162($9n, $9o, $8u, 4, 4), $9u = _162($9n, $9o, "0xFFE81123", 4, 4), $9v = _162($9n, $9o, $8u, 4, 4)
EndIf
If $8x[1] Then
Local $9w = _162($9n, $9o, $8u, 0, 4), $9x = _162($9n, $9o, $99, 0, 4), $9y = _162($9n, $9o, $8u, 0, 4)
Local $9z = _162($9n, $9o, $8u, 0, 4), $a0 = _162($9n, $9o, $99, 0, 4), $a1 = _162($9n, $9o, $8u, 0, 4)
EndIf
If $8x[2] Then
Local $a2 = _162($9n, $9o, $8u, 0, 4), $a3 = _162($9n, $9o, $99, 0, 4), $a4 = _162($9n, $9o, $8u, 0, 4)
EndIf
If $8x[3] Then
Local $a5 = _162($9n, $9o, $8u, 0, 4), $a6 = _162($9n, $9o, $99, 0, 4), $a7 = _162($9n, $9o, $8u, 0, 4)
Local $a8 = _162($9n, $9o, $8u, 0, 4), $a9 = _162($9n, $9o, $99, 0, 4), $aa = _162($9n, $9o, $8u, 0, 4)
EndIf
If $8x[4] Then
Local $ab = _162($9n, $9o, $8u, 0, 4), $ac = _162($9n, $9o, $99, 0, 4), $ad = _162($9n, $9o, $8u, 0, 4)
EndIf
If $96 Then
_gk($9t[0], "0xFFB52231")
_gk($9v[0], "0xFFB52231")
EndIf
If $8x[0] Then
If $96 Then
_gz($9t[0], 17 * $97, 9 * $97, 27 * $97, 19 * $97, $9b)
_gz($9t[0], 27 * $97, 9 * $97, 17 * $97, 19 * $97, $9b)
_gz($9v[0], 17 * $97, 9 * $97, 27 * $97, 19 * $97, $9d)
_gz($9v[0], 27 * $97, 9 * $97, 17 * $97, 19 * $97, $9d)
Else
_gz($9t[0], 17 * $97, 9 * $97, 27 * $97, 19 * $97, $46)
_gz($9t[0], 27 * $97, 9 * $97, 17 * $97, 19 * $97, $46)
_gz($9v[0], 17 * $97, 9 * $97, 27 * $97, 19 * $97, $9c)
_gz($9v[0], 27 * $97, 9 * $97, 17 * $97, 19 * $97, $9c)
EndIf
_gz($9u[0], 17 * $97, 9 * $97, 27 * $97, 19 * $97, $9b)
_gz($9u[0], 27 * $97, 9 * $97, 17 * $97, 19 * $97, $9b)
EndIf
If $8x[1] Then
_h3($9w[0], Round(17 * $97), 9 * $97, 9 * $97, 9 * $97, $46)
_h3($9x[0], Round(17 * $97), 9 * $97, 9 * $97, 9 * $97, $9a)
_h3($9y[0], Round(17 * $97), 9 * $97, 9 * $97, 9 * $97, $9c)
Local $ae = Round(7 * $97), $af = Round(2 * $97)
_h3($9z[0], Round(17 * $97) + $af,(11 * $97) - $af, $ae, $ae, $46)
_hc($9z[0], Round(17 * $97), 11 * $97, $ae, $ae, $3t)
_h3($9z[0], Round(17 * $97), 11 * $97, $ae, $ae, $46)
_h3($a0[0], Round(17 * $97) + $af,(11 * $97) - $af, $ae, $ae, $9a)
_hc($a0[0], Round(17 * $97), 11 * $97, $ae, $ae, $9e)
_h3($a0[0], Round(17 * $97), 11 * $97, $ae, $ae, $9a)
_h3($a1[0], Round(17 * $97) + $af,(11 * $97) - $af, $ae, $ae, $9c)
_hc($a1[0], Round(17 * $97), 11 * $97, $ae, $ae, $3t)
_h3($a1[0], Round(17 * $97), 11 * $97, $ae, $ae, $9c)
EndIf
If $8x[2] Then
_gz($a2[0], 18 * $97, 14 * $97, 27 * $97, 14 * $97, $46)
_gz($a3[0], 18 * $97, 14 * $97, 27 * $97, 14 * $97, $9a)
_gz($a4[0], 18 * $97, 14 * $97, 27 * $97, 14 * $97, $9c)
EndIf
If $8x[3] Then
Local $ag =($98 * 0.3)
Local $ah[2], $ai
$ah[0] = Round($9n / 2.9)
$ah[1] = Round($9o / 1.5)
$ai = _166($ah[0], $ah[1], 135, $9n / 2.5)
$ai[0] = Round($ai[0])
$ai[1] = Round($ai[1])
Local $aj = _166($ah[0] + $ag, $ah[1] + $ag, 180, 5 * $97)
Local $ak = _166($ah[0] - $ag, $ah[1] - $ag, 90, 5 * $97)
_gz($a5[0], $ah[0] + $ag, $ah[1] + $ag, $aj[0], $aj[1], $46)
_gz($a5[0], $ah[0] - $ag, $ah[1] - $ag, $ak[0], $ak[1], $46)
_gz($a6[0], $ah[0] + $ag, $ah[1] + $ag, $aj[0], $aj[1], $46)
_gz($a6[0], $ah[0] - $ag, $ah[1] - $ag, $ak[0], $ak[1], $46)
_gz($a7[0], $ah[0] + $ag, $ah[1] + $ag, $aj[0], $aj[1], $9c)
_gz($a7[0], $ah[0] - $ag, $ah[1] - $ag, $ak[0], $ak[1], $9c)
$aj = _166($ai[0] + $ag, $ai[1] + $ag, 270, 5 * $97)
$ak = _166($ai[0] - $ag, $ai[1] - $ag, 0, 5 * $97)
_gz($a5[0], $ai[0] + $ag, $ai[1] + $ag, $aj[0], $aj[1], $46)
_gz($a5[0], $ai[0] - $ag, $ai[1] - $ag, $ak[0], $ak[1], $46)
_gz($a6[0], $ai[0] + $ag, $ai[1] + $ag, $aj[0], $aj[1], $46)
_gz($a6[0], $ai[0] - $ag, $ai[1] - $ag, $ak[0], $ak[1], $46)
_gz($a7[0], $ai[0] + $ag, $ai[1] + $ag, $aj[0], $aj[1], $9c)
_gz($a7[0], $ai[0] - $ag, $ai[1] - $ag, $ak[0], $ak[1], $9c)
_gz($a5[0], $ah[0] + $ag, $ah[1] - $ag, $ai[0], $ai[1], $46)
_gz($a6[0], $ah[0] + $ag, $ah[1] - $ag, $ai[0], $ai[1], $46)
_gz($a7[0], $ah[0] + $ag, $ah[1] - $ag, $ai[0], $ai[1], $9c)
$ag =($98 * 0.3)
Local $al = Round($9n / 2, 0), $am = Round($9o / 2.35, 0)
$aj = _166($al - $ag, $am - $ag, 90, 4 * $97)
$ak = _166($al + $ag, $am + $ag, 180, 4 * $97)
Local $an = _166($al + $ag, $am - $ag, 135, 8 * $97)
_gz($a8[0], $al - $ag, $am - $ag, $aj[0], $aj[1], $46)
_gz($a8[0], $al + $ag, $am + $ag, $ak[0], $ak[1], $46)
_gz($a9[0], $al - $ag, $am - $ag, $aj[0], $aj[1], $46)
_gz($a9[0], $al + $ag, $am + $ag, $ak[0], $ak[1], $46)
_gz($aa[0], $al - $ag, $am - $ag, $aj[0], $aj[1], $9c)
_gz($aa[0], $al + $ag, $am + $ag, $ak[0], $ak[1], $9c)
$ag =($98 * 0.3)
Local $ao = Round($9n / 2.2, 0), $ap = Round($9o / 2, 0)
$aj = _166($ao - $ag, $ap - $ag, 360, 4 * $97)
$ak = _166($ao + $ag, $ap + $ag, 270, 4 * $97)
Local $aq = _166($ao - $ag, $ap + $ag, 315, 8 * $97)
_gz($a8[0], $ao - $ag, $ap - $ag, $aj[0], $aj[1], $46)
_gz($a8[0], $ao + $ag, $ap + $ag, $ak[0], $ak[1], $46)
_gz($a9[0], $ao - $ag, $ap - $ag, $aj[0], $aj[1], $46)
_gz($a9[0], $ao + $ag, $ap + $ag, $ak[0], $ak[1], $46)
_gz($aa[0], $ao - $ag, $ap - $ag, $aj[0], $aj[1], $9c)
_gz($aa[0], $ao + $ag, $ap + $ag, $ak[0], $ak[1], $9c)
_gz($a8[0], $ao - $ag, $ap + $ag, $aq[0] + $ag, $aq[1] - $ag, $46)
_gz($a8[0], $al + $ag, $am - $ag, $an[0] - $ag, $an[1] + $ag, $46)
_gz($a9[0], $ao - $ag, $ap + $ag, $aq[0] + $ag, $aq[1] - $ag, $46)
_gz($a9[0], $al + $ag, $am - $ag, $an[0] - $ag, $an[1] + $ag, $46)
_gz($aa[0], $ao - $ag, $ap + $ag, $aq[0] + $ag, $aq[1] - $ag, $9c)
_gz($aa[0], $al + $ag, $am - $ag, $an[0] - $ag, $an[1] + $ag, $9c)
EndIf
If $8x[4] Then
_gz($ab[0], $9n / 3, $9o / 2.9,($9n / 3) * 2, $9o / 2.9, $46)
_gz($ab[0], $9n / 3, $9o / 2.9 +($98 * 4),($9n / 3) * 2, $9o / 2.9 +($98 * 4), $46)
_gz($ab[0], $9n / 3, $9o / 2.9 +($98 * 8),($9n / 3) * 2, $9o / 2.9 +($98 * 8), $46)
_gz($ac[0], $9n / 3, $9o / 2.9,($9n / 3) * 2, $9o / 2.9, $46)
_gz($ac[0], $9n / 3, $9o / 2.9 +($98 * 4),($9n / 3) * 2, $9o / 2.9 +($98 * 4), $46)
_gz($ac[0], $9n / 3, $9o / 2.9 +($98 * 8),($9n / 3) * 2, $9o / 2.9 +($98 * 8), $46)
_gz($ad[0], $9n / 3, $9o / 2.9,($9n / 3) * 2, $9o / 2.9, $9c)
_gz($ad[0], $9n / 3, $9o / 2.9 +($98 * 4),($9n / 3) * 2, $9o / 2.9 +($98 * 4), $9c)
_gz($ad[0], $9n / 3, $9o / 2.9 +($98 * 8),($9n / 3) * 2, $9o / 2.9 +($98 * 8), $9c)
EndIf
_lv($46)
_lv($9a)
_lv($9b)
_lv($9c)
_lv($9d)
_fh($3t)
_fh($9e)
If $8x[0] Then
$9g[5] = _163($9g[0], $9t)
$9g[6] = _163($9g[0], $9u, False)
$9g[7] = _163($9g[0], $9v, False)
GUICtrlSetResizing($9g[0], 768 + 32 + 4)
$9f[0] = $9g[0]
_14d($9g[0], "_iHoverOff", "_iHoverOn", '', "", _161($9g), $9q)
EndIf
If $8x[1] Then
$9i[5] = _163($9i[0], $9w)
$9i[6] = _163($9i[0], $9x, False)
$9i[7] = _163($9i[0], $9y, False)
$9j[5] = _163($9j[0], $9z)
$9j[6] = _163($9j[0], $a0, False)
$9j[7] = _163($9j[0], $a1, False)
GUICtrlSetResizing($9i[0], 768 + 32 + 4)
GUICtrlSetResizing($9j[0], 768 + 32 + 4)
$9f[1] = $9i[0]
$9f[2] = $9j[0]
GUICtrlSetState($9j[0], 32)
_14d($9i[0], "_iHoverOff", "_iHoverOn", "", "", _161($9i), $9q)
_14d($9j[0], "_iHoverOff", "_iHoverOn", "", "", _161($9j), $9q)
EndIf
If $8x[2] Then
$9h[5] = _163($9h[0], $a2)
$9h[6] = _163($9h[0], $a3, False)
$9h[7] = _163($9h[0], $a4, False)
GUICtrlSetResizing($9h[0], 768 + 32 + 4)
$9f[3] = $9h[0]
_14d($9h[0], "_iHoverOff", "_iHoverOn", "", "", _161($9h), $9q)
EndIf
If $8x[3] Then
$9l[5] = _163($9l[0], $a5)
$9l[6] = _163($9l[0], $a6, False)
$9l[7] = _163($9l[0], $a7, False)
$9m[5] = _163($9m[0], $a8)
$9m[6] = _163($9m[0], $a9, False)
$9m[7] = _163($9m[0], $aa, False)
GUICtrlSetResizing($9l[0], 768 + 32 + 4)
GUICtrlSetResizing($9m[0], 768 + 32 + 4)
GUICtrlSetState($9m[0], 32)
$9f[4] = $9l[0]
$9f[5] = $9m[0]
_14d($9l[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _161($9l), $9q)
_14d($9m[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _161($9m), $9q)
EndIf
If $8x[4] Then
$9k[5] = _163($9k[0], $ab)
$9k[6] = _163($9k[0], $ac, False)
$9k[7] = _163($9k[0], $ad, False)
GUICtrlSetResizing($9k[0], 768 + 32 + 2)
$9f[6] = $9k[0]
_14d($9k[0], "_iHoverOff", "_iHoverOn", "", "", _161($9k), $9q)
EndIf
Return $9f
EndFunc
Func _159($ar, $85, $86, $83, $84, $as = $28, $at = $29, $au = "Arial", $av = 10, $aw = 1, $ax = "0xFFFFFF")
Local $ay[16]
Local $az = _165()
If $7z Then
$85 = Round($85 * $7s)
$86 = Round($86 * $7s)
$83 = Round($83 * $7s)
$84 = Round($84 * $7s)
Else
$av =($av / $7r)
EndIf
$ay[1] = False
$ay[3] = "2"
$ay[15] = _164()
If StringInStr($2b, "Light") Then
Local $b0 = _16b($at, 7)
Else
Local $b0 = _16b($at, -15)
EndIf
$as = "0xFF" & Hex($as, 6)
$at = "0xFF" & Hex($at, 6)
$b0 = "0xFF" & Hex($b0, 6)
$ax = "0xFF" & Hex($ax, 6)
Local $b1 = _fg($at)
Local $b2 = _fg($b0)
Local $b3 = _fg(StringReplace(_16b($at, -30), "0x", "0xFF"))
Local $b4 = _162($83, $84, StringReplace($25, "0x", "0xFF"), 5, 5)
Local $b5 = _162($83, $84, StringReplace($25, "0x", "0xFF"), 5, 5)
Local $b6 = _162($83, $84, StringReplace($25, "0x", "0xFF"), 5, 5)
Local $b7 = 3, $b8 =($b7 / 2) * $7s
Local $3m = $83 -($b8 * 2), $3n = $84 -($b8 * 2)
Local $4e = _l2()
_k0($4e, $b8 + $3m -($b7 * 2), $b8, $b7 * 2, $b7 * 2, 270, 90)
_k0($4e, $b8 + $3m -($b7 * 2), $b8 + $3n -($b7 * 2), $b7 * 2, $b7 * 2, 0, 90)
_k0($4e, $b8, $b8 + $3n -($b7 * 2), $b7 * 2, $b7 * 2, 90, 90)
_k0($4e, $b8, $b8, $b7 * 2, $b7 * 2, 180, 90)
_l1($4e)
Local $3t = _fg($as)
Local $b9 = _fg(StringReplace(_16b($as, +25), "0x", "0xFF"))
_h9($b4[0], $4e, $3t)
_h9($b5[0], $4e, $b9)
_h9($b6[0], $4e, $3t)
Local $4d = _n1(), $3u = _g8($au), $3y = _g6($3u, $av, $aw)
Local $4c = _mk(0, 0, $83, $84)
_n4($4d, 1)
_n5($4d, 1)
_h5($b4[0], $ar, $3y, $4c, $4d, $b2)
_h5($b5[0], $ar, $3y, $4c, $4d, $b1)
_h5($b6[0], $ar, $3y, $4c, $4d, $b3)
_g7($3y)
_ga($3u)
_n2($4d)
_fh($b1)
_fh($b2)
_fh($b3)
_fh($3t)
_fh($b9)
_l4($4e)
$ay[0] = GUICtrlCreatePic("", $85, $86, $83, $84)
$ay[5] = _163($ay[0], $b4)
$ay[6] = _163($ay[0], $b5, False)
$ay[7] = _163($ay[0], $b6, False)
GUICtrlSetResizing($ay[0], 768)
_14d($ay[0], "_iHoverOff", "_iHoverOn", "", "", _161($ay))
Return $ay[0]
EndFunc
Func _161($ba)
Local $bb
For $w = 0 To UBound($7t) - 1 Step +1
If $7t[$w][0] = "" Then
$bb = $w
ExitLoop
EndIf
Next
If $bb == "" Then
$bb = UBound($7t)
ReDim $7t[$bb + 1][16]
EndIf
For $w = 0 To 15
$7t[$bb][$w] = $ba[$w]
Next
Return $bb
EndFunc
Func _162($bc, $bd, $be = 0, $bf = 4, $bg = 0)
Local $bh[2]
$bh[1] = _f4($bc, $bd, $2m)
$bh[0] = _ii($bh[1])
_i0($bh[0], $bf)
_i1($bh[0], $bg)
If $be <> 0 Then _gk($bh[0], $be)
Return $bh
EndFunc
Func _163($bi, $bh, $bj = True)
Local $bk = _f6($bh[1])
If $bj Then _50(GUICtrlSendMsg($bi, 0x0172, 0, $bk))
_gn($bh[0])
_f7($bh[1])
Return $bk
EndFunc
Func _164()
Local $bl = GUICtrlCreateLabel("", 0, 0, 0, 0)
Local $bm = _oj(GUICtrlGetHandle($bl))
GUICtrlDelete($bl)
Return $bm
EndFunc
Func _165()
If $7z Then
Return $7s
Else
Return 1
EndIf
EndFunc
Func _166($bn, $bo, $bp, $bq)
Local $br[2]
$br[0] = $bn +($bq * Sin($bp / 180 * 3.14159265358979))
$br[1] = $bo +($bq * Cos($bp / 180 * 3.14159265358979))
Return $br
EndFunc
Func _168()
Local $bs[3]
Local $bt, $bu, $bv = 90, $4 = 0
Local $39 = DllCall("user32.dll", "long", "GetDC", "long", $4)
Local $1n = DllCall("gdi32.dll", "long", "GetDeviceCaps", "long", $39[0], "long", $bv)
$39 = DllCall("user32.dll", "long", "ReleaseDC", "long", $4, "long", $39)
$bt = $1n[0]
Select
Case $bt = 0
$bt = 96
$bu = 94
Case $bt < 84
$bu = $bt / 105
Case $bt < 121
$bu = $bt / 96
Case $bt < 145
$bu = $bt / 95
Case Else
$bu = $bt / 94
EndSelect
$bs[0] = 2
$bs[1] = $bt
$bs[2] = $bu
Return $bs
EndFunc
Func _16b($bw, $bx, $by = 7)
Local $bz = $bx *(BitAND(1, $by) <> 0) + BitAND($bw, 0xff0000) / 0x10000
Local $c0 = $bx *(BitAND(2, $by) <> 0) + BitAND($bw, 0x00ff00) / 0x100
Local $c1 = $bx *(BitAND(4, $by) <> 0) + BitAND($bw, 0x0000FF)
Return "0x" & Hex(String(_16c($bz) * 0x10000 + _16c($c0) * 0x100 + _16c($c1)), 6)
EndFunc
Func _16c($c2)
If $c2 > 255 Then Return 255
If $c2 < 0 Then Return 0
Return $c2
EndFunc
Func _16d($8d, $c3, $c4, $c5 = 0xFFFFFF)
Local $c6, $c7, $c8, $c9
Local $8a = _16k($8d)
$c8 = GUICtrlCreateLabel("", 0, 0, $c3, 1)
GUICtrlSetColor(-1, $c5)
GUICtrlSetBkColor(-1, $c5)
GUICtrlSetResizing(-1, 544)
GUICtrlSetState(-1, 128)
$c9 = GUICtrlCreateLabel("", 0, $c4 - 1, $c3, 1)
GUICtrlSetColor(-1, $c5)
GUICtrlSetBkColor(-1, $c5)
GUICtrlSetResizing(-1, 576)
GUICtrlSetState(-1, 128)
$c6 = GUICtrlCreateLabel("", 0, 1, 1, $c4 - 1)
GUICtrlSetColor(-1, $c5)
GUICtrlSetBkColor(-1, $c5)
GUICtrlSetResizing(-1, 256 + 2)
GUICtrlSetState(-1, 128)
$c7 = GUICtrlCreateLabel("", $c3 - 1, 1, 1, $c4 - 1)
GUICtrlSetColor(-1, $c5)
GUICtrlSetBkColor(-1, $c5)
GUICtrlSetResizing(-1, 256 + 4)
GUICtrlSetState(-1, 128)
If $8a <> "" Then
$7u[$8a][12] = $c8
$7u[$8a][13] = $c9
$7u[$8a][14] = $c6
$7u[$8a][15] = $c7
EndIf
EndFunc
Func _16e($ca, $cb, $cc)
Local $cd[2]
$cd[0] = "-1"
$cd[1] = "-1"
Local $9r = WinGetPos($ca)
If Not @error Then
$cd[0] =($9r[0] +(($9r[2] - $cb) / 2))
$cd[1] =($9r[1] +(($9r[3] - $cc) / 2))
EndIf
Return $cd
EndFunc
Func _16f($ce = 96)
_n0()
Local $cf = _gm(0)
If @error Then Return SetError(1, @extended, 0)
Local $2x
#forcedef $3h, $cg
$2x = DllCall($3h, "int", "GdipGetDpiX", "handle", $cf, "float*", 0)
If @error Then Return SetError(2, @extended, 0)
Local $bt = $2x[2]
_gn($cf)
_mz()
Return $bt / $ce
EndFunc
Func _iHoverOn($6r, $ch)
Switch $7t[$ch][3]
Case 5, 7
If $7t[$ch][2] Then
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][8]))
Else
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][6]))
EndIf
Case "6"
If $7t[$ch][2] Then
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][14]))
Else
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][13]))
EndIf
Case Else
_50(GUICtrlSendMsg($6r, 0x0172, 0, $7t[$ch][6]))
EndSwitch
EndFunc
Func _iHoverOff($6r, $ch)
Switch $7t[$ch][3]
Case 0, 3, 4, 8, 9, 10
If WinActive($7t[$ch][15]) Then
_50(GUICtrlSendMsg($6r, 0x0172, 0, $7t[$ch][5]))
Else
_50(GUICtrlSendMsg($6r, 0x0172, 0, $7t[$ch][7]))
EndIf
Case 5, 7
If $7t[$ch][2] Then
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][7]))
Else
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][5]))
EndIf
Case "6"
If $7t[$ch][2] Then
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][12]))
Else
_50(GUICtrlSendMsg($7t[$ch][0], 0x0172, 0, $7t[$ch][5]))
EndIf
Case Else
_50(GUICtrlSendMsg($6r, 0x0172, 0, $7t[$ch][5]))
EndSwitch
EndFunc
Func _16g($ci, $4)
For $w = 0 To UBound($7t) - 1
If($ci = $7t[$w][3]) And($4 = $7t[$w][15]) Then Return $7t[$w][0]
Next
Return False
EndFunc
Func _16h($4, $4x, $4y, $3f, $cj, $8a)
Switch $4x
Case 0x00AF, 0x0085, 0x00AE, 0x0083, 0x0086
Return -1
Case 0x031A
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(2, 4))
_p2($4, 0, 0, 0, 0, 0, 0x0020 + 0x0002 + 0x0001 + 0x0008)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Return 0
Case 0x0005
If Not $7u[$8a][11] Then
Switch $4y
Case 2
Local $ck = _16j($4)
Local $cl = WinGetPos($4)
WinMove($4, "", $cl[0] - 1, $cl[1] - 1, $ck[2], $ck[3])
For $cm = 0 To UBound($7t) - 1
If $4 = $7t[$cm][15] Then
Switch $7t[$cm][3]
Case 3
GUICtrlSetState($7t[$cm][0], 32)
$7t[$cm][8] = False
Case 4
GUICtrlSetState($7t[$cm][0], 16)
$7t[$cm][8] = True
EndSwitch
EndIf
Next
Case 0
For $cm = 0 To UBound($7t) - 1
If $4 = $7t[$cm][15] Then
Switch $7t[$cm][3]
Case 3
If Not $7t[$cm][8] Then
GUICtrlSetState($7t[$cm][0], 16)
$7t[$cm][8] = True
EndIf
Case 4
If $7t[$cm][8] Then
GUICtrlSetState($7t[$cm][0], 32)
$7t[$cm][8] = False
EndIf
EndSwitch
EndIf
Next
EndSwitch
EndIf
Case 0x0024
Local $cn = DllStructCreate("int;int;int;int;int;int;int;int;int;dword", $3f)
Local $co = _16j($4)
DllStructSetData($cn, 3, $co[2])
DllStructSetData($cn, 4, $co[3])
DllStructSetData($cn, 5, $co[0] + 1)
DllStructSetData($cn, 6, $co[1] + 1)
DllStructSetData($cn, 7, $7u[$8a][3])
DllStructSetData($cn, 8, $7u[$8a][4])
Case 0x0084
If $7u[$8a][2] And Not $7u[$8a][11] Then
Local $cp = 0, $cq = 0, $cr
Local $cl = WinGetPos($4)
Local $cs = GUIGetCursorInfo($4)
If Not @error Then
If $cs[0] < $7y Then $cp = 1
If $cs[0] > $cl[2] - $7y Then $cp = 2
If $cs[1] < $7y Then $cq = 3
If $cs[1] > $cl[3] - $7y Then $cq = 6
$cr = $cp + $cq
Else
$cr = 0
EndIf
If WinGetState($4) <> 47 Then
Local $ct = 2, $cu = 2
Switch $cr
Case 1
$cu = 13
$ct = 10
Case 2
$cu = 13
$ct = 11
Case 3
$cu = 11
$ct = 12
Case 4
$cu = 12
$ct = 13
Case 5
$cu = 10
$ct = 14
Case 6
$cu = 11
$ct = 15
Case 7
$cu = 10
$ct = 16
Case 8
$cu = 12
$ct = 17
EndSwitch
GUISetCursor($cu, 1)
If $ct <> 2 Then Return $ct
EndIf
If Abs(BitAND(BitShift($3f, 16), 0xFFFF) - $cl[1]) <(28 * $7s) Then Return 2
EndIf
Case 0x0201
If $7u[$8a][1] And Not $7u[$8a][11] And Not(WinGetState($4) = 47) Then
Local $cv = GUIGetCursorInfo($4)
If($cv[4] = 0) Then
DllCall("user32.dll", "int", "ReleaseCapture")
DllCall("user32.dll", "long", "SendMessageA", "hwnd", $4, "int", 0x00A1, "int", 2, "int", 0)
Return 0
EndIf
EndIf
Case 0x001C
For $cm = 0 To UBound($7t) - 1
Switch $7t[$cm][3]
Case 0, 3, 4, 8, 9, 10
If $4y Then
_50(GUICtrlSendMsg($7t[$cm][0], 0x0172, 0, $7t[$cm][5]))
Else
_50(GUICtrlSendMsg($7t[$cm][0], 0x0172, 0, $7t[$cm][7]))
EndIf
EndSwitch
Next
Case 0x0020
If MouseGetCursor() <> 2 Then
Local $cs = GUIGetCursorInfo($4)
If Not @error And $cs[4] <> 0 Then
Local $cp = 0, $cq = 0, $cr = 0
Local $cl = WinGetPos($4)
If $cs[0] < $7y Then $cp = 1
If $cs[0] > $cl[2] - $7y Then $cp = 2
If $cs[1] < $7y Then $cq = 3
If $cs[1] > $cl[3] - $7y Then $cq = 6
$cr = $cp + $cq
If $cr = 0 Then
If $cs[4] <> $7u[$8a][12] And $cs[4] <> $7u[$8a][13] And $cs[4] <> $7u[$8a][14] And $cs[4] <> $7u[$8a][15] Then
GUISetCursor(2, 0, $4)
EndIf
EndIf
EndIf
EndIf
EndSwitch
Return DllCall("comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $4, "uint", $4x, "wparam", $4y, "lparam", $3f)[0]
EndFunc
Func _16i()
For $8l = 0 To UBound($7u) - 1 Step +1
_14x($7u[$8l][0])
Next
DllCallbackFree($7w)
_mz()
EndFunc
Func _16j($4, $cw = False)
Local $cx[4], $cy = 1
$cx[0] = 0
$cx[1] = 0
$cx[2] = @DesktopWidth
$cx[3] = @DesktopHeight
Local $cz, $d0 = _a8()
If @error Then Return $cx
ReDim $d0[$d0[0][0] + 1][5]
For $w = 1 To $d0[0][0]
$cz = _bh($d0[$w][1])
For $13 = 0 To 3
$d0[$w][$13 + 1] = $cz[$13]
Next
Next
Local $d1 = _cg($4)
Local $d2 = _cg(WinGetHandle("[CLASS:Shell_TrayWnd]"))
For $d3 = 1 To $d0[0][0] Step +1
If $d0[$d3][0] = $d1 Then
If $cw Then
$cx[0] = $d0[$d3][1]
$cx[1] = $d0[$d3][2]
Else
$cx[0] = 0
$cx[1] = 0
EndIf
$cx[2] = $d0[$d3][3]
$cx[3] = $d0[$d3][4]
$cy = $d3
EndIf
Next
Local $d4 = DllCall("shell32.dll", "int", "SHAppBarMessage", "int", 0x00000004, "ptr*", 0)
If Not @error Then
$d4 = $d4[0]
Else
$d4 = 0
EndIf
If $d2 = $d1 Then
Local $d5 = WinGetPos("[CLASS:Shell_TrayWnd]")
If @error Then Return $cx
If $cw Then Return $cx
If($d5[0] = $d0[$cy][1] - 2) Or($d5[1] = $d0[$cy][2] - 2) Then
$d5[0] += 2
$d5[1] += 2
$d5[2] -= 4
$d5[3] -= 4
EndIf
If $d5[2] = $cx[2] Then
If $d4 = 1 Then
If($d5[1] > 0) Then
$cx[3] -= 1
Else
$cx[1] += 1
$cx[3] -= 1
EndIf
Return $cx
EndIf
$cx[3] = $cx[3] - $d5[3]
If($d5[0] = $d0[$cy][1]) And($d5[1] = $d0[$cy][2]) Then $cx[1] = $d5[3]
Else
If $d4 = 1 Then
If($d5[0] > 0) Then
$cx[2] -= 1
Else
$cx[0] += 1
$cx[2] -= 1
EndIf
Return $cx
EndIf
$cx[2] = $cx[2] - $d5[2]
If($d5[0] = $d0[$cy][1]) And($d5[1] = $d0[$cy][2]) Then $cx[0] = $d5[2]
EndIf
EndIf
Return $cx
EndFunc
Func _16k($8d)
For $d6 = 0 To UBound($7u) - 1
If $7u[$d6][0] = $8d Then
Return $d6
EndIf
Next
Return SetError(1, 0, "")
EndFunc
Func _iFullscreenToggleBtn($6r, $4)
If $80 Then _151($4)
EndFunc
Global Const $d7 = 0xFFFFFF
Global Const $d8 = DllOpen("kernel32.dll")
Global Const $d9 = DllOpen("user32.dll")
Global Const $da = DllOpen("gdi32.dll")
Global Const $db = DllOpen("comctl32.dll")
Global Const $dc = DllOpen("ole32.dll")
Global Const $dd = DllOpen("gdiplus.dll")
Global $de = ";"
Func _16u($df, $dg, $dh, $di, $3m = Default, $3n = Default, $dj = Default, $dk = Default, $dl = 0)
If $3m = -1 Then $3m = Default
If $3n = -1 Then $3n = Default
Local $ch
If IsBinary($df) Then
$ch = $df
Else
If $dg Then
Local $2z = StringSplit($dg, ";", 2)
If UBound($2z) < 3 Then ReDim $2z[3]
$ch = _18j($df, $2z[0], $2z[1], $2z[2])
If @error Then
$ch = $df
Else
If $2z[0] = 2 Then $ch = _18k($ch)
EndIf
Else
$ch = $df
EndIf
EndIf
Local $dm, $dn
If Not IsKeyword($dm) = 1 Then $dm = $3m
If Not IsKeyword($dn) = 1 Then $dn = $3n
Local $do = _17c($ch, $dm, $dn, $dl, $dh, $di, $dk)
If @error Then
$ch = FileRead($ch)
$do = _17c($ch, $dm, $dn, $dl, $dh, $di, $dk)
If @error Then
$do = _17c(Binary($df), $dm, $dn, $dl, $dh, $di, $dk)
If @error Then Return SetError(1, @extended = True, 0)
EndIf
EndIf
Local $dp = DllStructCreate("handle GIFThread;" & "ptr CodeBuffer;" & "hwnd ControlHandle;" & "handle ImageList;" & "bool ExitFlag;" & "bool Transparent;" & "dword CurrentFrame;" & "dword NumberOfFrames;", $do)
Local $dq = DllStructGetData($dp, "NumberOfFrames")
$dp = DllStructCreate("handle GIFThread;" & "ptr CodeBuffer;" & "hwnd ControlHandle;" & "handle ImageList;" & "bool ExitFlag;" & "bool Transparent;" & "dword CurrentFrame;" & "dword NumberOfFrames;" & "dword FrameDelay[" & $dq & "];", $do)
GUICtrlSetResizing($dl, 802)
DllStructSetData($dp, "ControlHandle", GUICtrlGetHandle($dl))
If $dq = 1 Then
$de &= $dl & "|" & $do & ";"
Return SetExtended(1, $dl)
EndIf
Local $dr = 157
If @AutoItX64 Then $dr = 220
Local $ds = _188($dr, 64)
If @error Then Return SetError(2, 0, $dl)
DllStructSetData($dp, "CodeBuffer", $ds)
_171($ds, $dr, 64)
If @error Then Return SetError(3, 0, $dl)
Local $dt = DllStructCreate("byte[" & $dr & "]", $ds)
Local $du = _172(_173("comctl32.dll"), "ImageList_DrawEx")
If @error Then Return SetError(4, 1, $dl)
Local $dv = _172(_173("kernel32.dll"), "Sleep")
If @error Then Return SetError(4, 2, $dl)
Local $dw = _172(_173("gdi32.dll"), "GetPixel")
If @error Then Return SetError(4, 3, $dl)
Local $dx = _173("user32.dll")
Local $dy = _172($dx, "GetDC")
If @error Then Return SetError(4, 4, $dl)
Local $dz = _172($dx, "ReleaseDC")
If @error Then Return SetError(4, 5, $dl)
Local $e0 = DllStructGetData($dp, "ImageList")
Local $8n = DllStructGetData($dp, "ControlHandle")
Local $3w
If $dj = Default Then
$3w = 1
If DllStructGetData($dp, "Transparent") Then $3w = 0
Else
$3w = $dj
EndIf
If @AutoItX64 Then
DllStructSetData($dt, 1, "0x" & "4883EC" & _18l(88, 1) & "" & "4831F6" & "" & "" & "8BC6" & "A3" & _18l(DllStructGetPtr($dp, "CurrentFrame"), 8) & "" & "48B9" & _18l($8n, 8) & "48B8" & _18l($dy, 8) & "FFD0" & "" & "4889C3" & "" & "49C7C0" & _18l(0, 4) & "BA" & _18l(0, 4) & "4889C1" & "48B8" & _18l($dw, 8) & "FFD0" & "" & "3D" & _18l(-1, 4) & "75" & _18l(2, 1) & "8BC7" & "" & "8BF8" & "" & "89442438" & "B8" & _18l($3w, 4) & "89442448" & "4989D8" & "49C7C1" & _18l(0, 4) & "89F2" & "48B9" & _18l($e0, 8) & "" & "48B8" & _18l($du, 8) & "FFD0" & "" & "4889DA" & "48B9" & _18l($8n, 8) & "48B8" & _18l($dz, 8) & "FFD0" & "" & "A1" & _18l(DllStructGetPtr($dp, "ExitFlag"), 8) & "85C0" & "75" & _18l(46, 1) & "" & "48BB" & _18l(DllStructGetPtr($dp, "FrameDelay"), 8) & "488B0CB3" & "48B8" & _18l($dv, 8) & "FFD0" & "" & "FFC6" & "" & "81FE" & _18l($dq, 4) & "" & "74" & _18l(5, 1) & "E9" & _18l(-200, 4) & "E9" & _18l(-208, 4) & "" & "4831C0" & "4883C4" & _18l(88, 1) & "C3" )
Else
DllStructSetData($dt, 1, "0x" & "" & "33F6" & "" & "" & "8BC6" & "A3" & _18l(DllStructGetPtr($dp, "CurrentFrame"), 4) & "68" & _18l($3w, 4) & "68" & _18l(-1, 4) & "" & "68" & _18l($8n, 4) & "B8" & _18l($dy, 4) & "FFD0" & "" & "8BD8" & "" & "68" & _18l(0, 4) & "68" & _18l(0, 4) & "53" & "B8" & _18l($dw, 4) & "FFD0" & "" & "3D" & _18l(-1, 4) & "75" & _18l(2, 1) & "8BC7" & "" & "8BF8" & "" & "50" & "68" & _18l(0, 4) & "68" & _18l(0, 4) & "68" & _18l(0, 4) & "68" & _18l(0, 4) & "53" & "56" & "68" & _18l($e0, 4) & "" & "B8" & _18l($du, 4) & "FFD0" & "" & "53" & "68" & _18l($8n, 4) & "B8" & _18l($dz, 4) & "FFD0" & "" & "A1" & _18l(DllStructGetPtr($dp, "ExitFlag"), 4) & "85C0" & "75" & _18l(35, 1) & "" & "BB" & _18l(DllStructGetPtr($dp, "FrameDelay"), 4) & "8B0CB3" & "51" & "B8" & _18l($dv, 4) & "FFD0" & "" & "46" & "" & "81FE" & _18l($dq, 4) & "" & "74" & _18l(5, 1) & "E9" & _18l(-147, 4) & "E9" & _18l(-154, 4) & "" & "33C0" & "C3" )
EndIf
Local $5z = _16y($ds)
If @error Then Return SetError(5, 0, $dl)
DllStructSetData($dp, "GIFThread", $5z)
_177(_17b($8n))
$de &= $dl & "|" & $do & ";"
Return $dl
EndFunc
Func _16y($35)
Local $5u = DllCall($d8, "handle", "CreateThread", "ptr", 0, "dword_ptr", 0, "ptr", $35, "ptr", 0, "dword", 0, "dword*", 0)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _171($35, $e1, $e2)
Local $5u = DllCall($d8, "bool", "VirtualProtect", "ptr", $35, "dword_ptr", $e1, "dword", $e2, "dword*", 0)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _172($2w, $e3)
Local $5j = "str"
If IsNumber($e3) Then $5j = "int"
Local $5u = DllCall($d8, "ptr", "GetProcAddress", "handle", $2w, $5j, $e3)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _173($e4 = 0)
Local $5j = "wstr"
If Not $e4 Then $5j = "ptr"
Local $5u = DllCall($d8, "ptr", "GetModuleHandleW", $5j, $e4)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _177($4, $3e = 0, $e5 = True)
Local $5u = DllCall($d9, "bool", "InvalidateRect", "hwnd", $4, "ptr", $3e, "bool", $e5)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _17b($4)
Local $5u = DllCall($d9, "hwnd", "GetParent", "hwnd", $4)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _17c($e6, ByRef $3m, ByRef $3n, ByRef $dl, $dh = 0, $di = 0, $3s = Default)
If $3s = Default Then $3s = 0xFF000000
Local $e7
Local $e8
Local $e9, $ea, $eb
If IsBinary($e6) Then
$e9 = _17m($e7, $e8, $e6, $ea, $eb)
Else
$e9 = _17l($e7, $e6, $ea, $eb)
EndIf
If @error Then
Local $ec = @error
_187($e9, $e7, $e8)
Return SetError(1, $ec, 0)
EndIf
Local $ed
If $3m = Default Then
$3m = $ea
Else
$ed = True
EndIf
If $3n = Default Then
$3n = $eb
Else
$ed = True
EndIf
Local $ee = _17s($e9)
If @error Then
_187($e9, $e7, $e8)
Return SetError(2, 0, 0)
EndIf
Local $ef = DllStructCreate("dword;word;word;byte[8]")
Local $eg = DllStructGetPtr($ef)
_17t($e9, $eg, $ee)
If @error Then
_187($e9, $e7, $e8)
Return SetError(3, 0, 0)
EndIf
Local $dq = _17u($e9, $eg)
If @error Then
_187($e9, $e7, $e8)
Return SetError(4, 0, 0)
EndIf
Local $do = _188(4 *(8 + 4 * @AutoItX64 + $dq), 64)
If @error Then
_187($e9, $e7, $e8)
Return SetError(3, 0, 0)
EndIf
Local $dp = DllStructCreate("handle GIFThread;" & "ptr CodeBuffer;" & "hwnd ControlHandle;" & "handle ImageList;" & "bool ExitFlag;" & "bool Transparent;" & "dword CurrentFrame;" & "dword NumberOfFrames;" & "dword FrameDelay[" & $dq & "];", $do)
DllStructSetData($dp, "GIFThread", 0)
DllStructSetData($dp, "ControlHandle", 0)
DllStructSetData($dp, "ExitFlag", 0)
DllStructSetData($dp, "CurrentFrame", 0)
DllStructSetData($dp, "NumberOfFrames", $dq)
Local $eh = False
If Not $dl Then
$eh = True
$dl = GUICtrlCreatePic("", $dh, $di, $3m, $3n)
EndIf
If $dq = 1 Then
Local $ei = _182($e9, $3s)
If $ed Then _17n($ei, $3m, $3n)
_187($e9, $e7, $e8)
_17f(GUICtrlSendMsg($dl, 370, 0, $ei))
_17f($ei)
Return $do
EndIf
Local $e0 = _17h($3m, $3n, 32, $dq)
If @error Then
If $eh Then GUICtrlDelete($dl)
_187($e9, $e7, $e8, $do)
Return SetError(4, 0, 0)
EndIf
DllStructSetData($dp, "ImageList", $e0)
Local $3r
For $13 = 0 To $dq - 1
_17v($e9, $eg, $13)
If @error Then ContinueLoop
$3r = _182($e9, $3s)
If $ed Then _17n($3r, $3m, $3n)
_17i($e0, $3r)
If $13 = 0 Then
_17f(GUICtrlSendMsg($dl, 370, 0, $3r))
_17f($3r)
EndIf
_17f($3r)
Next
Local $ej = _17w($e9, 0x5100)
If @error Then
If $eh Then GUICtrlDelete($dl)
_187($e9, $e7, $e8, $do)
Return SetError(5, 0, 0)
EndIf
Local $ek = DllStructCreate("byte[" & $ej & "]")
_17x($e9, 0x5100, $ej, DllStructGetPtr($ek))
If @error Then
If $eh Then GUICtrlDelete($dl)
_187($e9, $e7, $e8, $do)
Return SetError(6, 0, 0)
EndIf
Local $el = DllStructCreate("int Id;" & "dword Length;" & "word Type;" & "ptr Value", DllStructGetPtr($ek))
Local $e1 = DllStructGetData($el, "Length") / 4
Local $em = DllStructCreate("dword[" & $e1 & "]", DllStructGetData($el, "Value"))
Local $en
For $13 = 1 To $dq
$en = DllStructGetData($em, 1, $13) * 10
If Not $en Then $en = 130
If $en < 50 Then $en = 50
DllStructSetData($dp, "FrameDelay", $en, $13)
Next
Local $eo = True
Local $ep = _17y($e9, 0, 0)
If BitShift($ep, 24) Then $eo = False
DllStructSetData($dp, "Transparent", $eo)
_187($e9, $e7, $e8)
Return $do
EndFunc
Func _17d($eq, $3c = 1)
Local $5u = DllCall($dc, "long", "CreateStreamOnHGlobal", "handle", $eq, "int", $3c, "ptr*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[3]
EndFunc
Func _17e($34, $e1, $er)
Local $5u = DllCall($da, "int", "GetObject", "handle", $34, "int", $e1, "ptr", $er)
If @error Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _17f($34)
Local $5u = DllCall($da, "bool", "DeleteObject", "handle", $34)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _17h($3m, $3n, $3c, $es, $et = 0)
Local $5u = DllCall($db, "handle", "ImageList_Create", "int", $3m, "int", $3n, "dword", $3c, "int", $es, "int", $et)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _17i($e0, $3r)
Local $5u = DllCall($db, "int", "ImageList_Add", "handle", $e0, "handle", $3r, "handle", 0)
If @error Or $5u[0] = -1 Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _17l(ByRef $e7, $eu, ByRef $3m, ByRef $3n)
$e7 = _17o()
If @error Then Return SetError(1, 0, 0)
Local $e9 = _17z($eu)
If @error Then
_17p($e7)
Return SetError(2, 0, 0)
EndIf
_17r($e9, $3m, $3n)
If @error Then
_187($e9, $e7)
Return SetError(3, 0, 0)
EndIf
Return $e9
EndFunc
Func _17m(ByRef $e7, ByRef $e8, $e6, ByRef $3m, ByRef $3n)
$e6 = Binary($e6)
Local $e1 = BinaryLen($e6)
$e8 = _188($e1, 2)
If @error Then Return SetError(1, 0, 0)
Local $ev = _18a($e8)
If @error Then
_189($e8)
Return SetError(2, 0, 0)
EndIf
Local $ew = DllStructCreate("byte[" & $e1 & "]", $ev)
DllStructSetData($ew, 1, $e6)
Local $ex = _17d($ev, 0)
If @error Then
_189($e8)
Return SetError(3, 0, 0)
EndIf
_18b($ev)
$e7 = _17o()
If @error Then
_189($e8)
Return SetError(4, 0, 0)
EndIf
Local $e9 = _181($ex)
If @error Then
_17p($e7)
_189($e8)
Return SetError(5, 0, 0)
EndIf
_17r($e9, $3m, $3n)
If @error Then
_187($e9, $e7, $e8)
Return SetError(6, 0, 0)
EndIf
DllCallAddress("dword", DllStructGetData(DllStructCreate("ptr QueryInterface; ptr AddRef; ptr Release;", DllStructGetData(DllStructCreate("ptr pObj;", $ex), "pObj")), "Release"), "ptr", $ex)
Return $e9
EndFunc
Func _17n(ByRef $3r, $ey, $ez)
Local $f0 = DllStructCreate("long Type;long Width;long Height;long WidthBytes;word Planes;word BitsPixel;ptr Bits;")
_17e($3r, DllStructGetSize($f0), DllStructGetPtr($f0))
Local $e9 = _180(DllStructGetData($f0, "Width"), DllStructGetData($f0, "Height"), DllStructGetData($f0, "WidthBytes"), 0x26200A, DllStructGetData($f0, "Bits"))
_186($e9, 6)
Local $f1 = _180($ey, $ez)
Local $41 = _183($f1)
_184($41, $e9, 0, 0, $ey, $ez)
Local $f2 = _182($f1)
_17q($e9)
_185($41)
_17f($3r)
_17q($f1)
$3r = $f2
Return 1
EndFunc
Func _17o()
Local $f3 = DllStructCreate("dword GdiplusVersion;" & "ptr DebugEventCallback;" & "int SuppressBackgroundThread;" & "int SuppressExternalCodecs")
DllStructSetData($f3, "GdiplusVersion", 1)
Local $5u = DllCall($dd, "dword", "GdiplusStartup", "dword_ptr*", 0, "ptr", DllStructGetPtr($f3), "ptr", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[1]
EndFunc
Func _17p($e7)
DllCall($dd, "none", "GdiplusShutdown", "dword_ptr", $e7)
EndFunc
Func _17q($4h)
Local $5u = DllCall($dd, "dword", "GdipDisposeImage", "handle", $4h)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _17r($e9, ByRef $3m, ByRef $3n)
Local $5u = DllCall($dd, "dword", "GdipGetImageDimension", "ptr", $e9, "float*", 0, "float*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
$3m = $5u[2]
$3n = $5u[3]
EndFunc
Func _17s($e9)
Local $5u = DllCall($dd, "dword", "GdipImageGetFrameDimensionsCount", "ptr", $e9, "dword*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[2]
EndFunc
Func _17t($e9, $eg, $ee)
Local $5u = DllCall($dd, "dword", "GdipImageGetFrameDimensionsList", "ptr", $e9, "ptr", $eg, "dword", $ee)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _17u($e9, $eg)
Local $5u = DllCall($dd, "dword", "GdipImageGetFrameCount", "ptr", $e9, "ptr", $eg, "dword*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[3]
EndFunc
Func _17v($e9, $eg, $f4)
Local $5u = DllCall($dd, "dword", "GdipImageSelectActiveFrame", "ptr", $e9, "ptr", $eg, "dword", $f4)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _17w($e9, $f5)
Local $5u = DllCall($dd, "dword", "GdipGetPropertyItemSize", "ptr", $e9, "ptr", $f5, "dword*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[3]
EndFunc
Func _17x($e9, $f5, $e1, $b)
Local $5u = DllCall($dd, "dword", "GdipGetPropertyItem", "ptr", $e9, "dword", $f5, "dword", $e1, "ptr", $b)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _17y($e9, $58, $59)
Local $5u = DllCall($dd, "dword", "GdipBitmapGetPixel", "ptr", $e9, "int", $58, "int", $59, "dword*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[4]
EndFunc
Func _17z($eu)
Local $5u = DllCall($dd, "dword", "GdipLoadImageFromFile", "wstr", $eu, "ptr*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[2]
EndFunc
Func _180($3m, $3n, $3p = 0, $3o = 0x26200A, $3q = 0)
Local $5u = DllCall($dd, "dword", "GdipCreateBitmapFromScan0", "int", $3m, "int", $3n, "int", $3p, "dword", $3o, "ptr", $3q, "ptr*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[6]
EndFunc
Func _181($ex)
Local $5u = DllCall($dd, "dword", "GdipCreateBitmapFromStream", "ptr", $ex, "ptr*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[2]
EndFunc
Func _182($e9, $3s = 0xFF000000)
Local $5u = DllCall($dd, "dword", "GdipCreateHBITMAPFromBitmap", "ptr", $e9, "handle*", 0, "dword", $3s)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[2]
EndFunc
Func _183($4h)
Local $5u = DllCall($dd, "dword", "GdipGetImageGraphicsContext", "ptr", $4h, "ptr*", 0)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return $5u[2]
EndFunc
Func _184($41, $4h, $58, $59, $3m, $3n)
Local $5u = DllCall($dd, "dword", "GdipDrawImageRectI", "ptr", $41, "ptr", $4h, "int", $58, "int", $59, "int", $3m, "int", $3n)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _185($41)
Local $5u = DllCall($dd, "dword", "GdipDeleteGraphics", "handle", $41)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _186($4h, $f6)
Local $5u = DllCall($dd, "dword", "GdipImageRotateFlip", "handle", $4h, "dword", $f6)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _187($e9 = 0, $e7 = 0, $f7 = 0, $do = 0)
If $e9 Then _17q($e9)
If $e7 Then _17p($e7)
If $f7 Then _189($f7)
If $do Then _189($do)
EndFunc
Func _188($e1, $3c)
Local $5u = DllCall($d8, "handle", "GlobalAlloc", "dword", $3c, "dword_ptr", $e1)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _189($f7)
Local $5u = DllCall($d8, "ptr", "GlobalFree", "handle", $f7)
If @error Or $5u[0] Then Return SetError(1, 0, 0)
Return 1
EndFunc
Func _18a($f7)
Local $5u = DllCall($d8, "ptr", "GlobalLock", "handle", $f7)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _18b($f7)
Local $5u = DllCall($d8, "bool", "GlobalUnlock", "handle", $f7)
If @error Then Return SetError(1, 0, 0)
If $5u[0] Or _18c() Then Return $5u[0]
Return 1
EndFunc
Func _18c()
Local $5u = DllCall($d8, "dword", "GetLastError")
If @error Then Return SetError(1, 0, -1)
Return $5u[0]
EndFunc
Func _18d($2w, $f8, $f9, $fa = 0)
Local $fb = "wstr"
If $f8 == Number($f8) Then $fb = "int"
Local $fc = "wstr"
If $f9 == Number($f9) Then $fc = "int"
Local $5u = DllCall($d8, "handle", "FindResourceExW", "handle", $2w, $fb, $f8, $fc, $f9, "int", $fa)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _18e($2w, $fd)
Local $5u = DllCall($d8, "int", "SizeofResource", "handle", $2w, "handle", $fd)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _18f($2w, $fd)
Local $5u = DllCall($d8, "handle", "LoadResource", "handle", $2w, "handle", $fd)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _18g($fd)
Local $5u = DllCall($d8, "ptr", "LockResource", "handle", $fd)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _18h($fe, $3c = 0)
Local $5u = DllCall($d8, "handle", "LoadLibraryExW", "wstr", $fe, "handle", 0, "dword", $3c)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _18i($2w)
Local $5u = DllCall($d8, "bool", "FreeLibrary", "handle", $2w)
If @error Or Not $5u[0] Then Return SetError(1, 0, 0)
Return $5u[0]
EndFunc
Func _18j($fe, $f8, $f9, $fa = 0)
Local $2w = _18h($fe, 2)
If @error Then Return SetError(1, 0, "")
Local $fd = _18d($2w, $f8, $f9, $fa)
If @error Then
_18i($2w)
Return SetError(2, 0, "")
EndIf
Local $ff = _18e($2w, $fd)
If @error Then
_18i($2w)
Return SetError(3, 0, "")
EndIf
$fd = _18f($2w, $fd)
If @error Then
_18i($2w)
Return SetError(4, 0, "")
EndIf
Local $fg = _18g($fd)
If @error Then
_18i($2w)
Return SetError(5, 0, "")
EndIf
Local $ew = DllStructCreate("byte[" & $ff & "]", $fg)
Local $e6 = DllStructGetData($ew, 1)
_18i($2w)
Return $e6
EndFunc
Func _18k($e6)
Local $ew = DllStructCreate("byte[" & BinaryLen($e6) & "]")
DllStructSetData($ew, 1, $e6)
Local $fh = DllStructGetData(DllStructCreate("dword HeaderSize", DllStructGetPtr($ew)), "HeaderSize")
Local $fi, $fj
Switch $fh
Case 40
$fi = DllStructCreate("dword HeaderSize;" & "dword Width;" & "dword Height;" & "word Planes;" & "word BitPerPixel;" & "dword CompressionMethod;" & "dword Size;" & "dword Hresolution;" & "dword Vresolution;" & "dword Colors;" & "dword ImportantColors", DllStructGetPtr($ew))
$fj = 4
Case 12
$fi = DllStructCreate("dword HeaderSize;" & "word Width;" & "word Height;" & "word Planes;" & "word BitPerPixel", DllStructGetPtr($ew))
$fj = 3
Case Else
Return SetError(1, 0, 0)
EndSwitch
Local $fk = DllStructGetData($fi, "BitPerPixel")
Local $fl = DllStructCreate("align 2;char Identifier[2];" & "dword BitmapSize;" & "short;" & "short;" & "dword BitmapOffset;" & "byte Body[" & BinaryLen($e6) & "]")
DllStructSetData($fl, "Identifier", "BM")
DllStructSetData($fl, "BitmapSize", BinaryLen($e6) + 14)
Local $fm = DllStructGetData($fi, "Size")
If $fm Then
DllStructSetData($fl, "BitmapOffset", BinaryLen($e6) - $fm + 14)
Else
If $fk = 24 Then
DllStructSetData($fl, "BitmapOffset", $fh + 14)
Else
Local $3m = DllStructGetData($fi, "Width")
Local $3n = DllStructGetData($fi, "Height")
$fm = 4 * Floor(($3m * $fk + 31) / 32) * $3n
Local $fn = BinaryLen($e6) - $fm + 14
Local $fo = 2 ^ $fk * $fj + $fh + 14
If $fo < $fn Then
DllStructSetData($fl, "BitmapOffset", $fo)
Else
DllStructSetData($fl, "BitmapOffset", $fn - 2)
EndIf
EndIf
EndIf
DllStructSetData($fl, "Body", $e6)
Return DllStructGetData(DllStructCreate("byte[" & DllStructGetSize($fl) & "]", DllStructGetPtr($fl)), 1)
EndFunc
Func _18l($fp, $e1 = 0)
If $e1 Then
Local $fq = "00000000"
Return Hex(BinaryMid($fp, 1, $e1)) & StringLeft($fq, 2 *($e1 - BinaryLen($fp)))
EndIf
Return Hex(Binary($fp))
EndFunc
Dim Const $fr = 'struct;' & 'char fadeIn[10];' & 'char fadeOut[10];' & 'char slideInLeft[10];' & 'char slideOutLeft[10];' & 'char slideInRight[10];' & 'char slideOutRight[10];' & 'char slideInTop[10];' & 'char slideOutTop[10];' & 'char slideInBottom[10];' & 'char slideOutBottom[10];' & 'char diagSlideInTopLeft[10];' & 'char diagSlideOutTopLeft[10];' & 'char diagslideInTopRight[10];' & 'char diagSlideOutTopRight[10];' & 'char diagSlideInBottomLeft[10];' & 'char diagSlideOutBottomLeft[10];' & 'char diagSlideInBottomRight[10];' & 'char diagSlideOutBottomRight[10];' & 'char explode[10];' & 'char implode[10];' & 'char horPositive[10];' & 'char horNegative[10];' & 'char verPositive[10];' & 'char verNegative[10];' & 'char center[10];' & 'char hide[10];' & 'char activate[10];' & 'char slide[10];' & 'char blend[10];' & 'endstruct'
Dim $fs = DllStructCreate($fr)
$fs.fadeIn = 0x00080000
$fs.fadeOut = 0x00090000
$fs.slideInLeft = 0x00040001
$fs.slideOutLeft = 0x00050002
$fs.slideInRight = 0x00040002
$fs.slideOutRight = 0x00050001
$fs.slideInTop = 0x00040004
$fs.slideOutTop = 0x00050008
$fs.slideInBottom = 0x00040008
$fs.slideOutBottom = 0x00050004
$fs.diagSlideInTopLeft = 0x00040005
$fs.diagSlideOutTopLeft = 0x0005000A
$fs.diagslideInTopRight = 0x00040006
$fs.diagSlideOutTopRight = 0x00050009
$fs.diagSlideInBottomLeft = 0x00040009
$fs.diagSlideOutBottomLeft = 0x00050006
$fs.diagSlideInBottomRight = 0x0004000A
$fs.diagSlideOutBottomRight = 0x00050005
$fs.explode = 0x00040010
$fs.implode = 0x00050010
$fs.horPositive = 0x00000001
$fs.horNegative = 0x00000002
$fs.verPositive = 0x00000004
$fs.verNegative = 0x00000008
$fs.center = 0x00000010
$fs.hide = 0x00010000
$fs.activate = 0x00020000
$fs.slide = 0x00040000
$fs.blend = 0x00080000
Dim $ft = _1aq
Func _1aq($fu, $fv = 'fadeIn', $fw = 200)
Return _pa($fu, DllStructGetData($fs, $fv), $fw)
EndFunc
#ignorefunc __SQLite_Inline_Version, __SQLite_Inline_Modified
Global $fx = 0
Global $fy = 0
Global $fz = False
Global $g0 = _1db
Global $g1 = True
Global $g2[1] = ['']
Global $g3[1] = ['']
Global $g4 = 0
Func _1ca($g5 = "", $g6 = False, $g7 = 0, $g8 = $g0)
If $g5 = Default Or $g5 = -1 Then $g5 = ""
If $g8 = Default Then $g8 = _1db
$g0 = $g8
If $g6 = Default Then $g6 = False
$fz = $g6
Local $g9 = ""
If $g5 = "" Then $g5 = "sqlite3.dll"
If @AutoItX64 And(StringInStr($g5, "_x64") = 0) Then $g5 = StringReplace($g5, ".dll", "_x64.dll")
Local $ga = 0
If $g7 < 1 Then
Local $gb = True
Local $gc = Call('__SQLite_Inline_Version')
If @error Then $gb = False
If $g7 = 0 Then
If _1d4(@ScriptDir & "\" & $g5, $gc) = 0 Then
$g9 = @ScriptDir & "\"
$gb = False
ElseIf _1d4(@SystemDir & "\" & $g5, $gc) = 0 Then
$g9 = @SystemDir & "\"
$gb = False
ElseIf _1d4(@WindowsDir & "\" & $g5, $gc) = 0 Then
$g9 = @WindowsDir & "\"
$gb = False
ElseIf _1d4(@WorkingDir & "\" & $g5, $gc) = 0 Then
$g9 = @WorkingDir & "\"
$gb = False
Else
$g5 = StringReplace($g5, ".dll", "") & "_" & $gc & ".dll"
If _1d4(@ScriptDir & "\" & $g5, $gc) = 0 Then
$g9 = @ScriptDir & "\"
$gb = False
ElseIf _1d4(@SystemDir & "\" & $g5, $gc) = 0 Then
$g9 = @SystemDir & "\"
$gb = False
ElseIf _1d4(@WindowsDir & "\" & $g5, $gc) = 0 Then
$g9 = @WindowsDir & "\"
$gb = False
ElseIf _1d4(@WorkingDir & "\" & $g5, $gc) = 0 Then
$g9 = @WorkingDir & "\"
$gb = False
EndIf
EndIf
EndIf
If $gb Then
If Not FileExists($g9 & $g5) Then
$g9 = @LocalAppDataDir & "\AutoIt v3\SQLite"
EndIf
If $g7 Then
$gc = ""
Else
$gc = "_" & $gc
$ga = 1
EndIf
$g5 = $g9 & "\" & StringReplace($g5, ".dll", "") & $gc & ".dll"
EndIf
EndIf
Local $gd = DllOpen($g5)
If $gd = -1 Then
$fx = 0
Return SetError(1, $ga, "")
Else
$fx = $gd
Return SetExtended($ga, $g5)
EndIf
EndFunc
Func _1cb()
If $fx > 0 Then DllClose($fx)
$fx = 0
If $g4 > 0 Then DllClose($g4)
$g4 = 0
EndFunc
Func _1cc($ge = Default, $gf = Default, $gg = Default)
If Not $fx Then Return SetError(3, 21, 0)
If $ge = Default Or Not IsString($ge) Then $ge = ":memory:"
Local $gh = _1d9($ge)
If @error Then Return SetError(2, @error, 0)
If $gf = Default Then $gf = BitOR(0x02, 0x04)
Local $gi = FileExists($ge)
If $gg = Default Then
$gg = 0
EndIf
Local $gj = DllCall($fx, "int:cdecl", "sqlite3_open_v2", "struct*", $gh, "ptr*", 0, "int", $gf, "ptr", 0)
If @error Then Return SetError(1, @error, 0)
If $gj[0] <> 0 Then
_1d6($gj[2], "_SQLite_Open")
_1cq($gj[2])
Return SetError(-1, $gj[0], 0)
EndIf
$fy = $gj[2]
_1d2($g2, $gj[2])
If Not $gi Then
Local $gk[3] = ["8", "16", "16be"]
_1ce($gj[2], 'PRAGMA encoding="UTF-' & $gk[$gg] & '";')
EndIf
Return SetExtended($gj[0], $gj[2])
EndFunc
Func _1ce($gl, $gm, $gn = "")
If _1d1($gl, 2) Then Return SetError(@error, 0, 21)
If $gn <> "" Then
Local $go, $gp
Local $2x = "SQLITE_CALLBACK:" & $gn
Local $gq = _1cm($gl, $gm, $2x, $go, $gp)
If @error Then Return SetError(3, @error, $gq)
Return $gq
EndIf
Local $gr = _1d9($gm)
If @error Then Return SetError(4, @error, 0)
Local $gj = DllCall($fx, "int:cdecl", "sqlite3_exec", "ptr", $gl, "struct*", $gr, "ptr", 0, "ptr", 0, "ptr*", 0)
If @error Then Return SetError(1, @error, 21)
_1d8($gj[5])
If $gj[0] <> 0 Then
_1d6($gl, "_SQLite_Exec", $gm)
SetError(-1)
EndIf
Return $gj[0]
EndFunc
Func _1ck($gl = -1)
If _1d1($gl, 2) Then Return SetError(@error, @extended, "Library used incorrectly")
Local $gs = DllCall($fx, "wstr:cdecl", "sqlite3_errmsg16", "ptr", $gl)
If @error Then
_1d6($gl, "_SQLite_ErrMsg", Default, "Call Failed")
Return SetError(1, @error, "Library used incorrectly")
EndIf
Return $gs[0]
EndFunc
Func _1cm($gl, $gm, ByRef $2x, ByRef $go, ByRef $gp, $gt = -1, $gu = False)
If _1d1($gl, 1) Then Return SetError(@error, 0, 21)
If $gt = "" Or $gt < 1 Or $gt = Default Then $gt = -1
Local $gn = "", $gv = False
If IsString($2x) Then
If StringLeft($2x, 16) = "SQLITE_CALLBACK:" Then
$gn = StringTrimLeft($2x, 16)
$gv = True
EndIf
EndIf
$2x = ''
If $gu = Default Then $gu = False
Local $gw
Local $gs = _1co($gl, $gm, $gw)
If @error Then Return SetError(2, @error, $gs)
If $gs <> 0 Then
_1d6($gl, "_SQLite_GetTable2d", $gm)
_1cs($gw)
Return SetError(-1, 0, $gs)
EndIf
$go = 0
Local $gx, $7p
While True
$gx = DllCall($fx, "int:cdecl", "sqlite3_step", "ptr", $gw)
If @error Then
$7p = @error
_1cs($gw)
Return SetError(3, $7p, 21)
EndIf
Switch $gx[0]
Case 100
$go += 1
Case 101
ExitLoop
Case Else
_1cs($gw)
Return SetError(3, $7p, $gx[0])
EndSwitch
WEnd
Local $1l = _1ct($gw)
If @error Then
$7p = @error
_1cs($gw)
Return SetError(4, $7p, $1l)
EndIf
Local $gy
$gs = _1cu($gw, $gy)
If @error Then
$7p = @error
_1cs($gw)
Return SetError(5, $7p, $gs)
EndIf
$gp = UBound($gy)
If $gp <= 0 Then
_1cs($gw)
Return SetError(-1, 0, 101)
EndIf
If Not $gv Then
If $gu Then
Dim $2x[$gp][$go + 1]
For $w = 0 To $gp - 1
If $gt > 0 Then
$gy[$w] = StringLeft($gy[$w], $gt)
EndIf
$2x[$w][0] = $gy[$w]
Next
Else
Dim $2x[$go + 1][$gp]
For $w = 0 To $gp - 1
If $gt > 0 Then
$gy[$w] = StringLeft($gy[$w], $gt)
EndIf
$2x[0][$w] = $gy[$w]
Next
EndIf
Else
Local $gz
$gz = Call($gn, $gy)
If $gz = 4 Or $gz = 9 Or @error Then
$7p = @error
_1cs($gw)
Return SetError(7, $7p, $gz)
EndIf
EndIf
If $go > 0 Then
For $w = 1 To $go
$gs = _1cp($gw, $gy, 0, 0, $gp)
If @error Then
$7p = @error
_1cs($gw)
Return SetError(6, $7p, $gs)
EndIf
If $gv Then
$gz = Call($gn, $gy)
If $gz = 4 Or $gz = 9 Or @error Then
$7p = @error
_1cs($gw)
Return SetError(7, $7p, $gz)
EndIf
Else
For $13 = 0 To $gp - 1
If $gt > 0 Then
$gy[$13] = StringLeft($gy[$13], $gt)
EndIf
If $gu Then
$2x[$13][$w] = $gy[$13]
Else
$2x[$w][$13] = $gy[$13]
EndIf
Next
EndIf
Next
EndIf
Return(_1cs($gw))
EndFunc
Func _1co($gl, $gm, ByRef $gw)
If _1d1($gl, 2) Then Return SetError(@error, 0, 21)
Local $gq = DllCall($fx, "int:cdecl", "sqlite3_prepare16_v2", "ptr", $gl, "wstr", $gm, "int", -1, "ptr*", 0, "ptr*", 0)
If @error Then Return SetError(1, @error, 21)
If $gq[0] <> 0 Then
_1d6($gl, "_SQLite_Query", $gm)
Return SetError(-1, 0, $gq[0])
EndIf
$gw = $gq[4]
_1d2($g3, $gq[4])
Return $gq[0]
EndFunc
Func _1cp($gw, ByRef $h0, $e6 = False, $h1 = False, $gp = 0)
Dim $h0[1]
If _1d1($gw, 7, False) Then Return SetError(@error, 0, 21)
If $e6 = Default Then $e6 = False
If $h1 = Default Then $h1 = False
Local $gx = DllCall($fx, "int:cdecl", "sqlite3_step", "ptr", $gw)
If @error Then Return SetError(1, @error, 21)
If $gx[0] <> 100 Then
If $h1 = False And $gx[0] = 101 Then
_1cs($gw)
EndIf
Return SetError(-1, 0, $gx[0])
EndIf
If Not $gp Then
Local $h2 = DllCall($fx, "int:cdecl", "sqlite3_data_count", "ptr", $gw)
If @error Then Return SetError(2, @error, 21)
If $h2[0] <= 0 Then Return SetError(-1, 0, 101)
$gp = $h2[0]
EndIf
ReDim $h0[$gp]
For $w = 0 To $gp - 1
Local $h3 = DllCall($fx, "int:cdecl", "sqlite3_column_type", "ptr", $gw, "int", $w)
If @error Then Return SetError(4, @error, 21)
If $h3[0] = 5 Then
$h0[$w] = ""
ContinueLoop
EndIf
If(Not $e6) And($h3[0] <> 4) Then
Local $h4 = DllCall($fx, "wstr:cdecl", "sqlite3_column_text16", "ptr", $gw, "int", $w)
If @error Then Return SetError(3, @error, 21)
$h0[$w] = $h4[0]
Else
Local $h5 = DllCall($fx, "ptr:cdecl", "sqlite3_column_blob", "ptr", $gw, "int", $w)
If @error Then Return SetError(6, @error, 21)
Local $h6 = DllCall($fx, "int:cdecl", "sqlite3_column_bytes", "ptr", $gw, "int", $w)
If @error Then Return SetError(5, @error, 21)
Local $h7 = DllStructCreate("byte[" & $h6[0] & "]", $h5[0])
$h0[$w] = Binary(DllStructGetData($h7, 1))
EndIf
Next
Return 0
EndFunc
Func _1cq($gl = -1)
If _1d1($gl, 2) Then Return SetError(@error, 0, 21)
Local $gq = DllCall($fx, "int:cdecl", "sqlite3_close", "ptr", $gl)
If @error Then Return SetError(1, @error, 21)
If $gq[0] <> 0 Then
_1d6($gl, "_SQLite_Close")
Return SetError(-1, 0, $gq[0])
EndIf
$fy = 0
_1d3($g2, $gl)
Return $gq[0]
EndFunc
Func _1cs($gw)
If _1d1($gw, 2, False) Then Return SetError(@error, 0, 21)
Local $gj = DllCall($fx, "int:cdecl", "sqlite3_finalize", "ptr", $gw)
If @error Then Return SetError(1, @error, 21)
_1d3($g3, $gw)
If $gj[0] <> 0 Then SetError(-1)
Return $gj[0]
EndFunc
Func _1ct($gw)
If _1d1($gw, 2, False) Then Return SetError(@error, 0, 21)
Local $gj = DllCall($fx, "int:cdecl", "sqlite3_reset", "ptr", $gw)
If @error Then Return SetError(1, @error, 21)
If $gj[0] <> 0 Then SetError(-1)
Return $gj[0]
EndFunc
Func _1cu($gw, ByRef $h8)
Dim $h8[1]
If _1d1($gw, 3, False) Then Return SetError(@error, 0, 21)
Local $h9 = DllCall($fx, "int:cdecl", "sqlite3_column_count", "ptr", $gw)
If @error Then Return SetError(1, @error, 21)
If $h9[0] <= 0 Then Return SetError(-1, 0, 101)
ReDim $h8[$h9[0]]
Local $ha
For $hb = 0 To $h9[0] - 1
$ha = DllCall($fx, "wstr:cdecl", "sqlite3_column_name16", "ptr", $gw, "int", $hb)
If @error Then Return SetError(2, @error, 21)
$h8[$hb] = $ha[0]
Next
Return 0
EndFunc
Func _1d1(ByRef $hc, $hd, $he = True)
If $fx = 0 Then Return SetError(1, 21, 21)
If $hc = -1 Or $hc = "" Or $hc = Default Then
If Not $he Then Return SetError($hd, 0, 1)
$hc = $fy
EndIf
If Not $g1 Then Return 0
If $he Then
If _x($g2, $hc) > 0 Then Return 0
Else
If _x($g3, $hc) > 0 Then Return 0
EndIf
Return SetError($hd, 0, 1)
EndFunc
Func _1d2(ByRef $hf, $hc)
_e($hf, $hc)
EndFunc
Func _1d3(ByRef $hf, $hc)
Local $hg = _x($hf, $hc)
If $hg > 0 Then _k($hf, $hg)
EndFunc
Func _1d4($eu, $hh)
Local $gj = DllCall($eu, "str:cdecl", "sqlite3_libversion")
If @error Then Return 11
Local $hi = StringSplit($gj[0], ".")
Local $hj = 0
If $hi[0] = 4 Then $hj = $hi[4]
$hi =(($hi[1] * 1000 + $hi[2]) * 1000 + $hi[3]) * 100 + $hj
If $hh < 10000000 Then $hh = $hh * 100
If $hi >= $hh Then Return 0
Return 20
EndFunc
Func _1d6($gl, $hk, $hl = Default, $hm = Default, $hn = Default, $ho = @error, $hp = @extended)
If @Compiled Then Return SetError($ho, $hp)
If $hm = Default Then $hm = _1ck($gl)
If $hl = Default Then $hl = ""
Local $hq = "!   SQLite.au3 Error" & @CRLF
$hq &= "--> Function: " & $hk & @CRLF
If $hl <> "" Then $hq &= "--> Query:    " & $hl & @CRLF
$hq &= "--> Error:    " & $hm & @CRLF
_1dc($hq & @CRLF)
If Not($hn = Default) Then Return SetError($ho, $hp, $hn)
Return SetError($ho, $hp)
EndFunc
Func _1d8($hr, $ho = @error)
If $hr <> 0 Then DllCall($fx, "none:cdecl", "sqlite3_free", "ptr", $hr)
SetError($ho)
EndFunc
Func _1d9($4b)
Local $2x = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", 65001, "dword", 0, "wstr", $4b, "int", -1, "ptr", 0, "int", 0, "ptr", 0, "ptr", 0)
If @error Then Return SetError(1, @error, "")
Local $hs = DllStructCreate("char[" & $2x[0] & "]")
$2x = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", 65001, "dword", 0, "wstr", $4b, "int", -1, "struct*", $hs, "int", $2x[0], "ptr", 0, "ptr", 0)
If @error Then Return SetError(2, @error, "")
Return $hs
EndFunc
Func _1db($ht)
ConsoleWrite($ht)
EndFunc
Func _1dc($ht)
If IsFunc($g0) Then
If $fz Then
Local $hu = _1d9($ht)
$g0(DllStructGetData($hu, 1))
Else
$g0($ht)
EndIf
EndIf
EndFunc
Func __SQLite_Inline_Modified()
Return "20190228080113"
EndFunc
Func __SQLite_Inline_Version()
Return "302700200"
EndFunc
Global Const $hv = "handle hProc;ulong_ptr Size;ptr Mem"
Func _1dd(ByRef $hw)
Local $ev = DllStructGetData($hw, "Mem")
Local $hx = DllStructGetData($hw, "hProc")
Local $hy = _1dq($hx, $ev, 0, 0x00008000)
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hx)
If @error Then Return SetError(@error, @extended, False)
Return $hy
EndFunc
Func _1dj($4, $e1, ByRef $hw)
Local $2x = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $4, "dword*", 0)
If @error Then Return SetError(@error + 10, @extended, 0)
Local $hz = $2x[2]
If $hz = 0 Then Return SetError(1, 0, 0)
Local $5y = BitOR(0x00000008, 0x00000010, 0x00000020)
Local $hx = _1dr($5y, False, $hz, True)
Local $i0 = BitOR(0x00002000, 0x00001000)
Local $ev = _1do($hx, 0, $e1, $i0, 0x00000004)
If $ev = 0 Then Return SetError(2, 0, 0)
$hw = DllStructCreate($hv)
DllStructSetData($hw, "hProc", $hx)
DllStructSetData($hw, "Size", $e1)
DllStructSetData($hw, "Mem", $ev)
Return $ev
EndFunc
Func _1dl(ByRef $hw, $i1, $i2, $e1)
Local $2x = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", DllStructGetData($hw, "hProc"), "ptr", $i1, "struct*", $i2, "ulong_ptr", $e1, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _1dm(ByRef $hw, $i1, $i2 = 0, $e1 = 0, $i3 = "struct*")
If $i2 = 0 Then $i2 = DllStructGetData($hw, "Mem")
If $e1 = 0 Then $e1 = DllStructGetData($hw, "Size")
Local $2x = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($hw, "hProc"), "ptr", $i2, $i3, $i1, "ulong_ptr", $e1, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _1do($hx, $35, $e1, $i4, $i5)
Local $2x = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $hx, "ptr", $35, "ulong_ptr", $e1, "dword", $i4, "dword", $i5)
If @error Then Return SetError(@error, @extended, 0)
Return $2x[0]
EndFunc
Func _1dq($hx, $35, $e1, $i6)
Local $2x = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $hx, "ptr", $35, "ulong_ptr", $e1, "dword", $i6)
If @error Then Return SetError(@error, @extended, False)
Return $2x[0]
EndFunc
Func _1dr($5y, $i7, $54, $i8 = False)
Local $2x = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $5y, "bool", $i7, "dword", $54)
If @error Then Return SetError(@error, @extended, 0)
If $2x[0] Then Return $2x[0]
If Not $i8 Then Return SetError(100, 0, 0)
Local $5o = _uc(BitOR(0x00000020, 0x00000008))
If @error Then Return SetError(@error + 10, @extended, 0)
_ud($5o, "SeDebugPrivilege", True)
Local $7p = @error
Local $i9 = @extended
Local $1l = 0
If Not @error Then
$2x = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $5y, "bool", $i7, "dword", $54)
$7p = @error
$i9 = @extended
If $2x[0] Then $1l = $2x[0]
_ud($5o, "SeDebugPrivilege", False)
If @error Then
$7p = @error + 20
$i9 = @extended
EndIf
Else
$7p = @error + 30
EndIf
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $5o)
Return SetError($7p, $i9, $1l)
EndFunc
Global $ia
Global $ib[1][11]
Func _1fl($4)
If _1gw($4) = 0 Then Return True
Local $ic = 0
If IsHWnd($4) Then
$ic = _2m($4)
Else
$ic = $4
$4 = GUICtrlGetHandle($4)
EndIf
If $ic < 10000 Then
Local $id = 0
For $8 = _1gw($4) - 1 To 0 Step -1
$id = _1h5($4, $8)
If GUICtrlGetState($id) > 0 And GUICtrlGetHandle($id) = 0 Then
GUICtrlDelete($id)
EndIf
Next
If _1gw($4) = 0 Then Return True
EndIf
Return _o7($4, $1t) <> 0
EndFunc
Func _1gv($4, $8)
Local $ie = _1i1($4)
Local $if = DllStructCreate($2q)
Local $e1 = DllStructGetSize($if)
If @error Then Return SetError(-1, -1, False)
DllStructSetData($if, "Mask", 0x00000008)
DllStructSetData($if, "Item", $8)
DllStructSetData($if, "StateMask", 0xffff)
Local $1l
If IsHWnd($4) Then
If _ot($4, $ia) Then
$1l = _o7($4, $1v, 0, $if, 0, "wparam", "struct*") <> 0
Else
Local $hw
Local $ev = _1dj($4, $e1, $hw)
_1dm($hw, $if)
If $ie Then
$1l = _o7($4, $1v, 0, $ev, 0, "wparam", "ptr") <> 0
Else
$1l = _o7($4, $1u, 0, $ev, 0, "wparam", "ptr") <> 0
EndIf
_1dl($hw, $ev, $if, $e1)
_1dd($hw)
EndIf
Else
Local $d = DllStructGetPtr($if)
If $ie Then
$1l = GUICtrlSendMsg($4, $1v, 0, $d) <> 0
Else
$1l = GUICtrlSendMsg($4, $1u, 0, $d) <> 0
EndIf
EndIf
If Not $1l Then Return SetError(-1, -1, False)
Return BitAND(DllStructGetData($if, "State"), 0x2000) <> 0
EndFunc
Func _1gw($4)
If IsHWnd($4) Then
Return _o7($4, $1w)
Else
Return GUICtrlSendMsg($4, $1w, 0, 0)
EndIf
EndFunc
Func _1gz($4, ByRef $c)
Local $ie = _1i1($4)
Local $1l
If IsHWnd($4) Then
If _ot($4, $ia) Then
$1l = _o7($4, $1v, 0, $c, 0, "wparam", "struct*")
Else
Local $ig = DllStructGetSize($c)
Local $hw
Local $ev = _1dj($4, $ig, $hw)
_1dm($hw, $c)
If $ie Then
_o7($4, $1v, 0, $ev, 0, "wparam", "ptr")
Else
_o7($4, $1u, 0, $ev, 0, "wparam", "ptr")
EndIf
_1dl($hw, $ev, $c, $ig)
_1dd($hw)
EndIf
Else
Local $d = DllStructGetPtr($c)
If $ie Then
$1l = GUICtrlSendMsg($4, $1v, 0, $d)
Else
$1l = GUICtrlSendMsg($4, $1u, 0, $d)
EndIf
EndIf
Return $1l <> 0
EndFunc
Func _1h5($4, $8)
Local $c = DllStructCreate($2q)
DllStructSetData($c, "Mask", 0x00000004)
DllStructSetData($c, "Item", $8)
_1gz($4, $c)
Return DllStructGetData($c, "Param")
EndFunc
Func _1hh($4, $8, $9 = 0)
Local $ie = _1i1($4)
Local $a
If $ie Then
$a = DllStructCreate("wchar Text[4096]")
Else
$a = DllStructCreate("char Text[4096]")
EndIf
Local $b = DllStructGetPtr($a)
Local $c = DllStructCreate($2q)
DllStructSetData($c, "SubItem", $9)
DllStructSetData($c, "TextMax", 4096)
If IsHWnd($4) Then
If _ot($4, $ia) Then
DllStructSetData($c, "Text", $b)
_o7($4, $1y, $8, $c, 0, "wparam", "struct*")
Else
Local $ig = DllStructGetSize($c)
Local $hw
Local $ev = _1dj($4, $ig + 4096, $hw)
Local $ih = $ev + $ig
DllStructSetData($c, "Text", $ih)
_1dm($hw, $c, $ev, $ig)
If $ie Then
_o7($4, $1y, $8, $ev, 0, "wparam", "ptr")
Else
_o7($4, $1x, $8, $ev, 0, "wparam", "ptr")
EndIf
_1dl($hw, $ih, $a, 4096)
_1dd($hw)
EndIf
Else
Local $d = DllStructGetPtr($c)
DllStructSetData($c, "Text", $b)
If $ie Then
GUICtrlSendMsg($4, $1y, $8, $d)
Else
GUICtrlSendMsg($4, $1x, $8, $d)
EndIf
EndIf
Return DllStructGetData($a, "Text")
EndFunc
Func _1i1($4)
If IsHWnd($4) Then
Return _o7($4, $1z) <> 0
Else
Return GUICtrlSendMsg($4, $1z, 0, 0) <> 0
EndIf
EndFunc
Func _1iz($4, $ii, $3m)
If IsHWnd($4) Then
Return _o7($4, $20, $ii, $3m)
Else
Return GUICtrlSendMsg($4, $20, $ii, $3m)
EndIf
EndFunc
Func _1jb($4, $8, $ij = True)
Local $ie = _1i1($4)
Local $ev, $hw, $1l
Local $c = DllStructCreate($2q)
Local $d = DllStructGetPtr($c)
Local $ig = DllStructGetSize($c)
If @error Then Return SetError(-1, -1, -1)
If $8 <> -1 Then
DllStructSetData($c, "Mask", 0x00000008)
DllStructSetData($c, "Item", $8)
If($ij) Then
DllStructSetData($c, "State", 0x2000)
Else
DllStructSetData($c, "State", 0x1000)
EndIf
DllStructSetData($c, "StateMask", 0xf000)
If IsHWnd($4) Then
If _ot($4, $ia) Then
Return _o7($4, $22, 0, $c, 0, "wparam", "struct*") <> 0
Else
$ev = _1dj($4, $ig, $hw)
_1dm($hw, $c)
If $ie Then
$1l = _o7($4, $22, 0, $ev, 0, "wparam", "ptr")
Else
$1l = _o7($4, $21, 0, $ev, 0, "wparam", "ptr")
EndIf
_1dd($hw)
Return $1l <> 0
EndIf
Else
If $ie Then
Return GUICtrlSendMsg($4, $22, 0, $d) <> 0
Else
Return GUICtrlSendMsg($4, $21, 0, $d) <> 0
EndIf
EndIf
Else
For $ik = 0 To _1gw($4) - 1
DllStructSetData($c, "Mask", 0x00000008)
DllStructSetData($c, "Item", $ik)
If($ij) Then
DllStructSetData($c, "State", 0x2000)
Else
DllStructSetData($c, "State", 0x1000)
EndIf
DllStructSetData($c, "StateMask", 0xf000)
If IsHWnd($4) Then
If _ot($4, $ia) Then
If Not _o7($4, $22, 0, $c, 0, "wparam", "struct*") <> 0 Then Return SetError(-1, -1, -1)
Else
$ev = _1dj($4, $ig, $hw)
_1dm($hw, $c)
If $ie Then
$1l = _o7($4, $22, 0, $ev, 0, "wparam", "ptr")
Else
$1l = _o7($4, $21, 0, $ev, 0, "wparam", "ptr")
EndIf
_1dd($hw)
If Not $1l <> 0 Then Return SetError(-1, -1, -1)
EndIf
Else
If $ie Then
If Not GUICtrlSendMsg($4, $22, 0, $d) <> 0 Then Return SetError(-1, -1, -1)
Else
If Not GUICtrlSendMsg($4, $21, 0, $d) <> 0 Then Return SetError(-1, -1, -1)
EndIf
EndIf
Next
Return True
EndIf
Return False
EndFunc
#Au3Stripper_Ignore_Funcs=__GUICtrlListView_Sort
Func __GUICtrlListView_Sort($2, $3, $4)
Local $8, $5, $6, $7
For $ik = 1 To $ib[0][0]
If $4 = $ib[$ik][1] Then
$8 = $ik
ExitLoop
EndIf
Next
If $ib[$8][3] = $ib[$8][4] Then
If Not $ib[$8][7] Then
$ib[$8][5] *= -1
$ib[$8][7] = 1
EndIf
Else
$ib[$8][7] = 1
EndIf
$ib[$8][6] = $ib[$8][3]
$5 = _1hh($4, $2, $ib[$8][3])
$6 = _1hh($4, $3, $ib[$8][3])
If $ib[$8][8] = 1 Then
If(StringIsFloat($5) Or StringIsInt($5)) Then $5 = Number($5)
If(StringIsFloat($6) Or StringIsInt($6)) Then $6 = Number($6)
EndIf
If $ib[$8][8] < 2 Then
$7 = 0
If $5 < $6 Then
$7 = -1
ElseIf $5 > $6 Then
$7 = 1
EndIf
Else
$7 = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $5, 'wstr', $6)[0]
EndIf
$7 = $7 * $ib[$8][5]
Return $7
EndFunc
Global Const $il = DllOpen("kernel32.dll")
Global Const $im = DllOpen("oleaut32.dll")
Global Const $in = DllOpen("ole32.dll")
Global Const $io = "word vt;word r1;word r2;word r3;ptr data; ptr"
Global Const $ip = DllStructGetSize(DllStructCreate($io, 1))
Global Const $iq = DllStructGetSize(DllStructCreate('ptr', 1))
Global $ir = -1, $is = 0
DllCall($in, 'long', 'OleInitialize', 'ptr', 0)
OnAutoItExitRegister("_1k6")
Func _1k6()
DllCall($in, 'long', 'OleUninitialize')
_1lw(True)
EndFunc
Func _1lw($it = False)
If $is <= 0 Then Return 0
$is -= 1
If $it Then $is = 0
If $is = 0 Then DllCall($ir, "ptr", "Initialize", "ptr", 0, "ptr", 0)
Return $is
EndFunc
_14z()
_2f("RolloutAssistant")
Global $iu = '\\sjkfs13\pacotes$\Rollout Assistant\Binaries\dataBase.db'
Global $iv = StringTrimRight(_1rz(), 1)
Global $iw = @UserName
Global $ix, $go, $gp
Global $iy, $iz, $j0
Func _1rs($j1 = False, $j2 = @TempDir)
Local $j3
$j3 &= 'iVBORw0KGgoAAAANSUhEUgAABREAAAEWCAYAAADxSNC0AABc4UlEQVR42u29idckRZ3v/fwJdY5z752ZOzOmOtje61YyDjKjM1M64y5Yd1xB1FQZFHEpN2TVBGRfCkT2JVkFeqHYupum6U7ojU1IdgHR1PHyep2rb77zF8Qb9XRWd/XTVZVbZGZE5Od7zveox36qsn6xf/IXEUtCiCWMMcbmGSGE8uh1/3pNT9qV9qRH0oF0KC1yOkg8Sj5rkHy2Q5SziTEMY4wxxkauQQkCxhgDERFC1gFDJwGGfkFQWMZB8r3LcJHSACJijDHGGIiIMcYYiIgQ0gccdqWHDUDDrGBxSLYiEBFjjDHGQESMMcZARIRQMxmHYzgXaQgO9zMlBkTEGGOMMRARY4wxEBEhVB887CfZfcIkU3JARIwxxhgDETHGGAMREULVw0PXlKxDICIQEWOMMcZARIwxxkBEhBDwEIgIRMQYY4wxEBFjjDEQESGkATzsmrhtGYgIRMQYY4wxEBFjjDEQESFUD0D0bIGHkxuaKVUgIsYYY4yBiBhjjIGICCF12YehZQARiAhExBhjjDEQEWOMMRARIaQIII7PPowtBIhARCAixhhjjIGIGGOMgYgIIQUA0bcUHgIRgYgYY4wxBiJijDEGIiKESsLDjk2XpwARgYgYY4wxBiJijDEGIiKE1APEsAUAcWyPEgciYowxxhiIiDHGGIiIEAIgAhGBiBhjjDEGImKMMQYiIoQAiEBEICLGGGOMgYgYY4yBiAihOiDiqGUAEYgIRMQYY4wxEBFjjDEQESGUAyAOWwgQxx5Q+kBEjDHGGAMRMcYYAxERQukAsd9SgDh2jxoARMQYY4wxEBFjjDEQESG0GCA60jEQETGGYYwxxhiIiDHGGIiIEJoHEYMWA0QgIhARY4wxxkBEjDHGQESEUApAHLQcIAIRgYgYY4wxBiJijDEGIiKE2Mac6i61AYiIMcYYYyAixhhjICJCaDZE'
$j3 &= '9AGI19BpARExxhhjDETEGGMMREQIzQGIPQAiEBGIiDHGGGMgIsYYYyAiQmgRRAwAiEBEICLGGGOMgYgYY4yBiAghshCBiEBEjDHGGAMRMcYYmwkRk8scXOnR2CzbESILsUHH1AggIsYYY4yBiBhjjDWAiHKR3pHuSw+loxUL+IBlO0K1AsQu4JA+CIiIMcYYYyAixhhjLSBiAioGGTKeWMAjVC9E5EZm+iAgIsYYY4w5UgshhFBjYGKyRXkMKGIW8Ahp2U47QEP6ICAixhhjjIGICCGE6gYSvWSLcsgCHiEj2uwAaEgfBETEGGOMMRARIYRQ1QBiskV5xAIeISPbcGghBIySYxNmOcvf+9QMICLGGGOMgYgIIYTKAYfJhSj+jAtRgIgImdWeHUugYZi8zOjl/O3jzGlvRn/mUTuAiBhjjDEGIiKEEMoPGrrJQjtkKyFCVrVtz3B4OIZ/jmKo6uaBkUBEjDHGGGMgIkIItRksTBbSo5wXogARETKrrZu6lTlQCQ8REBFjjDHGQESEEELZYUI/uRAl4lIDhFrzssBEgDik9ICIGGOMMcZARIQQqg8gTC5ECbgZFaFW9gGugQDRpeSAiBhjjDHGQESEEKoPHgS6b1WklBCqvB8YGQYQB5QaEBFjjDHGGIiIEEJARCAiQvX2A7FBAHFEiQERMcYYY4yBiAghBEQEIiJUbx/QNQggjmFnh1IDImKMMcYYAxERQgiICEREqN4+wOUcRARExBhjjDEQESGEEBARIbSoDxgaAhAjSguIiDHGGGMMREQIISAiEBEh+gCyEIGIGGOMMcZARIQQAiAAERHSsA/gLEQERMQYY4wxEBEhhBAQESE0t/07hkBEn9ICImKMMcYYAxERQgiICEREqJn23zMEIvYpLSAixhhjjDEQESGEgIhARISaaf8DQyAiW5mBiBhjjDHGQESEEAIiAhERaqj9ewYAxJCSAiJijDHGGAMREUIIiAhERKi59j/iPEQE'
$j3 &= 'RMQYY4wxEBEhhBAQESFkcvsf26OkgIgYY4wxxkBEhBACIgAREaL9L3KPkgIiYowxxhgDERFCCIgARESoufYfAxEREBFjjDHGQESEEEJARITQovZvws3MXUoKiIgxxhhjDERECCEgIhARISDiXFNKQESMMcYYYyAiQggBEYGICAERgYhARIwxxhhjICJCCAERgYgIARGBiEBEjDHGGGMgIkIIARGBiAgBEYGIQESMMcYYYyAiQggBEYGICAERgYiIRQjGGGOMgYgIIZ0XuV3pXl4TOSAiQgiIiJTVFafIWMyYjBBCvATCGIiIEFK5MOkki4yB9DCBWqHCRWicfObYXvI94+9ziD4QESmtS2Pg30/a2XCq3UUl2qyffF4fEAFERJWOwe6MthtXUKbzxuQOpYFqmmPmmfdEyb8fJfV13E66RBYhreaek/FrVGDeOekThoxHCCGkd2c/SDr6qOEFajw1cLhtBItARFSyHfuKoX8Wh8n3DljMlS5HIGI7YYqvad8fTcGaHqWGCtZzN6njVc8xA+oqQrW38V7S7oIaxiM/6U+Aiggh1OCELjZg0Roni5hWAAogIspYT5wp+B9r2GaZ6AER0b5lOw36IxPKegGoGbB7AGUYn0INxqE+JYKQ8jbe12AdGSb9DPNMhBCqsMN3E+AgDHek48QweRMncGXu0Ya1WJgV8cj2hZwB8N9Ee5ZAw5EhL+zKLOIAimbMC8KWzjOjJFOKemreuBUQQz3myskcdKjpeDZinWDmupSSQkhf6OBbvIDR5k0zEBGIWFG9mmQOh5a016GNCzkgIhAxqQd9CzINy2Qousy89uu/rV6wJb9xYFCd94GJQESLY+hW8Bt7Bs1xQsYhICJCqB0dvso3zY0BCiAiELGCFwBDi18AWLWQAyK2FyJqsq1Lt7GYLWZ764e1C7aknGODx6BOy+smENG+GHoKf5vJa8mw7ZmJQESzFny9FTdhcg4HAh62JK0diAhEVDiW+C0q'
$j3 &= 'VytgIv1uuyBi0t8DDtMzjwfMy+wbS5O1TkQdZdwCIi6v960aNy2bh47amnkMRNS7cDoJMIzqPncEoRkd/ohFS3OTDyAiEJFJWykPTc4KASLaDxEN3LapU2Ziv8XzM2vG0mScsrGvC9oIGoCISmLo2RQvw7OLF70scIGIQESd4OGiRtZdQqi+AYxsiDmLFzprIKIh4wllvLsf6xtajkBESyEigB9QYxlEdAv+DtfyuWbrQAMQEYjYghcEK7MSOy1q30BEw+Ch8TcKImPqY9eSyxYq3SpJZw1E1LgN27IlrPUTPSCifRCR40EANZZCRC/n83dattPFb1HdBCLaBxGjAr/B9hcEK89K7LakfQMRNSmILOm9ETcCIY3qI67xrBsgIhCRRZly2NAzqEyBTZZAROAhl1pY3jd4OZ69rS+rgzbUTyCilRBR5Hz+YUvnl90WtG8gogYFEAEPkUbwgW1V2d2lswYiajim8AJAwxcBQEQgIuVYe0aIA6jRE8owVi3Xzw51E4hoI0RM1pNtH+9cy9s3ELGhwGe5qCIGHqKaASLbl3O8aaKzBiJq1oaHlKOd28uYjFsDERljyQhpPURMtjdSPy0HiUBEJTHsmzZfZj3ZDpAIRGzurUKcMunx2nQ4J2q8TnY5Oy3/uWp01kBEjV4AAJksXsxRvtZAREA/INH2viECIAISgYhWz/17AEQubgQi1g9q0hrWEHiIGqiXbH/UfBskEJFBnhcA7V3MARGtgYj044BE6/sGAKLeL6UZt4CIVax/AIjtGn+AiPUFOu1Mg6Att/kgACLnIbL4BCLSfgGJQMSWXqxCm2UhZ3vf0AEg5vaQuglENGTu7wEQC40/HcvaNxCx4gA7KY1qXKn64CzUQN3skMFkxnmIQEQgIguydoNEIKJVEJGb0wGJKuuTr/t4yguvdp6fBkS0du4/ZI5iX10DIuq3yIvZuow0BYi8MTJo6wkQEYgIQGzvZI8JulUQkfbLSwKV9cnT'
$j3 &= 'eTxN5psAxOyQ2wEiAnY0n/sHBrzIYN7ButQ8iJgMmIsaVGTrIZuIN9echwhEBCICICyxr1G5AxHtgYgOsecMOssh4mDq+Xhh3dJsJSCi/RCROan+x2EBEc0JaNrlKWQfoqbr6IAO3LwBAIgIRGSy1o4XBkBE+zMCACu0bcshoqfxs1E3GbdMgogdXY90Sl6IkWVcIBseiAhEnLXAixekqPeWEGoectPhG3YeIhARiEjbbfdbYyCidRBxSPw5H9FiiDhMxizqWYu3NQMRlcVRSzDDvKTd25qBiPVMCEdkHyIGdLZBARGBiABEIx01PYbTd1sHEenPAQg2Q8T4dVzcZ81xGkBEIOKcs2Vppy1+UQBELB/Azuvm3LT35s/cYE1KOrICILKN2eBtJiw62wkRuQSJM9SAiHZmAvBigK2jFkNE3KKzmoGIrYSIuOUvCoCIFS3u3vP1deLYqx5yQVdIo7rKgsXgrY1AxNZCxBFlo437LMaAiLRtKzNCOgbP74CIZMoCEYGI2Ew7BrdvIGLBwM3dXvaFs7aIO594hQxExCST8xCBiEBE2i2wAYgIRJxVplyURF2gHmFrsxGBiEBEbG82IhBRMUD0bvqZeOS3/2n8ORaILESs15ZGIGK7JuocSs+ED4hoPUR0KAPOp2JugHU+SgOICETEZCMCEdW98YtnnX+4+uHfABARWYicncRCAYioAvxzKD11BYhoefYZ551SH5gbYIshAxARiIjTPWTssRwiztsyMD7/MHjpD2OAGIKskIaNnCxEw89DZKHQOog4NDyWUbJ4GCUvMSYOEpveJwUN1Akgop0QcUg5cFwBcwNsKWQAIgIRMWNPuyHiPIA4Pv9QwsNlgCht7MHMyFqA6FrSuQYLXFfGVkxnDUSknOdCw2GeGCbZlv3k70zMuuzXXC+AiHZCxJ4mwD9YAfwXeWTJywCtdhswN8C6zj+BiI3HkYx1++0y9lgIEeeBmHPXPT0BiLF0oQyl79we'
$j3 &= 'OqAuVGHdNfH2x/EzD/JCnQRK9JK/HVYweQnorIGINZSzSUDNV5Wdm9Rvk0BZxGIMiKiobOuAcWHSXr2krTmKnn0y7nqWLHQjA+d5zA2ADEBEuyEi47/9Dhl7LIOIswDi+PzD64KXJwBx7NwZCYO1j3e/ve6J8LujUBx755PxcXc9FZxwz9PDkzY84/7g3me6SwipmdyblG3oVXHuS3JBxUABUPXorIGIFZexZxDodyqs5wGLOhYRLYKIVbzsC6aAYafG3+Ik423EWMDcALf7ghUgIuM/tvfsUyBiToA4Pv8wuUBl4tyT0G+sfnwwWPO4kBBRjCHi9+98UkiIKCREFBIiih/e+4w45b5nxWmbnwtP3/K8f2bw/ODsB1/onbPtBbZLo1L1V2MgUecip+gWyh6dNRCx4sV3bADs79cUjwGLDxYRLYGIKsbqKMk07OtytlLyu0yEib5hcz3mBu1xx7C6CURk/MeWHqcBRFycvTTvApWJc3U8X73lsc7Xbv1ZICGiyAQR739enLH1eXHWAz8XEiKKc7e/KM7f8WI03PXS6MKHXjKKViNrshusmqwn7dzPAm/orIGIFZevr/tWi7oXMEn7jKk3LCIsh4hOybNIu5rPRTzD6oVR588xN2BLM/ALiIjZ0szYo8H6fdbCZXyBygqAGOe5SOXLNz3aP/qnj8XH3PozUQoi7nxRSIgoJEQkKxGl1eMYgJg7ayLQdZKRLDQ9BdY9MyRS9Dvz2mmwbLsGnH3YaTA2Ovdloxr7JxX13JSzNuto8z2Nxp8wZ3z6hs1HTHgh0NjFSUDEQpftjVa0Z7/my/bIkgUiEsfqXloHyUuy6TYetCAWHcYeQyHirC1lUzcwFzoH8agbHx1KiCgkRBSKIKJxh28ioMQMUNTROHa+jhkrLZmMBC1srwGLFqMBhGNQXSMrWM9yGWZ8udIx+DeaBBJ9g+LaBogYJEdcOBlj0pk6usamW8RNy5IFIgIR82TV93KOJ4PX'
$j3 &= '2XdztcvYYyBETAadfSrj1y7aNgsgZso8+OJ1DztHXv9w+G83PioUQ8QhmAyl1GWXTlLJCwXftkUtEJFB2MStFcmCkG2xQMS29QORibeyWgASI8YQbbKSHQUxMvV8zlnuGlQ3gYhAxLSXA31F44pvS5/H2GMmRNynkZ677ulZADHTNubPX/tQT0LEWEJEoRoiXrDzRaO2saBGGrbu29ZMStd2LKsbQES9ymOk8ZvhjmaxGgIcgIgW9wWxrfBwxe8cAGuAiBku3HMqiJVnQWwGBrV1ICIQcd78sl9RX2j6ywJeYJkGEVcS7DkAMdM25s9evcuTEFFIiCgqgoich4hMHnDYjk/dACIulbpQoZUL6GS3QES8gIgWv1CITbuhseBvDYE1QMQ55x32K46XaedzNnIOLxCROJp4xnYyTzQ9K9Fh7DEEIq7c+rkAIC7saA67fEfnM1fuHEmIKCqDiDtebD2A2fnk/+xL+9LxziffGEi7oCGjBpyAEqJuUD+0vpHZ0zhmuh7VMDSkzgER9Z6Qd1ryW/smLHYNiqctlyk4NcXLMfgstdigeglEBCI2cpSV4SCxb0j7bjdEXHkBxQKAOPbcwe1Tl+3ofvryHaGEiKJiiOgttVB7weEbx+BQTHtHuOxYerg9fGN3CS0xYCMgovbl0GErReHYRcQNiIiM7wN133bGMQX1AsROzTEzOSPRMaReAhGBiI2dhW8wSPQMad/thYgrt0alAMS5byQ/ccm23icv2xFLiCiqhojn7XixNZNrCQi70vuBwwQa7vH2ffwmsS18UyjtPvjEm1q77ZsBGwERtS+HAQCncOx0zUbsMjYAEVHmujg0oC52DIklANHiRbCpfSQQEYjY9GWahmYcB4a071ZDxFFGgDg3C/FfL37Q/fhPtgkJEUUdELEF4NCR9qSjHNBwH0t4OHEs7Uu3LjuRm5IQEFH7coiIfan4xbw9BiIio/vAHnWx9RAxbjqrztDLVjxD6iUQEYg4'
$j3 &= 'aDh2joEZxxFjuMbMYToL5AtnbUkDiDOzED960QO+hIiiRoho7eJawkK5XfmNo5LQcIbfLB54fNlR8PibB9JtOW+I8x4QEFHfMuiyYC4dQx2zmELGBiAiylwXOyyAWw8Re5rEz7QbXX1D6iUQsd0QcaRJ/Ix7UQBE1DSW0+dgZACI+2UhfviCrZ1DhsFIQkRRM0Q04s1TVklA6Eh70lEF0HCPgxXe+rM3+9JWL1JM2L7CEorJSIshos+bT2tBbIexAYiIrKmPXJjUgmw6jY/IMH27IxCxvRAx0mU+tPL4OuZBQMQyP3p5f/whx96VBSDu87bng+dt6Xz4/K2hhIiiboh4zrYXrJhYS1DYk/ZrhIYz/Bax5bG3RNKetMPEnO0YQEQmdDWWgY5bK1ziaH+WNZNnpFl9DBmPWgkRIw1jaBJkiA2pl0DE9kLEvmYxHBA/IGLZH7yc0vqer68TwUt/yAIR90xm33/O/d0PnrslkhBRNAERTZ8sSkjoSocNQsOZvl9686NvGUlbs8WWw3YREFHb+PfJoFMWyxGZS0BExHjE2VQABgUxNCobkfYNRCSmuWLYMexsRA+IqFFfOdn+9ObP3CDueep3WQDinsnD+86+vyshYiwhomgGIv58tGSgJCjsSHvSkU7QMAGHsxxLD+975K0OEJFFN4s2Jh8VxF/Hs/xGhsZyQP0FIiLGI2ANgEERZDApjl3aNxCRupkrjj4QEYhY9Mcub5u4Lng5C0Ace/lA5X8+477ue8/aHEuIKJqAiGcGz48kSDQqS0QCQ0cCQ09CwlhzaJj4rUKCw5V2gYj1nZFowoSIRRsTOgXx13HLlGtoLHtAByAiahS69BL3k50+0w4y2ITMkI4BZUEWopo4jgyKY8+AeglEbB9EDDSOY584AhGL/NDljAXvpp9lBYhjd999+n3ue864T0iIKGqHiJufi0/f8rxRW2wlJHSk/WzA8E37AcOGoeEeb3rkrUZf/GHwTV5DE7dV'
$j3 &= 'UjeAiBljz2Ug7Vg8d4kXENEiSOgmUHCUjB+RofMLm2ENZyGqiaMLjAUiEkd7+0uDtjQDEXWAiPIDnHGl+dQPN+YBiNE/nbbJ7f1ok2gCInqbng0kRHRMg4cGQ8Nl37vbsbTRWXGGvU3d78DoZMECTAQi2hZ7Hbffmv7ChEtqgIhIzWJgkLzIC1oGCYGI9XlgADhnuyMQkThaeoasQevj0JB5g/UQ0T/4yFuzXqSy7Ivufyn+x1M3iSYg4g/ufUb7gWEiCQYdad9waLjS7pLhmlwgZLjj5PwKZwkBEe2IvY6TF5/63J7FHdAGJS/W3QQYhkBCKzK+OCtNXSwjICIQkTjaeca9Sbc0AxEbjuPkB65++DeZAeLFW34h3uXdKxqAiNFJ6582IgNuHjw0Eho+vNsbd9vICwZMbdh5BnlucgYiWhD7mMyQVtRnnc8EAiK2r8/vJGdB+S3citwWWGPEi2FD2otPvQQiEkdrX7j0gIhAxMwN79irHsoFEP9ebntuACKOjr/nae23b0pQ2JH2LIKGYsNDexxJW7OF1tLJfJxkTzgsDYGIhsW9C7CpJK463nYdMS4AERsuZyfJuGBrMhCRsT1fLD2yvoCIxLGQHUPaOBARiJj649z3fH1dZoD44/t/IQ4+eUPtEPHYO57UPhNEwsGOtCcdWwQNV9qq24ENPxcx643OA85OBCIaEnddt1B0DI+rx+QPiIj2ZBy6bFEGIgK97F8YA7+II/OewvGMiCcQMbWS3PPU7zIBxAvvf0n87Ynr64aI0XduD7UHVxIUutKRCmh4vwJouEkdNJy2t2SZDLtlrqxHye8FKAIRdY27rlukAsMd8UYeiNjyPr1n0BZMIGJ727VnSHtygIhAROJo53EFQFkgYiaAknUb8xXbfiUOPGF93RAx+Na6J7QGHhIQ9qTDdGD45pJZhm8pcwlKUWi4x+sfequt0KLT0gm/b8K5HAyerYOIZAdxoyuwAYiocnx3OeMQ+AVE'
$j3 &= 'bG08gV/EkTgWi+fQkDbe0TyOdkLEd375tigLQFwbviIO/sHGmiHiz7QeSCUsdKRHFkPDacfrLToHcUYDb3N2QpRsdSQ7EYjIogRzwDgQ0RZ46Gl6SRMQkXZtRbsGIgK/iKPVENGjzwQizvtR7nXBy6kAcc0Tr4iDTt4o3nLc3TVBxEfjY259TNsMKQkHO9Ke3dCwK+7ZtY+tXqxofJlDE9mJ3SUERKQd4haDBybOwEMMRKRdA22II3EEItJnAhFX6F9PXJ+ahRi8/EcJDTeINx17d10QMfrKzY9qCzEkKOxLRy2Ahnt8987ucKkF4nbG/c5/a/UCFYjIQIuBiEycjeo/XOAhbZl2zTwJ+EUciaOSePbpM4GIMydbaZepjAHiB87aIt743bvqgYg3PBJIiKjllkp5AYojoWHQEmg47bBFCxCyoICJQETeemJuIgU2mPfygbNUgYi0a+ZJwC/iSBzb92IfiFgnRPzqhQ+mZiF+9IIHxf/8zp21QMQvXfewr2vhS0jotQga7vFdO7uxtNOyxQg3N86Hid2W1QUgYv0xH9LW2te3ABuAiAXLqEOfAUSkXTNPAn4RR+IIRCSONUDEw0/dlJqF+MWrHharvnVnLRDxC/5DA03hYU86qhMabiwIDVdcglIEGM6y29JFCduhFmQNteUCFiAiMcdARCbO2vYVXW5cBiLSrhmzgV/EkTgCEYljTRDx2KseChYBxHM2viD++pt3VA4Rj7hqV/y5a3ZpB6okLOxI+5VCQ7U3JyuBhnfua3+ppTLoDIimHOt6oyoQkZhjICKwwfq+eUC7ASLSrhmzgV/EkTgCv4CINUFE+Y+cRTcy+zt/LV7z9dsrh4iHX7EjPuKqndptj5RgsC8dtxAa7vEdO7qRdCuyzRa0E7Y1p3tkc1YiEJEFHgYiMnHWqkw6jM1ARNo18yTgF3EkjsAvIGLNEFHeyDyYBxC3/uKP4n9IaFgDRAwlRNQKIEpA2JEetRQarnSr'
$j3 &= 'zr5bsFjhoPZsWYk9S+sAEJEFHgYiMnFmTMZARNo10IY4EkcgIn1meyGihIXhPIj4Lm+TePUx66qFiJduDz912Q6tspemsw9bCg2l3yZG25c9WEKTRu9wPqI9iwcgIhARU4+BDUb2C10AIvMA2jXzJOAXcSSOwC8gYgMQUYLCzjyAeNS1j4q/OHpt1RAx/MSl27UBiBIMdqRHLYeGe3z79reNQIczFy+AxGz2bdreDERsBNrTjoCIwAYgImMwEJF2zTwJ+EUciSPwC4ioCUTszwKIF93/C/FnX1lTKUT8Xxc/qNVFHRIS9qSjlkPDiUfSrnSrz0FkEaPEoS0gEYjIIIuBiEycG3+xwNgLRKRdM08CfhFH4si8HIjYIET0Zp2D+JpvjKqGiFoARPl7u+MYBE8dE5oGDfMBw+4iYDhxJD2QdsCEgERAIhCRQRZTj4ENGsWfMxCBiLRr5knAL+JIHJmXAxE1gIjBSoj47h/dL/7rUWsqg4gn3v70+HvcBqHh+CKZkXS861ePi/uf+FhboeHEvrTV2QuAREAiEBGIiIGIwAaj+wMAIhCRds08CfhFHIkj83Igom4Q8fg1T4s/+bfVlUHEE9Y9NQ0sY2k/2VKtHC7Iz3SSz/aS3xlP/9ZtL1wtNj32zjZCw+msQ7Yrl+8IHBY37QCJQEQGWQxEZOLcSOx92gUQkXbNPAn4RRyJI/NyIKIeEHEPVLvrmf8j/uqY2yuDiMevfVLMu8QlcZhAxTH06yXupEDCyb8bJH83mpVdOe2Hf/OK2PLU19oGDafPOrQ2U6HBzmC8zWrEgiHbZStARCYiQEQMRAQiZoy7S5sAItKumScBv4gjcWReDkTUECL2Tt0sXvWl1ZVAxO+vSQWItXi8ffm+x97fJmg4diw95KzDWjqFAYuGTB4AEYGIQEQ8xyNgAxAxiTkXqQARaddAROAXcSSOzMuBiDpCxBNWPyVe9YXbKoGIx64OtQCID/786rZAwz1bltdt'
$j3 &= 'e5snzZblejuGLtubM7kLRAQiAhGxKeCBiTN9bk1HfgTJzgZvyr059mnLtGvaLPCLOBJH5uVAxLohYrT1F38QzlfWVgIRv3vbE43Dw+Xty08fZz00lLBw4jE8dMF5jXcQHjBg8WKJBS0QEYiIgYhAxDnxdi2HhX6ye2HczzmWzjOAiEBE5krEkTgCEekzLYSIwWEXbhf/xb1VOUT8zi3NA8Sd4+3LP/uY1dBw7V5Ha4GHunUS3RZmUli1wAAiNt5+aCf0C8CGlkHE5Jxhm7YxR9JD6b7Ky8WAiLRr5knAL+JIHIFfQMTaIeIJt4TD//b5W5RDxG//tHmAuP2le8TGR95pLzR8cI8D6T7ITvuMigg4sJ/johkYTEbsh4gGLfBwCyZ/xK7WWHuWgEOvyjEOiEi7Zp4E/CKOxBH4BUSsHSL+2WdvDlRDxK/4jzYOEIPnLrQZGk4cSVuxYGgJSOwkE34OiTf0tmYgIgs8DEQkdrWMlSaPk0Fd5QBEpF0zTwJ+EUfiCPwCItYKEf/8iJtdCRGFSoj48YseFA/88o+Nnn94/1PH2QoNEx8o4eGBLlgOmGiRHUPKDojIAg9X7w51sdUQ0QMeAhFp10BE4BdxJI7ALyCihhDxvx9xU6QSIn7swmYB4q7oRXHvYx+3DhquefDAiaM1wEMbYSLbnA3JRgQiNhJzbjpvmYENrYeIpr1gGz+v21CsgIi0a+ZJwC/iSByBX0DEeubjf/GZm1wJEYUqiDi+SGXj8//R6AUq6x9+l23QcOJY2pPuLCFbgaLb8gtYYl2zj4CIxBxzazuwodax0LRblp0G4wVEpF0zZgO/iCNxBH4BEeuBiH/5mZsiVRDxnfIilXVP/j+NAcQHX7hN3PPQu2yChste/cCyh9LAw/bAxPFttH5Ltzq7TEaAiDNiPgKstcqBxnWRiTPtfZ8M+qZffgERadfMk4BfxJE4Ar+AiLVAxL86/CZXQkShCiJeuPml5i5Qef4a26Ch'
$j3 &= 'uC1YdiDtLKE2A0W3ZQBlxGQEiGjYIjlM6gRWZ1fjusjEudr4djiCA4hIuwYiMlcijsQR+AVE1BAivvqwGwNVEPH0e55vDCBufvI4m6ChuHW3I2mjMwlQJQsrtyVnw3WYjAARV8R8oHG8+/RQreqLmThX/+LMlC3MHU1iBkSkXTNPAn4RR+II/AIiVgsRnU/f0JMQUaiAiF/2H23sBuZNT3zNFmg4cSw9YJmGUjodJ4EqtgLFvubxByIy0Bq1QEbABoPia0LmfdzkGYhARNo10Ab4RRyJI3NyIGITENFXARE/cPZWEbz8x0YA4gZ5A7MF0FDcunWPfWnOPUR5OyAbz08cMhkpt8C1sJ7rvMXRpycCIjJxVhZfE8YyT7OYARFp18yTgF/EkTgCv4CI1UHE13zy+o6EiKIsRHy7vI15/XO/rxMextKj7S/vGt7zyIdi06HhLXsdSRs74UdadUa2bHcONY9zYNRbI3vqd0x9RcAGeyGiIRPqWLcjN4CItGvmScAv4kgcGauBiFVDRFcFRLz+od9UDQ2jMTSUHkh3x88uIWFXOjYZGv50yz72lhCqplMKTAaJTEaAiIbFnSxyICIT5/KxHRgQ26GGcQMi0q4Zr4FfxJE4Ar+AiFVCxOtGZSHiwSdvHCZwb5TAvrIZhoG0L+1J96T3W5BJQLgMEA2HhuLm3Q6kHZZjCJg4110mI6XsWFifdV4ou/Q4QEQmzqVj6zM2ARFp10BEoA1xJI7ALyCiRhDxNZ/wOxIiinIQcTSzko+zBRMA2E9g4CwPkn/Tm2QXZtEYIErHBkPDiWNpLk5BdXdSAwPPTOxrHM+AgbORuPeZ/CFgg9UQUfe+NeIFCxCRdg20IY7EEYhIn9k2iOiWhIjx674xqnXblgSBXenYUGgobrr/byYOpB2WYKihjsox7LxET+NYmjAZcS2tw2R/ImCDvRBR97iONI3bkPGcds08CfhFHIkj8AuIWAlEfO3Hfb8kRKy1MLIA'
$j3 &= 'RI2h4bJvvP9vYmmyD5EOnVXHIJAIRLT4husSsY+4pRkBG+yDiJrfwK71uGTAmAREBCICbYgjcQQi0mcaDBGjohDxr45ZV+uiVAJCdxZANAAaTju4kexDpN9CLSLjg8mIofVX9zPTuvQyQEQmztZOpnWFiBFxo10zTwJ+EUfiyHgNRFQOEV/7sWsdCRFFEYj4349eE/7VV9fWto15OgPRMGgobty87Fia7ENEp2XhYGrKZTWW1l2XeouADUBEzurd58Ug8JV2zTwJ+EUciSPjNRCxEojYLwERa8uukKCwK6FhbBg0nHYoTTYK0n0ACBlMC8duaMjg2bew3pqwYOYFEhCRibN9Lwi0PGtW8wungIhAROaZxJE4AhHpM02GiK/72LVeEYj4p19eU9vgL+FgVzo2DBqKG/baynPIkJUL4QGDaeHYeYYMnr6lddeEySAvkoCITJzt61c9DePmEzfaNeM08Is4EkfgFxCxIoh4jV8AIkYSItayjXklQDQBGl6/17G0cZN21OqFcI/B1HqIGI8z9wDgjcUekAhEZOIMRKwyZo4h9RGICERknkkciSMQkT7TUIgY5IWIf/Jva2oJvoSDXenYIGg47UDauoU6YjHMYGo0xDJm8WbxwhmQSL/JxNkuiDjSLGY+4xDtGmgD/CKOxBH4BUTUBiK+6sjVtWyFk6CwMw0QDYCG07ZqgX7AR690pH3pWDpK/rsrDSRlMcxgat7gaXM2YgBIRPSbQMSaHfEyBYhIuwbaEEfiCESkz2wTRIyyQ8TbYgkRK194SljYkQ4Ngobius1vHzuWNm6SngEeigUOpYfS1vzunA3dRhDDeX72Q0TtsmcUlYFrGMjtLyH6TSbOpkPEsR0WxUBE2jXQhjgSRyAifWZbIKLIARErH/AlIOxIaBgaAg2nHUhbAZT++qNXdjPAw3kOpAfS1mfZjDOJEhAwsOg3OSw6igNlwyCidTcGJ2UQG1YGQxtfRgARmTi3DCJ6xAqI'
$j3 &= 'SLsG2hBH4ghEpM8EIu4DEW+tZbuGBIa+CdDQv28fW3H78gGHXuEccOiVI2mx7I+W9nj78yjZ+uxYuGicPgMvGmdBWfCb+kAv6xcctoPEoYFlEJkIeBCwgcm0HluaDRi7gYi0a6ANcSSOQET6zLZBxD9xb60ckEhY6BsCDcW1m5YdSxsPjg449HIJD6/wpUU2X7m/s0HFKNn63LfhPMXxdtA5MGBgamaRAQey697xh4aCxJEu2/EUlIFjaBmIZELblizuoU3wlIlz6xcljb2QmdoVAUSkXQNtgF/EkTgyXgMRdYGIt1RegSUodA2Ahnt8zaa3R/I/jV7sHXCIhIeHXO5Li2UfOstXlPQC4Hjo8nmKnvxPIxeRKZP2OAFyXYN+jwnwxdE8hoHBAEuoqrPJtuJeUzDdoNtJF0FdK+DaVH3oJ+US2ZgJy8SZlwLJuO/UHB9TASIQEYgItCGOxBGISJ9pOUSsNNgSEvYMgIbTDqWNzaSTwLAj7e2Bh0VcCXC8Qm6lvmIw3lZtQEfZzdHQQhOyEw0YTGMD6oVnOLyaXgyPkt8zSAa0WXaTf+MlgChYAYl6DMCltzkPTMwSTcrAy9Cv+EsWiIlz62M7Pd53aoqLa3j/BkQEIgJtiCNxBCLSZ1oJET/300orrwSEXQkNY82hobh6r41e8BxwyGUDCQHjUgBRCXBcCB37BnSUgxIZRq5uQNGQzK2RAfXCtQReGT9QW5AVOmur80DH7OYpoDwssKU/WLJAtMdKYxsCEveJR2fOcSpARNo10Ab4RRyJI/ALiNg8RPzTz/20skBLWNiRDjWHhtN2jYWHH7m0Jx0dcMilYq8vm+HLm/WhlweGdJQjRQuNRqGAYYuRgQH1ogs41AYi2lwW05mitWwbT7aV9pI+a5JhqATuABGZOFvwkmvW+N6tIBauwduXgYhARKANcSSOQET6TOsh4hE3V3rbnISFI82hobjq3r8dO5buLxmoAz5yiSPhYSAtMvuQ'
$j3 &= 'Wb6sDug4zpB0DOko44qgQC1QMYGHnmGLka4hdQN4qMlAbcHZiEWyFYOpLeZeAh16CzxY8e+9qc8JaNvABg1iOzAZlKmA/Ek7jizrr4CIQESgDXEkjkBE+kzbIOKfH3GzWxlA3Pw3A42h4bTHANG4BY6Ehx1pT1os9qXlrBY4eoZ0kt0agcAeCKDouV1Dt0FFBg2iAfBQG4joWJS1Y7PdJcNFe7RizK0yc3j8QqOf83f3kiMCbO3DgIhARKANcSSOQET6TMsgYmWXGEhg2NMYGk47lHaMA4gf/klfOjrgwxISTvsjZV0FcNwDHUOyIjIvRmZlG83zyBKoNTSofnhAIX0GasqD9g1sMBsiJvG1CaQFCRycNWb7LXoRBUQEIgJtiCNxBCLSZ1oGESuZ1Esg2JGONYWG4sqNexxKG3UDswSHjvRIWuTzJbNdL3Q0aRI0YtHPVmYLBtHWDNQGXszQNht/uQrtsfL4+rQT6+zTroGIjEfEkTgCEekzLYKIww0/dyuCiIGm0HDavnkA8eKBdCwt9vonFVk5cDQqC4XtkWxlpo4YBxG58Eb3yQgQEdiwOL592gkvD2jXQETqJXEkjsAvIKKmEPEDJ28Uj/z2P8ceSiuDaRIWDjSFhuKKvfaXDNIBH/px94APXRzuCw+LuhHgGI/PbzSogwRGcF5alnpCtqpmAzXbmsk2BjaYCxF5OQNEpF0DEamXxJE4Ar+AiBpDxLPveHYCEceOpUsv4iUo7OoIDS/fsI9NA4ietFjsi2dbH+Bo1K3Xht8SaeqB9EZlBSf1xKXs9Buo2dastftLBov2WEuMh7QTICLtGohIvSSOxBH4BUTUECJufekP0xBx4kC6cNAlKAw1hIbT9oyBhx+8qCsdpgPEIq4VOBp3DhYZZhy8nrGedCg7LSEitzXT1oEN5sbYoZ0AEWnXQETqJXEkjsAvIGLzEDGehogfOnHDLIC4EiY6eYIhIaGnITQUl63fY9cggOhJi9zW'
$j3 &= 'Ezg6S4YJAFHvWYgmZiFO1RUuAtBwoObiGybKwAaj48yLPNo87RqICPwijsSR+TUQsWGIGExDxB/+NEyDiBP7WWCiBIRd3aDhpffsYyMA4us/cKEjHUiLPZZwcOIDVLoe4Ghc1gnnIbK9EVhlx0DNdnM9jy4AIgIb6FeBiLRrICL1kjgSRyAiENEwiHjbI/+eFSJOPFq0zVkCw1AzaLjsS3bbFIDoSsf7AMQi1gc4GnfbbtKoOQ+RQTNvnQmBiNqWDZmi+tkxuK3THln4YSAi7RpoQxyJIxCRPrMVEHE0gYhvdH+aFyCu3Oa8D5STkNDTDBqKS+7eY+0BogR/HWm/NDzUBTjuhY5GLmTYRlXrZSrGwgQy3owaqAGJZB8DG8yLNWcjWnJkCe0aiAi0IY7EEYhIn2kkRLzWm0DET5x2XxmIOHEk7d31xMU9naDhT+7axwYAxGFXOmoEIBYEjhmho1E3YK9o1JyHWI/dJYuUnO0IRAQkYosvV6E91h5vbmq2wLRrICLQhjgSRyAifaaBEPG1H7t2MIGI37vmERUQcdm3bD9SJ2goLt5rEwDiQFrk84UmOJYQ0ciLMjgPsTYbC5kX1J0+EBGQiO0+xoD2WHu8Oy1/QQNEpF0DEYFfxJE4Ar+AiI1BxN4EIvoP/FIJQNz8/AadoOG0tc5yeP37L+hIj6TFHueGiVoDR2MzzDgPsRaHS5aqxWd4mbS4ASSyvRHYYFbMuWQFiEi7BiICv4gjcWRMBiI2ABGdCUS85+nfKYGI1205RBdoOG2tM5wkMOxKh/sAxLyuBDgqg45GX5TBeYjVA8RxZonFELELRDSinDzaYuM2NVud9thM3NnWnO4REJF2DbQBfhFH4gj8AiIqHb8nEFEFQLzz8Yu1gIY/vuugZV9059iaA8T3XeBKx9Jipt9fgesHjl3DFyqchwhABFC1AFokl+HQ3qkzwAbAhDVHhGi89btHuwYiAm2II3EEItJnmgkRg4O+vLo0'
$j3 &= 'QNz161fEVZve3RA03O3d0FD6jj0e6Q0Qzx/OhYdF/H4toaNHFhluM0Bs8WLXM7jNc94adQbYYEbsOR8x5YgQjbMRgYhARKANcSSOQET6TEMhov/h4+9RkoXYTKbhPtBw2RfudiitJaCQ8LAjHUiLbL6gGlcPHOUN00OjIRHnIQIQWey28rbdDscYNLP1EogIbCgI/skgnjO+apwJD0QEIgJtiCNxBCLSZxoJET/he2Uh4jgL8cp73900NBTD0R5H0noCxPee15WOpEV2iJjH2gDH8RmPRm9j1vwNPrcws9gFIlZfXmxv5nIVYAN9q9Ev6OT/7jNG0K6BNsAv4kgcgYhARGUQ8TWf8HtlIeIdP7u4aWg47VhaS3glwWFfOl4GiHldCXCsBDoGEh5as1hhUaLcg6WWq0WLXc+S8nJ4mcDlKsAG+lZTX9AlfRhjBO0aaAP8Io7EEYhIHJVBRKcMRBxnIV6x8d1NQkNxQeLzbz9I3Pvs/ZF8rqH0QLon7WgCEN1C8LCo6weOvrTxmYczFiQs6tVlR1hVP1jstgMirsjm4ew1FsXABv371ja2U8/AF6I+7RqICLQhjsQRiEifaSBEHOvQE9fHRSHi6LGLG4WG0747XLPoWUPpQNpL3E8gY+VZDxLq+bUCxHqBo4SH5ztLFip5ew80ACZVVb86CVyl3M0qM48MZbKVgQ30rZp43Bf1DV0wB7RrICJ1kjgSRyAifaahEPGw0zcHRSHiZevf3Rg0nPaN204qezlMnEDGsf0p2OglsHHamcDj6997bkdaAsRzxWKfZ473wsORrfBwRoN2gYnFBr8xiAUXptavIRARmIh3ZyaZmLHMxJm+tcExtmNwLELaNRARaEMciSMQkT7TUIj4mk9e7xUBb+ufWtMYNDxv7HUHiXOlL9t4WOnbpVV78/O/Dw7s/zhKB4hF3ChIDKRbtxhJGnbfkEFHh4VNK+tIyUEjAiICE1t61MHA5NvamTjTtzaQfegW'
$j3 &= 'eBmq70KEdg1EBNoQR+IIRAQiGgcR+1tf+kNuUHbN5k83Ag2nPbzjPWKnPJdRJ4AYvPh/xXu/eK14/b+cm896A8eorfBwRgN3krf6gAPgYRVACohoZtm5LdpCqQIcerZkKjNxNqJ92pKVOCwC3DVemDi0ayAi0IY4EkcgIn2mgRDxe9c84vgP/DIfKHvpiUag4bLX7vY50ltefEIrgLh656/E33/6MgkFz5nyuepdH3Ac3ybtLqF5jb3f8ptbY1O3IGoOqX0gorHl103Kj5cM+79kGNh4xAETZ6Papqm7CfyybYd6SbsG2gC/iCNxBCISR6W7CM6/89koFyzbdVYj0HDssxOve8zXCiCukQCxe+iFKwBiXmsFHIfjcx3BOpkzHfotggejJPOK+lE9TIyBiEa/ZGgrUAyTrKm+7f0EE2fjyqtnyAIyTtqQo+h3h4wTtGugDfCLOBJHICJxVAYRJQQb5rpQZcMhtUPDic9ac5C4estAO4D4tkMuFKv++ezZloBwVSm4WBNw3A0d5bmH51qXLdJAxoNn2RmKgMPmALVJW2WtzThTMDHwLN7yHCS/r9+2PoKJs9HjtI6QP6hirNV018SIdg1EBNoQR+IIRKTPNBcidrMCs43PbKwdGk77wjsP0eocxFSAmNeVAMdM0DGWdllaVAoQRgYd8j6BAiw+9alHTgLoAo0yZVoLj0qC4d7UiwaTMhXDFWXOUQbIlhc1o4Zf0vHyBSGEEEJmSQKxIAs0u1VuZa4TGp65el9vem6bvQCxIHBUAB2HEiACAOqHCINku1KTICGaggIuUMCoelQXnJ6Ao+EELLPYVV6WzlR5TvqEqMH+YJQ8y6S86RdQW9pif6oNVv3ypUfEEUIIIWSsJBTrZQFnl6w/pFZoOPEZtx0kbtx2ll4A8SMNAkQ1WY6RNJNYvRYw3WTR7k4t4v1k0THtKAUCTHsaCLhAgVbUn8FUmU9A43Sd8Oa4NzHR1KZMO1Pl0p9TbrP6'
$j3 &= 'CG+B+1OfSV+A0OI+tb8C8AdzXv7FK/5/P/m7QdLWeFmLEEIIIbuUlo247eWXaoWG0774nsP0A4jvOTuf9YKKQ2kmtAghhBBCCCGEEEIonyQgc6TjefDsdnkjcl3QcOLTb3vHsu9/4QlNAOIvJUAcSih41pTPVu/q4GEk3aO2I4QQQgghhBBCCKHCkqDMnQfQrt06qA0a/ujWxLe8Q9yy8ycaA8S8PrtJ6Ej2IUIIIYQQQgghhBBSIwnM/FkQ7aK7D6kFGk77vNGh+gDED18gVr37zNkuBRYrh46xhId9ajZCCCGEEEIIIYQQUqqVIHHnr1+pBRqelvjUxBuf3d44QAxe/A/x3s9fNR8gFnF9wDGQJvsQIYQQQgghhBBCCFWjaZC46blttUDDU3+611dvOdlOgFgfcPSoxQghhBBCCCGEEEKockmQNhjDtLWP+hmh4UGFoeHYpyQ+/bZ/FjujV5oEiOH4t/cOuyxsFCAWA46xdI/aixBCCCGEEEIIIYRqk4Rp3Ru3nRHtDw3fUSrTcBoaejfv65t3NHKZyii5WGZ5+++q3hm+tMjl5kFiIM32ZYQQQgghhBBCCCFUvyQ0HFUJDad99traLlOJpIfS+106sqp3+kBa7PUZ1VgtQBxSUxFCCCGEEEIIIYRQY5LAMKgKGv5w7JveIX6QeN1ja6qEhn6SbejM+60SGvb3BYhFXCtwjKVdailCCCGEEEIIIYQQalQSGAZVQcNpn6k2CzFMMg0XQsNprfqn07vSsbSY6V4VLgUXI+kuNRQhhBBCCCGEEEIINS4JDIMqoOHEJ9+42xue2V4UGAYJMBxfBNMr8htX/eOPOhIUhnMBYl5XDxxDac4/RAghhBBCCCGEEEJ6SALDoApoeNKUzxkdnrYVOUguP/GS7MLe5BIUFZIQcSQtUq0KMpYDjvLSl9MBiAghhBBCCCGEEEJIH0k4GKiGhifdeHDid4gTbzhYXHDXUV4CBnuqAWGaVv3jaQNp'
$j3 &= 'sb9/VM7VAEcuUEEIIYQQQgghhBBC+mkaIpaHhgcvQ8OxT9jrqKnftuofT+1Ji9k+Lacrh44utREhhBBCCCGEEEIIaSkJDYeKoeFuX7/HbhO/S4LCjnQ0HyLmdaXA0dW5jnzBf6jzxese9o+8/mFx1I2PBl+5+dHhV295zP36bT/j4heEEEIIIYQQQgihNkiCQk8lNDx+4uuWHUs3cr6fBH8jdQCxMuAYS4DY07l+fPbqXd7nr30olhBRJBBRHH3zo+KYWx8TEiKKb655PP72uieC741C7/t3Ptk//u6nHFoVQgghhBBCCCGEkGWSwLCnEBru8XG77Tfxm1b9wymutNjPjUHFmZYA8TRtM/kOu3xH7zNX7owkRBQSIop5EHGw5nEhIaKQEFFIiCiOv/tpceL6p+OTNz4TeJue9U7b/Fz/9C3PO7Q0hBBCCCGEEEIIIYMloWFHITQU35/YX3btkEzCQkc6ngkR87hygHiqlgDx4z/Z5nzi0u2jT1++Q0iIKApCRCEhopAQUUiIKM7Y+rw4M3g+PmfbC8F5O170zt/5Yv/Ch15yaH0IIYQQQgghhBBCBunEG94RKoKGe3ysf3DYxG9Z9a5TAmkx1/9QkS0AiP0fPzj42MUPxhIiCtUQ8awHfi4kRBQSIooLdr4oJET0aXkIIYQQQgghhBBCBklCw6ECaLiPv+cfPKj7d6x6lzdYCBCLWC1s1BIgfuSCwDn0wiCQEFFIiCjqgIjDXWQiIoQQQgghhBBCCBklCQ27CqDhSjt1/gYJEDvSsbTI5lNEzcBxvMVaO4D4wfO2DD58wdZYQkRRF0SU25nJQkQIIYQQQgghhBAyURIYhmWg4XcnvnbZtW9lXvXOH46yA8S8Lg0YJdzUCyC+96zNnfefc38gIaKQEFHUChF3vOjQ4hBCCCGEEEIIIYQMlASFbgloKL5zzT4e1vnsEiD2pEVu1wcctQKI7znjvv6/nLk5lhBR1A0Rz91OFiJCCCGE'
$j3 &= 'EEIIIYSQ0ZKwMCoIDcW3p3zbI7ePHvntf3bqeu5V7/xBKC12+4fVuDhYdHUq496PNg0lRBQSIoqGIKJDS0MIIYQQQgghhBAyWBIW9opAw7G/dfVeS4A4diTdq/qZJTh09wLEIq4UOLq6lO27vHudfzjl3lBCRNEURDz7wRfIQkQIIYQQQgghhBCyQRIYjvJCw2mfeftRE4g4cWVZiav+/gcd6Vha7Od3VuFcMFEbYPZ3P9jQe6e3MZYQUTQLEX/u0MIQQgghhBBCCCGELJAEhh3pOCs0HEx81W5ftvnslRBx7Fh6oPpZJSz0ZgLEvFYPHEe6lOdBJ613Dz55g5AQUTQJEc8MnicLESGEEEIIIYQQQsgmSWg4yAoNJ/5m4lseXjsLIk5vce6reMZVf3dyRzqWFnOtAjDmB47j8xk7OpTjgSes9w86cb3QBCL2aFkIIYQQQgghhBBClkkCw1EWaPiNia/c7bue2r4IIk4clD0vcdXfneQtBIh5rQYyjrdWO02X3Zu+f3fnrcfdHUiIKHSAiKdveT6gRSGEEEIIIYQQQghZKAkOOxIWxmnQcOKvJ97+q1eyQMRpmJg7M1ECRJmFeJLMQjxJpPvkajwbIvaaLrc3fu+uzpuOvTt8y3F3C40gYo8WhRBCCCGEEEIIIWSpJDTspUHDib92xW7nAIgrtzm7WS9gWXXwiW42gFjEhcGi13R5/Y9v39l943fviiREFBpBRLIQEUIIIYQQQgghhGyXBIbDRdBw4mMSF4SI0xewDKWdRc8kIWIkLTK7euDYOCh7/bfu6L7h23fGEiIKnSDiqfc926MVIYQQQgghhBBCCLVAEhqG86DhMZfv9lelT11zVFmIuHKr837ZiRIK9nIBxCLOBxPH26obvUjldd8cdV8/uCOWEFHoBBF/eO+zZCEihBBCCCGEEEIItUUSGnYlMIxXQsOVPmW1Uog4nZ3oT85OlJDPrxwi5gOO/SbLxvn67d3XfmMUS4go'
$j3 &= '9IOIz/RoPQghhBBCCCGEEEItkgSH7ixwePRle10RRNzjrS/8Pl71jhPEPm4WIvpNlslffnVt99Vfuz2WEFFoBxE3PEMWIkIIIYQQQgghhFAbJaGhPw0Np/2Vy8YXsPxLpRDxvBt3iP0gYl6rA4ixdGPbmP/86DXdvzh6bSwhotAQIkYnbXimS4tBCCGEEEIIIYQQaqkkMAwn0HDZl+72lxNXCREP/7pfHiKqA46NbWP+b0et6fzZV9ZEEiIKzSBifPzdT7m0EoQQQgghhBBCCKGWS4LDjoSG8ZenwOG0t//qlcog4hsOOn63JeB7Q50wcX+Pmor/q/5tdee/HLUmlBBRaAQR4++OQu/YO57s0EIQQgi1QatX39Zb4Y4Gz+RMPQ87AsysV86KekU5NlseXd3auWV9p0NE9B9bKmpL9G20Dcq1prmEFoGQsLD75Tkg8c4nt1cCEC9b95gEiMclPj671QPH8bmMjTXqVx25OpAQUegCEb+55vHgW+ueoJNDCCFkM0TwpEfSkbRIcSjtS/drerZh8p3znidKnqen4LuCBe7k+KzOnM9wcz7TYMHzdDP8faDKBWPaT8pv/BlxhroVJP++q6j+DBf8pmHOz1oUH6eCejesoD2N66WbtPU4QzsfJf/eaaBf6qfEvF/gM3uq6sOMZ/VT+s8gac+OwhiprN9DlW1/qm4PknoU5hhbXJ3BYoHfFSex9BT2ba6q/jqlHnUVxGqY0jYmY7iruA/N/RtS4uqVjIWK5+sl9UiFeyV+Sy9Dn6d0rjg1fgUZ2tqgMUgtgaE7CyJevuWSSiDiN05ZNwUR81opdPSa6pRf9aXbfAkRhQ4Q8au3PBZLiOguIYQQQvaBQyeZRGaBhmmLI0/1gi95vqDA8wRFJ8bJdy767F6Oz+rPe74Ci455z9PJ8PdClQssLsp+Z1R0UZkxfnnLQqj6rBnxUvqZc+p22TIZ1ZlZlSwYFwInxfXBLfB5/YJ9qK+iz1Rcv4Oy'
$j3 &= 'bX+q3FSMLZM4OZqMmSp/V6igb/NU9NcZ6lGvRLxGRecUivrQImO3l/JZTokyq+P58tgr8Bu6BedmpcbzBArGxvQhs0DiGbd/uxKI+L5PXiDe8LffT3dh0JgOHA989yli45P/eyifpzflWt4EveoLt7kSIgodIOJXbn40kBBRi0ELIYQQqmBBFKgETMkEUWWGRVz35Dj57kULxIGKib6iRUdY8u+rhIhCscOii4AaIaIomm1RNURUvOj0a+6nfIVwYNFLgqgmQLISlnQr7Mebgoie4vYflwVuGraj6ZdenSqep0mImICmsmO4o6APrQLSlXlhZDREVDE3qxFGNzZuTYNEfyVIrOQ8xCwAMa9zAsbzb9iR5Vkj6UCRw/Fn3vLob8Wrj14nNIGIwyWEEEIIiNjEothtEnikTFZ9RfHtZvyMbtlnsQQiFq5bNUPEqGCdrwQiTm2pV1kOTs39lKOqjacASTdnXEOFMe1X1I/bAhELZ4oaABEnL+Ac1c/TFERUBBBDRX1oVZCu6AsjYyGiorlZkTmZir62ubNJV4LEm3atVQoQr9/4jHjD27+f3RUAx3d9+MxKb56e562/+IN4x3HrxZ984damIWIsIWLjb7oQQgihhiFiNDkvZ4W9DBO6wiAxxyQ1zAFHvJzPMFCxsEl5pkHGz+iXXVBrCBEnZxVN16t+hjOzJvWyo7Ceq4aIRbeH9SrIeFENuhrL5siQjdjJGI9YURbiKEeWWVTlyxcDIWKctPX+ij5gkLFP7zc4ZnoFxsxJ3xavVr81XzuImNLO8nigqA+tCtIVfWFkJERMXubEdb8wSdpOaUjf+IR7GiR6tx2l9lKVtfJSlbcfmw8kKoaO59+wvRGIePiF28R/dW9pGCLuir/gP8QNWgghhICIKRPLZMIeq9zuk3GSut/Zixm31+SZoPfKLswyLGiyZhF6CrIZ0yBH5kPYFcG2XsoCNA0YDRXW8yogYpw3q6giiJj1sofJJRaz4MfK'
$j3 &= 'lwZOQ32VUxY4pLSlPHV7kAF092c8/1A1RDIUIgYlx5a4qQtXytShjH2bp/B5moKIfoYxZ1b7cFfAeVV9aJWQrsgLozqeT/nFKhkA/37n5U6V6+Rv45yx6mYYv/a7PCWpC9PgXo8dptMgccuLLykDacefd08CEfNYHWQ88J9+KIIXfl87QPzxphfFn37up41CxCOu2hV/7ppdAESEEEJAxIyT4wwTvF7O5xkVzdTJsH0q79aoUttisoCGkmUUK/otXkV1q1S9yLAQdRTV8yogYu6MPdUQMeMiOPNlSJPFoMb9VZTh76OyUCpDllW46LMyZFp7iuNiHETMOLZ4DdVBT0FG18JxzmSIqOLogcmFbwXKpgmIWOSFUeXPV0G9T4utm/Ez8maX+mViP3URkrOkiyYgUeUFK8efKyHi3xy722+vyvMh4hhiNrGN+YAjb2sUIh5+xY74iKt2AhARQggBEfMviHxFZ5V1FWQalZ7oZoxNlglzlu2OTobPmQcsRpZDxDRYM1BUllVBRFXZr0UyerNkb/QN7K96RbfJpcA7L8czDMtmyKn4DNshYoaxJWqoDnqKtoUK3WCSIog4aKrMGoKIRV4YmQgR/SoumckwB1D2klorTUDinU+q2QLc//xP9kLEvFYAGNc//u+1Q8SvXLpL/PkRNzcJEWMJEQGICCGEgIjFFkRdFVkVqhaMKZ+T5zxDr8x22oxnB/VLLDbzgA/jIKLKhUuDEDFPfVMJEQNVMN2wPmtU4O9UZiF6ij7HVRgTkyFiV1U2sk4QUdXYqylEDFSdcWgQRMz72SZCxKjuM0pTzoOOlkyXhIjud677qNj+q1cUQcTvZfCx5TwDIB5+zNW1A8TbHvmt+MvP3NQcRLxkW/ypywCICCGEgIgVQionw993FGYQKll4pkxg0870cjIuPIYlnqGnqHx0hoiuIkDdFETMc/lNT9Hz9VRmzWjYZ/Xytu+UPmGY47tdVRmEql522AwRVfUjmkLE'
$j3 &= 'oaUQMW6qvBqGiCouXNMZIpa61KqCthYs2aAxSDzv7pPLQ8TPXSzecOB3050JNOYDjudfX/+FKh88aWOjEPHjl2zrLyGEEEJAxLILmbDk1lVX5SQ15a151luRO0UBVo4bptNgpKdocWgqROypWCg1DBGzbnFVBRF93bK3KqhbUZ76nBITJ8f3jopkQaqCoS2FiMFqjc5FVAgRPUshorAcIsYKXhgZBRHTXszq3taMAIk37VpbD0TM6wywse4LVfwHfilefdiNTULE4RJCCCEERKx6a1YWiKj0vB2F22CjIov8DLewZpqAL4irSvAFRFTzu/yS299VQcTY1izEqd/oZt3mlvIywFdYp13FbcRtqH4DEeuBf0MgopEQMSh7QZOBELHXxIupVmQiTnTB+lP7tz5yd1wUrB1+9FXVQMQUH/7Vq2rPQvzQiRuahIjhEkIIIQRE1AUiRioXimmZgIpg5KJLHGZlZkZ547MACA1zxgOIWD1E7BWFzqogYpmLRwzsu6IsAC5lIeoojG1Xcf/rN1S/gYj1QMRAN5hUA0T0Ky6buiCiW/KFkWkQ0WloDuGpvIBKe0mI2JWQLCp0O/M5d4k3vO07s10hRPy6vBV666/+39oA4tVbXo6dT9/QGET86EUP9HSqMzImHeneEkIIIWQmRCy7nVl1ho+SBX+RG10XZD75OT/HUQWDLIWIup2J2Et53qDgb80DXLwmzq5qqO9ys8R6AWzMm4U4UL1oT8lGa+riIJMgYr+BeqfiduaOqgsjNISIoWrYrhtETOlXsrwwsu1MxEqAXlqfa0tm/SwoNMwL10675L75EDGPc0LEk9Y8LoYP/Uasfe73Yudv/r+q4GEoPZB2XvPJ60YNQkRfs7riSo/GdYblLEIIIUMhoqggA6vwFqgMF7X0M35ON+8ZaAt+Tzfn5/RVbR8yGCIODLqduVcGeiiCiIGqyzoM6LvSbjh2UkBj3jbkqY6tKhDQ4otVnAbqnQqIOFTV'
$j3 &= 'H2sIEf0MwKlbUdnUCRHLvDAyESIGaRfLqG6PGS7JsxMkJoColycr8fqNT6uBiDk9BogTX/zIv4u7X/y/qsBhMAGHk5i89uP+GCKKpiDiIcPA0ahujOPjAxARQgiZChFTYFec4e97VWRPqQJnC0BFlGNyHy74rDjnIiFqKhYNQMRR2QtyGoCITpEsI0UQMVJ18Ych/deihfRQ1ZmiquuQ6r7PVoiYMrZEGtY5L8PfD1TCaA0hYi8D+BHJc3cUl01tEDFDvPqWQcRBhjKN84zLCsa06S3mvSUblWSbZYKJb+h+e7drAojv+dRwH4g48aWP/bYITIwTKObOA2MSIg4ahIihBnVhAg/H8RosIYQQQmZDxFLnelU1GVYIEYM8i/w5/36YAsWcHN/rNxWLOiFiCozLtX2qToiY/JthgW3wvYqztjwL+69F2Yix4uzmJiBir4H6rRNEDFQec9EURJzKig1SMrk6ip+ndoiYfE6YESTGyfM7hkLEoi+MTISIaZnfK89/HqiAxGnnWwMTp29o/uyP94LEPC4IET/gXjITIk7DxJRtzpNsw0ypyRIiBk1BxA+dv3XQYNlPw8Moa7wQQgghXSFihgleFlhUFURUdWmBl+f3LVrwLvgsd8bnxGUz8DLCpcwT9JohYqAiC7EhiJgGtxydIGKO7KHablpVtZhWCPzCMpcpABHzPVPK2BJqWt+iJH7TzlInhyUy7nWEiN0C/YlfFibWDRFLQOXKIWIV/XhKZvAiSNwpWa5Bzu8NbYaJvSRjb7+bnM+/7sFiELEgcDzipNULIeL0Nudbn/k/EwDmFbkI5HUfu6YjIaJoECL2GirrYKqMOf8QIYSQ8RAxwyQ2a7ZJExBR1Y23g4yLJyfls/wVn9NRfAusMRAx+e0jlWcg1Q0RM0AQXzVEzLBwdy2FiE4dz11FlicQsRBArOxMvZrhTawInGkHETOU4ULoZBhELPLCyEiImHzvsGC59kuUayfjtuZZmYnO'
$j3 &= 'kq2SQKmfXMKynKEYvPB78Ya3fmuxFQLFeRBxDA2vfeKV5SzEjS/9QWz7dTwNO6OVZx1mhIi9JiFijWXaSbJOwxVbvdm+jBBCyBSI6E/dODtxP5lExhkmjU7GZ9AaIqZM+lfCv0HatqYsmTWLFkMVABAtIGICwbyUuuVrXBdm/aYwB3QsCxF7JcCtsRAxeX4/a4ZKie8AIlYIERNQkLblt1GAqBjeTDIXS2Vq6QoRS4DECfzpNNWe8kDEDL/TtwkilgCJpS5BSfqHsG6AaRJQdMZQ8Z8POSNIBYl5vAAifumHa5dh4TjL8I6f/4fY/PIf897QHCaZiamduoSIXsOZiJ2Ky687J8M0ZPsyQgghwyBimQyLbo5nMAEihhnh3ygDaAzSzlfMs4AxFCJOLxajjHXK1Rwo93IuarOCYyBi+m/Pmo1Ypg4BEdXDtjDHGOSrvohDA4g4DRP7VTxPkxAx+cxuQfiT+4zIpiBi3tiZDhGT7+8XzA4s8yKnUwJgukttkAR/jnSsFCTO8fFn36nqJuaVF6s4+0HEf71m2DBEVEqik4zDfvKb55116S0hhBBC7YCIUd5MEUMg4jDL882ZVLsZf28vBUaWgRW6QsQ0cDhSMflvCiIm/97PsrBRABE7JbYzO0m9XOnIBIiYIc6lb/MFIlYCEbOApKFOWxILnoHXS7LUQ9X1SHeIOPXZbgHoFDTRngpCxDwvjIyHiFNjjrc6+4UrpTMSp8B0kblrOxK6JODzDISIKx0lZwAun6HY/eyNYZMQUd7OHJQpkzE0lFu9ezc//TtvxTmH8y6cIfsQIYRQGyBi4QO0K4SIkaqLEFIOFO9OgZjUm5cXLDa8DM/eKxgL3W5nTqt3To31vGqI6KScmdVRARGrKOcqoUIF9a1bZSaKqouagIh7XjbFqi+q0RUizhhLYlXt1BSIuAImhlVkkDUJETO8yHDrhIg1t4lOAUjcU/C9To6jLBq9kKkJkBhWDRGP/M71VULE'
$j3 &= 'fXzI9+8SDUNEccgwyJSNKGHhMjCUt1N78j996XB8TuR4y3eGbEzOPkQIIWQ7RNyTKabLmU5VAZWU7ZLuAtAY53i2YGpCLtK2PBsOEXspC46RLRAxQx0fAhHrqXO61CEg4vJ3DEzMGioLEaeAd6wbTKqzvSfzhiwZbFHd7akEROxkfGFkFURc8VyDjOUaKPxOJ8dc1l1qg+rY1tw/4qJWQcRDLwzio295vD8GhFc9/r/78jzIMST05H8fg8Ig8X6XzIwvmMlwVqTPzcsIIYQsgYizLlaZuKPwGXpVLCYrACpRCgQaZoVh8+KeEg+tLoVQABHTyr1fUz2vHCKm1B+RLIJUQMRQJZgFIlYOEV0VIMDUi1VS6quWWUMqIGKGz4kUfY7Qub3nuCwjK0xvFCJmKI+h7RAxIySvasfBIMN3jpbaIgn6ulWDxLog4qck4NMAIor+jx8U37vjmZm3Uq+03LqcBR6Oty73lhBCCCF7IKJX0zP0VC/+M1y0UOQzRwUWxIOcC4Dugv+vzM2G2kHE5N/4Km74NgQi9lMys1RAxJFKKANEzLxojyv4zDZAxG4TfZMmELGj4iWKyRBxKg6xinqgA0RM/jbthZHVEDFj264kKzDDxSvxUptUNUi8bM0jtUDEY696SBuI+LGLHxRHXL1LnLD++bnwcNuv4yxnPvaXEEIIISBiVYv/QYHPU57duOAtd7zgN3RzPt9gAQhyK4pvkxAxbQEZ1FDPa4GIWdqbAoiYdth+R2Hc2gYRXZWxzQB9g4bqd20QMeOiv6tZHfMUHpMRlD0X0nSImDK25nqBphFE7KXs8Ihth4jJM/p1zz0ywHmx1DYlIDE0+VzESzb8XCuI+IlLt4tPX75DfE7CxG+ufVKcvPHn4nK5dTkDPByfe+guIYQQQkBEFc8Rqry0oIoJdsqb9X6eN94LJrrDBWXi2AYRM8KZQcX1vE6I6KRkXpaFSUq3iAMRM7f/otnNoYrLRQyHiGkvEkLN'
$j3 &= '6phKiDgsW26WQMS0thUo6v9qgYgZYhm1BCL2G5p7BEDE/UFiR3pYBUhc//hvagGJb/rsTdpBxM9cuVN8VoLEz1/7kPjidQ+LI69/WBw/ekqcsv5ZceqG58SP7n1OnLHpeXHulheirS//0ePcQ4QQQkBEpc/hqzgfaurzRlVkty06Zyfv2TtzAEJQxRYcnSFihnpYeluzLhAxAzhQ8XyxqvOggIi5YpsXIHVUbfUzGSI2CRs0gIgeEDFT2zURIjo5+3kbIWIPiKgfTOxJByZmIx5z8XYjIOJRNz4qjr75UXHMrY+J764Lo2+uedxdQgghhICIVTxHX9WWtgyL80EF8Yryfs8cmBRXcRi4ARDRUQnSNIeIWc4AK/N8aVvIHEVxayNEVHbmpMrt0SlgOlIVwyoBWYbbVbua1DEyEdXH1LFpO3PWsgEiAhGbhImuSph4/YanKoeIwUt/EG/63M1GQMRvrX48+Ootj/WoaQghhICIlT9LrGJLc4bFuVPiGT1VC4IM4FRZWegOETPGdlBRPa8VImaso2Wer6diQQ5ELFRueepAqLDMPRV9Xsq20kjhMwVzQJL225prPBNRVfZd1gtaOk2BlwztylMUi7ohYt4XRrZBxKGqbGuFc8l2XaySASaOz0v0y16+8q73nSKCF35f/dmIG1/QGSLGEiIOJUR0qFkIIYSAiLU9S+kMqmTSHlWY0ZYZ/JVdtCk+z80EiJhWdoW3NesGETNApFJ1NkNWV0/B57QOImZYoAaK+hE35zP1FGVy+arOpi2yVTcDDPU0qGN13c48VPQ5KjIaw4pjqqq/0goiZgSktt7OnDaei7LHlBSM92gJzYSJnSQ7cVQUJL7vf51dC0g8Z/SMVhDxiKt2jT5/7S6XWoQQQgiI2AhETNvSFKZt8csAIsvCuI5K8JMVJFUMV7SAiBkXgUEF9bwpiNirECKmfXacZXsoELEQ6Bpk6ENilWfAZoCbqWAyw+LbVRinoESf2G24'
$j3 &= 'jqmCiJ6KDMKMMUurk92U+jPMGaO+wjjECvu92iFiRkhqBETMWa5pc7Ew4+c4OTOp4yayH20Dio70QDrSFSSePXpWrJLAsDGIeMm2UELEweFX7HCoMQghhICIzWZ9ZJl4zppQJgvzUZXn6uUEf17GzxpWAZFMhYjJ341Ub2vWESJmrO9lwKmfASS6JeLWVoiYZYuiN+uFRwI5oioWuRmPWtjvuZLfk/a3keLnCUqAoLDhOuYp6PddVeAs4+dNLv+aNXYOMtRnp0D7iJLn6iyAQyOVR3loDBF7pkPEqZe8QYZyzQJN3YzfO5kj+YteICTPFGcY87gctyBQDPJsbV7z4IuVg8S7n/6deN8P7q0TIo4kRBxIiAg4RAghBETUCyJmPUMoSCbRXrIQyfI3XUXP6KtaDGTcHj1U8MxZY5nqGiBiWh3Iva1ZY4joZKi7QYm2lAV4hwlI6E25nyzeYiBi4XYbJ33FpO2EVb4wyHn+WjBloWrBrwIiZuxjvQbrmFd0y3eSKZUFnBV5UZL1eIRwquxj1ePPHKA5+c5h8vuzPmsu6KMrRFQ9b8j40sDL4V6G7xsoLNcox++MZ9SJIPm+YY56XOpcZbS0Z8tzPzlDMTVL8fiz76wlK/Gabb8Sh120vQqIGEiI6EmI2KP0EUIIIX0hYsaFQBG7Cp/PVbX9OOP26L6CZ1YWyzqAzpwFSxnwpyVEzLgYLAOWnNX5Dvav5CZR2yBiDiiQx4XP/MwJN/N6VEG9DjL0i7GO25qzbL+dghxeUk+CDBmoZSFVt4K2HubN3MoISbO6n/O7dYaIWeq0SoiYx16G7wsVfl+3gf4sWELKoeIkS3E0Dyoe+PfH1wYTt/7ij+LCzb8QX7r6EfGe0+8Xfz0YZYWIoYSIgYSInoSI7j+dtqlL6SKEEEJmQcSsoK6um43nLNZUAq60xWVHwTMbBREzLloGiup5oxAxQx0oexmQo3gBCERUDxJjhZnSbpMQSQVEzPg7wobq'
$j3 &= 'mFcRlC8V7wrKvkjGd6fJF386Q8SMdUdLiJhhzlNJuSrsX8PVbGOuDSqOMxW9ZPtzNA0Tj/zO9eKyNY9UDhMTB9JDaVfaoXQQQggh+yHi1IIgLrkIcit6NpWH0PuqL1mwBCJ2VS1yDYCI/YrPxOxkPH8TiJj/O4cKFrhdxc/kKshKG5UEWl7ZOp1hu7XXQB2rCiIOFT2fiozEQtBFEcQsPG7rDhGTz40MhIieonLt5YyViszaEQCxebjYS25+3gMX+0dctJyheP2Gp8T6x39TFhaOpL0EGJJFiBBCCLUYIk7BjyJvo/2yWwNTnmukcAuWW/SMLZshYkZAowJGNA4RU54xUFhvHQXZHYGOALEpiDgFL4ICi2qvwmcqWtaRoiMUVEBEp66zbgv02aEisKJ8rJp6aRAXKHtXQWyigvEoFQtDIGLPQIg4uXypTLl2ah6vlPRjqB7AuOzPn3DT4Oy7HvMSILjSfeleYkAhQggh1Oyi2y1z2HbNMHGQwLtowTlUgyrh4YqFwLy45T1Dyqm6DHIesq7qYpVFn+PkKHev7Gel1HNXUSydkmXkqHi+HHF1kwVamOF8Nz/5947m/ZlXVflk/P7u1GH/8zK8/EW3m1YEEwcpFxCEyXP3auoj3Ryf008p136D9a0z9XxZLqqJpi6y6tf0fG7K5WOTOtmvoC1M4hKm9C9Kxu2UsTRXH7Cg/roKnnNQ4fMVca/A9y465zNK6txA0XEs0+NVkJJBO0yry/8/N9K5zIW7tVcAAAAASUVORK5CYII='
Local $j4 = _1s3($j3)
If @error Then Return SetError(1, 0, 0)
$j4 = Binary($j4)
If $j1 Then
Local Const $j5 = FileOpen($j2 & "\LogoStefanini.png", 18)
If @error Then Return SetError(2, 0, $j4)
FileWrite($j5, $j4)
FileClose($j5)
EndIf
Return $j4
EndFunc
Func _1rt($j1 = False, $j2 = @TempDir)
Local $j6
$j6 &= 'iVBORw0KGgoAAAANSUhEUgAAAWIAAAI9CAYAAAAAbHLFAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAMsAAADLAAShkWtsAAP+lSURBVHhe7J0FeFRJtvj3/96+tdm34y4MM8AAg1twS0IMEohAXHB3tyAJIUIMSCBocHd3d3fXQAyZGWZ2dve9t+d/Tt1b3dW3q5NOSBhmt873/b66fbtjne5fTk6dqvsbFSr+zcMf+Ug7VKFChQoVv0SMQ64iSsYqVKhQ8QsFiRiQrUh9OqFChQoVKl5tcBErGatQoULFLxSiiJWMVahQoeIXCKOIlYxVqFCh4hWHTMRKxipUqFDxCsOWiAklYxUqVKh4BVGQiAklYxUqVKgo5ShMxISSsQoVKlSUYtgjYkLJWIUKFSpKKewVMaFkrEKFChWlEEURMaFkrEKFChUlHEUVMaFkrEKFChUlGMURMaFkrEKFChUlFMUVMaFkrEKFChUlEC8jYkLJWIUKFSpeMl5WxISSsQoVKlS8RJSEiAklYxUqVKgoZpSUiAklYxUqVKgoRpSkiAklYxUqVKgoYpS0iAklYxUqVKgoQpSGiAklYxUqVKiwM0pLxISSsQoVKlTYEaUpYkLJWIUKFSoKidIWMaFkrEKFChUFxKsQMaFkrEKFChU24lWJmFAyVqFChQpJvEoRE0rGKn7x2KtQvGbcRWTCLE2uIh8hKlT8IvEckb0wFYp/N1RmrOIXCyVihcKMkrGKXySUiBUKS5SMVbzyUCJWKKxRMlbxSkOJWKGQo2Ss4pWFErFCYRslYxWvJJSIFYqCUTJWUeqhRKxQFI6SsYpSDSVihcI+lIxVlFooESsU9qNkrKJUQolYoSgaSsYqSjyUiBWKoqNkrKJEQ4lYoSgeSsYqSiyUiBWK4qNkrKJEQolYoXg5lIxVvHQoESsUL4+SsYqXCiVihaJkUDJWUexQIlYoSg4lYxXFCiVihaJkUTJW'
$j6 &= 'UeRQIlYoSh4lYxVFCiVihaJ0UDJWYXcoESsUpYeSsQq7QolYoShdlIxVFBpKxApF6aNkrKLAUCJWKF4NSsYqbIYSsULx6lAyViENJWKF4tWiZKzCKpSIFYpXj5KxCouQvUgUCkXpsxdRoYKFyogVilfPUcQVUaGChRKxQvFqURJWYRVKxArFq0NJWIU0lIgVileDkrAKm6FErFCUPkrCKgoMJWKFonRRElZRaCgRKxSlh5KwCrtCiVihKB2UhFXYHUrECkXJoySsokihRKxQlCxKwiqKHErECkXJoSSsolihRKxQlAxKwiqKHUrECsXLoySs4qVCiViheDmUhFW8dCgRKxTFR0lYRYmEErFCUTyUhFWUWCgRKxRFR0lYRYmGErFCUTSUhFWUeCgRKxT2oySsolRCiVihsA8lYRWlFkrECkXhKAmrKNVQIlYoCkZJWEWphxKxQmEbJWEVrySUiBUKOUrCKl5ZKBErFNYoCat4paFErFBYoiSs4pWHErFCYUZJWMUvEkrECoWGkrCKXyz2KhSvGXcRmShLk2ykIqJChQoVKjDGITJZlhYqE1ahQoUKQ7xKESsJq1ChQoUkXpWIlYRVqFChwka8ChErCatQoUJFAVHaIlYSVqFChYpCojRFrCSsQoUKFXZEaYlYSViFChUq7IzSELGSsAoVKlQUIUpaxErCKlSoUFHEKEkRKwmrUKFCRTGipESsJKxChQoVxYySELGSsAoVKlS8RLysiJWEVahQoeIl42VErCSsQoUKFSUQxRWxkrAKFSpUlFAUR8RKwipUqFBRglFUESsJq1ChQkUJR1FErCSsQoUKFaUQ9opYSViFChUqSinsEbGSsAoVKlSUYhQmYiVhFSpUqCjlKEjESsIqVKhQ8QrCloiVhFWoUKHiFYVMxErCKlSoUPEKwyhiJWEVKlSoeMUhilhJWIUKFSp+geAiVhJWoUKFil8oSMTZSEV2S4UKFSpUvPLojigJq1ChQoUK'
$j6 &= 'FSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFChQoUKFSpUqFCh4jf/r5ioUKFChYoihEykJYUKFSpUqNBDJsmi8h8SZI+ToUKFChX/tiGTYkHIZFsUZJ9TRIUKFSr+ZUImuYKQSVPGfxYT2eciZN8LoUKFChW/upDJrCBkUhSRyZTz2yIi+xyyr2n8HlWoUKHitQyjrOxBJj0RmSgJmVQ5/xUWFvaHFSum/Xnt2rVvHThw4H06ZwPx44xfw/i9GL93FSpUqHilYZRQUTFKTcQoQBFRlBwm0cqVK//O1dX1982aNftD165d/xQZGflnokyZMn94ePdu/e/ysju8eJbf66cX30fj438v8DsDhYlZ/F6NP5cKFSpUlFoYhWMPorBkiIIVEeXHEeVIGOX5+6tnj375Xe5j1x/yc9r+/OMPCT+/eLEZ2ZSfk52V+/jR33MeZf3Pk9zcZ3guEx//R4E/CMgEzb8m/17498l/DtnPrkKFChXFCplQ7EGUqxFRsEZE0XJE2XJMwl03e/Z/P310r9GzR/eb/O3H7wf/9cWLOcjcJzk5h1C0D1G4j/OzH2ejfL9/kpvzt/ycnL/hCM/y8uBpXi589/QJ5OU8unvjxpVm33zzzX/j53wD+ZOAUc5GIfPvk/8M/Oc0PicqVKhQUaQwSqQwRNHKEGXLEWXLsSncpzkPqj68fa1afvaj8T99/33U/Xv3lt67e3tb7qOsvSjas3mPH517mpuT9Swv94eneXkvSLI/PH/GRPv8ST6T7pPcbEZe9mPkEeO7p/mQ'
$j6 &= '8+hh3u3Ll51qf/XVm/i1SMbEn3VIzFzOMiErGatQoaJIYRSDPYhCtYUoWBFRshyjbAkm2/vXr3917dy5stn374f/8PRpj/t37467eeNGyqOsrJmY4W7Oz87ejBlt/vMnT54+QbH+/OMP8NcXP8CL754zuHAJzIB14WrkMvHy0czTvBw69z2Ok1xdXWnS7i0dkjLxF4SL2ShkWXbMf3b+3IjPpQoVKv4NQ5SAPYhylSFKVsQoW8IoW+J3l44f/+jc4cMf3L15swWKtc2Du7cCLl++SNLtn//4cUZednY6SvfW98+ePc59/Piff/vrX+HvP/8MP/3wA+NZPsk2D0Wbw8RaELk6JFxRxNp54dzjR/98lp93q2HDhp/g9/iuzjvI2zpczIUJmX5G+tn588KfN/E5VqFCxb9JiG98W4iClSGKVsQoXMJCuNQSRpw/f/6bezdv1rp+/brD6dOnHW9eveqCkh3zJDt7BMr06A/Pnt3Nz8356W9//Qn+8fPf4KcXLxjPnjyBJyTb3FyUZbaAWa6F8hhFS5BwbY36MdWMs7Me/l9CQkJN/P4/0KHs+D1ElDIJWcyQC5Mxfy6Nz70KFSr+hcP4hhcRJStiFC2nQNlGRkb+KT4+/o0NGza8d+TIkU/379//+ZYtW77eu3dvORRtxJPs3PD83Lw1L54/v4JZ7OMX338Pf/3xR/jhu+8YTzGzlcu2AOE+No5cqvqxcZTex8+bj6mMkfMo6x9njx/t4ujY+Cv8+Sgz/hj5CPkQ4VLmQuYlC54dKxmrUKHC6k0uIkqXKEy4BJMt9eGWK1eO9eH6+vr+kXB2dn7js88++yNmts6Y1brn5uYmf//s+Ynvnz27mJ2F2aUuVyKPygeItWhloChNow2sRGw81iVrF1k6JOLHTMTH9+/v3tTBoTz+7F8gnyOfIVzKRiHz7NgoY1slCuPvRYUKFf8iYXxzixQkYCvpCpBIGFl379Z49iy3cU5OzqBn+c92/PDs'
$j6 &= '+113b9/5PvvR4+9yH+f8SOQ8zv57bnbO/6JE/4+L1y4BM4GKx7pMbYoW5Wkc+f2mY3G0H1ZDfvzo/57lPT46dOjQhvizU1ZcFimDkJS5kClDprJFQTK2NytWoULFrzzEN7QRUb5EgfK9efPm58/zntfMzs5u/yTvyYKffngx7/bNmxcfZT26iKK9g5K9h+Tn5eT+PT8n7+9P8vLh2ZOnmPlSHTe/4MyXSdRwbBytziHiaOsck6h4XBBa5ms9Wp7Ly8kGFLEzPi8VEMqMv0ZIyF8iJORPETE7NsqYasZiiYKLmMtY/D2pUKHiVxzim1lEJl8m4KuHrv53Xt73FZ7m5jZEon568fO4O7furLx///7a7EfZ+3Ie5xzLzcm9kpeb9xMK9sdnT5/B9999D989ew7PkacoXrwPoXpuDuSgNG1BQsUsWYDL0nxsPmfGeF8Ok6Px2Djy45fBLOLvnz2F1StW9Pzggw+q4vNWCfkGISGXQ3iGzLNjkrExM+bdFLISBf/diL8zFSpU/ApDfBOL/MeKFSv+85///Oen3333Xbm8vLxOP//4c8Td23fH37lzJyY3O3dWXk7eapTpzvy8vOdPnzx7+t3z7+CvP/0VXvzwAn74/geg2/mU4SIoZZQqCdcIypSLlh8bIXHyUZeveM4oZPFYNlqeI2HS8SP92BLZOU6ORRbMscyQqXvizs3rW0YOG9YGn9NqyLeIKGQqWdiSMW9vK6xEIf7eVKhQ8SsL0xt47969v719/5Hzzy/+x/H+nfsd7t2+F5yTkz/oaf7zlCf5T2bl5z95/P3zHx4+e/oc/vbz35lwf3zxIxNuft6TQmTLQWHSyMQpHDOhCiNDk6VJwHyU3GcWsXCfjqV0ZfeRNLVRlC4/No6W5yylq42W57QFHtkPkxPjw/B5roXUQCg7JiFXRIwypjIF1YypxY26KYwlCpUVq1DxLxamN++5c9lv3M16duKH7366npuTx2T781//htntT8iP'
$j6 &= '8CT/KRMu3WcpV3tAQdJIouSjeMwFzEeTLPmxcbQHEqWt0fqcUcYFjcZzhYk4P/tRzpyMjP74PNdDaiPUW1wdqYIYZUw1Y5rA4/ViW1mxErEKFf8iYXrznjp16k+3H/91zePHuf8g4eZkU3YrwqWq81gEBWmSqj7KzplEawuSIR/FY3vusxcuU34snrNFljDqx4/MoyZlLmDhHBuz4KcfvofDBw5kenp6euBz7YDURSg7NsqYasY0gSeWKIqTFatQoeJXFCYRU2nif1783BLFmv30yTNNnjJIvHwUj9mIUuSjxbFwzgoSoWw0nrMXkiLBj2WjrfsKgeQrCDjnkT6y+wUR68d8fPH9cziwd0+mi4uTJz7XjZD6CGXHXMZUpqCaMU3gUTcFL1HIsmLeQaFErELFv0iYRNy1a9f/Wrb9ctOsBw/znj99BtkoT4Jkmk0y5CM7r43isew+s1ALgiQoG+25r6iQHIVjEqlstDgnitcOUL7mj9POPcnLgcdZD+7PmTNrFD7XzZDGSAOEZ8Y0iVcZoRY3KlEUlBWLizy4iLmMlYhVqPiVhUnCOv8RPCj+jR+//35dfm7e36gWbBaxMCJ85OIVIUnyUTsm6VmPhd1nKVB7IXkaj2WjrXMCVpImqfKxAEwfrx+zMQt+/OE7WLl8+XR8nlsiXMaUGddB+AQelSgKyooLK0+Iv08VKlS85iG+YQn+r+1/Pnj8fHl2dt5f83LzUYxctLLR8hyXsihnTa7yUTsmCZpHTYp8lJ0T7ysMkiBJEY+NUhWPbd3H0OSarY8isnMW6NkwH//204+wf8/uNWXLlqU6MZcxlSmoZkwTeLxEYcyKeQcF9RVTeYJEzCftlIhVqPgVh/iGNUmYOHD6QZ/79x8/pAUYZtkasT4vy47NPDaM5mOSq/lYFKn5tvV9EphIbZzjkuWjeGx1ny5Quq1LtSRETBvKX75w/vioESP64PNMK+1Ixk0RWv7M68WyrJg6KMTyhOqe'
$j6 &= 'UKHiXyTEN6so4t/WDkh47969B8eoZU0TLhescbSFtWytRxGSpvVoPqaP0UazYDWyUZzZTKB0Wxhl50yjDj8WR4QEq6Ed83Pa/bpci8Gz/Dx4cPfO/SWLFsTh8+yKOCHNEV6i4FkxrxVTBwVtEqTKEypU/IuG+Ga1EDHyX7fuPNz45Ml3QG1rBYvYXjnLkQmYRtk5Emk2yZeJkRCPSab6bXosE7V2Ths1yYrC5cfax5MstZF9LtOxOfMVR9k5Gi15aD7GrJj2nMjLfvTzjq2bF+Fz7I64II4Iz4pp4o76i6mdjTooaE8K6ivmk3ZieULMilX3hAoVv9IwipjexAS9qX93+vKj8fce5OQ+zX+CYiMRomgf0YiIo+wcG3Vp8mPZaPM+hEbjMZMjH8Vj+ajJ1ihkfdSPtccTJFNx1I7pcZajhngsI1uXMB85VCc+tH/fXnyOWyNuCJUoeFbMa8XUQUFLoKmvWCxPUFZs7J4orDyhQoWK1zhECXMRs2wY+V32/fvfolS3/vD9C5QhZbvGzFfMgMVjO2GyRLho+ahL1PqYRnvRRGk8b5ENC+fNjxVHW+dE2cpHOZqQ6Rp4F86dPRcWFtIdn2eatKOsmNeKqZ2Nd1CIk3a8PEGTdoWVJ5SIVaj4FUWBIh4Rv7zypSt3t/3ww08oSUG+LOPlI5eqjZEdo0RtjbbOMfEZj2Wj8bhw5CLmkEz5KB7L7jNizoCN2bA5K37INgB6/PDBd3t37VqOzzNlxWKtmDooaNKOlydo0o7KE2JPsbE8YWtxhxKxChW/gihIxPTG/kNW1uPIJ/lPvqOtKkm+j62ESxJEjDK15z4aTccIjQySHR+148dW54oLSdHWOeNo6z4zmmStR+M5EVruTJfiP3/61Dl8jmmVHdWKWyEtkCYIn7Tj5QnePcH3n6DuCXF7TFWeUKHiVxr8DSoTMb2h6Y39xys3swY+fJz3JD+PREzSJHkasmIrOQuj6RglKhuN5xAuXRot'
$j6 &= 'BWwcRWTniotZpkWHZ77mY+usmMoTz+DapYt369SsGYzPM2XF4qQdL0+IPcXG7gmqE9sqTygRq1DxKwmjiOnNayXi5VtPeF66dv/I98+f67LMhsdiWcJCtjSSEIXbpnMIl61xZPBjTb6agC1F/FgfzR/Db5sfU3xIlMbbIrJzcrhs+bFMxE/zcuHBndvP1qxcORufZ9qjmCbtbJUnePeEuLiD6sTi4g6xPMF/l6KICRUqVLxmIb5BbYr4N78p89apM1djf/7pZ02cCC9PmMoU7BhFSMfGkR3zUfIYA1y8ZgHLzpnvs5SnvZilqcHPiaPsnDhaI8rXeGwkL5s6N7L+cfXixeP4PNtbnuDbY/I6sWxxh606MaFChYrXLMQ3qChieiOTiCnDojf3n0+fvdT7ydMfgLavtBSrPsrOSe9DcRpHw7GW9WojP9bkZ2u0dc5AFolRHCXnUJCWIz+2H5Ks8VgcOZqIH/7j+uWLpz796CM/fJ5594SsPEGLO/j2mFSeKMoqO/H3TKhQoeI1CvHNWaCIt+4+533tZvb1J7TvhC5VMSs2H6MIhVETo3AsG4XHGTNfGmXnaDSLkh+L54oKiVI22n+fUbr8uCBYeeLe3Z/iY2PHvfXnP3vhc11YeULce0KtslOh4l8kRBFzGfPShEnE3zi4fLlu074JL777gYlTy1bFUZevZLQ8FkdLHmOGyj6fcdSP+WPMI95PjxGOmRTF0XSsC9MqAyb4sWws2n0kVz6Kx+I5kfycbHj04P7f9u3dvezTTz/1xedaLE/wxR3GvSeM5Ql7VtkpEatQ8RqHXSJG3tyxY5/fix/+imLUxKsJ2fLYckTB4mgSLzsWRvaxmoSZXAW02yQ3y+PSzYrtQZSveCyeM0OytTUSdPmk7KyH/3P98uVTn3zySXt8nm0t7jCWJ2Sr7AoSsShjFSpUvGZhr4j/snXXoSa37+dl8V5iEU2AXKzG0fKceNsEZq7SEQUnnqOPtRw1+LF4'
$j6 &= 'rniQKMVRdk5+n7Y4xDxqx+bRJo8fQdaD+z+OHTt62FtvvUWTdnxxB22Pyfee4KvsxPKEWmWnQsW/SBQkYr1rQhNxTEyK15FjF87QBkBGETMZW2TD2qiJV8CQDdsLEy8TnOWoHXPoceJYGogyFo/FkVbs8fs12fJRBr+s0pzZ83dUqVSFeoqpPGHce0JWnijqJkBKxCpUvKZhl4hrNvLxbhc6fFvGvLWPc7PN8hWxT8SaVIsqYlG6/FiDfz66TxxFtI8rGUTpiseWo1G2snMcWmVH4769+390d/ekSyhReYLqxFSeMLax8fKE2gRIhYp/oShQxHWb+X3U2KOnbwP3Xgec/UdDvzFptEcCCtAsYBEuWLNo+Wg+ZyHhLB12WxOr9Wh5juTKR8tj2Wg8LinkIjaXJfheFto5y1HO07w8GDc+Zv0nn5QJx+eeyhPUxiYrT4ibAImLO6g8IS7uEMsTKitWoeI1Dlsipjfw790Dhw1o5j38UZO2w6Buq67/bB00Aq5fvYnyI5lyuCz5seVI4pVLWBAtPxbPGdCkq41yuCRLAi5X8dg4Wp7jEjbLWDvWRCsbLc89zc2FbTv3fhcW0WkMPveyrTHF8gTfo9jYPcEn7UjEatJOhYpfSdgUsWPrLnVbh4y96Og7FBxadQEHl27ggSLeffAcZD1E8VEJQi9DELLShOV9JEttLCokWmM2TGPB2bD2cfL7Sg4SKR9tI5Ox5TmqEz/Nz4eYmJgp+PzzNjZ7yxN8cQeftKPyBM+KuYiNWbGSsQoVr0mIb0oLETfx6tetufeQ+828+kND165Q37UbNG83AAaNmwn37j1kV+3gotUgOVqOVtkwL0OIo+nYXH6wHC3PkUzFkR9rYpQJt6D7io8mUcvjlyH38WN4kpMDY8dGrcDn3x8pqHtCdmFR2d4TBZUnCBUqVLwGIb4pLUTcwK3H/Eat+75o2qYPNHbrCg1cEPee4Ow3GC5duGLOeGkUj0m+wqiJmEPy'
$j6 &= '5GPRIIHy0T64NPmxeO7lIHEaj0WpFgxmwJj9ahvU68f6+PxJPqxZt+mBT4ewifg7KGp5wtaS54LKE4QKFSp+4RDfkBYiru0YPh6z4Nzm7QZCM88+0Aiz4gau3aGpZ184eOQ8ZGEmK+0plsmYHZNIjaN9kEStRxKgdqxJUTYWdB+Nhd1nCYmUjy+NRMb5udlw6+YtSE6evg5/B94IX9xB5YnC9p5QS55VqPiVhviGtBBxhZptXOs4hl9p7DUAmiJN3HtAQ9du0LRNX4idthJu3LgLuTmynmKSpPEcP19crEsTHC5Jfh+/bY1MtMZzth/DrhbNRu28lVTFsSj3Gfjpxfcwc87iO//9YeUo/D3YKk/I9p6g8oTsyh0yESsZq1DxGoX4ZrQQsaOrZ826LUMu1HPtAY1b94aWXpgVu3WDxh69oHXwKDh99go8yctHAYqiFUcZdF9xsBaxJkgzliK2vE8UqvV9HNljzOeKJGIuVlv3iY8xQBvGr1i9+Z/u3h134O+BeoqpPFHQ3hP8yh0FlSfESTslYhUqXrMQ34wWIh4woFO5eo7B+2s2D2ECdvbBzLh1T2js3hPqOneFPQfOQE6OdtUOs2SN0uWjeCwbxcfJISEax1eDKOMiSJhjz2MEnuTlwOXL1yBuSvr9dz6pOhp/FwXtPWG8coc9S55lMlahQsUvGDZFjPy+akPvUdWbBGQ3cOsJLb0HgWPbPtDEowc0RDHPXLAZrt+8ZyhPkCSNo+ycOBrPWUMilI38+OUxy1Zb/cfFyI/NoyZSHMVj0zkaX47c7MfwFGW8fuPOfzRyC92Hvwd7LixaUE+xyopVqHjNQ3wjWon4069qlK/e2G9DHadO0MCtO7j69YfmrXtAU4+e4Bk8HHbtPQbPnjxBIXKhyuDSFI+LjrU8XwYuXv0YJSqOJFXtMeZjcWTiFY/FkQmVRvGYRvt5mp8LFy9egYmTp97F30NBV+4oaMmzmrRToeJXEuIb0UrEyB+/'
$j6 &= 're81tFrj9k8buHQG1w7DwKltb2jephc4tOoKazftg6dPnqEojfLl0jUey0bb9xn7kC1lWkxQjKZRPBbPIWaZFgcuVX5sHAuGRHzh/CWIipn6vHp95zT8tdha8mzvpN0v1comfu6SRIWKf6ngL2z+prQScZnydWtUbdBueT3nztDQow+4+vaFll4k4i4we/EWuPcgG3KyeRubTKqyc+Iov48LWDw2y9gOKaP0rI6No+QcyZLf1sRZEpBgjaPx2AxdRok2r9+8edffajT23ou/B1s9xcbL7dtaaWdvrZjzMmH8XK8SFSp+lcFfwDZFjLxRpUG7MXWdIoBw9x8CTu36QLPWPaBT/1jYtvuoHeWJoqGJlqOL0eK4EFBwVsfGUUQ/R2Jko35cunDx8mPxnDZpd+niZRg4YlLuBx9/3RV/D5QVGyftClppZ09WXJCMCVshe6w98K/1ssg+ty1UqHjtg79Y+Quci5gyJ5OIqzb07VyjacD/1W4RAi28B4GLb39watsHmrbpCXMXboDvnj2XCrWokGzNma8IP0fS5LcF+DnTKN4nGQ0wCeJ9Zkn+kmgizsvJhqyHDzAr3vG/NRu1Xfmb//wjbRpvnLSTtbIZs2K+PWZRs2IRHrL7CoJ/7tJG9rVFVKh4rYO/UPkL2pgR0xv3jW+quzSv1shvZ+2WYbQLG7h3GAitfPqxZc/JM1ZAdnY+Cs1arEWFZGtZghCPjbLF0UrA4ihC52wjF+IvD8n4xvUb/+zcJ/LJV+Urd8PfhXEjIGMrG8+KeSubrazYKGNRyBxRZIVh/FgO/9wy6Gvbi+zjObKvy5F9rwWhQsUvEvwFyF+49MKmF76FiJH3KtZy7olZMdRoFgju/oPArf1AaI4Z8ZBx6XD4xCXIz82zEqsceY2YhGkczRK1MRZ0H40Wx8Yx2yS811XGJOJHD7Ng6fIN0Kp1+3l//PObdNl9Pmkna2UTF3gYOygKkrEoO1FkRYV/Dg7/3CL0NYuD'
$j6 &= '7HMRxq9JyL43jijewlCh4pWE+KKjFym9iOnFTS98UcT/XbZyk3pV6rc7VrN5EDT3HgAe/oPBzW8AZseDIDl9GXz3zFb3hP2Y5WtEl2dBopUKV3ZOG3NwJMzHlhJ8HWBXQ8nKgqNHjkPb4H7Z739WsRf+LvhKO7GVzZgV803jjX3FvERhlLEoOqPUCC4x2X1GfhscPOiNfpFJbwX2GP424ewc/Ebt2rXp6/KvaYTO27pPhH+vxu9ZRPY9EfxnMCK+BwpChYpSC/GFRi9KesHSi5le5PTCN4n4T3967+PyVVt0rYkZcY0WEZgRDwDPgEHQ0rMXjI+bA0/yn0rlagsSonjMhCsbbZ17CbiALSUsG/nxLwdtj3n75k0I7BYJn31Vcyj+LmilndjKZisrploxlSj4ZkAyGdPv15aQjfDXhpTKlSuzzzE0MuWzSdOWB8RnrIuNSVs9acLU5bFDomb6hfcc4u4bFEF/LP7w8ccf/+mzzz77I4G3+fdRGFzWMmHz772gn0GUMmEUshHxvWEvKlQUO/iLiL8A6UVLL2Z6gdMbgN609G/tm5+VrVW1SgOfCzUad/g/Z7+B4Bk4FJzb9YEhkWlw8cpdvY3Nekc2Eyg2GkmGfLQ4lo227nsJzJK1F5IiH18dJGGCjudkrgRnj/bp+HvwQmxlxWIHBV9tJ+7MJsqY/sDKhGxLbjYZODyhQsKstXEp8zZeS567/sckYs6Gn6fMXsfA+36Mn7XmBRsz1t6Omrpy0cj4hUNGxWUO79JnMNW9edlEhL43I1zcRnnbkrTxey1MzoUJWpRuYahQUaTgLxz+YqMXI71o6YXMRUxv3Df/+O67n3xVrXnf6o3b/1y3VTdw8RsAHu37Q2DXcZCxcJOwCZBExigycSQh8vuYIGUjPy5BSKh8fDmsxVmScAkzsrPhxtXrENpl6MV6Lb3n+gZ1mewT3CWufcd+MYHdR0SF9ho/oYlrQBD+jqiDgvqK+RaZvJ2NShRG'
$j6 &= 'GXP5iZIzik2UmgVjEuc2SZ23YU7yvPWnk+asu5k4Z8Pz5HkbYeqCLZAyfxMkz98IdJvBbm+ClMzNkDR3A0yZtY7EnE/EzVx5Lz5j9bWYtBWbxyYuGD94YkaXgRPSwz3ataM/LPQ90mtPRCbq4srZHjETooyNiPItCipUWAW9MPgLi154XMT0IqYXOr0B6M37zjsfla9U1yn8f2s0CwZn777gFTSUlSkGjklFcYoTcAgKy3ysyZnvYUyjUZKlDQlUPC5Z5EItCjz75ccidHHRpGlz/9Z3WHT+iInJWWMmpz0alzg3a+LUpQ+jpq94OD516cVxyYv2jU5csKf/hLQZwb3GRQT1mhhWo0FrWoVnlLE4gcflZlNqfn59v/ALGfZF9LTl7RPnrJ+BWe4W5FTy3A0/Tl+8HaYv2q5LdiMkomg11luBmTITcQpKOhUfn5q5iYmbPkfinHX/l5CxNjt2xupbcTNW3ohJW3I4Nn3lhokpixOGRc3sOHDs9A6dB052+aamE/0s9H2LkjbK+dckZhUqTEEvCP5CohcavQjphUkvWnpB04ucRIxv4D+/V6Op/67qjXz/3sijJ7j7DwVX3/7QtX8MXL122yxdI4KEKWPWsl1Rxvy4dATNhSkelywkUD4WD6N8RfJzc+HE8VMwOWk2DJ2QClNmLoXE2WshORMz0AXbYOqinTB9yR6YvnQvTEpf89PEqcvPTJi24vTohIXrxkzJnDY0etbQHkOm+IUPiHUP7DqsablP36EaMmXHJGSeIZvE5tWh25cRPYZ/NXn6sojYtJWZMemrlk6Ztf5M8rxNMHP5HpiG8qQs1yxeGTIRy6HMOXXBZpi6cCtMW7gF0vDzpy/dBQmz1vwYO2PVZcyYT0dPX74/KnXxgklTF0WPipvbrdfIJJfuIxNc/MIG08IW/jOUhqBftaRV/JsGfwHQi4VeTDIR0wv8rd/8+c/vV6ndslv1Rn75NVuEQ8u2faFNwGAI6TEeVqzf'
$j6 &= 'h6IjkZrlKwpYHM0iNgqYjyWLtThLCpKoOPLjoiGTL4c/5ll+LkyITYfgnmMhMWM5/ou/BiWGGSbKkTLMJBwT5278Z/L8LSjmHSi1HSjM3ZC+fD/EZaz/fuK0VcfHT125OzJp8brRsTNiRsbM7th9SJJnUPfI+l17jazTf2RUrTHR6Y0mJGV2nJiyNCVm+vKpSfM2Ppi+eAfMIPli5qt9DZl0LcGPw2yXxLoFpuE4fSFlwBsBs2grCRdECmbNJOZpKOjpi7fBjGW7IG3JDoibuebRpGnL90RPW7Z7XPLCzLHxc0eMjpkV2GdUSquwvmNqd+47oXaDFt5UJ/+l5WyUsYgoXxkq/s2C/+LpxUEvHi5ievHRC5NesPQipuzpXXd3Z4cajX2vVWvUHpq17gZeQcPAK3go9B2ZDI/oEkp87wmUqkU2jJKSi1d2znhf0eFiFI9LBxKlcTQe20YmXUu0JdC0aXxy2gII7TkGRk+eAaNjZ8PYhPkwIWkhoDQxE16Fwl0HU+ZsREh4mzDTZHKGJJRz6oLtkLpwu5Y9Y+Y8bdFuGJ+6+vbY5OVrJyYvWh43Y8USFOWelPmbns9cvheFtwtFuMVKsragPwpEwux1EDdjJWbtKyA2fRnEz1gBUzJWQvzMVcgazOTXQdIclCw+NnX+BvweiyZngsoa0xaRoLXSxswVe9j3EJO26uz45MXLJqQsXjEseubYQeNT2vQeOblecPcRVdoE9yznG9y7bIUKtWnVYWFitiXnlxUzYRQyR5SwiIp/k+C/cHox0AtFJmJ6serlid+8V6m228yqDXy+a+DWDVw7DIHW/oOgQ8dR7MKibLEGytgs0qJC8uSjeCy7Tw6XpHhcupAwxVF2jkYzooBtS9hMfk4O3LpxE+IS06Bhq/bQwiscHH16gKt/P2gXMRJC+8bAoAmzYNyURTA+aRFKcCXKbj3Ez1oHCSjmKVTDxUyVYMck6HmbmWxJ1Il4nKiLm0RuFK0U+rwo'
$j6 &= '1fhZa5E1EDtzJUQmzoN+Y2IhvPcI8A7tBz4dh0KHrqMhvH8M9I9MgzHx8/CPxwKIS18BqXPWQiJ+3BT8eE3Q61DMVKqQC7ggSOiUQU9doEGSnrF0J/5xWps/cdryjWMSF6aNis9M7jk8ISAgvG/5tqFdvnby9P/EoWXLD2vXbvbe22+/zTdJKsnM2Shnwh4xiyKWoeJfMPgvl78IRBnTi4xegPSi1MoTmBW//3nlxt82aHeqRvMQaOyOWXHgEPANGw4Zs5bB/bsP2IbxmjBLEhKrcTQeaxIUj18vSLrZOnicrY1G6drix++fw7yFK6FOc2+o19wL6jr6Q33XUGjkEY6/hzBo7BEBTT27gJNvH2gbPhIiBsZDv8gZKL4lMDkNxYyCm4aSInlqwtWkmzBbEzaTNh5rItZkbZQv3UcfT5kvk3DGGhg7ZTb0HR2L2fpg8AoIB1ev9uDs2QGauvpBAyekVSA0dA2GRu6h0LRNZ3Dy6wNeESPw+4vF7y8NRidkQvTUJZCAIk9fuAnBPxIoZYZEujKSCyFpLn0u7XMm4h+AePw5IzF7HhWXOWnwxIyB7TsPoFZAXjMvSs1ZFLQtORck6MLELApYRMW/WIi/XKOI6QVELzB64dGLkl6oNPP+QaW6HtOrNmj3Y0PXztA6cDirFfuEDocr125DXi5dRokL9NWRw5AJ8BcCRSuORRWvkedPn8DevYegZ79R0MipHdRq0QEcXEKhgUswNHRB2RGuQShlEl5HaO7VBVq07Ypi7gluAQPAr0skdB48BfqPy4DIpOUo51UsEyU5U12X5MREaxKvWdQJszewGjFN0sXOXAUj42ZC71GTIbj7APD0DwPXdh3AyaMttPL0g/B+oyFm1irIWLsP5m86Ast2nYZV+8/D2oMXYfOxa7D5+DVYvOsMLNtzDqav3AvxC7YyJs5cC30nzIROKOi+YzF7TlgA0alLIGXOGpi5aBOkLaA6MxerBp8IZOf1bFrKfOrY'
$j6 &= 'EMAMOnH22r+jlH+aMnvNj8izKbNW50+cvjxnZNzcyJHx80f0HBHvW716S+rHLqqcuZhtydkeKdsjZBX/QiH+YrmIuYy5iOnFRS88U3nis69ruVSq53mwtmNHdlFRyoo9/AfCrgNnISuL5FMaWbEMc1ZsFvEvIGSSrS0sHiuXrD3k5eTAw/v3Yd6CpVCjkTvUaNIW6joHQ32TiAN0NCE3QmjUstEwaNamEzh69wAXzEg9UMxeYcMgoMd46DEiGQZNnA3jkpfSRBjryJixZCukL9rCMl8qQUyathSGTpwGXQdGgn+n3tA2IAw8fAKghWsbaOMfAf3GTYHEzHUwZ+0eWL77JGw7dQsOXsmCw9cew7EbOXD8Vi6cuJ0HJ+/kM47iuaM3smH/pQew5/xd2H3uLmw/fQs2Hr0Caw+chw2HL8HS3Wdg6ordkLhwG0zGbH1E3HwYNmkOTExeBPEzVkJa5gaYgYKehiNl+wSXtFTGBrRWOg1W0lhIpRr844NCTpi1Oi8+Y9X9hIyVFyfPWH5+XPLirUMmpHUcEjWja0DXwbQVqUzORjHL5PyyUhbfr4SKf5EQf6n8l81FTC8OetHQC4heYPSCY+UJ5MPyNdwmf+vg83M9pwjwCh4BnoGDYdj4dLh0+QY8yadd2YzSLD1IvnzUhCfKuJTEzCVrFC8/b0Iu1uLw/Ek+HDx4GPxCekCVBi5Q17E91Md//RuggAmzjBFXErIGSVkTM0k7GB+Lt91Qzp6doZVfb/yvZiD4RIyAgO6RENZvEgzA3+PI2HkwPmU5xGesg4SMNSi/ZRCVPA96joiDwC4DofuwaBiTOBumL9sKqzHj3XPxIRy9mQcnbuXB8Zu5cBLle5LkSyM71kfkFJ4nTt9B7uabOHPvCYOOj6Cod5y9A5tPXId1hy7Bcsysl2w7CXPXH4LkRdsgdcl2mDxzNSttjInPhBj8Y5E0azXMWIhiJcFS3ZiES+K1U9D0WNbxgdCEYNribZCG'
$j6 &= 'X2cK/nGKm7HyetzMVTcnpy07Mjl96dr4GctXjU9eNGPQ+Bl9B4yZ4tNz8Hha+SjLnLmkRTkXJmaZlAsSMkfFrzjEX6RRxDwrphcQvbh4eeL9ug1dwus08blaq3kwtPTGDCtoKLh3GACHjpxiK+2MsiwtNNFaHmsCFG/zc3ZiJVMdmXBl5yQSLQme5ObCnZu3IGNWJnxTqxnUbtYGHJzaQwNnFHErg4xdLWnEhCyiybkRk3OQVuJwC4WmKGeaBGwbrmXMEQMmo3yTYUQMZqOpy2B04lIYFTcPJqOcMzcegTV7z8F6FOWWkzdh9/n7sPfiAxQpCfWpSaoWQjZCgpZwCiV9huTMwc91Csd9lx/C+qNXYfXBS7Bw2wmYvfYAzFy1B/8g7MCsfCNMX7yV/REhOU+auhQSZq6CqfPXQ8aSLaxTIwWPmZyLAH3cdBQzkY5inrlsJ8zCbJ0EHZO+8k5s2rLjMdMWHYlOzZxEvc7DJ83q2290qnfbDl3oAq8FZc5ixlyYlI1CFt+3Iip+pSH+EvkvmcuYXhD04qAXC72ITOWJVq1a1W7g6LuwetMgqO1IWfEwaOXTF1av2wkP7mdBLrvkvrU4SxqSLB+txSsb+bENjGItCqbPIxdpSfAkNwdOnzwNzh4doHZjF6jXoh3Ud+6AIvbXsFvG5tsWmbMbCRlxDWFybuBKcu4CrgH9wa/zGAjvP5nVcAeM07ogolIWs4m+tOV7Yf7Go7Bo6wnYcfI6bEZZbjl+HXZhVnvk2mOW/VplyIVwysDpO8hdFPQ9zKARkvPZB0/hGN639cxtWLL7DCzccRJi8I8EdYfE4fcVi1lzfMYqmJS6ECam0MTlCkiavYbJeBqVJRBT5lwI/HH8samZKOiFmyFt0VaWPWes2AVzVu2FyemrfoietvxMVOqi5KFRiR6BnQfXCOtpWnzCxVxYpiwKWcn43yT4L9AoYjEr5uUJyoqpH/ODr6s6daGe4hpNOoBHwGC2NWZU'
$j6 &= '/Fw4c/YK5Oc9sZJmSUNS5aMckqJs1I+zjeNLwj6/ERIoH1+e/JxslhWnTs2AWg0doXYTD6jv5Av1W3VgaELWRWwDTcKaiMUShiZjXcjCcWMUcyO3EDwOZYJu5B4OTdp0Bo+ggeDfIxK6DJnC2tOGx8yCCcmLMQtdDdFpKyF29gZIX7EXVu87D/su3IOj1x8XW8ImUMZGuKC1EgeJGjNyFPS6I1dgFmbt8ZmboB/+4RgRvwBGT1kEw6JnQmTCPIhPXwaJKOl4/H7ZasW5a1nbH8+cCxKxLVLx46Yv2IBy3gSzV+7Ez7vqxcSkeQsnJs1e2D64O+2UR4mMbGWjTMoFCZm/V20JWcWvMMRfIP/lGkVMLxCLrLhMxUbtKtbxuFodRdy4dU8m4w6dxsDGrYeYiElwRnmWJGap2gPKkAtXPKaRiVQc+bEd8M9XZOSiLRT98v2XLlyEBs1bQc2GrcChpTdmxe1ZZlzfWc+MkYaERMQW6NmyGS5gDbOgeSmDsmYtc27sHgKNPcJYaxqVNZq37QY+mDUPHJ8Bk6avpj5eNgEYPX0lpCzYDJsOX4ATN7Ph+K0cqXwJqXwZWl2ZShZmdAlLoI85ybJwbaLwKH7dDcevwfRV+6Bdp5H4fY6CToPioffoqTBoQgYrZ0xMWQgJM5ZDWuY6SJ1H7W4k53UMmXRNoHxJwKnz8ePmr8WPJTDrnruajdMX4GPmrET5Z8z3CelOW5fSPAvf+6MgKRuFXNTsWMWvMPgvj/9ixayYlyd4Vswm7f7yl/fLlavSPLJaow5QFTNjN3+6lFJfSJ65Cq5cv1+qrWxy2Qow0epjsUFhmkYJUsEWFYlsCwJFTG1wD+7dg4lRMdCwZWuo1aQ1ODj56SLWaKBnx0zGIgWJWHreMmNmsM4Ma2gS0LFdVxgenY4CXo2S2sgyTfwXHcZPmQUzFq6GI9cfwfGbOXBCz4ythWsDQcBsks/AGUauCSsxI/QHgCYBD+P3sPX0LZi7'
$j6 &= '9SiMmb4MAnpPwAy/E7i07wtBvSZC71EpMDR6FoxLWgST05ZD4qzVrL+ZJgJTUNApKOZUFLAmX13ATL6YUesCTpm7ipE8ZwUkz14OSbMw+561FGKmLrjapc8o2gKULmlF/1mKUjYK2ZaMuZALk7GKX2GIv0BRxIQxK+aTdu99Ub6OU6W6be5WaeADTj7alTs6dBoNy9ZsZxcX1cRZcu1sJFfxuOSkay8ozxIRsUSyBUGZsABdweP82bPQwsULqtRzgnqOPihgyop5ZowiNglZkzKb0KOyhS0pF4RJ1ihdhD4PTRTWaeELzT07Qkjv8TAibh5Ep62AKbRIJGMNjIqdASNiZ0LKoi2w5sBF2HP+Dhy9ns0krGW4gmgtoPsMSMVrC7OQjWJmWfRd6u7IgUPXsmDPhbuw48xNWH3gHEzABKLT8ARo0jocn7tA/Lk6gUdgPwjqOQ76YOY8YvI8GJ+8FKbMpPa5tTAdM+cUk3w1ASfPIVYyASehgBNRwFMy6GOoZLMY4tMXQWR8xoWIPiPa4/uH9owmIdPueDIhG7NjWzLmIlYy/hcJ8Rcoyph++WJWTC8SlhX/93uflv+qSrOoqg19oJZjR3D16w9O7XrBNHzxPc3LR2GRhLmIX07IJELx+NVJGMVZIvIVkci2UKgsoYk4W2fkmPHQ2MlLy4odKSu2lLGFlIWyhRldzjL5CtBjSbx1W/qi9P3Axa8HdB4SC/0jp8GYhPlsUmzyjJUwJn4W9B0VD0NjZsDUpdtgxd4zsPPMbcyEszEDJgHKRCtKmKPJt2gCFrGWMUfMlLXaMn5ft3Ng59nbsO7geVi87TBEz1wBnYYlgGtAX1Z2cfbpjj9zT2gdNAACUcyjE5ewXuvZi0jIJF/KfleifFHAs1DAGSjgmbRiEOU7YxHEpS2A2OmZGtPmw+jo5HXt24fSJv+0vSddUYW2K+VZsijkwrLjwmSs4lcY4i9QFDH9wsWsmF4cPCt+/+Mvvm2EWfH9'
$j6 &= 'b+t7/9PJuw84efeG8bEZcPnyTaF7ggtZFLMdoAgtRkQuy1JCKtEiYFPgMtHag1nEdPvwocPg5RcMFWs1h3otvZksHUwythYyn9QzTu4ZxUzUp9v4MfVa+rB6cZugfhDedwJ0HDgJRmL2GztzDcRgBjw2YQ6MxN/3xOlLIZ06B9buhiXbj8Guc3fgGImXFnKgWAlrCRcAClUm49IQsjbxh19Ln+zbff4urD9yCeLnrwfP8MH4nNLzRX+UgqGZV2fwCh8OXQbHwaiYDBTtckP2uxQSZlD2u9Ak4MlT50FM6lyYlDIbYvF4fFzazwNGRM/68ssvv8H3EF1rkFbxcSHzDJnXkMXs2B4Zi+9jQsWvMPgvj/9SC8uK33vzzQ+/LF/VadW3dVv/vYFbV3D07gtdB8TA6g172DXtNIEaRSzI2LgSDwVoAT+Ho1SWpYWVPO3AKF6piGWCtRMhG6byBG0INGLUOKjXxFXPin0NIjbI2CBis4xp1G47OHXAzNcPmnvQv+eh4BHQGzoOiIIRsXMgevoKiJq2nNV9J05dAonzNkD8HGoXWwOLth6F3Rcewsk7T+D0vaeYaT5Bub28hDmlJWPKwE9iRswmEm8+1r7WvXzM5K9D8oI1ENRzBP4X4Mv+GGmTlVprX9M2ncAzdCh0GzYFoqcuYuUHlv2mI9NRwNMsBRydNAuiEmfCxCnp/5yUMgdGTEi4HdG1F10Ylq41SFdVob2iKUPmJQueHduSsVHEtmSs4lcYtkRMv3ASMb0A6MXAs+J333777S8q1Wg+8tu6nj9XbeQPLbx6gWfQEIiaMg/u38/WJcplK0pXP+YiNo2WSCX5suDXkZY0+HkLcdoJl65UviISwdoBF7AoYlr6vH3rdvAP6QwVazbVs2I/qI+ZsU0ZG6RM4q6HH1MXZUNjszZh4B7QC8J7jUIBT4TB0TNgcvoKiJ+1CqKmL4OxifNhXPJ8SJi7FpbvOQvbztyF/ZcfoXifosTyGVy+'
$j6 &= 'xZIwgTI0UnwRExIJo3xP3tIETDVjmjw8cj0L1uw9CUu2HIARk9PBM7AXOOMfo1pNvFlZpqGLPzSmlj53auOjbpEwcPLtBV2GJsD4RMx2p8+HydPmo3xRwCko4GQScIYm4IQZMD5+OkTGToWxsakwfGLC//UaPHoTvofoEle0+EMUsjE75jKm9509MhZFTKj4lQX/xclELJYn6K8zvTDeef9Pf/rI2dm5FWbEuZXqtIZmHl1Y9wRdvWPbnpN6eQIlKwrXSr7ifZqA+bGVLAuCPocB8T77kQlUwCjdAsVbVAoWMIdETFAXRXRMPNSs35JlxZS9aTIWa8bWUmZlDEfaIc0fmrYOhZZtO4Jrh+4Q1nc8jE7MhEkzVsGkdMx+py2ByKT5MBblOyljJUxMWwprj1yFw9dz4DiTZj6K0Vq+BQoY5SjDKFtbyGVbGDwDJgGTfCkDzoYj17Jg17lbsHrvacjctB9C+o6FNvg8NHIMgsp12kK1+t5Q1QHHBm2YjOmPXCOXQGiMmTFtskS73zVr2xU6D45F0c7Qsl8UcFRiBma/M2FCQjqMi5sOYydPhdGTkmFUdCJJGEZGJ0PPIWMv4nuIrjdIJQq6Eje/ACyVK3h2XJCM7S1RqPiVhfjLM8pYVp6gOhb9C/VhhaqOqyvVcv+rg3NHcPbpB21DhkLk5NmQn0tLnkm0JFZ95MdWcAFrxzTZp4lUHPmxhlG8RuSitRPh65hBWZaKgDmFi5hJ+GEWPHr4kJUrzp0+B6Mio+Hbui2hbgvMilGwJhmbpGwWM8mX9QljhufaoQd0GRYHkalLIDZjDcRlrGYCjkTxDhqfBAMmpEJ85gZYd/Qa7Lv0EA7RZj43UcKmNjQ7BYwytEXJiNY2XMCU/R678Zi10R2+8gD2X7wD6w6dhwnTF6NYQ1G2vlCjoR/UbIw0aQ+1iaYatRr7QPX6nlC9gSf+5+HHyhRcxk08wsDZrzf0HB4H4+LT8b9BFDCOmoBTYXRM'
$j6 &= 'MooXBTwhHoZGxsKgMdEweOwk6DVk9B0PT19/fP/QlbgrInQ1bp4dG2VsLFOI3RRcxErG/yIh/uKMIublCS5i+stMLwz6a/3Be5+Wd69Yy+VelQZ++ALtAq6UFfeLgnt372tSZHK1H7N0NfEySdPnKQJSudqCJCse24tUpkXFUr6agDmChLNIwghKmIv40QOUMT5+8+btEBDaHWo0cmMTbEzGupCJek7U8aC1uXmG9ofeY1JgZDz++5y+AuJm0cKLZTAqbjb0HzsFhsZmQMb6A7Dh2DXYee4uCvgB203tyHXkRjbbPY3JmP61Z5iFXLB4tdKFlkVbC5iQibS4sPovfn+U+R698QiOooCPoogPXX0IaSs2QcSASHDGbLZu8yCUbQDij3SA2s06QJ1m/lC3WQDeF8COuYxrNPBCGbfB59gXJUwLW7TFLU1ah4Ffl5EwMDKByZcJGDPgkVGJMAwFPGTcZBg4Ohr6jZgAfYZFQu9hY6HbgGF5QRHdJuP7h65eTSvvKiM8Oy5MxvQeJBnLShRKxL/yEH9xtkQslidM3RPIx19Xb766Yq1Wf2vgHAatfAZAYOdRsHL1FnhE22NSiUKXbEFw+ZrOoRiLg4VkbSETq71IhVpUdOmKGAWM4uUwCYsiRgln3X/AxhvXbkD6jLlQoXojqNOirdZqhtRq1hYat/ID/44DYEBkCvQbPw1iUL7U8xs1bSnreBgSPR2iZiyHOZuOIIdhw9GrsPvCfZb9kni5fM0CzmVlCba9pUBhmS9BZQxLSlbEp9nkW64p+z1GNWC8fYy1qN3APz7p0Gf4JPAK7Af1WgShZAOgVhMSL0q3WSD+RxGEz10QPndB4KBTr0Ug1EFB12rsCzUbUrmiNWbPHvhYHyZhLuMW7bpCeL9xMHziFJQw/kEbHwdDIifDgNFR0BcF3HvoWOg5aBR06z+MJAyh3fvlObl7xuJ7pzZC+1FURWzJmGrGfAKPt7YVpUSh4lcSooQJmYiN'
$j6 &= 'dWIuYnqBfPTOp9/4flPd8XyNJvivr1s3aNOhP3TpOxEe3H+E8hLkWhgoyZelxIRrRCrUoiII2CReEUsBW0g4KwszYYQkjDxEERMk5r179oOvfwSKwhmcPALAqW1H8O8+GvpFToXIxAUs+50wdQmMnTIHeo+YDH0jkyBm9mqYt/kIrD18CXaev8fKD2b50t7BOXopglanoeDEcgSKj5AJ1xpzNqxlxCUnY1P3gz75RvI9SefuPWHyTcpcDV0GTwLfjiOgeetO0Mg5lGW7NRvrAm4eyKTMxOsYDPWRBowgqN8S76OsmInYRxOxgwd8W7sVPs9urN7OM2PqqGgbNhh6D4+CoeNiYMCoKMyAx6OAx0CPgSOhKwq4c5/B0Kn3QOjYawAEder5k5tX+3X43nFA6iC0BLoaYkvGvJuCSoJiicKerFjFryRECROFidiiTtzBvWmlqrVa1ipfzXFPxTqtWWbh7tsXPAMHwpHjF9kFRm3KmNeNGXKxFoUSFbDp88mE+nJYiVgQr4iYCTMJIyRhDkk5Lzsbbly9CjMy5kOHrsOg7+gpMGhCGoxNWgRR05fD6IS5MHB8KozEMXHhJpi+dAvMXrcH1h2+DPuvPELxakuASbrEUX3k8tWy33wUnCWaWG0L18RdOXw/Yr64gpDJVgZlvyRgVh4h+eL3SW1zx1HCi7YfgriMZTB4wlRw69AbajVtD1Uc2kGNRu2hJiYKVIqohwJ2wNdp/ZYk3RBo6KRBEiYBO7Sgx3RAaVO9mLJh/Pj6nlC1rjtUrukElWq2hBoNPaARk7CGk08PCO01AvoOHwe9hoyF7kzAQ5mASb7h3ftCaLc+ENK1N3QI6/p3F6/2B/H90wihSzbVRYwyppoxTeDxbgpeohCzYnpP8qyYi5jLWHxPq3jNQ/xlEVzCRhFblCYau/Wq0HHAlBaB/RND+o2dMavP+EUzm7h3vV25rgfUbOQNzu36MBHHpiyEW7fuWXZQlJKILQQqCrW4'
$j6 &= '0OeRSLQksJSwXMQyCRN0H8n38cOHcO3qDTh49Axs3HEIFq/ZAeOnLsPsdyWMS6Ydx+ZDFLWfzV0LCXNXQ/qqXbDp5E04eB1leyuPLbog6XJMpQcmYJ75UleELQlzChCxIF4jZhEXLmNT1syyX/z+8HslCdPXoD8WW05cg3lrdkF02lII7h0Jjl6doQEKtYqDDys/UP23jin7pcwXpcvkG8oE3Igdcwn7Qz0UcJ2mvpgJe+PruS1Ur9+GSZiy4Uo1WkKFKk2gYvWmLCumzZBop7qmnh3BJ2IAdO43gmXAnfoMgohe/SGsRz8m38BOPcA/ohvSHdoFRrxo6tR6Jb6XmiGNEVHGVKagjgqawKNuCmpto4UfvEQhZsVUnrCVFYvvaxWvcYi/KI5Mwr/7zfuV/xzYa0rVjiNmOHYaOiOs+6h5iYNjV2zrE7Xs/pApG2HU1B0Q3C8F6rYM/Gel2m7QoFVH8OjQD9oFD4Ijxy7AYy5hC/HKkEvWChSlOEpFWlTo81ghF2lRsc6AbSFIGKXLoHOPtHNUiiD5njx9EY6eOA/rtx2iy/zAsNj5EJm8CCZOX8Ym4MYkzmMdAbM2HIQtZ+/CoRu5cOSmpXhNAmby1a6yYa79WsuXYyVbI7poC8JSwpYiZjI2CFkTsVYDpu+P5Lv3wh1YvfckzF6zG4bGzoa2wf0wS/WFb+t5a9lvY+p68DeVH+q31OTbgOTrrNHImW6bBeyAWXC9Zn5QtykKHAVco0EblLAHStjNJOFvqjaDrys1gHKV60OdZm1RxNTSFsT2qmgd2BuCuw2Ejj1RwJgBh3TtxQTcIbwr+IV2Bt+QztA+rCt4+Yc9qdOwWQq+t1oiooypTEE1Y5rAo24KXqKwlRXz8gQlSkrEv8IQf0kcJmF8VfzW19f3j35+kX/uG5n5xcBJGRW6DZvTrt+kVesGTl71j9FTt8LI1C0wLHEDDElYBwNjVwOeh77Ry8DVfzCUq+oI1Rt6g7tfH2jl'
$j6 &= '3QvSMCO7fv0u5IntbEVCFy7Bj4VzUqkWFSZdezFK1oz0fKEClmXB2kgZ8IN7D+DO7btw8+ZtJuDla3cx6Y7D7Hd86lKULma/CfNgZFwGZsDLYdHus7Di4GXYcf4BHMLsl9V8SbqsBKGNx3jdl6SG0iWYfAsQMCEVLweFKpesvRQgY7z/LEIi3nPuNmw+dhmmLd0EAd2Ho1CDoWp9X6jOSg8kX6r/apNvpuyXZcBcvloWzOvALANu3h7qooDrNPGB2o3boYS9UMKtoVo9d6hSxwUl7GSScLnKjeCrCvXg64p12XUE2R7PKGNqZXNp3wPad+wDod16QUDH7kzAPihfn+BOGiGdUMRdwLND6NM6jZqm4fvNGeEypjIF1YxpAo+6Kai1jUoUxqyYL4PmHRTipJ0oYiXj1zzEXw7Dz8/vP/v0Sfl97a5d/2vSpGnlJkxKaz0kdkXQxPRtJ2Nm74CYWTthQvo2iJy2GUanYAacsgFGJq9HGa+DoQlrYXD8GhiRvAGz4gSohf/SVcEMoqVXTyZjn7BhcPDwaXjKlj3LRKtjLFsUglSoxUUqXBG5eEUs5UugZGUIEjaJV+cRCpiXILKQO7fuwOGjp2D1pj2wGAU8ftpKmDBtOUxExkyZx1rO+oyOh4kzlsPKQ5dh98WHsP/qYzhMk24oX63+qwsY5UvZL5evSbyFyJcjla+AXK5FxVLGvBxBiy/2XbwHG45cgsHRU8EvYgC4eXfHP/jtWemBlR8sJt90+TqSdHX5IpQR12cCDkAwA27BBezNMuCaDT21LNjBA7NgV6hS2xkq13SEb6o3hwpVm6CEG8JX39SDL8vVgi++rgZfVarHlohTbzZ1T7Rsh7IN7QmhXXqa5OtNBHU04RtCIg55Wqdxsxn43nNFuIybIg0RY4lCzIrFdjbKigubtBPf5ypesxB/OcR/9JiwtFJq5p601AUHtiUt2Hs+ZeHu/01euPtvOP5f6qI9QKQsRBbshuQFu5Dd'
$j6 &= 'kJS5C6bM3wnxc3dC7JxtMDx+EQT3ngANWwXA11VbQrVG/uDu2wtatOkGa9fv1Cft9FqxKN8iSpi3uRUOCrQgrGRrjSjaQmHylWEW8GMTgnx1qAyhta49hru378GegychbdEWmDRjDVtwQW1nNPHWF8U7YOJ0SF2+G1Yfvgrbz96FPRcfwMFr2ShgS/Fy+WotZ0Lmi+IsKhbiRWnKkMu1MAzyZeDnw++Z+pV3nr0J0emLwDN4ADRy6Qh1WgQz6VLZoRZizn5Jshrm7DdMz36p/KBlwPX1GnBdTBhMAm5AAm6NAnZDAbtgFowCruUIFVHA31RtCuWrNIKvKzlA2Qp1oQxK+POvqsJnX1aGshVrQwPn9kzENGHXtE0YtPHvAgER3aBdYEeqBUPbACJcJ0ITc2DEU3cv35n43vNAXBAnpDnCSxQ8K6aJO7FWTOUJ6qCgrFiJ+Fce7Bfj5xf5u0Exi2snzds5K3Xh7ptTF+/9aeqivX+fumjf/6YtPQDTl+6HqYv3AZ5jIjZBQmaQlHdD4vzd+Jgd0GPIeGjlhRlKQ2f4okIDqFjLBVzpUu7ePSGg03DYsn0/PH/6HKUlF6w9yIVbECjUIgqYlT1kojUila6ILmBEJmAiBx+Xn5MLudnZcO3aTdi08zBMXUgXrNwKSXM3QPT05TAsZib0G5cCo5IXsksArdh/HtYducpazg4w+eaaBMzFy+u+FgLWhVpcZOI1Yi1Ze8mDM/cIPL73FI7i9z9/037oP24KdO0/AZq4d2LyZeWHxpgBN6XFFpT9BjMBO2Dmq8k3jMnXXH4wC9ihBXVBYPaLAq7dGAXc0EvLgKk3uJ6bXoLQMmASMGXA5b9txGrBX1WsB2Uq1IbPv64On5WtAp+WqcQoW6EWitgP/0DQJaiCoIlHCIq4MwR27GYSsJd/GEJjOGbCYUzQPsEdn7XxDZiD78M2iDtCm8bLsmJeK+YdFGJ5ghZ4GHuKlYh/RcF+Mf1jFn81KmXd'
$j6 &= 'xQWrj/4wb/URmLn8IKShfKcv2Q/TUMAae5mILWSMEuYyJhEzMnfChNTl0G1YPHgF9IAGTd3gs3IO7I1BdeImbp1g3sK12tU7UJCMUsuEOShWXbwkVwvhCuctQYEWhJVsZYjitRQw3ZeHX/tZXp62RPncZVi1aR/MXr4d5q/B5zRzE4xNXgJDomfA0MmzIXLaMoibvwlmrNkHK/dfgB3n77Ouh8MoXJb50qhnviSvYyUsXwaKkiOTrxG5aOWw2i+7GOgzOPvwGWw8fgXiZi6DqMRZ0HNwNDjopYRqDWnpsT+TcZ1mQZgBo4BZ9ksCxqyXMl+h/MDrv/VbBLAJOGpDowy4NmXADc2TcFzAlakGXLMlCriZLuCGJgGX/aYOlClfAz77qhp8+mUV+KRMZfj4i4rwCfIlnq/vqG0KxDJiFLG7XwT4hnQyiZhw9wkED+8A8A/vBqHd+kIbv+DHVarVisT3IV2OvzXihlCJgmfFvFZM7WxUnqANgsTyBO+ekC3usFUnVvGaBP+FMEL7xlXrO3E+jEleDeOnrYPJs7fCzGUHYO7KQzAdBUwiTiUJk4x1IdNty6xYkzErUczfBePS1sOgmDnQY0Q8tO04CtwCh4Jf2EBo7t4RxkdPh/Monjy67D6K0qI8IbstIBdtYWjCNU3qScVrCxRqkQQsk68G3ZeLnyMPeXDvPhw7dhblux9Wbj4Ic1fshJj0VTAyYQEMj50Dfccmw6BJMyFm9lom34U7T8G6o9dhz6UsJl+W+eryNQuYWtFIwChfFCdHKlW7eGIhXyMy+RqRSZfDsl4cz2Lme+7Bczhw5QHMXLUVxiXNh4iBk8EZ/4tyatMRmrqEQdUGtP8D1X8DoU5zWumG2S+VIDD7pVWcBJMw3eYZsKNxAo4yYG0Crqap/ksCbgXf1nLUJuGqkYAbQzkU8NdMwHXhS8yAy5SvCV+wLLgqCvhbFLAm4Y8+r8DGryvVwe/Hm135hIm4dSi4+mDWi/L1'
$j6 &= 'xEzYHeXr6N4WGrdwAScXT/DE275BncC1bfsH77330QB8H7ZDPBExK26CNECog0IsT5RFxDqxcXEHFzFlxUrEr2lYSBj5D8+gft94hg957tV5PAT0jYeuo2bA6MQVMHnmJojJ2IxZ7m5YuPY4zFimZcZaJmwtY03ENKG3BaIyNkHULASlPiFjC/SZOBcGRE6FsH4x0H1IAixbtY2J6QnKOC8nH/8l1zNkLuESlbEgVvHYLlCuLyFhqgeTfHMwC36I8r154zacOnMZNu48CjMXbYYRCYuQhTAE/2gNjcHMN3UxPuerIHrGUkhavAXWHLkGe68+hkM381C4eUy2onxJvEy+JgE/0XlZCSN3ScQvJ2OjfAl2GXxdvqfw8288chEyVm6H+Izl4BU6AOq1DIBvHbxZB0S1hu2hBq1+I/k2D8b7ePmBZ7+igLXyg4OpA0IvQVAHRKN2UJNKEPVJwO5sAo7a0Kj8UKlGCxRwU6hQBQVcGQVMNWAu4HI19DJEVS0L/lKT8EefV4KPP0cRf1aBZcQVqtTD762dNmGHIm7WJhTcUMSUBbdpHwIurX2gXoNm0LBxS2jS1AkaNmoBLZw8wLm198Py33w7BN+H3gjPimnizhGhDgpenqBWNrF7glbaiW1stlbZKRG/pmEhYcKrQ78v24UNPuwW2P//XP37g3vwMPDshFLulwBdR8+EYfHLYM7S/TBlzhZImLsdMpYfZEw1SXi3ScQJ87ajiDdD1MyNMHHGBpgwYz1MmLmBiXkinp84ayv0jc6ESdNXwN5DZ+HspVtw89YDtgSaZEwLPmgijwRamJSthSundOWbDY8NAiYhU+cECZjKELdv3oWTpy/BnoOY1W47xC6xMyp5GYxJWgyRKUshKn0lRCYvRAkvhKkrdsGGk3fgwI08lG++SbqifE2Z7618Tb4ck4Q1WEZrAcrTJvpjTPI1go+xgUzAHEsJP2ESJvnuOnsLlu88CRmr9kDfcang7NMFs99O'
$j6 &= 'UMXBl4nXVH4wZb+hmOFi5suEaxCwXv/VVsGZJ+Co/qsJ2BOqs/ovCVir/1Zi9V9NwDQBV+7bBihgrfygCbgmCriahYBZJlxGk/BHJOHPv4EPUcSUEZf7ti7UbeGFIm7PRNycROyridjDJxAaNGoOlavWhgaNW0C9+o2hZs060Khxc3B09cxyaNR8GL4PfZG2CNWKqTzBJ+2ola0ewuvEfKUdTdjxJc+FdU4oEb9mIUqYYL+gNsG9y/pEDDnhHjjgn+5BA8E9UMMtcABKeTB4dhwLvr3iIGJEGvSftAjmLT8E81cchPg5W1n3xIxlB5iIEzN3QezcbRBN0kX5WsCkrIl5YsYGGI/HI1PXwLj09bBs40HYe/gsXL1+D+7dw8zxIQrtEQmRRGrorhBhkjUfm8XLMQrWDiSilfGYEOSrCRjvwzHrQRbcvXMfrt+4AxcuXod1Ww9BbMY6GJ2yHMZNWwnjpy6HsYkLMAPOgLGYAc/ZcgK2nL0P+67mwIFrOXDoui5eWnxhWoBhLjuY5WspXg0SMgqSpCqF7uPo5yyEWxiafGXYlvATBu3ctv3kdVh/+BLb29jFrxdUbeCL2S/1/nZgUPcDlR/qCtlvfRQvyVcUsNZ+RgKm7FcTMNV/aQJO64BoBzUaoIAdzBNwlWuhgGvw+i8KmE3ANWCtZ2W/qQtlyteCL8pVh8+pBswFjPLlAmaZ8BckYaOIv0ER18Gv30brnCARe4aAu28o65ZwauMD773/EXz8aRn4smw5qFatBtSqVRsaNWkBLV3bPKhWs+5AfB+SiMXyBNWJ6Zp2vE5cC6E2NnHCjouYd06ICzuUiF/TEAVM8F/Of/oGDyrr32nYCRTvP0m+RtyDBoFHyBBwR1qHjwSfHjEQNmQ69IlaAEnzdsLufVcgef52iJ29BSZRSYKyYYmIiSg8JugciXk8ipjqyZFpa2HUtLUwZ+Ue2H3oDArsBty9+8AkZKmAZcjkWhj0NQTJytDEy7EU'
$j6 &= 'MJGFfzyyHj6C+/g9nz57GRat2Q3jp6+CySjgSTPXsp7fkXFzYHjcbBiBEh6WMA8W77kIOy48hH1XHrMFF1rXg4ZMvhoy+VpiKV4b6GKl7NQaLlPZfYSlcEUsM2D8o4DfP125ef/lh7Bo2xEI7T8W/EIHoGiDMPP1Z5mvtu9DoGnyrR5mv7z8YK7/hpsFbOp+0PaBqNOUOiB8tAk4fRUcbcpTlQm4FQpYW4TBOyBY/beSOAFXEwWsT8JRJ4QuYCZfDpMwF7EmYbOIK6DQa2MW7oHfnx80cg2GliRivxDwIhG39oUPP/oUPvmsLJQr9w1Ur1YTatWsDU2aOULTlq7X8T1I+xH7Ibw8wevEJGKqE1MbGxcx7yfmIuadE0rEv5KQSpgIjOj/VVDPUadQuiji/ihfDdeAfuDiz6HbCGXKQSTl4dAmYjT4do9mUu4ROQ+GJ66G6BkoYsx6x01fC5HIuLR1FoxPJ9br4DGd4+A5EnR0xkaIQSbg7cmzN8G5C9fh/IWrTMq0Ko+VLnJE+RZBwEy6ImbRiuLl52yJlz2Gfc5seIDy3XfwFKTOWw9R6atgyryN+BysQvkuQ/nOhp7DY6HXmGSInb8ZVhy4AlvP3mNdD/uvZbMlx0y+KF7WAaHXgY/dyodjunxlsi0IqXg5KFIRuWgLozAJ4/eB3zd9vd0X7uHzsAhCuo+Arn3GQk22528gky+1nmmTb8EoYLH8wMWryVcrP5gFTDuh1aX6LwmYrYDTBVwfBVzPg9V/q7D6r5NefhAm4EwC1ibgWPnhK8x+aRJOKD9YwUWsZ8Mfo4QJqhFrIq6F34s7Zu90bTtNxB6+weAVEI4i9tFE/HlZ+KZiZahRoxbD1aMNBIRGkIgDELq8Phcx7ynmE3a8n5h3TnAR22phUyJ+TUOUMCGK+Lftgvp/HNhl+CyU7/+yLBiFS5CAW3Xoi/SBVu37gDMtVUacfHtDS5/e0AJxDxmGkkmH1MztkDh/G0poCytN'
$j6 &= 'jE/npQgDejbMiZqh1ZKjEJ4lk4BJyiRyImHuZoifuwnicNx9+BxcuXYbbt95AM+fPoP8XKor6yUJQbiPhWMSLpOqvUgyXy5mre0tG25cuwnbdh6G3QdOwYylO2DK3I0Qnb4axqUsgeGTM6DXaNpcfQ6krTkAS3afhVWHLsOWM3dg/1W93xeFy8XL5MsEzOVrLdeiUJB4jchFaw+CgO/px/j1Tt99BgeuPsLf1wroNHAStA4cBI1dO6FoA1kpgbLgWjz7bR5iyn618oMoXy37Ndd/ScC8/qt1QFD5gSbgmIAdPPQJON7/qwm4PJuAayB0QFD5gQRcXRewZf1XikU2LMmIP0cRV6qJfxBc8Wf0hoauQSjiICZiqhGbMmIUcaVK30JNzIZr1KyF2XArcPJoRyIOREjEPgjViWnCjouY+ompc0LWwiZuAKRE/JqHKGDCQsKEk5/fmwERAyLcAvv9j3uQJmItG9Yk7Ny+Nzj6dIdmnl2gkUcEtMbHdBuWCAOj5sDgmEyIRfGmLtoF8fO2Yga7Wa8RU3kCM8MigTJmItbGaDzHpI7Z8qjUNTAqZRVMXbgVZi3fAelLdsCSDQfh8IlLcO36HZTlI3ianw/5eZQxa1mylWBtYRKvyGO2ApDuz8XP94g2X3+YBVev3oIte05AxrKd+McHf+4F+IcnbSWr9w6Mnonf92qYgfKdt+kILN51BrZg9rv/Ook33yRfGpmA6d92ki/jyUsL2ASKUiZdGXLJ2gMJWLta87ms7+HMw+dAy47HJM6G4ZPSwQX/YNdpEcTazqo1oM6HAMyCafJNy341AYdpAhayX60MQZmxlgEb679a9ssFzCfgNAHTBBwtQTZNwJGAKzkIAq7B6r9sAk4X8MfG+i+OdGzELGFCk7BZxN9Axap1oHajVpjVt0MRB4Ijiri1Xwi0bh8CjZ3c4YMPPmalicrfVoFqVatDzVq1wdG1DTi38b2F70FbIqbOCS5iamFTIv6Vhihg'
$j6 &= 'QpQwF/F/NWvW7M9BXQZ6ooD/4Y4ZMUmYBOzo2xOat+sGLb27g28n/Ndy6BToPWYaDI/NhLhZJN89kLxwD2tj0ybpNhdTwNrHROPnjJ61GSbhOGnmepgwdTkMnjQLug+Lg9BBU6Db6HToHz0fhsQvheFTaOJrNcxcsh0WrN4DyzcdgOWbD8OJM1fh7u378OD+QyZmvmjDPvlqUPabh1k2ZdtU9z17/hps2HEU1mw7Aks2HoSk+ZthdDJmvnFzYUTiIvxjlIF/PFZAKsp50a6zsO38Qzh4I591PbDSAxevUb4o3mMozuNGkRYXFKSITLy2kMtWhLJe8+2z92nhxXew+fgVSFm4Ef8LmAMRAyZDE/xD3cQ1nLWdaZNvVH4IQgGHWJQf6mP2axYwz4L1EoQjdUroAm6KAmb9v3r5gXdAOOib8FD9t2ZLfQ+IplCOCVis/xoEbJiA0zJdLmGNoor4ky++gcrV6+H354w/X1smYievINa25uEXDI0d3aDMVxXgw4+/gGrVa4Kzizu4e/mAW9v2/2zp3vYovgftFTHvJVYi/pWEKF8RUcRMwsjvnJyc3uzUe7ifW0C/f7iggJ1QwCTk9l3HQFj/SdBlyBQYGbeArZrLWHWEkbbsIExbsh9SF+9jizhiZmu9w0UVMWW8mnypLrwBIqeugKH4pu43JhE69x8L3qE9wbG1HzR0D4cWvv2gddhI8O+F39PwqdBv4hz8938hDIlbjGJexgQ9C2W4YfsR2LDzKBw5dRnu3X3AoKw2D2GLOQx1Yq3ckMMeQ2UH6ng4fe4q6+TYdfAMzEfRR81YC6OSl8KwuHko3lkwKjETz62EpKU7IG7+Rli69yLsuZIjl68oYJTv8Tt67Zcd6xJ9WVCOLyNiQhStNXoGjAI+fD0blu04Bun4n0n/CdPAyacn6/utVMcbBUzdD3r9tzlNvgnZryPKVy8/WGTBKGCtA0LLgKn+yybgqPyAAqYrYtAeEGwBhr4LGlsB'
$j6 &= 'J12AIdZ/efmB6r+igI0StlPEJhmLIi6P91fA70UTcT1dxM5tScTBLCvGrBcatXCBKjUdoFGzVtA+uCMEduoJbfxCfmzQzHkzvgdJxB0QUcS8l7gwEfPVdUrEr1GI0hURBWwhYYRW4fwhIKJPM6+wIf/wQ/l26BaJ2W8ijEteBtOX7IVZq4/CjBWHge87QSNBIqa2tfh5O1CkKOKZJOJNVrK1IEOTL0mbJuWiZ66DsakrYGQ8Cm7CVOg8cDy0De4OLdzbQZNWHtCqXSB4h/UEr4ih4B4yGNyCBoJLQH9wbN8PnAMGg3fXCRA6MBH6jJuFGeoCFOQSGJm4DIahmKPS18LuA6dh5/5TcPr8dbh2/S5K9iE8uJcF95F7Ojdu0taS9+DS1dvscTv3n4a0RVtheMJiGDd1JWa9i1HCeDxtGYxOmg8jEuZA/IItsPb4bdh7NRcO3XoCh1GyWunBLF+2+ALP89qvJmEzUqHaw92nUpESooCLI2RrAT+FMyhfum/PhXuwau9pWLT5IAT2Gg1N3MKgWgM/qNqAtp0MYBNxrP7Lyg+hKKUwvfxgFrBZvgjVhlHAtACDTcCx8oMfZr/aAgzaA0JrQUMB6yvgqAOiYo0WUIHXf9kEnF5+sBCw1gFhUX6wqPcaeTkRV67ugN+zWcROXoEoYZJxKLTpEAbegR2hNR67+4bgeWpro9vBf63fzHkbvv9kIlYZ8a80RPGKSCVcpkyZP1Sr5vyGl1fYW2E9Iz/qPHTyt31GT/37ZJRlOma7s1YegRnLD+HxAZiJt2fi8YzlB9ntdJQwMR2hssQUzJQnY0bMBMtELIcy5RjMfKNmrmf9tHQJH6onhveLBM/ALtCytTfDpW0AuKKAvYK6QN+odJi39yosOngDktcehfgVh2AMfp3QwfGYiXUDl/Y9wTVgALSOGAXt+8RBxPB06D1hHsuSI1OXQ1Taaoicvg5GT10Ds5bvhu17T8HBo+fhwBEEx/1HzsGKjQeQ'
$j6 &= 'g5AwF79HlHdMBn1/q9jH0/XdBk1Mg2H4hyJ9/RHYduERHLn9FI4iR/S6L616EyUsTrxZyvcp44QFulztwDwBRyIWMYtUlKl4rjApW8rXzIErWbDzzG1Yd+gS/o5XQbuwvtCp+3Co2Zg23tFaz0zlBz37tRCwSb4RbNT6gbUeYD4Bp12GyI9dD85U/+UtaCYBO2oC5jug0TaUFR1QvnXZJjzWE3BVmICNkrUWMMd8f1FF/ImFiNtBQ5cAcKbShF8wEzEJ2M0nCNy8tQk8zw6h4B3UiUT9o0Mzx034fiyKiGU1YtU18ZqEKF4Of/KtJIz8bljMnOqj4hY7Radt6JW8aO/ldCZd2uwHxYvCnbXyMMxGaMxA+XERz8DHkIzTCJ4V6zKOm7ONLW+mWjFb4syy3k0QwybwNsLEtLUQjVnlkKg0COk9Cjz9O4ET/ttG2W9LpFmr1uAT3g/Gz1gDyw/dhM1ns2DLuSwmvx2XspHHjO3INp3NeN+iA9chcdURiF22H4akrIQO/eLBPWwstO8dD51HzYR+0ZQpo1RRrpNmrIXJszZA7OxNEEu16IwNEIN/GKLStcw8dc5qSExfiBn2NPZ9LNl/BbZfeIiZbzabdDtIK97YqjdRvvla5ovSJZh8mYA18RqRSdaMLmgUrJb5FizdghCFajwvewyHlksfuZ7NShBTMteAX5dh4OAUCtUbU9sZoU28abVfLfs1Z8DhuoBJvBFMxKwX2FT/1QRcly5X31S7DhxlwFzAdCki8ybs2hJk6oAwC7iBJmDahrI87YJWAz4rqy/AMGXABnlaIQrY+Dj8WJ49C5juN4r4UxTx51zETlpGjCJ2aRcCXihc2mWtDY4kYIJKFXTOJ6QLuLXzz6pcvfZ0fD/aqhHb2zWhRPyahChgwihh+mX8Nip1Tb1hMZk14zN3Jk9dvPfO9KX7f0L5/ohi/b85q4/CvNXHkKMwB6U2GzNigkQ8a4VcxkzILDPeD1OpXoxCTqJl'
$j6 &= 'zvN3QvLCvchumDRzHcSgfPuMTYXAHsNRvh0xW+gALdzaQhNHN2jq4gnBfcdC8vJ9sGTfJVhz9AZsOnMfdl7Ohj34bz+x95pt9lzNgZ1XsmH7xUew9UIWbD73ADaevgcrj9yAjK2nIWrBLugTuxi8ukSBT/fJMGTKapi29jR+vSPQLyoTeo3NgB6jpsOoqSshecV+WLTnAmw+fQd2XcqC3ZcfafJF2RIkXy5gUb5s0o0QZGuJlhFbyVYEJStiLWBbWErWFjLhcqj2S5k2/fGgn2PD8WvQc3QcdO43Dlq26cbkWwPFW50WYDQNxAyYLkEfjBmwIF+q/5J8W+kCZpmvJmDqgGCXpGflB1HAWv2XlR/qt9brv7wDguq/zVG+5gUYZSvW0wVcSyg/6PXfL+0RMEfyGBKsfp+VhAnT48yta8QHJGLMiKvVaQC1GjrhHyRPtt+Eq3coa11jIsaM2ELE/lzEASjiuvaI2J4+Yr6gQ4n4FYcoXo6FgPtFJr01MGFxxRFTljdLzNybmbJwz820JQduTl9y4LsMlOyCdadg4fpTMH/tcZi35hjMR0jEcwUZU4nCSsZMxOYyBZMxbZmJ0L7FKYv2wcTpq6D3qDgI6DoQ2gV1gVZtA6CZixfUb+rEJjJ6jk2G5KW7YM6mI7BkL8rv7EPYTeK9ngd7RNmiCDn78D7OfhHMUBnsOB/2oyT34e1dKGjqYNhw8jasOHAZVh68AhtO3MFzKO1zD2H98Vuw/tgN2HDsOmxB+e68+BDFng0HSLYoJKr7HsLsUBOw1gVB50QBS8WLgmTI7kNsybdoAjZiKd6CYPKlY5TvybvP4MyD72DflQeQvnIr9B0VD4NGT0GZhEPdlsEoYH/WekbyrY3Zr9b9IGa/lPVq8tUyYF3ApvqvJmC6FH1tunyRIODqKOBqDihgVn7gS5D1/t+qjeFrFPBXJGC6Ekb5OvpG7Chg1v2AAi6jlR8KFDDLYCW3ZZg+jj6X9jk/tvo4'
$j6 &= 'FPFnchHXbNAS6jbXljm7+YbSpu8oYS5i6qCg+jBmyv7h7OoclBFXqlbTKOLiLuhQK+t+oRAFTLAnOzJu3kdpS/b3Slm0f8SUzN3zMEs9jKI8iaL8ayZKd8nmc7Bow2mU8EnkBCxEFqw9AZko4/lrCJLxMamMM1DGJGILGS/VyhkmGS/GzHjJAfy3fwOMiJkBoT2GQv3mraBNcHcYFj8LRqcsgCkLN7Psd9vFHBTmE5Rsvkm8omyNWIkXoc1xbHGQ5HnriVbTReEQR1CeXKhHUYZHUWLH6D48pvuYfHXxst5fvH2YT7rh/ZqA8WPw8Sa54uewB5l4CblYi4qlbGWcosyXjlHAZx9+DyfvP4d5G/fCyPjZEDEgBtz9B7AMtolLOKv/UgbMBNwsBAUcimIO0wVMGW9HQcBaLZgEXJ8tQQ6GelR+aE5XzSAB8/ovz4DN9d9va5OAeQcEZcA0AUf7PziggLXyA9V/P0MBi/s/fPwF1X8lNWAuSwa/XUR0EVt+Tg3ace1jWyKu3xx/3tb4XPiBm48mYnNGTCIOZRN1tNqOROzVISSrfpMWtkQsboVpS8T2LHGm/4iViEsx2JPqh0/05KRZlZIW7Q1PWrAvdPrS/XPSl+2/l7b04JP0ZYf+Z8mWC7B86wWU7ynkJCzBccnGU7CYbq8/aRbxOi5iWzLm9WIuY16iEESMsKyYlSn2QNI82lt2MXQbEgMTZ67Bf/svw6ZzjzDrfYJZ51NdsLp8r1lLVzwuXML5FiPVckW0uq6W1WpYZrrm21R6oKwXBY7yZQLGYy37pX/fUaqigO0UsSjcX0bET1nmexrZffEepC7eiL+ftRDUcyzUbxUKVer7QWUHPxRwALu0Va1mlAHz7DfcIvu1FjAvP+gCbkYC1rJfEnDNRrQBD6//koC1LSgr6R0Q4go4TcDG/R+E7NeGIC1vv6yICf3r6Oc+No3C8mYLEdeHGg7N8Od2h/rOvrqIOzIRUxbMRUwZMomY'
$j6 &= 'XcMuKPyRs2ubdHwfy5Y4G0Vsa9MfUcRqG8xXGPzJ/H8A8B/9x6Q26TN+1pKhCStyhieuyUrIpIkzlODCfSjS47B802lYtvE0rNxylgl4KR6TjEnEi1HEJhkj5qxYkPEqg4wN9WJeouAipqyYlykYlDGvPArzt56HORvxD8Hui7Du+G3YfOY+7LiQZSpDcBFbCFYiX2sBEyRfM7SYwkrEJuGKWJ7nGTBJ2Fz7xexXlK8Iyu04ZtNG6YqUrGwLQiZfre/3bNb3sO/yQ1iy4wSk0BaciQvA2bc7OHl2Zt0PVRvQtpOBUBOz31pi9ovydXASyg9U/2U1YBIwZb8oYNohrQUtV6b6LwqY1X+1DLhmQy5gof5by7wEuQJbAddYn4Cj+q/WfkY7oLHuB1PtV8t8TWUCC+mWApKvQSLWMIuY+OATXcS160P1uk3w53djInb3RdkGdTKLmJUltMk7Kk3QFZ1b+wbdqePQKBbfy7ZEzDf9ke2+Jm6DqUT8isMkYWLIhLRvOg+fuqLjyFng2ysW/PsnQcjgVOg2Zg70m7QY4mZvhzkozvSl+1nWSzImKXMZcyHbkjHVjbWs+CjM5jLWRWysF1uUJ3TYde5YzXgvm8CjXmNqJYtfuBtmrDuGcj4Fqw7fgHUnbsPWsw9YTZcyZJog05CLlkOlB3sQZWtElK9ZwFrpQSs/oGg5TLq2sBSviFycJY2lgE+x673lwdaT12HdoQswZf568OsyEqo29IWKdXygWkN/qIqZr7n+iwJuEYYC1rNfxwhBwB2ZgHn5geq/lP2SgFn9l8oPTcXyQzuUr17/5QswqP7LBKyvgPuWOiD4BJzQfsYm3yRbT74KARswy1fgM0sRf/hpOfi0zDdQrZYDirgx1G7sgs+TL0o3gl2Bg7WvcRHjMRexX1hX2mfi/Bv//VY/fC8bRSzuvmZrG0x79iOm+rAScQmHhYSR//DuOn5gm7DhT1sHD4I2IYOhdegQoL0iPEKGgne3'
$j6 &= 'aAgcmApdUMoDY5fB+LRNsGbrORTsUXa1jaUo4KWYIVvKWKsbk4wzZTIWasUZy7USBfUaizLm5QlRxrybIo4WfszeClEZm2HCjI34PdE2mJtgyuK9mC0fh5WHr8P6E3dYtrzzwiPYeyWHZcAyuRbEIRSrBXROgjn7NYv3GAqXkMn2hAHL++QSNiKXaMlA8qW9iA9cfQw7z96B9UevQK+xU8CxXVfW61u1AYqXdUBobWi1qPOBsl8UsFZ+0OSrCZjkq9WBaTEG7QnB67+s/cw0AadnvyjgGjQBZ9qAR6j/6kuQy3MB8wk4QcCs/ovytRIwyu9Vw4SLX9sEP8cQREz7TCBlvq6sibhOI9ZLXN/ZGwUcAX7BnVkpgjJhVh8mEdMFRANQxKFdwbmNz4X3PviI9iImEfNtMMXLJRlFLF5A1Chi2aWSlIhLISwkHJe8wCewx9gzbUKHQhsUcJvQwfqoEzYUWocMQrTVZyGDp0OP8ZkwdMpKGDttA4r2GKzeehYz5eOGMoUgYz07NteLBRkL9WJt4YdlVswz46k0eYcypj0pKCuOmbOVLWkmGYvQirwJtIXm3J2Qvv4EbDp+k10WnkoXVLJgkkVpyqH7NKwkrHMYH8c6IRCalCP5mgVsKVU51lI1w+Usu0+OTKTFhVriaBEJLZvefyULMtbuhsBeIyCwyzCUaATr/6XMlwmYT75R7y/Kl5UfUMAOjiRdTb4NcdQEjPJl2a+WAddrrtd/TeUHX63+y/t/af8HJuBWKF+q/2pLkKkFjS3AqKQvwNAn4NgG7Kz8oE/A8TYxFF6hfEbjS9aCDVjIV4TuMyHUiLmIv0IR13aAanUasmXODZy8waVdkH615nAmYgYTsXYpfd+QrtDaJ+hC5SrVbInYuDG8eIUO4yX1ZSLmHRNKxCUYooSJ/wjpN9m7XcTIM14Rw3UJG9GFHEJSHgae4SPwNmbKXcZB8KBU6BO1CEYmr4OJM7ZAysK9sIyyY4SXKYhM'
$j6 &= 'UzeFefKOShTURcGyYhLxCvuyYrOIt6GIaV8KuYxppPtJ2JPn74Apyw7Biv2X2ZUrSMYHdIwypu4IGWb5PoUjKF3qjuBZL3VLcNGKmS4hSth4n22shWsPMrkWjFZ+oI2D2Pd37zlkbj0EPUbFQyufPijTzqzUQO1mXL5U+62N2S8vP9Qj+aKkHUi6JvkSevbL9oYw9//WQQHX1vt/azUSJuAc2mD2y/t/ScCO8I1pAo4E3EAvP2gb8GjZr3kCrsgCZqB8P+MS5seyx9kHE6yVeEm4AlSSYFAmrMFE/Hl5ISNuyDLihk7twJVEjBJuw0WMEqYyBcmZrtrhixlxa9+gi99WqzUY389cxMYrdPArORsvlVTQNevU5fRLMcQnkf11cw0YMKx18OAsr/BhgnwLhkoYrVHGXhGjoW3H0eDbbTyEDEphUh47jZYf72AlB8qWF+kyJgmbSxTHrLLimTazYpKx3kVhEvEOJuIoGyLm8OyYmJixBeIyd0DSEvx4/Pzzd5yDHecfMLkeuIkSRmg8RIgCvkXtaJp4NQoWb8kgF21RkIv3KdCeDzTypdIn738Huy4+hHHTF8KgCang13EE1EV5UsdDVdp4h2XAJGDr8oODU0f891kTsCZfrf5LK+JYBowCrkcTcHTNOLp0UZP2evZrXoBhrv+66v2/4go4fQLO1AEhLsDg8kVk5QeW6RaEIF8Rdl72eCP8sRpWwmVwGQtSZhImdBHrGfFHnxlE3LgVNGrlgyIO1kTcXhMxSVgUcYfw7uDk4X0Y38tBCL9CBxexeEl98Zp1ti4eyq/iTIs5lIhLKcQnkP+L8Z9u/v2Wklw9wyjzlYuXESLe1h5L5QqP4IEIfnz4KPDpNhE69IqB8KFTYdDkZfjm3gSTZ+9gGfDa7edhLmbBlBlTJkwiNtaLScbGrNgsYxQxok3Y7YLJc7bbzIjlkJA3wrj0DcgmiEWZT1txAGauOw6zt5yDlUduMRkfRulq6H3DQtYr'
$j6 &= 'Crj0JEzI5VpcmIRZ3ZfG53Du0Qv8/p/Ast2nYEziXJiUmgmtfHujQEOhFma+VetTDTgIM+BgrfuBZ7+m+i9Jt5MuX8qCzfVfkq/WfsYFzOu/moC1+i8KuF5rqFLPDb41LcDQ6r+mCbhKJGAtAzbu/2Cx+IJJUYAEzDHexzGJlyRI8NsCKM3CKFy8HOEx+LkZvD6si5iWN39VoYq5RtzYBRq7+LB9Jbz8qYdYqxFzEdNqOypNkIhbunntw/eyUcS2Lh7Kr+LML6dPIjZeTl+JuBRDfALNIg7ot71dx5GCZO3AQsoElS5IyoOALhrahq5H130SBPafAp1GpsOopNWQkrkH4uai/Bbvh237rsACFCBvZyMJUxeFScSmrPig1sqGcBFTnThxwW6Ixc/FJ+yKyiS9tswm+lDKk+bshJQVh2DRzvOwcv9VWHvsDtsN7ThK69jd50y6Rglz5CJ9Waxl+jJQ5nvqwfdwArPftYcu4PO4GcYkLYDQftHQyDUcXNt2g5qNdQE3wuwXBazVf8Xyg5b9sgyYECfgMIPm9d+6zemqGVT/FSbgqP1Mr/9WreeB2a82AVeJ9f9yAWtLkNkKOLYBOwqYdkDTF2CYlh6z8oNEwAQTMEpSKmJdoFy0DC5iiYz5440fJ5yzECx+DTnCY/DjpSL+lPYirgDlKlYVMmJXTcQ+VJqwFDGVJygjZjXi0K60t8p+fC/TYg4SMb94qChi2eX0uYg/Q4ojYhXFCFHCBJPwqVMz/6t18MA9bSNGaHLlSGUrUNB9upRbY5ZMUvaMGAW+PWIgaGAKdBs7GwbHr4A1W8/CdBQq1ZSpZLFo/QmUMbWyWZYnLGSsZ8Uk4qSFKHXeOSGZsJOh7VWMzN4CMfhxk+dsQ5lvxz8OGnQ7OmMrJOIfjJQVR2Dx7kuwkfqUT9+HPZezUWiakEnORhkTcqEWF7lQi8qp+88RWnb8CJbsPAGZmw/BwKg0aN62K1Rp4AeV6vpC1YYBeBwA'
$j6 &= 'NRqTgENQwGGCgDvqAu6klyB4FiwKmMoPZgHXbtIBs2reAaHVf6tR/ZcEXNcVKvMJOLoEUVWt/mveA0LYAU1fgmwpYBSqsQTBMUm4Inyoj4Ujipgj3I/ytLitnytcvhztcZ98gTDhonjxc4gSJj40ibiaJuLaDVhG3NRVy4i1VXWaiHmdmESsLejoDE2dPIoqYtoC0yhi2gKTRMz3mVAiLoUwSpiJOCoqsZZ3xNDTbak+HEKtaxwUqgxBuLyTghDPi7RmDAH3YO2S+q3DhoNf7zgIGjQNeoyfx6ScjnJdgiKm1jQSL+8r5iLmS595Vmwt4i02ZUylC+o5psexSTtdvgTtfUyTftbsYJn7pFlbIRYz5dRlh2HBjguw86zeCoeZMpUsXlcRn7yHH48cvJ4NW07ehBV7z0Lq0u3g02UotOnQCxo6RTD5UunBVH5oHgq1Ub51WtC+EBGGDBjlywXMWtIMAublh6a8/uuD2W87ff+HNihfvf7LJ+DYAgxtBRzfgpLqv/wacNoS5GpsAq5gAWtSJEi8HCtx2pKsxXkj4uM0tExWJlsZmoBZtss6IsrDx59+DR988jU7Z0QT8TdMxFVr1YNqKGLqmmju5g3umBFrIiYJa4s52Ko6PSOm/YgbObrtwvezKGLa8IdETJvCiyI27kWsRPyKwyhielL/MzoyuVq78CGnrEUsglLV4eK1hqSsi9kkYBlDtMvpB/bH42Hg23MyhA+fAb2jFsKIpDUwGeU3U98wXpSwKGJtwm4vinQnClafsCNIviRkhATMJEyZL2W8KF2CPiaeyXYXJGQaoHO6jOkxHPo4qkdPmr2dSXn+tvOw9QxdOVnbyvLILX2xBgpUhly0hSGXbGHQMmrKfvdeegiLMQPuNjIexUrXe6PlxoEMtgVlUxIwdT/w7FeXL2bAWv1Xz351AbOeYJKvIy1TDsHsV6z/mifgajTQ678OrTUBs/5fLmC9/1efgCurC7iMfg04bQKOOiCo'
$j6 &= 'B1jo/xUE/CFJV8QgS0uMcrUXy89jKiVwLIRrhO4388HHX8N7H3wGb7/7Ebzz3qd4+ys8LxOxtqquvCDimg0dobmrN3j40L7DMhGThDvh/UHf1W3QfCG+n0nEtBcxF7G9V+cgEdPyZuOm8ErEpRAyEf92woSY6m3DB5/yCh8uyLQooFztxSBk6rogGbcOof5llHL3aAgfkQH9Y5bAiOQ1MJUyZJSy1kt8gNWHNRHT1Tz2MnmycoIuYi5eLfvdhgLexjJbki9Jdgo+fkrmbn3UsEfEMkju01cehkU7aZn1HdZbTFmyqZ1NgEuaS7ZocpYLV4RW8PHl1zsvZcGY1EwI7jESWnfoB9UaY9ZLNNLGmk1o8g2zXyZgnv2SaEm6nXXxcui8uf5bjzZrb6GXHwwCro4CrsYm4Kj8YJ6A0/p/zQswvtKXIFt2QFD5ge//IOuAMMgXMcrSEplcbWH+OC5a420p+D0w8bIMmd/Wzn2CkHDfJQG/8yG89c4HjHff/xQ+RDGLbWscaxHXZzuwtXD3RvEWIGLaFN43+Ps6jZotwvdzcUVs6+ocSsSlEFIRR0bG1mobNvi0J2bEctEWFV26JmTnJJCYw4azenLbjqOgfa8Y6DxqFgyIXQYjU9axCb4NOy6gnPcwIScuoBa2XWzCLgazYoKy1liW9SIoSxIqyZYm9jhTCEHG1iImBOni+cQFu9imQ5PTV8Ok6SshYeYa/Fj83NRGh58rAT9nyrL9mIFegtVHbrH2N5oUo55ckq5xibNJzhx8jAaXa8ESpu4Haj2jRSQn7n0Hx+89g2V7T0OfyAQYMSEJ2vgPgBokXKQalSCo9tskBGo1NQvYXHqwFDArRejlB7oyBpUf6or1Xyo/CBNwJGBxAq5yLRfMfjUBa+UHqv9qHRBiD7CWAWsCZi1o4u5nEvmyEgQK0DYyycqw/DipZIsDfc/4+T/4uCwTLhPw24Qm4bfw9rvvfwYfUmmClSpEEVfA8+VY1wQr'
$j6 &= 'TdREEddygJr1W0ALNxKxtgE8FzGNdJtKE3R1DnefgO9rOjQWReyDiHsRG0Us7rxma1N4vrxZibiEQ5SwScRda9f+L4+gAbtpMYe1VF8GiWwZBd03GDx0NCmPBO+ukRDYLwF6jpsPo1PWspV80bO2wba9V2D2ykNMuiRjIl7Pepl0UZJUR05CYRMkbpOMmYg1GRtFzOSLn5PKESRYyrj7jpkObt5dwM2nC3j4doU2ft2gbUBPGDxxBvsc9BgiEbP0JPyDMXXFIVi4/TysPXobdl/OhtNsm0ijmM0ZMxe1JmsBlC6XM7Wf0UjZL0n+5MMfYO2RyzAmeT4E95oI7gFDUaYR0MSlI8oyhJUiajQOxgwYBdwsDAVszn4dMPut70zyNQjYmQQslB/0DXjM/b9+5vpvfT4B547ZL/X/8vIDClifgNP2AKbyg7YEmW3CQ1fB0HuAP/4S5ctLEJ9XRuFalh54/dcoT0tksuXIHq+hCZSLUBCq1W0zxs9Pj6Xs9yPMZj/4+Esm4Lfe+UgTLwmYw7Lij1iG/NGn5djHGSER0z4TFavUZCKuiiKmHdgcPXxM4mUibm8WcVsScTCJOOhFrYZNl+D7mRZzcBHTPhPipvC2tsAsTMR8wx8l4hIKo4jpiaUn+HduQQN2tuuE/8qGDDRglOvLYJSurfNmPIIGMtqglL06jUUpj4eQgYnQPXIeJMzeDtEzt0AUQgs8aNe2pIW7NfkaKUDETMZMwMg8rR7MOilwnJSxGboNnQJNWvljtucM1R1coVZDN2jcvA3Ua9gKs5HeMDJ+IT6Wrjy9lWXlk/CPRHTGFibx1OUHYebaY5C59Qws230Jdlx4xDYGIikTmpQtRSwKmcRLIy0iocefevgC9t/IhemrdkBU2mLoPSoJmnh0ZTueVa7bAarWpz0gqAyB2bCp/hthUX5gAmZQJqyVH7QJOC5gyn7pqhli/y8KuCH1/3IB0wbsKODaNAGH2S/bgEdbgFHuW30B'
$j6 &= 'Bqv/UguasAkP6wHWyxAs+9UyYE3AmoRN8i2WgAt6nHZbk6q1CAnLz2ULWnhBq+AqojipBFEW3sFMl2rAb6J033z7fUsJm0T8Ibz3wef4seWlX5tE/FmZilCpai2TiKs7NEURe4OnIGKOlhGHsYy4lVf7h5Vq1J6G72WjiIuyKTzfeY1ELNt5TYm4hEIUMcuGESZil4A+Cz2CB0CbUBJjaYmYEEUrO2cb2oDILaAfHg+Bdl0ngE+PSRA6OAV6jp/HMmXaHW4yQtJNXUyXVtrLsmJNvmYJW4oYYaUILRMmoVJNmXVUZO6BHsOToGFLb9Za9W1tJ5SxE1Sv5wQNm7pCvQZOUL+JGwR1HYpSXMPky2vT9PGUIZOYWf0a7yPJZ2w4CYt2nIOV+y7DtrMPWE2XMl6zlHUJ4zm2Xebd53DqwQ9A+1ss3XMaMlbvhJFTFoJn6BBo6o6ZbctQqOzgD9VZ/VfPfptq2S8TsCn7FQRMWTDdprIEq/+G6/Vfs4Cp/quVH3w1AVP5wcETquoTcEzAevnBvACDT8Bh9qvXf80C1veB0FfAaRkwF69ZxPZLmDAKUvYYwvwYSwlblge0x5BkzY83Qo+jzgYS5qdfaFmwJuD34S8IidhawoRZxKx7Qv9cIiYRVxNF3ASc2vigdAsQcXBncHRvd/WrCpUm4Xu5KCKmDX/ETeELE7FRwkrExQxbIv69o2+3aLfAfk88aRKNBBysYyFlQpRqSUBfT3auIAaxRSP4/bLVfG27jAf/flMgYnga9I1aCGNS17HOi9g5OyAZBZxCm8oLAjaKWCxJcBFTrTkBP5ZKEZ/jv9AkF+pxpas9VKhSHypXbwDVazeGSt/WgFYevjBi8hxNxPh12SQhQTJGtOxaG2N0KVMmn776KCzdexnWHbmBUr7P9ksm8dIqPupTppV9m07dggVbj0HK4m0QPmgytPbvDVXqm7Pfag1pAx5NwFrvL2W/HVn2W8+i/MAFzMsPWv2Xyg+8'
$j6 &= '/7c2Xb6e+n9Z+cEs4GokYF7/pQUYTMCOUIFfA66ydhFOc/1X24SdC1isAXMBc9lyERdNwPZiLVHLc1pma33bWsaatLWVb598Tm1oX8EHH30Ob75F8tUELJUwIYj4XaOI9Y4Jtik8E/E3IGbENeo1pWyXCZdkLBUxZsQunn7XK1WtMRnfyyTi4m4Kz0Vc2BaYSsQvGTZF7NShZ6xbYP/nTMRcwjKsxEwYRVqSGCVsjQc+jm3XiVJuR1IekAxdxsxmnRcxKLwpTK7bUbq72PXvrCTMRUyPQ7TJP5QnytQzoDfKpgF8U7UR+xf707LfQvlv60ElFHHVmg2heq0G4OHbEYbFLsBsmDJgrU+ZTRrqEtZErNWcScgcEjbJeyJ+jwmYfS/bfxV2nM+CnXRdvOPXYdXBSzBu2mJw9OkGdIWLbzHzrdpAE291pEZjcfLNLGBz/beLjlZ+4BkwFzDVf+s0IwH7o4BpAo73/3oL9V8Pvf5LAtaugCEKmF8DrgwJGLNfJmCUr7YIgy9D5gI2Z8FWJQhCKlOND1FaRrT7uCzFYxGjWPlte9A+RpNwefjw068xay0L73/wCfzlzXfhLyhhqXiNyDJiXcAmEePX0URcASpVFWvETcG1bQe2lNlWRkw9xO38w643bNLCKGLaZ0LcFN6evYiViEs5RAmLIqYn+fc+YQMneYUMesr6hGUCLgpWMi0+JFnLc9YiNsIm+kKGgE/3KAgamApdI+fBwLhlMAmFt3DNMUhACZJ0mYj1TNiUDVN9GCXKOjBQyP2jMqHzoHgI6TkWGrqEYJZXDZp7dgKndl3B0asjhA+YDGOnrWP9xSwb5p0bVgK2FrFI7NytbNEJbUw0c8VO6DJsEgR0GQLuPr3gW5p0a4LybRLExppNQqFm03CUcwRKuCMrP9Rz7GQ5AYcjXwmnyVcXcAut/5cLuHZj3n6mTcBp2a9efkABV6IJOLYBjzYBp/X/6kuQaQtKfQLOfBl6zH7ZKjhB'
$j6 &= 'wKYyhCHz1TGJ2SRdjrV8RcxylWGU6stAGezX8M57H6OA39OyYD0Tti1ewzHy9jsfoYi/sBQxfn4OE3HZilClZl2TiGuiiN29A6BdQEcLCdMl9UnCbNMfzIi92odcdWjQlEoTtJhDFHFBm8LThj/F2RReifglQiZiVh9Gfh/RY0Swd9jgC7Tpj1SuxcVKpC8HlSQs5WwtYjP0swwC2q6TNiIKHZoGPSYsgCEJKyFy2gaYv/oopC/dxzokeDbMoayYhKpNvm3VMlfaLChtPUIb0G+ACekb2c5uVAO2ELCVfI2gfEnSrMeZ6slURiG2IJvxe9kKA6LmQst2/aCyQweoRvVfEnDTEKjZLJR1QNSiGjDLgDUBa+hZLys/0DEtzjDXf+uYyg96BiwswKD+X03AWvlB6//VV8CRgKn+W0lbAUd7AGsTcJLyg94BwRFb0YzitcBCwBy5gAlL2ZaGfInyrMOBygXUFfHu+1+gUD9BAfNJOeQtSUlCkK8I1ZLf+xBF/LlZvqYSBcJE/KUu4lqWIqbVc9Q3bMyGScS0zwQtb/7LW+/0wfeyPSK2tRcx3wKTi5h6iJWISzgKEvEfajZ2rebWoffmthHDUF4DBCRyLTYoTltYyNWMtXj184R+n20wO6bH0OcP1fZRbhNOi0YmMCnT5Z+GJ61GsW7CLHknWzySmEmi1DJjawRJs4xXm9TTkD3eiFnAsQSTr1nAcSThOZtw3ASTMzbA5Blroe+oFGjp2RWqNqQrYNAS5Aio0wKzYAsJd0ThUlcE3xmNlx9ou0oUMMt+6RJG2gScqfyg13+rUPlBvwIGr/+KV8D4ShewlgFr/b+mDghT+cEgX13AvBPCJlIBE3IBf4jyIuTifDloQcX7H38N7374Jbz3UVn47ItvUJxlka8Y737wJbz/0VdsUo3Gt96lVjW9Xa1AGWtlCWsRmyVsEjHLiOtgRlxX6yN2aAIeLCMmEZszYk3E4SYRN3Zy3/vHN/7SC9/L'
$j6 &= 'JGJbexGLW2AWJmJxMYcScQlGgSIOCur4jVdI//XWIhaRybVoaNtliudQkjpcmnZhlG5h97PHDNQv/TRYWzTSaQy07xEN4cOmQ99JS2BUyjrMcjexLorEzF04akLWMlw9W6ZzpjIGxyhcI1zWJF8uYJKvWcAkX5JwAjJl7kZInr8JUhdsgcwVWyExFbNjz+6YDYu9wFo7mjZqAq7LxEu1X738YDUBxwWs1X+r1KX6L5+Ac9L6f9kCjKbwtWkBBr8KhrkDgrefmTbiYfIVBGySMAq1MOyWsFyeJcH7H5eDt94vA+Uq1oDGzV3AtbUPODRygjf+8jH85e3P4J33v0QJl2WQkN//CEWMH/MuCRqF/M57nzHRyjNjTcJcxO+TiPHnkcFFTBLWShP1oGb9prThO9tzWCZi6iOmq3M4e/js++yzskYR0z4TBYmYNvyxtSm8EnEpRYEijowcUcU3YvAmr/ChKEWZhGWIQrWGS7dokDA5xtt2wIQrOWcEP7d7UH9wx/tJylS6COwXD11GZ8CguOUwOlWTcvKC3WwjIl66oLpxrJWIRSwlHMskbJ39GgU8BUmch1+PBDx/I0zL3IjjBpi7fBvMW7oZeg1PZLuj0cY8fGN2dmVkhC5RT/KtQ5esR/FqUPZrXoBRvUE7qKZPwGkC1hdg1DALuJxpAg4F/A0KmHVAaD3A2iY8JGB+HTih/isKWJewzRKESKHy1SiNsgNtsPMeZr/vYPb7TeXa4NiqDYRFdIP+A4fD0BHjoE//4eDZLpAJ+c13Poc/v/kJChcz5Q+/ZpCINTCDZiULrYXNdpmCi7gMfII/j0zE73/yNStNiCKuVb8ZeHUIZVdw1lbU0Qo7MSMOA5/gLuDW1n9/+W+q8NKEcS9io4jFLTDt2RReibgEo2ARD+z6XtvQ/ou9CsyIjcgFzLEUbFEgUWqytLxtB0yyEowiFsGvQZkySdmr81jwxSw5ZFAS265zVNIaiJ6xGSYiVAOmzYbi'
$j6 &= 'aWc2lG6slYS5iIXyg0nCXMDaaM5+N0ESCjgFBTx1wSaYjqQt2AjTMzdA6rx1kDh7DSTMXgtRU5eBWwdatkzbVNJ14jTqsMxXEzBlvjX11rMaDbXs17L+a56Aq0gCrqbXf2kFHNsBjV+Ek/YApj0gaAWcOQM2lSBYFkzSlUiYkElXxi8gYio/vEvlhU/LQcVv60CT5q4QFNwJRowcBzExUyBmciJET6IxCSbHJUPfASOglZs31K7XHGgBx3+//TnKG7NilDBt5vP+RyTiz5loNREbZGwSsVYjJhFrk3SWaN9bOfjiq0qCiB2gVoPmQkZsXlEnitg3pAs0d/Hc/NZb74The5l6iGWbwhe0FzHfFJ7vvKY2hS/FKFDEyJ+cO/RObddxBLRmrWDW4qVz9iFKtSTQZGl5uwQRpEx7J9OiEffAASjlSPDrHQuhQ6ayRSMjEldhxroLYqhfeDZJ1pj56tmvVQa8Rc9+ScCbIQHly7PfqZko3oWbIB2ZgaQt2ABT56+H5Dko4IxVEJu+EmLSlqOIl8KwSbOguUcXFDEtXfaHmk04KOBG7VG8vpj5eqN420JVtviC2s9QwHXctfIDn4BDAWv1X70DAgWslR/oKhhcwPouaIYWNIsasIRCa8KcQgRsnoDjyMVaFOhff7bNZKWaUL+RIwq4I4wdGwWTmXwTYGJUnBWTYhIhIWk6y5Jd3H2gcvX6UKZcNXjrvTKsjkwypv0jSLRmERu6KSxE/AXQnsRWIsYMnerGZct/C1Vq1IUquohrN2wOrTzbsy4Jo4jZFZwRv7BuUK9x88X4HpZt+KNE/JpF4SL265nkGTYUPEjEIlLZ2oso0NJAEGop4BbQF+kPnhGjoUPfBIgYng59aLtOlDItytBWz/HeYYKOLQXM5ItMQfkmUekB5Tt9wWaYsWgzZCwmSMIbYZou4HgU8OT0FTBp+nKIRgFHpS6BiSmLYWziAug5NBrqtQyCKg7eUB3Fq8mXSg/U+6sJ'
$j6 &= 'uArK91uUL1v9xvZ/cIZvqpOA+QRcY638YKr/ikuQ+TaUooA1CcvEa4E9k3NEARK2FjAhF6u9UBb8AWabn+K//fUwwwyP6Abjxsew7DcqOl4qYCIKicb7J2GmTNlxUnI6jMdz3ijEsuWrQZmvq2BGXBYl+wn85a33GKKMWVeFIOS33/0QH1/GhoipRa48lC33LXwriLhOo+bg4tUBxWuuD5tkzERMk3XdwKFJS9pnwtbOa0YRy7bAVCJ+RVGoiJu16dynVYc+2W1CUHBB/a2FzJEJt6D7LDCKtDSQS/VlodIF7aHsGT4S/PslQrex82BwwgoYl74R5UstbJp8LQQ8dzNmv5sx+90M0zI3Y+a7BWYt2QJzlm6B2Us2w0wU8HQUcBIJeOZqXcDLWAY8EQU8IWURTEheAOOTFsC4KfNhNNKoVQiKFrNdBy+ULom3jUZdErA++aaXH1j/LxOwtgMaX4DxZYW68IVJwNV0AVMLmi5gU/Zrn4DNEi6eiOUCJuRytZ/y8CldGaNMJWjt6QcjRkSigKdIxcsxCRizZMqW42KTICE+BaYkToWUlDRIS5sFKakzoHO3vvBF2cpskca7739slRVzEXNYRowi1uTLOyc0RBHzjJi2wazX2BFc2voz8doSMfUR6xv+vOxexLINf5SISzgKFXHzdl36uvj3yTWLWGRA4XDZGm/bxCjQV4FcskXFPbAftAkdBn69YqF39GKYmLEVJqSth9jZG5mAp6CAk1DAqSjftEUk360wb9lWmL+cxi2QsQgz4Hko4NlrIG7GKohJWwHR00jAmP2m4udDATP5JmZCJMp3bMJcGBM/B0bHz4Z+YxOhsUswfFPDBSqzsoMbileXb029/ivugKavgPtSXwFH5QetBY0ErF2I09QHbI94OVYCtlfC9giYYxSrPdAqOMyCP6HdzCqBX4cQGDFyPEyYGCsVrwmULwk4hgSMWXAsF/CUqZCcnAapKN/p02dBevpcyMiYD/Pn'
$j6 &= 'LYRVy5ZD3KRoSE2Kh5YtW8Jv/vMP8MZ/v6OL2MxbSHFE7NDUyUrE2gZAiC5i76DOVMJYiu9hvqpOFLFsC0wSsdoC8xeKgkRMT/afWnh29HTz73OEljlbi1jGAPuRiliGTJ6/BHIBc6iWrI2DoF2XSIgYkQ6D4pfD+OnrIGmuVnrIWEzS3QYLVm6HhSu3QSYXMGbANAkXN0Or/zIB6+WHCclcwPNRwPM0AcfNhtGxs2BU7EwYEZMOI2MzoHGrIPiqcnMUrzN8Q5jk2wLKVWkGX1sswCABY/bL9oCoblqCzDbh4QIuUwQBE1YC5hjEawQlVLCAjVItGnQZonc+LAsVKteGgMAIGDxkNIyNjGYlCFtlCH7fpEko4ZgEiMUsOD4+GQWcigKergs4AwU8GwU8DxZkLoZ1q9fA/p3b4OyJQ3D+xEG4fvEUrFm+AJLioqBr547wm//3O2sZcxFbrKjTjukPB/0BsRJxM2dwNYqYdU0QYWyhh4dP0Iuqteqn4XuYi7g4O6+pLTBfURQq4g4R/dx8wgfup+vMycVbEAN0xOMiwEVsvC2V5C+BLSEPYFL26jgKgvonQN8oFOm01TB7yRZYunoHLFm9HTKXY0bMMuB1kDhrNcSSgKn+iwKm8oMm4IWm8kNkAgo4XhDwZE3Aw6Knw9CJU2H4pDTw8OsElWu2ROE2g3JVmzP5lvu2CWa+mP1WbKi3n5nrv1/o9V8mYHEZclEyYAMWAv6MkIiXI2TCJS/g8qz16813v4Avv64CLZ08oHPXPkzAWheEfCLOJGCEsmAm4LhkSEhIhaQkEnA6TJuWwUoRXMBrVq2G3du2wsnD++DK2eNw68oZeHDzImTduQK3r5yFm5dOwYFdm6Ebyfg3v4X/99s/wH+/+S6K+AOJiGk0i5hfwVkUcaOWruDaLsAkYbOItQk7Kku0dGt7qczX34zH97BRxHxVnVHEtjb8oR5iWyImXygRl0DIREx/5UwibuURWNsjoPdy'
$j6 &= 'WuZsLdqiMKDkMYmZI5Nl6UIXP7U+T0LW2t9o5Z5/nzjWYRGTtpplv7MXb9IyYBJw+ko2AUf1X8qAqf47PmmhUH6Yx8oPRgGTeIdGTYXBE5Jh0LhEGDguCUJ6DIa6TTxQsvWgLGa+Zdnkm9b9IF4BQ1uAYe6AoOzXnAG/pISZfHUBc6QC5tgSsUyu9kG9wG9/UAbKV6oBzVq6sVa0wUNGoWDjbAuYQPmayhAo4Ni4JCbgxKRpkJKSDlOnzUQBYwY8cx5kzl8Iq1esgp1bNsPxg3vh8pmjcOvyabh3/TzcRwk/uHUJZXyJyTj7/nV4dPcqnDyyHyaMnwB9evdjk3Qk5Tf++122bab1ZJ0mYtoUvnylakzE1L5GIm7s5Aau3gH6ZvC8a0ITMR1TW1uzVq3PfPbFV2PwPcx7iO3ZZ0K24Y+tfSa4iLk7lIhfImyJmJ5kEvEfazZoUca1fY+ptKhDLtiiMKDkeS1FLIDfI12Dz79vPPQcNwcmpC6D+Jl6B8Q0TcDm8oMgYMp+qf6LAh6FAh4ZgwKehAKmDJgJOIUJeMDYBOg3Ohb6joyB7kMmQEsPfyjLJt1IvHzxBcq3nND9ILSfmRdiCJckKgbFkzAhkzAhl6wtSFrvffwVy4LLV6oJDRo7gX9AGAwfMZZNxBXUDWE5ETdFm4gjASdOg+SUNJg6lQSsZcBUA165bAVs37wJjh7YAxdPHcWM9zTcJQHfuMAyYQaK+CFx+wrK+Co8vn8LnuQ+gr+++B7u3LwNw4aPgvYdgqBi5erwX398G2jZtL0ibuLsAW4kYnadOk3GZimHgG9IZ2jQzHnzW2+9K66qIxHbWswhW95MIrZ3nwkl4peMQkU8uE+frzt0GpjuGUaliX6ITLDFYcAvgESUIoXdj5B4C5Ivv9/4mDbhIyCw/xToHzUXxiUt1uu/mAGjgMclUvkhE7NffQIuDgXMst8MJuDhKGCtBJHKMuCBKOD+Y+Oh76hY6DNiEvQaNhF6'
$j6 &= 'DBnHROwV0Amq1moMn35J4tUg+Rprv9oCDLELogAJo2QtEM5ZlCK4aI3y5eetkGXDctHagmRFK9noX/uvKlSH2vWaQgf/MBgzZmKBJQiCZ8FMwDEk4ESIT9A6IWgijgl4Ogp45lwm4BVLl8PWDRvgyL7dcOHUEVZyuHvtHNxDAbMsGDNgxq3LTMAP71zDTPgmPH5wB7KzHkDu40eQl5MLz548hX/8/R+Ql/cEJk1OwD8ajlDboRm8/X4ZtlxaK1HQz6ZdJsko4mat2qCIA8EDJezhFwwevkFUE2ajF4rYs33w/5Sv9O0EfP+KHRPGxRxcxMYeYtmqOlHE5AUl4lIIUcZWIh7YI/xzv4h+qVppgkQsIhNsSTDgFYKi5AjipBqvCfF8MXGjFreOYyBkYBIMjJoNkSRfhLJfngGPRgGz7JeVH2aw8sOw6GkwhAs4EkU+RhfwcE3A3QePg64Dx0DnfiOgU7/h4BPcGWrXb4FiqozyxYwX4dkvF69ZvrpUZeiiLQwLCcswCVc81qRrLWFCLlwjbKMflPDHdGWMspWhVt0mbDFGpF4DtpX9EqKAaeUcdUKwiTgUcBJNxE2dwTLgmTPmwNy5C2DZkmWwef16OLRnJ1w4eQRuXDwFd66igFkWzDNgngWThFHA90jA9yAnKwtysx+jgHMgLzcP8nPzIT8vH56ghJ/mP4WffvwJnj59DouXrITyFWtB5ar1TNmwhYj1lXVMxC6erEbsjuJ18wnUpIx4opS9AyOgQZOWm996h+26ZhSxrR5i2WIO4/JmJeJSjgJFjLzh5N2lt1fEUPCgq1/IeM3FrE2eyc9Zg+IsKly4Bd2nQyvzwockw+DoWVrtVyLgYaz+O00rP4xPhgEo4H6j46DPyMnQe0Q09Bw6EboNGgddBoxG+Y6EiN5DIKzHQAjtMQC88d/S2g2d4MNP8N9bUaqiZEV0oRYHq2zYpoTNWIuXIxeuLT7U29HqYibZsVMPiBwXXWD2S5jq'
$j6 &= 'wIKA4+KoEwIFzCbieCfEHJgzJxOWLloKG9etg4O7d8K544fg2vmTbPLt7jWtDGGZBfMyBEr4/m09AyYB5zLxmnnCJCxCQs7LyYObN27Dnr0HoVKVukDLpLVWO7OI+WRdCzcvJmLXtgHg1s4fs+FAaKNnw34hHeGzL74Ygu/bIEScqKPWNd4xYU8PcUGLOZSISyEKFbGjT5e+bSOGyyVsxKaUZeeKBtuQhx0PMCGXaWmhy7XYDGBXofbrGQXdRqagdGfCqMmz2Ejlh+GTxPpvkqn+22dkDPQaHg09hk5AAY+FLv1HQae+IyC891CU7yAI6d4Pgrr0gcDOvaF9eHeo39wN3vu4HArLsMm6LtCSwD4JEzLpGpHL1giJl+rAJOGG+O98t259YfSYiXb1AjMBI7wTggTM68A0EUedEOmYAc+enQmLFy6BDWvXwoFd2+HssYNw9dwJuHX5jHUZgibkTFnwVci6ewOz4LuYBT/ELDgbs1/MgAsQsIxcFPf+/YegZp0m8Ls/vYf/2ZSHilVqoYTrMBlXq+3AruBMfcR0lQ53JuIAaOcfCu1DO0G1WnVm/P73v++E71sSsVgfLqhjwlbrGomYd0yQiAvrIVYifomwJWL6q8dE3KR1SAeX9j1zWpMEZfK1B0HEtBKNkEm2+Bil+UsjEzGCWbFnxEgI6jsZ+oxNxex3Oqv/DpmodUAMjEyE/mMSoC8X8LAo6D6YBBwJnVHAHfsMh/BeQ1DAAyGkmybggE69oENED6Q7u0ROnUbO8N5H5ZgEmQy5GHWJcpGKYi0KBQqYQ38ErIQrIpetnPLw7odl4fMvK0OzFq7QuWtvGDYiEsZPmMwEa6sMwTJgROyE4BNxlAGnpKShgLVOiBkz5sLcOQtgxfIVsHvbFjh1ZD9rRbt56YxehkAB37hokPBlLQO+dwuyUcCUBedQFpydo0v4id0C5jzNf8Ky6DNnzsGmTdsgJLwLvPvx5/B1xSosIyba+gVBa2/M'
$j6 &= 'iD3bgydmwr6BYeDTIejq52XKjkQJd8b3bDBCZQkSMS9LiPsQF9QxwVvXeA8x1Yft7SFWIn6JEJ9EelJFEdMT/6eGbmE+zn697rGNfySSpRVlhOycbVCeRqSCLQ4yMb4+eIQOBe+ukRA+KJa1nWnlh0Top9d/e4+YBD1JwEPGQ9eBY6FzP03AYT0HQ0iPARBsEnBP8EcB0wYvPiFdtMvjBEZA3Sat2J642obpuow5XKLU3YCjTLRGjI8zfQ6ZgBF+eSO5gAmZbC1hpQcSMP4cf3n3c6hcrR50CAiDIUNHswyY9nooUMB4n6kTgk3EUR04ReuE4BNxabNQwHNg1qz5sGDBYli7ajXs3bGNZcHXL5xEAZ/V68CWWbA5A6Y6MGbAjygD1urATMCsDlx0CT/BzJlGKlX8+MMLeP70OZw4cQoyMUMfNnIsfP51RahSywHcPH2hjbc/jj7/08rd63LjZi0XVahQkVrVwpFQhItYXNosm6grqGOisNY1JeISDvFJlIq4ceswR9f2vQ7TbmvugX11rIXLb9snYgKlaRolSCVrLyQ98fj1gfqMqYuifY8J0H1YLGa/8dBn1GToPRwFTPXfwZHQZcAYrf7bZ5gm4O4DIKhrXwjs0tuUAfuFdUUBd4a2QR3B0z8cWrcPA8+ACKjXzFXb1pEJzShinWKKuFAJEwVKmJDLl+C133c/KgvvfPAl1KrXBNzwX/EuXftA5LhJMBmFakvABM+AuYC1iTjeCTEdBcyXJOsCzlwMq1ashB1bNsExvR3txqVTcIfKECwL5i1pKGEmYsqCr8Oj+5gFP7yvdUJk50KeQb75mNlaSlZOQbLWhPwj/PjiR5Yh9x84DGrUawTNnT3AxaNtfsMmzbd8Xa7cxD/96U9d8H0agdCWlyGIsT5MZQlxabOtiTrZhvCiiHl9mPzAJaxEXEIhPon0pPLyhEnEHr6h9dqG9FtlFHHJgsKUYSHXl8FaiL8kdEWQtp1GQUif8Zj9'
$j6 &= 'Uv1Xn4DrPxo66vXfMFb/7Y/ZLwq4c2/wxwyYyg8mAWP2S3sLtG4fCu5+IeDuGwKtO4RB3aYudoiYRkvh2sIsXxHhc+mUhIRpMcZHn1eAGnUaQ7MW7tC9Rz+InhQPcfHJdgnYPBGnrYhjE3EoYNqQZ5o+EUcCzpy/CFYsWwnbNm3U2tFOHoGbFy3b0cwdESRgsR3NXAdmk3GChE1itUPEFo8vAGp3I65evQ4To2Nh0NCRP7d0dF7+2//4jx74/qR6MEmYsmFRxMaFHMZL6Bsn6njHBJ+oM3ZMKBGXcohPokzEf/TyC6vhHdJvoaWIjcjk+jKgPAtDKtyiYi3JV0LwQLbQw6fzSJb9dh6AAjbVfwdBcLf+mP32hYDOvcC/Y082CecX2gW8gzuBF12rDIXLBOwbrEMiDtZE3KQV21vBLGIbMmbylMuXI5cwYfg8hQqYIxGwPglHAqZeYIeGLaFP30FsZVtRW9FYHZgm4qbwOjBfkqztCUH9wMuXLofNGzbAob274PyJw0I7ml4HtqgFX2YCzrp3S2tHe5SFWXA2m1Rj7Wj6RJxJqiTgQiRsJeBCP4ZKFvnw3bNn8Le//gwP7mfljBwxMh7fmyThjggXsbEsIW4Gb6wPGyfqCuqYMLauKRGXQohPoihierJZ58QXX1T8uFnrkOFtQmmHMZmEjcjE+rKgNIuLVMD2IBFoiUETd4OgTdgQCOk5BMKQkO4DIahrPxRwHybgDh17oIC7gW9oZ13A4WwzcFpFZRawJVSecGjmisKlGmsxRKy3tX1IMOHKED+++BKm75H2BP74iwpsc/ZqNRuAf2AYjBkbVWgrGsHqwEYB8yXJqel6HXg2zJxJE3GZsHTxMti0fh0c2L0DztGmPBfM7WiUBbNMWJAwa0e7ewMe3acFGXoGjPIVyxAW8i1EqBYfQ9jxMVzCIi++/wFuYERGRia/++673d9++20qTVA2TCLmZQnj1pfG+rBxos6465oS8S8QBYq4'
$j6 &= 'V8eOn4R0GjiqdQjKQyrewpCJ9WVBUTLE42Iiyld2rlBkorUPD3xO23fSst/AzloHhL8uYCo/tDPVf8Xs1zZuPjh6B0LjFq6sha3A8gQTqVm+ItbSxWPxcyCagIsjYW0ijngfM+GadRpDWHhXJuCCsl8OEzDCt6aMY3tCaBNxbE8IfUEGTcTNoXa0RUthw9p1sH/XDjYRd+3ccRTwGbYs2SRfSRZM3RCPH2IW/PgRSjiH9fqKGTATpShTg1BF8Vp8DCF5vG00AZtb4TR+QCHfvXv30axZszLwfWosSxjrw3wPYqoPGyfqxI4Je0VMjlAyLuEoUMTIGy29wtvQMme5aIuCUaglCUrR6nYJIxWxLeTyFaEVd22CaPKN6r/aBJx3MNV/ScDm8oMbF61wLKMkRKxJ11q8HLOAOTLxGjFLmOT73idfg0PDFtC5Sy8YOWo8a0WTSVfEYiIOM2A2EScsSTbvDTwbZs/KhEULl8D6NWtg387tcProAbhy9hjbmIfVgfWJOFYL1tEEfB0FfJsJOPtRFuRgFpyLArbOgp+aZSoIVXyMEfYYycfYRi5gztMn2vfwOOvx89MnTu/p3bN3JL5XeduasT4sLuQQJ+p4x4SxdY33ECsRv8IoVMSN3YNdvcKHgHtAHx2UKiGVbVEQxfkqQEH+khgETdfCc+vQHXxD9Qk4qv+igD3aa/sIcLky6FjHKGAOexyJuLku4k+pBosi/lQXqSBhBgrXVJbQkYnYWr4iRulaQ3Xgtz/4km3r2KiJE0R07A5Dho6B8eNjWIZbUCZssxOCbc6uLUmmibg0FPCsjPmwcMFiWLdqNezZrm1NeenMMbYxD29HE0sQPAtm7WisDnwfBWzOgOUC5tBtTZriY4wwqfLH6o8vDO1jreVrhH/O3Jzcv925fefR+vXrF3xVruJwfM8a+4dlE3W8Y8LYuiYTcUHta0YREyqKEfzJk4mYdU40dOnQpFX7njlmEYugUI1IpWsPMnmW'
$j6 &= 'JgZRvmJc/ftAKx8UMCtBoID17gcmXC5gg4il8vUJYve50tguQBMxLeogEZMIUZi2kItYv88u5PIlaJnuW++XYXsCN2nuAkH4x2bgwBEwATPgwnqBaeQCZp0Qk80C5kuSaUEG25x9lr438MpVsGvrZjh2cC9cPKXtC3EbBczqwGIWzEsRvAxBy5If0rJkLQM2dkLkWwj4KWtPY4iPkWAhYILOFYDlx1uLl8OzZc7zp8/gh+++x+w4K//okWPXNmzYciqsc/+5f/6gYmS5SrX64Xu4MBEXVprgIlZZcSmGLRHTE85EXL+lbz0n3+7n5CImUKL2yrig+xhckuJxaWIUpOxc6eCKz4Vju3C2naEHkypt5EJwwerQfbp4zQIWH6eJmD2GMuJmLsUWMZMxnbcbawHTpeXpEvPlvqkBDZs4Q/sOYUzAUVHxKNVENhrlK2LRiqZPxNHVMVgnhGkijramnAuZmYtYLzDbmnL/bhTwYcuJOIssmESs14FvXzMtysjO0soQWh2YJIiyZaAgDRI2idhCmtbYK2H2WH00IxewiChifvv759/B33/+G7x48RNs2rL7eVj3kVdqNG1/qlrDtjPKVHLoUfbbhtTyVpiIefsa7yPmS5zpv2NZVqxkXEJhFDEhiviPDs4+Ds6+3a/IJWwEBWoPVgK2hVGcrwq5PEsS14B+0NIrDNy8uYA5XLA6goDNErZ8PLuPhO4TCI1QxO+/hIjlwrWFWcAfsFJIBRRwTajj0AJ88Hui1XCTJk0xC3giypYjyJe3okk7IYSJuOm0M9pMFPD8hbBi2XLYunEjHN5HrWi0Mc8JNhFHCzLYZBxmwRbdEFzAvB2NuiEeP9bb0UhoXIQkWw1NvAYspGkJE2wRJCzHUroyRAkbefaUvu8nsHPPURgyfjqE944CB6fgI009Oh9zaN4+rlpdt+7V6rT0L1++EmXIXMS8fY0WdNDKOn6ZJFtZMYm4oKyYUFGE4E+aKGJ6gs0ibuVX'
$j6 &= '29m3x3G5eO0BhVoYUgkbkQnzVSGXKYcm3jiy+wnxMQQXsauFiK0lrB2LjzGiiZiVNrwDoAFmoZSV2iNiKkUUX8SagOnrfPAJXdqnIlSr2RB88fugSTiSb3R0gqV8RbiEdQGzy9STgGOFzdn1Jck0EUcCnkdbUy5eBls3aFtTnj1+EAVMnRCnTQLmEmYCZhLWFmWwjXnu07JkyoB5HZjLjwSrI5MvoWfJtrASMEHnDcg+1hK5YDm2BCxCX/vHH35g9e6lyzdCpz4TwcN/ELQNGQWuvgNfeLTve8ajbdjk//rTW7Sog/qI+RaYYp3YmBWLMqZkrbASBaHCzuBPGH8iRRGzCbumTt7lPQN6z2QylIq2KNDnKCJWQhaRSbPouOnI7hPhjzNjLVgzBT/OFc+3bBsOLihPtresScBBrN7LsRaviPYxXMSu7fyhXiNHiYhptJZyoQJm3RUCFvdrEqYrI3/2ZWWo38gJ+vcfKs9+RUQB63VgcSKOBMz3BqaJOGpFo53RlixaCpvXab3A2s5ox+HmZW0ijroh5FmweTKOliXTxjy5FsuSuWB12drC9DhLaZqlq2WhJug+AePH2cZaqhx7BGyENhKijztz+gKEdBuLf9jxddy+P3gFD6cxp5GzfxS+x2llHS9PGLNiqhXbKlEQSsYlFOITJhWxh3dA+YBOA2drYpTJ9WWgz/kScCHjsRu7bS1PjqUYSxtr8RrhIm6F8nRFEVNmzEDBFkXCoohdvDpAnfotNBFbtK9ZitgsWhKwRMJGAXNMj9HLEZgJO7t4wuDBIwvOfjkkYMQ8EZdg0Qkh7g1MnRAzZ85jWTBdooiuEaddpPMY3Lh4kl2ok+0LYVULFurAehmCFmXkPM7R2tGY8ES56hjlyzE9RhAmnhfrxhYixvuLJl8RuVCLDP2hMUETkHnw8P5D6No3Cpy9ekGbgMHQNnQEuLXvdf/bajWp55gvc6buCbFWbCxRiDLmmTH5Qsn4JUN8sqQi'
$j6 &= 'bufc7oOQzv27ewSSOHsjRpm+LLpUC4FEW2ysRPlLo5cm2kVAKy8UcTsUMcq1OBLmIqYyRtsAFLuHN9tcXCZiC9kydAnLpCsDH/vBJ9QT/A14tfWHQYNGsitjUCcE63awIV8rAU/S94SI15cksz0hzFdJnjFzLsuCF+k7o1E7Gm1PybJgvR3NlAFbZMGigI3taFx2olx1UKRy+YpoH2stYEKTsKVUi4ou0ZdFImHiSV4e3L37AE6dugAjx6VA3WZ+ULuBy3V8j9N+E2KtWCxR8Ik7WzLmWbHKjF8yxCdKFDE9sSTiP/i6ur7fqfvAzmYRixilWjhuOrJzUomWCihDQirJVwEXcUfMUPzBxdtSxHL5iggiRgGzyTpdxM4ePtoGOrqIefZqKWAdmWw5wuOoH/ntD8riWB4aNHKEsPDuMHLkOCZWYiJt0G6BWcBMwqYM2HIiju8JQVdJpjowK0PMyoSFejsaZcHHDtB14szdEHxvCJIvhySsbc5Dy5KpEwIzYBSwtiCDJCcTqw6KtHAJI0y41mgfZ5RqcSCRiscc4+0CsJAwYRYx8fyptonQ6VPnYOjIaPjgi6pX8D1OS5355j/FkTF5QpUpXjLEJ0kq4g8//M0bnu07NtWkifL1FyhEzGbBFheZREsLFKQMUaCycy+Bo3cncPLsYCFiuXhFLCUsipguq97Sta1JxGYJ25CxRLoilP2+9d6X8HnZb6FRE2fwD4yAfv2HYgYcY0PACIlXFzETtUHAtCJOm4jTWtGYgGlntIz5sGD+InapempHO8K6IQ6zbgi6SoZFNwQTsVaGMGXBd/UyBGXBeidE8csQAnjetoDpMVyepQUK1R4KkTCH6sY0XrhwGWbNXXg7IiSElj6TjGkDIJmMxTIF7y821owLkrFRyCokIT5BRhHTE0tP8p8q129Vzj2oL8oXBSuKuAAZy8VaHGTSLC1QkEa4OG2dLxZUJ+Yibl8EEQsS1kXMJUxQP3KjFu5AVzc2'
$j6 &= 'Ly02yPhTQbY2JPz+J+VZL/BX5atD/YaO4O0bxCbioqPjmFS1MoRcwjwDpi0sTVfHEFrRklL0BRnTaWtKWhE3j21NuXLZSti6UdsZ7ezxQ6wMQcuSKQPmizLuihLWlyVn0bJkKkNQPzAtykDJ2BQwRxSpSagS8HzBEiZEaZYGKFV7sEPCBN857scXL6j3+MWFcxdWzJ07l/aroCXPtmTMM2OxZiyTMRexyoyLEfzJsSniGk09yrt06PmdUcJuMlDGZmRifRlk8ixtUJxFxUq8RswidmztBy50QUipeEWsJSyKmE3WtfWHOijO9z+h69ZJRPypgEG+VH4gAVMWTFtS1qzTFNq284chQ0YxodovYN6KZlySrO0Jwa4Rx7am1C5Vr21NuR4O7tkBZ47p+0JcOs1WxVllwQSbjLsKD+/ehEesDsw7IbQyRJ5RpiKiRC1kakC430q+HPZYmThLEl2yhWEhYUIuYAty8uDZE21VXtaDrGNpaWm0cZAsMxYn8Gx1U6jWthII/sRwERNcxPTE/qlSzRZlHL27HnD17/W/TIgyARdEqUiZI5PnqwCFWlxMIu4MLT18mYjl8uUYJKyL2CIb1kVcm4v4U5QwwyBgjknC1P1QAT7G7LjM11WhSvUGTMDDR4xldV2bJQiCCziKasXmXmAuYOu9gakfWOuEWLKYrpS8Fvbv2g6nju6Hyyjgm5dOaYsy9CxYVorQJuNocx66ThwtS9ZKEDYFLJMox8bjpeIVYY+VibMkQaEWhJV8OYUIWARlTI+hVXkPHz48smDBgh4tWrRo+MYbb/BVd7RFpthNUVBrW1GXQhMqDMFFzGVsKeIGLcq09O52pNgiNmIl05JCJsxfAol8RfTM2NGnC4rYj10iXS5gjm0J83MkYurAqFm/JWtfs1fEJGCiSvX64Nc+BEaNGs8EbDP75TAB650QKGDayJ02dI+PQwHziThakjxNW5I8c6a4NeVa2Ldzm7Yxz+kjbCLulr4o'
$j6 &= 'g2XBeimCC5hnwbQs+dF9akfL0rohUDwk4CJLuCiPFbH4GJk8SxKUqi2s5MuxU8I0icnA/yR0qHb8v//zv3Dl8pX1o0ePpu0zSca0TSZf8EEyFvuM+Z4Usj5jLmNVpihiGEVMTx4X8R+rOzT70tGn21EmYibTXtZyfSlQooRUri+LTJS/BAYZ4zknEnHr9oVkxIKACUHC1iLuADUdWsAH9oj404rw3sfl2aWJaEOekSPHy4VrRBSwXrIwZcDGJcm8E4Ja0fStKakV7fihvawTglbFUR3YVIYQs2AS8A0SME3E3dbKEKwOzPuBUTwWYhSQSZRj7+OMiB8nFWdJQj+bDaQC5uiiLQiThAmziAn6eOqqePgw68rOnTsH4ntflDHt0mZc9FGYjO0tUxAqMOiJMIqYnkAm4po1G37SNrjXdFf/nn+nCTlNxEaMcn0ZUKBGpJItDjJJ/hL0ASffrtCidYcCRGwpYI5JwoR+P90mGTdybA0ffPQ1ita2iFk9GCVMAh42fCyMGzeJSbbALFgXMG9FY2UIFDBdU860JDmF7w2sT8TNmg+LFiyBdavWwO6tW+D4gT1sXwjeD8zb0e7oAracjOPtaFoGzJYlk0hQVKYM2ChIozyNFOWxIuLHMWTyLClQqLaQylfDSrgyCpAwh1biUU/0wwcPr+/eu3cIvv/FSTyjjO1ZDm0sU3AhG0VM/NsHfyKMIqYn8Y+fffbZOw2d/YJdO/T8iXVESEUsIpPry0JfVwIXrPF2kZHJsjQhEXdDEfujiGmJs30itsyEzY/jIm7s1MYgYksZf/hJBfjk84rg0KAFSjUWJZpiuw5MYtYxCXiS0IpGE3GsFc08EUeXKKJOCLEXmHZGO3f8oL4q7hRbFce3qDTWgu+zLFhblvzo4QPI1rentJiIY4J8ZoCflyBKVHa/LcSPMyGTZ0mCYjUiES+HlWdk0jVih4Sp7Y8gEdPHPHr46PrO3TuNMqZJPJJxUfamsCVjmZD/'
$j6 &= 'rYM/CVIRf/XVV296tQ93R8m+sE/EMmRyLQ709YuJhXjtRSbRkqAPOPtpIqaOCU2ucgm7WkhXhi5iX8yIWxozYksRE1QTrlylLgQHd4S+fQbCuMgoJlcrIesC5mUI6oSgTXk0AfMlyeY6MF2kk3qBVy1fCds3bYRDe3eyTojLZ3QBUz+w0A3B0SbiLsOD29fg4V0UMGbBj01lCK0OzCTIBGkUsJ0Slt1XEPzjrJDJs6RAudopYU3AdkjYQsCEbQGLsJWC+PGPsh7dOHnsZMKkCZNoo3km49///vf8OnfGzLg4E3hKxkLwJ0Am4j9Ur179rb59h7Vz9+/14y8vYoK+BxkF3adjIVl7kEm0ZOAiZpmuX0EiFs/LMGfKDVt4FCziz6g0UYHVkb8uXx1q1W4EHTqEwMABQ2E02zVtilUWzOrAKGrTZer5ijjT3sDaVZJXLFsBWzdsgAO7d8Lpo/vh0pmj2kQc1YH1MgRlwBalCMyA7zMBUx0YM+BHj0x14FyrLJj4JSVMGOVZkqBkiyThQkRcTAlzSMTfPXtOe2c8v3ntxs4tW7b0b9asGe1nTDKW9RrzzNi4hSbVjVVmbEfwH14q4nLlyv2lc+feTVComBGT7GSiLQ6iXIsLypJhvF0EpAIuDLlc7YU2hnf264Ei1urDJFG2qKOYm/+wq3vg7frN3FDE4mSdLmKhn5hE/DGOb71XBv705idQ9usq0LBhC/DxCYThw8dCVFQsky9hXJAhTsTxrSmpF3jT+vXsGnGnDu9nV8i4duEEqwOzzXlMAjZPyGkSxiz4zg3IYsuSUcDZJIB8yEXh5eU9YzD5WclXhO43IIpTdn9BiB9rhUyeJQVKthAJWwq4qBIm7BOx8X7Kjv/+88/0B/LOnj17RlWuXJk2lre1P0VBMqbsWJSxMTsWRUz82wX/wfkTYiFihJ7IP7t06PHd6ydiERRkSSOVsCV02SPzbbl4RUjCRKv2PaFFG23nNZb5cgkLIrYW'
$j6 &= 'r4g5ayYR08fVa+Jq2TUhWV1HIqbx3Q+/gnc+KMuWMf/5rc/g40/LQ0tHV+jVqz+MHTOBlSIoA6bL1NNEHAk4bbq2NeXcOQtgqd6KtnfnNjhxeB9cQAFfPX/CVIZg3RC8J5hBq+O0boj7N2lRxi1hUYY5A9ayYJl0jeDjbIlUdl9B8I8rEJlASwqUrQ0JWwuYQLHaohAJG8UrIn8M/oeSnQM/fv8DPH70+O7+/fvHvPHGG+LFR2Wr8JSMixH8h+ZPBj0xFiJ+880yb7m27/GUibhDTx2UqYhUtvZilGpJgXIsAUi2Ilb3k5A5xtsMs4BNIsbnsIWnJl4Sq1HCdouYlTZC2FLpuk1dNBGLK+vE0gQiivjdDzhlGe+8Xwb5Apo2dYJBA4dCQnwSTE1NZ50QM9Jnwxy9E2IDa0XbBscP7mV7Qlw5dxyuXzyJWTAK2NQNIUiYMuCbl+H+revw8M4tzILvweOHWZCt14G1LJhkJxOuDHysTKTG8/bAP7ZARGkWdn9RsRawXL4cFKstCpCwpVytsfkY2kBJhxZ/4B/OB0ePHh2HXuA7t/GaMZexeMklW5sFcRlzISsZY4g/NBcxPTkmEb/99ttvOnl13OrSvvvf3EmcJhnbkDLHSrj2IBNq8XG1uG0tUcIo2ldBK3x+SMQuoohp1LEWr4g5GyYoI6buizpNWhn6iAlrEdOE3Xsffc0Wf9CoifhLpAzj/Y++xGy5DDg5u8PkSbGsD3ju3ExWhqCJOK0T4hDrhKA6MG3SrnVDoIAtsmCEeoJvXYEHKGCeAec8pjc5SgVFZMqCpcK1BT1eEKFJrIb7C4J/rF2QMGXnCaNYi4KlhOXiNYJylfESEraJIGEOLf7AzPjRiVOnJqIbbK3C+//tvQeYXFd5/8/fAhtjG1dZsvpK23vT7mp7731XvdiSLbnJTZYNNhgIEIfAL1QHEgjFIQmB0AI4xIABNwiYBHBBuNsqlossd8Bg+/zf77nzzr5z5kzb'
$j6 &= 'nV3J8vs+z+eZ3ann3Dvnc9/73nPvuBcL0hkVSQZ3VooYCwgL61iIuHVwy3e7VsYSMYPH4hAl3WSQIo0GomV89yXGL8rppmv1dtMysGFCxIJo8UoiJdw9Gtx2Dq81lfUTP5UUT8TzFuXZU5sxn/i0uUvNaSRhEJYxZcWnnLbQzDljqSktqzGbNp5lPv3JT5pbb/qh+eWtPzZ33hFcGY3rwFyGsAfimPDBOMqCH3nIZsATMyEgYK4DszyTheQnRWr/9zweiwiJpgOfYJNhQsJ+4foguSYl4ACvXJPFI2FgxU63+x/b/9QDDzz8dfIDn/jhk/FkTomOJeM3RMQV8SmnnPL21pFzbuxadf7L8UUswfOSJEq+Ad1efDKdDvwCTRdd9Bktg0FtuGd8ciLG1DaIOChvbDC1rf32wvCRGXGkjAMR59uL/OCSmafNIRHPIREzVsqLLSeTjHG7eEmuaWpqN+97z3tJxDeZR+/9LYn31yThX4ez4AkJY05w5EkZj+FgHGXBTz7OGbAUZ4pAfmGxeh6X0nWJEGg68Ak2GVIVMCC5JilhO+vEFWsq4MCpI2AJZIyTP+i5L9137313fPnLX8YV3KyMjznmGJz4oTKeZMQV8amnnnrCwPrtnyHBPm+vvBYl3dh0h/8muXrojoVXwvHwyTTd+KU6GbqIlqHgIBsEm4qErYAZlDQIlCfqOwY909ekiIP/5y3Mo2yYJIxseG6GR8T8d5Adn3jyfHtbXFpt1q/baD76kQ+be/7v52bvg/dY+QZzg4OZEI/i6mjhOjB+pig4KSM4GOcTZzohOfrwSnSq+ASbHH7RxoMEm4SEAwFPQcJWwMAvYMZeeJ/ABuVPL/3RPPLQw3fefvvtf7Vx40b8ZH9WaHqb75RorhtDxvGmt7GQfTKWHHHBHfOK+E2zZx/fN755U8+q8x/rW3sRCTRStvGYtIiBV7jx8Mkz3fjFmiqBiDeFz6xLORO2Ep4QcQ9O6GiPJeJIcHYd'
$j6 &= 'nhcWsZSxI2IGIj7hpHnmrcefbgqKl5u/eu97zG03/Zd59L47zd6HdtmZELsfut/s3R1kwDgQ9zikAAE/QVkwifKQiNgr0aniF2wy+EWbCBLtYSThCGhD+4cXX0Kp4vE77rjjI2NjY9XkjESnRCeaUSGz4zeUjLlTroixYLCAjqts6KztXnnew/jZJFe28YCIY0PynAxeCTOQpfx7JvFLNxYtQ2eGRBxcHN4vYDAh4bCIhYQnROw7xTmaeQtzzOk2I2YJOyIO/y1EzMxZbN5+yjxzxoJMs3XLFvPVf/mS+fUdvzD7Hn3UnhEXCJh2WyFfkpatBZMkgV+eSZC0wEmS0y5h4JdsPGxd3CvZZCDZHqYSBjgVHdc23r/vscd/9atf/V1LS0sFOSPeRebjydhXqnjDyJg7FEPEc467/PJ3NPasOf+RYArb+SGSFW48SJgW+fckiJCxxCfMmSaGiO0vOUPCsa43wQgJWwFLEYfmIkPEMUsTkZxBIg5KEyzhGCIm6YZFTH9LTjl9kTnmuNNMZk6JuXznu8zPfnaHeWzf/pB8QwJmvNJMNyTIqUo4qdf5RRuL4MAkJDxZEZNsEwp4CiIOSxgkKWAQkrDkuYPP2oN4d/7mNx9dsmRJCbnDN9dYzqhgGXPdOBkZxxLyERHcGRYxyzicEe/Y8Y76vjUXPAwRd5OEo3EFOxlInNPB4SjntYGIO4ZJwiRTv4AZzoSD6W5gIhsWIk4iI7bT1xaQiFGaCEtYiDgCknAIyJdvAxZRhrzIzjs+9oTZprSi1tx6y8/MY/tJEiSsCBETfnmmCxLktAuY8QtXEpYvsAIGPskmgpalI+Fo+TIhsaZCGiXMYHobZcbP3HnnnR8/6aST8Ksfsaa3nU6kc3obeN0Hd4Q76YoYC+f4jpXb7kZpwi9ixifYyULSnG6SEfNqz31TZe3FJOLNpmNorZWpK1978I5ly//L+xyCjDi50sSCJflBRpyCiJmwiEnCzCmzF1qW'
$j6 &= 'ZZeYne/6W3P37x81Bw48ayU5/RIGJMjDQMIRAgZplLBfvkxIrKmQQMJ+ATN+CTOYVfHYvn3P3XX33Z+YP38+MuOZmN7GvK5DdsQVcXDAjkTcOX7u7/rWX0xi8gnYh0+uk8UR6LRDsmR8ImWSeY6Xi0wribjd/qR+8Lt1PsFKCVtB+55DYNZEbVu/OXV2hle+yIR5fvGCxRAxpq0JEc9NLOKJbDhSxCzjk09bYH9yKb+4ynzjG98xB59+1jz33ItCmNOBT5gJmJS0k5QvM2kJpyJgEBJrmFj3C6ZRwoDfh2T87G9+85uPFxcXl5E/co8++mg+iAcZx7vIPNeN33Aylp2QIkbnWcTHtQxv+U7XyvP+YmvCq0i0wCtgF1eq6cQn0emCBBoLn2zjPb6WRDxCIh7ENYmRFXsEKyQcJup5QWkC4MdIK6qbo+QrJQzmL8L0NTFjwkLijZJx8iJmTjplnjn2+NNM5fJ6c9U1f2N+9su7zfMvvmyeJinL7DhtdWOvNOMwqew5SQGH5SvxyTYeyQqYgVx99zlEyFcSR75MChIGOHj3+P79Bldwe2zP3qfuu/e+b+3YsaOLHJInZJzKjApXxizkI07GsgMxRdy7auv7u1edt9+ebMEidvGKWOKTaTpwpTldkERj3e/K14Ufp1tcJKh1ZItpH1htf/gzUq6ET8LAfV4IWzceXmvauoeiBMzMhIjBaXMWmbced6rJyCo1/SMbzHWf/jwJ5mnzwgsvkQSfIWmlQcSQuleaMWABTzEb9goYpEXCOEnClWqqkFx9xJFwOkUMCVv2PWZBzfjJx5949fe7fv/NK6+8soc84v5SNGSczNXb3hAylo33idgesNt63sVj/esuvBsndXglzHgFLPGJdKpAhvLvQ0FItEkAEbeNnG3aSMSdUxUx3W8P4tH7NHf0x5UwwLUmZs+bioj9Ao5ksTmRsuP/783Hm+y8Unsd41tu+yVlxs+F68eTJlUJg+mUMFAJR0mY'
$j6 &= 'Cf2e3l9+v2vXjZ/61KfODF1KM9b0tje0jGXDWcRAivht77z0/KV9a86/uW/dJX4Bx8MrZEYKNV34RHkoiCPi0bNN68CqqYuYwHxkvI9PxFLClgXZ5rSIjDgk4bSKeJGd4obnHnfi6Xbu8cq155ibfnK72bv3CVuqOHDgmUjBJkMCCWPGRvj/KWXBeC8SajIcFhIGJNikJAyEbGORpITDAgb7okUM8LyX//gn/B7eE9/73vd2ZmRkFJNT4l1KU05vg4zd6W1wEwv5iJGxbLQrYmyBrIiJEzrGz/16/waI+Lxo2U6GN5yYAwIRn2Oa+1eajqHVJFOeF0z4BMyE5SvnEa+jjNgv4igJE3MiRBwScFjEkC5u+e+piDiYTYG/Z9P7zZ6faeqa+8xXv/Y98+CDu0l2B82Bp1KQsZUwcIU5Qfj+KUg4eC8Sajyi5Mv4RRsLexlQr1RTheSahIRxAf4AIVxJWL4Sv4BBtIRBtIgte/fZX/0gGT/3zW9+c3tWVhZfZD6Vq7exjOElmR0fcTLmzvhEfHzv+Dnv71197oHggB1kLCGJpotpE7LEL8mZoItARtzSv4pE7GTEIelGTGWThJ8bSJgP2PVQVtzc3hdXwgCPeUUclm+0hEEqIuYpbWDh4lxTWFprFmeXmyXZFWbOwnzz7vd+xNx9173mGecgnpewgDEdLlK8EivSKWXADAk1Hl4BA79sXZ5gDomESayxSEHCEQIG8QTsgOlt+/bu+9PXv/718zMzM+2MCmIyMuZSxRFVpuDGShGjc+goOozOH3/x+edXjGy44Lt96y4mYboiTrOMI/CJNES8xyaFX57pxIp47JxoEQvhsoijhBwlYcLePyFin4CZOfNx+ctYZQm/iJOWMAv4tAXm9HnLzIKlhVbAGTmVVsJLcirMoiz6P7fCjK0713z9P39kDjz9gi1TeIVs5ctIWU4Qlql9jfg/CXzv55Uv8MpX4hcvExYwsBIGPrGmAkk2jnxBwiwY'
$j6 &= 'zJCEw9Dr9u7Z+4ff/+73X9i4cWM9uSXVucZumeKIkTE3NK6Iibe3D575zs6xrS/gNOcJAcfCFWo6IWkyXqGmh64QPqECSHUytI1tJRGvDkQsRUukJGGAx0bWmobWHq98AQvaHqwLX/BHSjhawExYxD75MiEBz6b3XZCRbxZlloSzYJYwszCz1GQW1pjS6jZz4aVXmd2794VmVUjxukRL0wo1LO5IycbC9z4TkFB9eMUr8csXRMuX8Yk1FUi0cSQ8IeDJSBjEkS+TqBwRhyefsJnxH++5664vbd++vZXcIucaY3obZMxzjVM98eN1K2NupCtidI5FjM6/vXB524qWwTO/3Y+TO8LCTYRPpNMBCdNFSFUSyHVCtPy/e58fv1xToT2GiGNKGIREjJowYBHjeagRVze0RwkYRJQrFuAXOiDikIQTiDhhNkwCxskcJ506nySfTVlwEYmXBAzpsoQdEYNFWWVmzqICk01C3rztEnP9v36TRHkwNOcYUkwkYRYwYf+Pje/10ZBQfXjFK0kgYJB2CQMSrkfCkQJmSKw+vAIG0yvhxyz77HWN9+3Z+8Kdd955/ZVXXtlBfsFc4yy6decap1PGh3XIhnIHWMToIDqLjmMBnFTXuXp759i2v0yINhkgSvn3dEEyFXQByDP0d/g+JkqyyQCZuv+nRvv4NhLxGhLoWoPfnkskYjtXeGRCwlLEEDSe29Y9HCVhECniHJJvrLJELAkTjoCDGvACmwXPX5RtyirqzGLKgiPkK3FEDFCiWLCsxJyRUWTaeleZf/vqd82+x54yzzzzvBWsX5gk13AWDAnHFrHvtX5IqCkLGCQQMDjkEgYk1xQlDNnGFHFYwsAvWx+BgAMJW/buMwcPPI2/n73zt7+9/tKdO9vJL5hrHEvG7ll4ky1THLYhG8mNR0ekiO3MCeLExrbhFb3j235gT3kOyzVVfBJNFx7hxiJCqFPBL9xYdIyfa0WMqWf4AVCfiKWE8TxLlISD'
$j6 &= '//tXbjKD4+tjSjidIoZ8cY1inBgyZ0GWWZZbbhpbev0ClnhkDFDCmL+0xHQNrDd/8/8+bX7963vMMwefMwcJKcyILDgsYTAVCQOS6nRIGEyXhB0R+wUMSK5JSxgkmwkzfum6TEg4JGKSMKCM+LVnnj6Iv59DZnzuuec2k2MmK2M3K44l48M6khGxrRP3Ni2fu3HLBVt61170UnK14kS4Ik2OrqQgSU4Fr3RDJHrcI2CmY+V5pnlgbSBiJyMOShAsYCHhOCLGe/QMrYqQrpQw32fnESdRH46QMBCZME7YwEG/hUuLTIYVKeq+ZX75ShwBu8xfWmyOO3Wx2bHzGnPrrb8wjzxKGdPTz5JYhXzjCNgv2USQVFOWMIgj4Aj5Mj6ppkq0hP3yZUisPrwCtr9FF5+0SJgISTgsY8L+MOmevS/dc8891w+NDTWQZ/gsvERlingnfbyus2IpYnQGHYuoExMnl5WVZY6vPfsjXePn/mFCqOkgUrTJCzcVSJLpxiviWLCI19lrEvda+bJYpYiFgONIGPTQ89v7xqLkK2E5h0UclnACEYclvMi+bv6SfLM4q8wKOOKAXDJ4BCyB2GcvzDM1TX3mus98iQbu4+YAy9cjYb9cU4GkOkkJRwkYeCUMfGJNhQn5JhYwQ4JNIF/GK15JlISBX7xMlICBI2GJvXLb3n0v79q16/rOzs5a8oxPxnJqm3sGHpco4KzXbVYsGylFjK2LFLGtExOnzp27ZPGK9vG/6xzf+lIPCa575bkBYakmpisuPolOFyTImSAk4w76TCtiXJM4LGIpYUfEQrrRIl5vOofWmBXNPVHylQQi5ulrCUSMC8KzgHFL981dkEUCLk1dvhJHvLHAzIrCiiZz+Ts+YHbvfVKIM3btOHVIqikJ+IBfvoxXwMAn1hTxijYeJNgkJIxfVfGKV5I2CQO/hBm8dt+eva/ct+v3XxodHa0jz8gyhTvPmE+HTlSi8IkYHJYhG+iK2C1PYJcA'
$j6 &= 'C2H26acvWlrTPvZ3HWPnPNe75oKQjD3C9d2XEj55TicQp/w7vXQSLQOY7bA2uhwBucpMWIhYSphFjNdh9kV1Y1eUfBlbliAJnz4vM76EpYBxQI5u58zPtNPRMNMBWbBXsKngEa+LlT3dLsuvMi1do+a3v77bPPMMrlWBOcc+qaYKiTVJCeO39wJIqj688mU8Uk0Vr2jjQZJNIOFAwEmI2CthkKqAgV++LvZ99u577Qf//YP31NTUVJFnMM8YMuZ5xvLaFL56cawShXQcOCxDNpBFzDJmEUeUJwgsiDmnzF2c1zO87mN9a85/2l6LYnzba+HsGAImIOIIsfL/7v0pIcU5nfhlOhWsiAc3OCIW4k1Cwvb59pZEPLjaLG/ojBIww9lwtIgnJMwCZgnPnrfMzF9SQBKeYhbs4kg3HsiMsQFo6xkz1374OvPww3vMc8+94Eg1FUiuKQv40EnYL9p4kGgPSwkDv3gleJ+naf088uDDB973vvetJ7/g4vKFBJ/0wVdtc+vFvhLF6zIrlo3jRsusmMsT6Gi4PEFgYczLysoqWb3p3I+NnXnxwYFNl9vfsutauY04V0Dy9OGVbCr45DkTRAs2WayIhyZEHDEzwiPhRCJuH1xlKuraowTMEvaLOFrCEDAeP2NRjlm4rCi9ApZ4pBsLtGHukkJTVtNuLn/H+83//fp35oUX/mhrxn7ZxoIEm4SEIwV8aCT8+P70SzhSwHEk7JWvJIF8mRQljBox3vOBe+/72d9/4lM7Z8+ejbPu8GOkkHEBwRcKcuvFvhJFrKzYlfFhGbKBrohjlicIbJ0WDHS31/SPb7yidejMb/SMbXl0YMNlBtcvnjkZ8+1M4hdtIjpXXUgZ8UZ7sC4QcUi8LmHZRoP78Xo8Dyd0rGiduNaET8Jz5oVE7GTDVsIhAaMOPM8ejCsNROiTaDpwZJsM8zKKTHZRrdl49sXm+zf+1Dz/3Ivm4EE+ASQZ/OKVvH4lDEi4SUsYkFSn'
$j6 &= 'IOHkRewXrwSXy9y3Z++ru36365fXXnvtBeQTzJxYQSwncE0K/AYe14tjlSjcrPiIEjHLGJ2SB+3Qac6KsTBQRMfCWTrn5LcUtnf3v6dt5OxbukY3PwoZB0ImUUZIebrk7BPmTOKXbyQk4iES8TBJdSwkXClgEJKtT8Qs4c4RTIELfvuuuWc0roRB8Ht1gYTljIjT5y2lLDjPLMkKpqGlpRYcD49okwFliuNPW2IGxzaZG274kdn96F5bO/aL14HEGotoATMk1qQFDPxyTYbHgZXwZERMwvVI2C9ghsSakoRB+rPh0GyJV+656+5ffehDH95BDmkjMJ8YGXENUUngam2JsmJfrfh1KWKEFDHLmLNidIyzYnQ4KismUMPBVgtbr6LG5uZ3dYxt/U3n2DkHOse3vdKzBhIiWSYj4nhEyTcZfNI8FNAyWA0RbzIdw4FEw9L1iFgKOPxcK+EJEYPGrmG/hB0RQ8A8E4KzYJQhIMhgShpJLwwu2JMK8rUJ8Ig2GTJyK82p83NMVV2n+cIX/tU88OBucyB0rQm/gEGqAmZIrklLGDhiFf/Hgp83IWHgk20sogU8nRL2ileSgoRxbWTc3nXnXf/71x/46yvJGfglj04C159oJDCNDQfsyglcx1hmxXwdY64VJ1ueeF2IGCFlLEUss2LsAkQctCOwUGxWTGD+Xz6BhVdRUl5yafvIWb/uXnPhKx1j217phhgjZCzBY1MgQr6J8IlyBogSsTNjIiRcV8LBc4PnuCKu7wx+KoklbAkJmEFpggV8+vxlZkFGgcnILjeLs1jAIaHmCNz/+b644L2SwCPaZMEJIDkl9ead7/2Yuffeh0hqJNckJOwXrg8Sa4oSDkvVQ0wBg6lkwiTW5AUMSKopStgrXB8REgZ+AQNIHe0nCf/q3Ve/+x3kiSGij+gmcLqzmxX7asXYE59KeeKwDilin4xj1Yqxm8BZMY5wYoFhwWEBYkFWL84s3lLfs+6WwTMvJyGR'
$j6 &= 'CL0idsHz0kSUiIFHlNMNRDx8pmkfIomOAhZxSMYhvCKGgIcBSzj4v759MFLClAkDKeLZJOJTSMR5hZUmu6DKXpbSJ2BcunKC5SEm7kteynjvONj3o/fOrSZqiKrI9/YIWIIDeZkF1WZ0zVbzq1/vCp3swdKNlLBftrEgsSYt4KcipSqRWW6ix72iTQCJNTn5Skiu6ZZwlICBX8DMwacPmp/c9ONfrluzBpnwGDFM9BPIinERoBbCrRX7ZlC45YkjRsQIKWOfiH21YjuDgsAuA3YdsAuBhYaFhxpP5Zvf/Obat588u2txTslZVa0jNwxsvNz0rbuIJOkTcCxIntPFTImZRNw6fFbwk/qQKUuYD9yFkPJlbCZMEkY2bDNiEnlwsK4/LOGgREHydUQ8d2G2WbisZEJmJMMJsbJwIUYH+ZgHvNa+RyoixmtJwEvz68yygiaTWdhilhU20v+19v5kRAxYxvllDeY73/2Befbg8+ZpzDcmoU5awElK+HFLSKouEZINEfNxj2QT4ZVsIkiuSUr4sTAk1Xh4JQz8AkYm/Owzz5of/PeNvxwbGUEmvIoYJ0aIQaKXwC8/o1bcRODEDi5PuAftIGKURd06MYs4UZ34sA8pYlfGslbMWbEsUYQP3BHhejGBLRoyY+xq1M+eu2hlbknd9qrmoW92rb7gT0Nn7jT4dQ6/fH04Ep0JfFKdDCERt9mf1A8uDh8h4lCm68MnYpzQUdOMWRMh+ToSRkni9DOW2Yv0LKYsmMXpkyqy0kgR4/8QvucLkhaylSy9Jq/GLC1oMJnFbSarpIvotH8vK2wKCRmfiecG0o0FT3FbXt9lPvrxz5iHHnjEXuPYL9tYkFyTlHAg4BQlHBePaOPhlWwiSLBJSHhCwGmW8J699sDcU08+Zf7jq1/9Wnd3907yAOYKryZWEqNErPJENYGpbCh1ouQp68RyTjGLGEniES9iWStGh9FxZMWyRAEZo4bD9WKfjLGlazx5zoI1'
$j6 &= 'xSs6rqntWPmtlsGz9veuvcj0Rk17S4RHmtMCSdQi/3bwidcBF5VvHd5sRYxsFiLuDGXBPvkyQV0YCBET7UOrTXVzr0fCJGACV0qbfUYGZcS5VoRheXqEuzTMcvF3QFjIFjzuvAe/L2GlHCVkwAKlDUEoI84sbjVZpd0mu6zPZJX10t9dJrOolTLlBrM0r9YsweclIWRcp6Kips1cefUHzC233WFeSlrGJNiUBCwhkU5JxB7RxuKxJ0ikwCfaeJBkU5ZwAhF7BcxESngfSRhXWaPPeOU/v/3t75SWlp5PY38DsZaAiJERQ8TIiKWIOSOGiGMdsGMRy4z4iBMxyxidiJcVuyUKnkUBGaOwLmVsyxQEFi6OiqIO1Dzr6BMGa9uHPj+wZuvu5v6ND+OCP5hl0Y1ygVe+LlKY0wnJNOJvB0e6PqyIRzab1gGIeLUVcNIiRn1YiBjghI6qpu4IEXMWDAnbkzjmZpjFmaUhAU+IdEKmgWBd+S4Tf09IOHRfHm759SFy6PGkZEy3eF7eCpsBIxvOLu8zORUDdNtPUu4JMmQS8tKCevs8CDl4XbSEAWZUzF1cYLIKV5jzLrrK/PKOO2k3+HmDOcR+ATN+8Ur8EgYkUx9e6frwCNfHpCUMSLQpSxiQVGMRJV8mUsIoRTz3zHPmwfsf+NO//PO/3FhcUAAJbySQDUsRc2kCInZLEypighvPMvZlxSxjlCgSyZhrxtjVQO0HxXjIuKmgIGesu7f//fkVjR/pX73t8bbhzfs7xra+GpQsID6fgOPBwpxu0L4YSAmH/p8QMX6lIxDxBOu9EgadoYN0nAmziPEewQkdkVkw5HsqSfgU/MLGnMUmM39CqCzXKPIoSw2xDOTXWDJDt2ApCD9v4rVS1CzjsJAhUFfIeDyX3rOgMRAxZcMQcU7FoBAyZcglHWZZUYsV8lIc1OP388mYmJ9RZHKK68y2i95lfvyT281+Eiamt/klTNDj8XDlG/24ZyYE45Uv'
$j6 &= '4xGuh0DAU5AwSTUWfgEDkmosvAJmJiSMaxvT81+99/f3Pvf5z33+RzTGIeEzCSni6agRHzEiRsSScbwShawXuzKWNWPIGLMpsHBxRBSlinB2fNxxx7StXr36o4XLmz/SPnLWQ13j217pHN/2mj2Y5hVuPFxpzhQh8XrATzK1jmwxLVbEq5ISsVsbtgwHpQ383dQzGsqCUYYISXjOEgJXUFtohTwh4AnZukj5LiugbLWg1mQW1pmsItwGf2fSfXgsUsgE3jf8GdFSjhCylTA9P7+eJBsqTZB4AwlLAiFnlXWTkNspe2625YwM+rxYQoaM7TUysspM18A6c9NPf2727n3cTmlLRcKugH0SnngeidWHV8DAL13JfjBNEvbLV0JS9eGVr2QiE8bn37dr14Mf+MAHvkjjejsBCW8iUJZYR6whUB92Z01gLnE6Zk0ccSIGsWSMDseSMQ7e+WSMhYmpbdjVcLNjWzsmUKhvW7ly7Nr2wbU3Ng2euTf5MkU8XGHGpzOE77FE8Gt9tI0EP6nfPrgy9EscIQnjNpaEpYjt/4GIO+j/hu4RWwfGD3hOnD2HM+cWBj/qubQoEKQQp5Uuw/INCRjSzSqqD5NdTOBWkElytrLm14Xe12bJTEjK4RKGFTAeo8/AbIniDpJwr8m20h1ymBBythVyn8kmYdsDerZ+jClvsWWM38/DbW//uPnO935gdj+6L5hJ8TgTS6p+Yj+XxOrDK2DgFy9jBQymJGGChJq6gAEJ1YdXvJJAwrjYO57/0AMP7Nm+/YJraRyfRUgJx8qGuSzhO1DH84j5GsXpOM35dRWxRMwyxlYnnow5M+bZFNilwBZNlio4O5a1Y6yEplmzZmEXpa22vn7H0JrN/9uzZjvt3kN0PsmmRmf472iJJsIn11TwiljINyxg4JFwBwQ8FID7IGJkwZESxk/bZwS/phGScCaJMwuiZUISzczH34QVcB2JtyGKHM99EDSej9cto9dHClkQFjL9'
$j6 &= 'jQN0Rc32oFx2+YDJrRw2uctHTA7dBpCEgSPjiewY9eOOIDsuQHYclCvkAT0ImFmaW2lPAPnMZ75g9u55zBw4cDCOVP3Efi6JNWkBM3HkC8ICZjySTQQJNW0SjhJuLPYFEn7sMbN79+5969atey+N3c0Ei9itDcvZEnIOsXtmne96E+6MiXhn1vkk/LoVMfDJmEsUkDG2RK6MsZB4NgXPM8ZuhcyOMSWFD+T5yhVNb3vbMZ2nnH7GSE5hxUVDY+tvwvzjWNewmBBsauB1PmlOB1bEfatN+8DkRdwOIGO6begiEeOsuZCA5y/OMYszi+y1hCFACDebhJlX2mAKyppMQXmzyS9rNLlWpJTd2vIDQPZL0i1pjEMgZUvobyvloobgvVC6YClbMeMWmTfdFtDnUUabXd5LAh4yectHScJjBG5HCJaxK2VXyJhhgey4ndqO6W4kZJI8C1mKGJkxLqmZXVhtrrr6A+aeu3aZF55/MSkBg9ezhP2yjQcJdRIShoBRisCvidz927v2jY6OvpvGrSthWZJANswliQFC1oYne60JZMNSxPGyYfC6Ctlw4MqYSxTJyJhPheZShZsdc7kCW0AuV/BUNytkojU7O3tjdkntlR39Y9/vXnXuq/0bLjX2Z5WiLr0ZSSDaVPBLNB20jZ5tmvtJxMiIE9WFhYRxWrQtR4QkzCKu7xiyV1E7dfYCc8aCTPurypASygOYRZBLoiysaDalVe2mrKaD6DSl1R2muKrNFC1vMwWVLSaP5Jxb2kRyBYF0cy2R90VQKv8nGQMrZcgdpYuAQPRNJru00+RW9JOAh01e1RgxLogUssWVskfIE+UKnn8MIbOMJ6SMK7jll9aZLdt2mBu+/xPzhxdfInm6co0ktqxJqlOUcISAQVokDHyCTQaSagoS3hdmn50fvHfP3r/cfuttt61ZteavaJwmI+FYJQm3NuzLhuERzoa5LAHvJFuWAK+7kI3nDsWTsSxT8NQ2bLXcUoWb'
$j6 &= 'HWOLJ8sVsYSMldWalZV1Zllt57XN3STk8bOfGdi4wx4IsxIdd6WaTvxyTYW20XNM88Aa0zYYOljnSNiKmCUsRByuC4fKEu2DqymzHrcXhj/9jAwzf1GOWbSsmLJA7JIHEs6jzLeIRFtW3W4qVnSZyrpuU1nfQ6/pDVNB/5fSY8VVHSTl1rCUrZiZsHCD+6Ohxywyo26m/9tNbnkXSZUEXDVi8qrHTX71SrpdaW/zq+hvIeMIIVcyIjuuJAkzEHI5CdnOrui0syuQdaMcEtSkJ0S8lJifUWw3Tms2nm++f+OPzXPPPmcP2rmijZ8tk1STli8TR8AgTRL2CzZZSLApSnjvnn3mwFMHzJ7de16+9eZbbxseHH4njc1UJYx5w/K0Zi5J8JQ17DHL2jDc4WbDcI3MhuEjuEmKWHrsdRmyAyAVGfPUNl92zAfysHAhZOx2sJCx8KWQsYviO6DXumDenDXVjV2fbOxbf3P70Mb9fespQ159IQnPJ9F04JdrKrSPbbW/5Iw5wPaaxK6EpYhZwiERczbcNrDKtPaP22y4aHmjvYgPX8oSB7Ay86tNXkm9KV7eShLuIAl3msrabrO8vtdUNfabmuYBU9s6ZFa0BFQ3DZKU+015HUmZMmZIuXB5uxVzfgXJuazZ4pcwgVKHFTH+pgy7gqRe1WcKakZMYe0qU1i31lJQu8YUrFhNrDL5NSAQcszsOCTjyHKFEHEIWz+m7Bilj/DZeRCyLVdwqaLSLFxWShup5WbV+nPNT2/5hRUxZlRI2SadCXul65KqhIFHtPFIp4RTEDEkTJnwn27+6c23rV299l00HhNJmA/OcV2YJSzrwu4BOvhAzpRwa8PuQbojriwhQ3YCSBG7MgYsYywcLCRssSBjNzvm2rEsV/C8Y1k/dg/osZBRrrBCPnrWm3qWr2j+VMvwlt+2DZ/5OOYfd6+BkCE/n1DTRbRoE9E+ts2KGHOA8XP4SYmY/uYsuJUk3Nw7Zpp6RkxD'
$j6 &= '5yBlue3BVdRwCjPOnsutNFkFNaaA5Fha1WbKKdutIAlXkoSrScIrWgathGtbh4mRgDYwHEi5edBUNQ2QmPtMBYm5LJQtF1a2mfxylDEISNkC8YYohaxJ3JXdprCGNhD1q0xJ4wZT2nQWsZn+PtMUNWyg+9dNSLkWUiYgZZspy+wYMg7IqQQsZJEds4zt36HsGGfnkZBxCjVmaExkxwGLMrHBqjTrNl9qfnzzL0iIT9rLaSadCaco4eQFzHhk68MKOE0SFqKNBQsY4NesScJ/vuXmW25duzYlCSMT9kkY41lKWE5XkyUJOVPiDZMNy5CdAbFkLLNjlrFbqvBlx1yucOvHPN1NHtCTQkZhPzzljegoKyv/f+2j59zfMbr1hY7Rba/gRAq/RNONX7wuHePbTMvAOpLqGsqIE4g4RJAJB6UIzBtu7B4xjV1Dphl0DFoJs4iR8WUXrjAF5U2mpKrdlJOEq0iq1ZQFx5JwXfuIqW8fDWgLbusIPFZDr0EWXV7bY0qqOykDbw+yZCvlIFPOoyw4v7ydsuheU1w7StJdZ0qbN5nS1s2mrGWLKWsOKG0hITefaYobN5oiorB+fWSmHBJyvhVyUKqQQg6k7BGyyJKRHePsvEw797jJLOPsWAh5CW24FmaUmHVnXWp++KPb7FzjJ56IzIynJuEn/QIGXvkyHuF6CAScJhGHRBsLKWCAz9/96O5Xb73l1lvGx8evojG3+aijjpISxuyIZMoRPgljjLOEuS7MJQm4IlZJwlcbPiJFjJAdAixjFjJviaSMk8mOYwkZdSH3gJ47wwIrkKe8YaWi1mSFvDSn6N3NA5vu6Vl7kcFZep3jJELUj0mEwa2DV67pQor4XPtLzshu3dIElyAkyIRRioCEm3tHTRMk3DlkmrpIkA0dZuFSnMAQXNYSkkE2jBkSxZWtVsLVTUEWvIIEDMIStlkwJBwSMNPBjFkacAsp02tqmocos+6jLLnbFJOUCyvbTQHKEMu7'
$j6 &= 'TFH1gCmuW0nZ7wZTTgIubzt7glYSsYSEXNZylilpCkmZMmVbvpBCtmULt1zBcO04VskCB/M4O24lIQdXd8MUOluuoIwYYNnV0zL5ytduMPseC0708IrYI9p4eAUMvPJl/NKVPAZmSMKugBm87lvf+NZPa2pqcBlLzoQxTzhdEuaDc7HqwnAHS1iWJDgblhI+IkWMkJ0CroxZyG52jIXF2XEqQuYDer4ZFlhxWIGukFGyaJk1a1bHm2bN6lyYWXRJbdeanw+eeYWx84BjidiFJer+PyVIxETLoBQxyVeUIAIBB7MkbCmif6WVcEtIwk0k4ebOQVPXQjKsaAjtak+UJPJK600RSRjlCEi4ppkk3AIBh2gDJGCi3uIKOJBwQ8e4aQSdRNe4aegMxIzsGUKvhpQbh01547gpa1pjyls2WgFXtJ9jKju20i1zjiknKtqCWwvJWQq5lLLkEhJycah0UURCLowQMteRnQN6YSE7mbEUcuhgXiZOlc7HqdKRMl6cWW4a24bNF67/D/Pkk/gtPCljv2hjgTKHV8DAK1+JX75MtISBT7BJAql68MkXBO3Yb7721a/9pLy8/HIaY4dKwr66sJsN+yQMjqhwOxdLxvGyY1mugJC5XOGrH/MBPawcd4aFK2SegxwWMsm445TZc1cuy6+4qKpt9Af9G3eYvnUXB9ParJQZ/J+AKLGmTgeBn9RHaQLXHA5L2Io4yIJRhrAH5AYmJNzcM0ICpky4Y8B09A6ZmsYOmwnjQBQOzuEaC5gnjKlpOCiHA3LIYCckPJEJx5fwqM2CrYBDEgZNXSsJ/L3SNHavMU09G0xj72Zim2noO9/U9V1oansvNCt6LjDV3eeZ5Z3nmoqObYGU6baiHQRiZjlztmwz5pYtJOTNoSwZQl4/IeQVqzxli4kMOSeiXOGTcZ89mJdZhKlulB3nUXacEwgZZQrU2Fuo33//mS+RbJ6yZ+ElK+FAvjEk7BWuS7R0GStf5hBJGLMj'
$j6 &= 'cNF9TFX7+te+/pOysjL8vhyXIqSE5ckakDDmCftmR0DC8sCcT8LYI2YJxzo4J+vCUsKxRHxEhuwgSEbGPiFzduzWjycjZJ7y5hfym97UNnv+kk35lS1XVbWN3NA6tPmF3rXb7TzklIXswxFubJARbzBtlO1i+poUMR+QYwljZkRL75hp6R62pYgWor1n0LR1D5rymhaziDJhTFPLL200xcvbbBZc1dgXkrDMhCHhEDElzKUIZL8TAo4U8SraIKyjdp1l2oZoozJysekY22Hax3YSl5vW0R2mefgy0zh4MYl5u6npudBUdZGUO84jIZ9rKknGlWE5h6RMmbKllcTcSplySMilXLYI1ZFl2aLAqSOHTwyJqh8TkHE5UUZCLqXsuJiy48LQpTZzV5CMq2xWvJSkXEEbsR1XvNc88XjwKx8+8TKRAk6vhGPLl/HINVlIrskIGJCEX3v+uRdQE37x85/7/L9UVVVdQeMoWQnjZA2WMOYJ+yQsD8xJCWO8SwnDCyzhZOrCbwgJc8iOMpMVcjozZHcOMlY8nxSCL0P72089Y1330Nrvdo+dtauxf+M++4vTq10hT0HK8bAi3mivSRz8Cgcy4UDCkDMk3BaScCskTJlwS9eQae8dNj0Do6amocMUVTSSfHHdB8qCK1rsSRqVDb2muokE3DJoCSTM8mVC2TAELCSMDDggkHBDhIRJwN2rTXP3WtooULsHzjbtw7Ssxi6lvYorTNeqd9DGLMTKK+19HeM7Tdvo5STlS01D/8WmloRc03WBqeo8PyTlQMg2U+ZsuY3ETJSHhBxkySTkljMpS0bZgjJkIWRMf2Mhs5S5ZJHjTnmzmTELuZ+E3ENCbg9OBMmrs+UKzKSYu7DAZOXXmKuv+RuS0H7zFMnYXl2NRBtbwICkmrKEQQwBM14JA49gk2EvSCxgsHfPY6/hLMS777r72Q9/+MP/Pn/u/HNp7PjKEfEyYT5ZQ0oY4zKWhN1yhEo4yZAdlsQS'
$j6 &= 'MhYcC1nKGPjqxyxkrh9LIcspb1iRWKHuHOSYQm6oqzm7qqbhiuVNvZ8fWL11f2P/pj32tOlVXEeeJhnT++MHRIPSRFCOkJmwBRLuGyMRj5qOvlHTTQLuIBE3tPSYnKLgoFNeSZAF21kR4Sw4EDEkvCIiCx62Aq6LU4qwQMJhEa8iAa8xTb3rTUvfmaZ18Bwr4I7Ri6kfO6xwId8el9UB3UTXqitsttyCLHngUsqSLw5lyeeTlFG+ICkDypYrAJcvIGSbLeNgHw7wkZCbcXBvUyDk+kghcx05EPJoqGwRkrE9ddqV8YDJQXaM2jF+qsnWjmsoK64yCzJK7EG8D334U+bBBx+1l9G09WKvgBmS6oxJGDiCTQYrYZBYwmgPJHznb+967gMf+MBXabxsJWQmjOlp8TJhPm2ZJeyerIHxiWM9vtkRbiYMF8AJXI5wJcwi9kkYvKHC7TyIJeN4Qubs2BUyCvVSyL4pb5MSclF+zsrBweG/zSlv/GjPynOe6hg9549WwCgjRAjZhyPZZOCMeGB1UA8mAePkDgbZMETcMTBuugbHTGfviGnt6DfV9SQNXDeioNYUljfbWnBFXSBhmwmLcgQkHBZxSMLx6sET2fDKQMA960jAm0wrZb9BCWI7tf1SavtOkitlvZYgC46U8DtNz5po8NxOEnfb6E7TPLTDNAxcQlK+yNTa8sUFppqyZStllC+QLQshB/XkYPYFDvCVYrZFMwnZ1pHXRZYsQjMt8qsh49DBvPA1LBwZE6gdZ5eEfhUkPyhV2IN5lB3Pnp9rPv7Jz5n77nvInvSBaxsnlPAkRBwlYOCVLyPkmixCwj7xSvB8un1l1+92PXH1VVf/M42RbYQrYRyUYwljjjAu4OOTMKaVYqxhqqlPwjxPOJaEE2XCKuEY4S4IcDgJmc/Sg5Bx1DYs5GOOmdWxevXaT65oG7+xbXjLk+HrVETJ18URbRI09a22td/OUCbMEu6gbLiDRNxpJTxuOvuG'
$j6 &= 'TXVdh1m4rMweWEI2XFjeZK8bUV7bZZY3BmfKsYjtPGGnJBHOhIWIJ+QLAvnaA3CU/Tb3b6YNxbmmbeRC0zl2CQk0yH5ZvpKwiJEFewQs6V0b3AaZ8pWmY/wK0zp6Oe0dXEpivtjU9pKUu7l8ca4lXE8Oz75whRzMtrB1ZM6QcdYe1495dkVlwET9eELIgYyDUgUuIrQMV4jLr6LsuNycekYmyfiz5oEHHgmdgRdDwl7RxuNQSNgKNi54Pt2+etdd9+zq6OiQ09NiZcIsYZwtl4yEUTqEhPmMOVfCXI7QA3NpCrlQmHQLOd4cZBay7yy9eELG1Jr2vr6+D/aMb34olBW/Fi3feESLV9IxtpV2/UdNc/dwUBsmEeMi8Z0hekdWm26SMA7GLVhaEj5RA79YnFtcZ0VcsrwtqAvXBdeN4LnCwfS0QMCBhCdEbOcLhyVM2a8V8GrKfiHfM0mIW03b8IWmneTbQfINsl/OgCMFHClhCPaqCOlKIOC+deAq4uoJ1l5tHw9LeWSHaRxE+eIis6L7QlNNQq7qwIE+CJmlHMy4sFLmKXAoW9g5yUEdmU8QsSULFjJKFTzLQgoZl9u02fGAycE0N8qMM/OqzbJczESpNFkEfu/vQx/+pHn00X2v4aeV0iHh1OQrEYJNBitfxi9fBs/fu2ffq/fd9+B9lZWVl9I4iCVhebacvJQlJIwLu/NV1FjCOHgeS8IYryg1soR9U9RUwlMMuXAYKWPgEzIWeDwhywN6LGTszsQSMs9BTlbIzcccc0znrFnHdC2vXvGO/rGNv+5di+lubu14MlCmObzZ1GMaWveQFTGy4q7h1aZ3dI2VcFf/mCmpbDKYH2xP1AhhL+SDecIlDaawssWU4kI+yIpx6nLTYHCyRli+LGCCBMwSrrflB2S/6ygr30iZ79mmdfh80z56kWkfv4zkezmJEfL1Z8CMlXA4C4aEryLhTki2d20g5l6ij/6OELAH+3xkypR5t9vyxWWh'
$j6 &= 'g3zbrZQjD/QFYg4O8gVCDteRrZBRR95giuq4bBFMe/PNQ4aQ7TWRcTZeMUk4v5pEXGEFnJW/3GQXgCqzeFnJgauufv/9+/Y88cSBpw5OWsJRAp4uCUcIOLGEcSo2pqn96n9+dW9eXt7FNAakhHFQznfKsns9YSlhzFaKJ2EcbHclHCsTdssR8SQMNDzhLiTGJ+NUhIzsOJaQsWInK2R8ecJCfhsJed7CJavzSqt2dg+tvLk3dC3k5OrHHuh1Lf3rSIwDpqV7xHSPrDM9o2vN0OoNZoBu88vq7W4x5gZHihhnzS2nrLjG5JKIccKGzYjre2xZws6QiJIwBDxiBVzXudI02Lm/Gyn73WJah2iDMLqd5HspZb+Xm86wfBl/GSI6CyYBE33r3kUSvdQ09Z9n6nq2mebBi0w3SbifJNvvZsLxICFD3vicoKZ8uT3Q10yZshVzqHyxnKTMWXIwDW5rtJDtqdQbSMohIYfrxxNZspVyRZ/JKmyg5b48JODKsIDzinEx/co/nHzavOuPOebY86+99m//4eGH9j5vZewRrY/HIiChTkrCwCNcD5ECZvwCxtzgpw8cNI8+svul73//+/9VvXy5PFEjnoTlxXviSRhjCxLGePNJGMlTujJhoJFkuAsOxJPyZDPkeCWLWELGltsrZKI1Mydnc0FF0/tIoD/sGt/6Kq70Fsyw2Bot3Bggq27oHjO4TgSy4OHVm8zI6o2mq2/EFFfUm4zsCrOQBAwWsYTpviU5lfbXL3KK601haLoaLsoTlnBEPTiUBVP2W9+12jT0bKDsd7NpGdhG2e8FlHFebDoo++0g+XaQdEFnEhKOPCAXkjAJGCWH1iGSY+MQZeodJq+80xRV9ZvK5vWUcZOQ6fkD699FQMoe+cYgyKqvCteUMfuidXiHaRq8xNT1XkRCvnAiS7YH94IDfEEdeULIfNYe15EL7ckhKwkSspUwbfzyAglnF4QkXFhtcotWmMycsvvmzFv82Te/'
$j6 &= '+ZgL6Dtw9vHHH7/t2ms/8o8PPbTnOZzkYGdShITrEing6ZfwPpCChJEBH3z6GZLwoy/ccMMN3ysvL7+E+pgOCWPvkiWMsYUxhvGGUqErYYxVljCSK4zpZCTsOkRjEuEuRMYnZJYxC5llLIUMGXOGjBUKIWM3x5chyznIUsjYbYonZMyBDIScuXRzRX3Pxxq6xn/cOXLWs/0bLiNR+eYgu5xr2ke2mJqWPpLwKjO8aoNp6x4wlTVNprC0yixYkk+7wMUTl7MkkAlDwktplxlzhlnCuIjPimZ5AR9IGAfjSL6dq4PSQ++ZpnngHNMydL5pG7mIRIbsd0dIwFdaOi1SxHHqwShFhCSMMkTv2nfRhmWnqe/eZMpq++28Zuza4xc6MinDzC5uM8XVg2Z5K20IBvCLKldawQ5sCKTsijcRyJTRhk56HztHeegyU98XZMkrKEuu7iIp25kXoQN8oRNFgpNEMP0N85FDZYvaVSa/stf+wghKEOEyRGEVCRjln1pTXLbiwTlnLPgorfMt4KijjsItLnCz+aMf/dTnH7j/0WeC38F7KoGAAcl0miRsBQxSkDAIJLz7+e9+93vfra+vx9lyroRRD453yrL8eSMcX2EJY+ykKuGpZMIaUwi5ICU+GScSssyOEwkZXwL3pBAWMk4K8QkZZwFByPiihYU8Z87Ja6oauv6xeWDjL9sGNz3Ru5ayP/trIciSRekCsy8oc8ZBusbucTsjoqOfMtbmLlNQXGnmLcwmCeeaRRn5ZiGxeFmRySAZ42LmuJIazpzLKakPTtxY0WWqGoPTl/nAXFADXmkaOteaxp6Npql/SzDrYXg7Zb8k33GS78rLQwJGBjwh4UC8UsIxsmErYEBStBJ+p82sa1opw6R2YTZHsBtfY/CrHFlFjSazgHb3C+pNdkkbZaGjJORNppGEjIOAeH0/Zcn9kxEyZeBoC9oVnnlh5ymHpsTZk0d45gWmwgkpU6Zc2rjOXisZexdZBVW2'
$j6 &= 'BAFyKAsGlBU/l51f8Zvs3PyP05fQypeAoFhSYNNn/+n6L99//8MH+MdI/QIGJNNJi9gvXya+hIFfwrjsJ0n4xe9973vfbWxstBIOXUFNnqgRT8K+60awhHHKsith7I36JIw9WYxZljDGs0r4EIRcqBJe6EwsIUspY0vqCjlWDTlZIeNLBSFjVyvqwkJE26xZb+opr67/TOvw2fe1j5z1dPvo2XYecsTUt7GzTXPvmpdXNHc+M7xynSmvajTzFuWQdAvMksxCy+JM+pv+X7yU/iaWZJVaUeC6wvhZI/y6xsTsCAh4zNR1rDINXch+zzLNg1tJSBeSmC6h7JfkO07yJelx+cEvYUmkgCMlzFnw1XTfTtNKoq9qGqENRK3JLakzucWBiFHfXpZXYzPizMJGEnIzibjFZJGMs4pbTX7VoKlo2UiZ7AXUPgj5HVauEHIqZYuAqyZqytRGZMoTJ4/gFOsLg0yZsuSqTkiZhNxM2XA1MuE6m/2iBAFyKAvORfvzKvbPW5z1H6eefirXSmWWCEmxqLDLvuH667/ylfvve+gpmxU//iRJNo6EvaJNhF/AYLISxoG5Bx946I/IhKtXVNtyhCNhtxyRjIQxNqSEMYYwljCuIGGMNeyVsoQxJlnCXI6IJWF2gOsIjWkKd0EDn4x9QpYy9mXILOTJZMg42CAvLOQVMtFRW9/w8RUdwz9o6l+/u3Vo04uguW/NCysa2w/U1DX8rLm94/NLc0oeWLS08E8ZWUWvZmSjFFFEIiboNgO3gozsUpulVazoMHUk4LpW1H/HbPmhoRu1X8p+h84j+V5sWscuM22QLwkuEDAzIeBoCUfLVwLBcT0Y8utceamp7VhnLxSPS23aHyGlW0yryycpZ+ZWvpqRU/ma/b26sIhbTXZpu/3ZpJyygLzKPlPWtNHU9eJa0Tvpvd9hD+qlLmMG7cPGIqgp21OsaWPUbOcoo6Z8oalq3WgKl3eReGtsBg/5BqxAPfi1zPzK'
$j6 &= 'x+csyLye1qPMglnAYfkSnC1iLu1akvG/2Mw4NLVtuiUcFjDwCpiJljBeT5nwy1/64pe+s2jRogup/W4fuW/ybDmfhPmUZZYwxoa8eI9PwhhzPgljzKqED7NwFzjjEzJWVqpCliULHNBLJGS+joVPyNgVYyHjSxkWMtGVk59/VktbxzWhgyD4IuMAB77UoyefOueDC5fm/X5pThnJtsRkZBH2tji4ZUL3Y15rUUWLWdE2blow53eAst/B80nAF1nhtJN4QDwJR2fBfvkCyKxnDYEDZuveZSXZPnKhqagfMAUVTfbHSHHheRaxvfJbeaPJyCnbsyirbL8tTUDExciGAxFnl3aQhDtMbjnoIrpNbkW3KalfY2q6tlI2e7n9nMENk8mOHcKZMmrKO01t15mmaHlnkLmHMnhkwLjNp/Zn5pb/5lRaJ7RuYglYyheZIkSFbBGs/NznvvTZBx/cfRA14ygReyWbiKkIGERLGJkwJPxPn/38d+bOnXsetdsn4WRPWcb3Hd99n4T5uhHJSDiZTBhIF2jMUMiF7iJXTrqEnChDxheLhYwvG4SMgxFxhTxr1qzOo48+uvfoWbOQSeCLjKPM+FIP0WNjRx31ljVvP2n2VfMWZf98aU6pAciAAwkHfy+lv/mxZXnLTT5JDLMRmge3kzB32jKBFW8MAUO+kRJm2eJEiuDUYwnEFZYwCa13/bvp/h2Uga83pTVddv4yJCxFnF+Gs9GWP56ZW/TVU0+d/Y43HXXUthNOPPWDi5YV/Sq/qs/kIgsOZcOBhAFJETImEedV9tifV8JF5as7zrZn2vWuudoMbZhcDZnBQcHeVZebOmo7MngIN7+knkRcb8spuG4zTo5Zll34jRNOPNGdtuXuprsCxuwBAFlhPu3IJz/5Dx9/+OG9z+LaFFOTMPDIl/GKVxIpYMyOwHS7hx96hCT8T9+Ze7qVMPoaT8KxTlnGdxszifB9x8FsjAEcT8G4wEFvljDGj5Qwxplm'
$j6 &= 'wkdAuCtEChlIKfuEzFJOh5BxECKRkFGysAf1CHyBMcUHu3X4UkPM+IIjSx4+7fS5O8rKq2+bvyj7p0uySl5dlodLMuJgXSDggDKbFWcVNZi8ii5T2rDarOg+z56N1g1priHZro6WcHQGzAKeIHJqGt7rKnsgDbv6bcPnUxbcb0qq8Zt1kHAAJIz/i6vazbKc0p+fcPLsvzrm2GMvOOqo8G79lmOPPe6yk+cs+uCSzOJbINp8Eu6EhFnEXbY/efQ3hFywvM8U1QzRxmaDaRq8yHRRVju08d1mcGPyUkbbBzbQBmTlpaa6edS20W4wIGKSLwScV2YP1O0nCf8HSfiyUJtZwm4WzAKGoFi+2LOBqAD2dAaPPfbY4Y997Lq/DWSMzNgn2GQgmcbCK16XCAm/9tKLfzT33/fgE9d+8NrrMhZlbKe2op8g1UwY32efhLG3CAljDxLTQzFmMEMJ44gljHHmk7AUsEr4dRLuigGxZMxCxopOlCHjC4IvCg7occkCBxWkkHkOsu86FokyZBZyuGxBhKV89NGzBhcvWHzBsce//byCkuU/zcgq+tWSzMKDmfkVJpOkvCwXEi6jvyvtFLZc+wOdvSSsEVPetM7U9qBGvMP0rMXpxCTb1a6EOeP1SRhTwgAE/E7TRxlw3zqS2PgO09hzpimvo89hAQsRQ26UFf8lJ7/iG29/+ylXUz8gMikzzrY2nXDCiTvnLMj5aEZO6U25pa1/KKwZJOmiLNFJEgYhGVuC//Px23crhk0FZf+N/RdQtn+F6acMF1J2p76hjNG+8kraIF1Fwn6PFTY2IFWNw9RmWlYkYZRN8ssagiye/s4uqtp9ymnzPnTcccexmNzskLNgKWCb+RJWvAREhb2cPtrDwbrsPeGEE/r//u8/+zcPPbT3IE9r88vWj1e+jFe6LhHZ8Gt//MOfzC/+5xd7L7noks9Q27CRlH3ljU0ymTBLGLOHIGEcwE5Wwkh0kPT4MuFYEgZynGsc'
$j6 &= 'ZiFXDiNXHvAJ2c2QUxEyz0HG9JtUhIz6mTwxRB7Y4yw5QspZWVkXn3La6ZdkZBZ8Oyuv7KHFmYX7cMptQCDivHL8eGcgLgiraMWoFVY9Catt7HJ7Rhuu7YDyQiBiv4CthAFEvJay4A3X0Otwcsb5pqZ1pSld0WXrwUXLW63QIOKi5W10XzMOcD20ICPvS28//vjzqd0+AXNWGc4sTzjhuIsXZBT8Y2ZB7c35Zc1PFVb325IEsmQWcZA5E/S3vZ+yZPwYaUXLetPQd56dt9y/DhnvNWYQbLyGxPtu89cf+ozZvvMjBmfjoX6OWjaXTwrKcdv4Gs5GzC9t/DNt3P539txFH6c2oc3cbpkFcxmCSxCcAUPALF+sL8yjxbrDOuxEKYpusaHt+OIX/+3vHnxwt51NgZM+fNJ12WchmfrwStdlQsK4nsVLL/7B3H77z/eed975/0BtSlbC3Ef0L9bZcpAwvuvxJIyxIyWMMeZKWGbDKuHXYciV5CJXZrJCBlMVsluywMELeWKIL0uOKeWFCxeft3DxsvfNnb/081n5ZU8tySraPyHiNpLVhLQCiXWbwtoxEtYm0xCaq2vn/eJgG2WKroStgPH36qtCZ8fhhIkrTHPfFlNZ3x9kwZXNVsKgmCjBT+pXNP+Bdun/75TT53+Y2skClgNcCs0KmGCx2V38t73tLZuXLsv/p6zChv/LL295vLR+xBTQBgVZcljElh7a0HD/ukxh9ZCpbNloGvtwTeTLbBaPDQdq2p/6+D+YCy+5xixvWWPKa3utgLmejb6gDyTj52kv40cnnXLaNdQOX5tjZcHIEJEBs4Cxjli6WHdYh9jjwfpkWr/29f+87sEHdu9/fH98GQcCnqqEwYSE6f+Xf/mLOx4766yzPkNtSUXC3MdkJMynLGMc8BxhljDGDsYQSxhJD0tYCtiVsDueNV4H4a40RsoY+ISML0O8DBlfIClk1I/TJWSZJUspcz0ZAxwDofvkk09enZtb'
$j6 &= '8InZcxd+gkT8FE5CsBmxELFleXDACzKzGXLrWaZxAKcXv8NO6cKJGN2rcbUzCBczCq62GeX45vfackTn6HZT17nO/lw+Ml4WsKWSsuDy5r8UV7Y8l5Nf+YMTTzx5J7UNAxsi9gnYd3CLxcYZpiU/v/DTlS1r7ius6nkmt7T1WcqCXy4I9WUC/E/gwJ7NmntNSd2YqW7fZOq6NhNnmdL6ccqg2+xBOJvFU/ZrBUyQgF8hMf9hWV7J19/2tmPOoc/1tZnb68uCXQFjHbF4sZeDdYh16dL47W9//9OUGT8GGbtligkBp0/CqC/v3bPvzz//+S9/1tHR9SFqA/rrSpjXD/dVSjgd141A8jIZCQM5jjVeZyFXnkSuYDAVIWMXi592od8AABwOSURBVIWM2lcyQuZpb3ymHpctfFLGFx6DVx7kw2AISzknr+hT2YU1+3JKmv+cX9HxKrJFKSwIrKCKskHckriKaoZNZetme2nJbhJv//pr7C79wAbUUd9j1m19v7l4xwdtKQIH5FB2COQburUya6WssunlzPzld2Usy/44icz9pQZXwD75QmoY7O4BrjClpaUfW5pd/NnMwoZfFyALLu/8S7SQQ31Ev1FLpg1SblmLyS1tsmce5pCEUQcOBByIGHXszILq3y/JyP308ccfj9kCsTYanBm6ZQgcWGU5sYCxfiBfrDOsO6xDgPXJ4H/sAdV96z//++MPP7zncXv2XZSAY0jYK9tYTEh496N7X/7Nb+7+1dve9jYIWJaMZNYvNzhyYyMljO8h+oe++CSM77lPwm4mzOUItxShEj6CQ65IF7nC0yXkRBkyMgZMbHfryD4pcz2ZyxeulMPliyVLln4wv6zxAZwhVkCZMcQUCIqh+yFkK2Uc1BskIVOG3H+haRsJLnWJi/409W81FQ3DdjceZ+4BK+GQgEuq2om2Py3JLPjWm9/8ZvxeWTwBs8xYwFK+GOh8cItrrBCcxN5fXl75nuqa5v9YnFPz'
$j6 &= 'o+LaoSgRByAr7iQZt5OMW0nEzfaKdMiGWcS2L5XNry7JLPyvY445FhfskW1mIcXKgt0yBDaGnCGygFm8WHcQFdYjwDrl9Yr77Qb33//9m3/98MOPPfXEEwdItAlE7JVtPII5wrsf2f3nn/7op3fQ50HAk5UwvmtSwugHvqvuKcuuhDEeYpUjXAnz+PMJGGgcIeGuWEkiIbOUfUJG/TgZIbvT3iBkN0t2pczlCwxeSBmDwJUydoXbjp41q+foY48fmr8w46r8ktr/LSFhFXImHEWvfSx4vNsUQtwksYJKHPBrDqZ1lQenUOP371jCmDNcXNnydEZm9kdCEmYBs9DcEoQrYM56pXghNnmAS4L7eo49+ugBylzHjj762LETT5u/bVF25Q2YZVFUPRAp4ooOanebyUNGXNJoTyjB6dZ5JGK7AalueyUrtwwSRttZvm6bOQvm3XOuBaOtaCfahQ0glyCwLrBOsH6wniBcrDeUn7AeJbgvvF6LiysH/v2r3/n20wdfMjjZI50SxlQ5yoRfufHGH95+4oknyj2WyUoYWX4yEsb3XUoY4wJjhCWM8eOTsByD7vjUOALDXcmM/CKwjF0hs4xdIeNLFkvIsmTB095YyG6W7EqZyxdcU8Yg90mZa8qts2a9qfOkU2dvPGNxztU5hVU3F9f0U/Y7MFGekITklVfWRhlkIK/c0MkNLGJkw/aAXHnzK8tyKn564smzd77lLW9BZhUrA3YFjMEtD2yx0HwHt3zgMTwHWDkfd8JJG047I/OShcuKvpFX3vFSSW1wYA8bExy0zONsGGfMldWb4mpsTBqfXZpVcB2mA9J7oJ0MyzeWgN0smMsQ2BBi+WM9sIAhKKwvrDesP6xHAGEBd72Wd3ePrPzKV//zWwcOvhiSMYl0ihJ+9pnnzMMPPfzEV/7tK18pLCzEBd3dvRasL7muZNaP9SP76koY30W0H99TljD2+PC99mXCyUhYitgdlxpHeLgrnIknZF92'
$j6 &= 'zELmckWiDJnnIXPZIp6UuXyBAexKWWbK2CXmA33hLPm0004/Z8Gysr/JKlh+E+22/7mkdjicBQciRhYc1FWxO59X2mQFxiJGFllaSxlzeeP+jKzirx133Ek4LZvlm0jAsWQGmWKQQ7IY6GgrxIZ2Y4MiwX0Aj+N5eD6LufOtb33r+rmL8t+TkVf1zazCFffnlDa/WFzdSxsPnO3XZrKKql9eklXyy4UZBf86d8HSv37rW9+CtqKNErRXCpizQl8tWGbBWOYoMUgBQ7JYX5AU1h/Wo4TXqTxOUNreNTD6tW987zv7nwh+5WPyEt5vnjn4rHnowYef+GeKZUuW4Qc+pYB5nWF9yfq3zPqlhLEO8L3CdyyRhJFoIOnAdx3fe86EMS6SkbBvLGq8gcL3BWB8UnYzZCnlWCULnmWBI8e+LNknZVm+wJc+kZT5QF+UkE855cQtS3LKP51VVH8rCfegLVtU94UyYkgYu/OURZaGMuLS4GeX8ssaXyoob7hzcWbePxxzzDFn03thEPMurRSwm036ZCYFzEJDOyE1tBnZJeQmwX14DM/hzJ/7xVLuPProWeOz5yx83/yMos8sy6v5RkbO8m8sySr71vwluV+gDP4Keg7aBOEAtJHhDYZss9xwyDb7smAse86AsW6wjrCusN4gKaxDrEvGV5Ky5aiautaB79xw0w9Rmnjyiae8kk3E0weewSnLT375y1++PicnB+WXTUcddRQEzBLmdSYl7MuEsXylhLGxwXcNbUWb0X70xZUwzxGWEsaYYAlzIsMS5rHlG3sab9DwfRmAT8YsZP5i+TJkX8kCQsYXlYWMLBlfYGTJsnTBUuaDfO4Adg/0+YQMYUQI+bi3vmXVkqziz+WWt/82t6zlidyytj8UVlF2DCFj+lt5i5VwVlHN85kFVbsWZRZ9c96CRVccdZSVrYR35TmjZAEjs/IJGMKEOCEzDHCWL2SLgY42A8iN4Ywf93MphuUspYz3hShtlkxA'
$j6 &= 'JvhcfD6EirZANGgX2ifBfSxfbjNn7ngvudHAZ+Lz0R4WE5Y9NoxSwFhX2Jhi3WEdMlinuE/u/WB98rosys4r7fnpzbff9sjDu1/DhYJ8svWBWReYfXHvrvue/rd//bcvLlq0CBvNDSRhzoDdUoRcX1LCnPVj2WI5T1XC8TJhOa7keNPQsCG/FBL5xZEyjiVkyDiRkGWWLEsXMlPGl90nZd7Vlbu5yM6wm4zBE1PIRNf8xUuvy8it+q+88s4H8is6nygob3syr7Tp8cyCmnsXZOR/49jjjsPlEDlzhGwlfD9nlCw1XwbsCpgzSrQPskVbsRFBuzHgXXA/HsfzWM4QBKTI2TLeG5/BWbIrZciVxSzBfSxfbjOXIfBeWGacBeMz8dmcBbOYsA6kgFm6WHdYhxJenyxluS6tjM84I7Pz1lv/52ePPLLnNZzw4ROvhOcf33fvg89+4hOf+uJb3/pWd48l1l4Lry/O/FnCsr9SwthgSAmjL1OVsDvGNDSiwv2SMD4hu1JmIUspc8kiWSlz+ULWlF0py5qyzJJjCRnSkkKGsLrmz5+/NTMz88rZp5yCWqLMHrHbymDwMnwfZ1Q+AXM2KQXMMkO7uK6KrBIbEbQbGxQX3I/HeTYJxODL/iFlucFxpYx2QcwS3Mfy5TbLDQdn7bGyYBYTCxjrB+sKgsK6wzqUuOsTr8FrsR6xDm2p4owlBZ2UGd+KaW12jrFHwACPQdb33//QM9ddd90X6LXIdiFc354Lbzix3rB+sSGSEpalF+4vb3C4r/jOoc1oO/qBPuE7i++wlLCWIzTSHr4vDJBCBrGE7GbJEHI8KbtidqWMQY6BIGvKMrNKRshuhixFJbNH3q1neDee5ctZJQSM1+J9WMB4f5kBs4BZZpArhAb5oM3ILNF+Fy7F4HncLzf7l1kyPo+zZLQBgmExo20M5INb3A+4zVg2smwC4cfKgiEm3kWHXLF+sJ6wzrBBxfqTuOUovEZmx1yqKFx3'
$j6 &= '5taL//vGn9z99NPPeiUMDhx4hjLhB56+7pN//zl6jax/u3svcs8F6w7rDeuM1xdLmDc63F+5wXEljH6gT/i+4vuL77JPwjwe4klYQyPpcL88TCIZ+4TsZsnxMmXgDmIMdi5fcJbMtcdEQoa0ZIacaLceQM4Svp/lKzNglpkrYHw+BIz2oF1oH9qJQY4288EtgH4A/I37ZebP5RjuG97TzZKllLl8gTaxnBn8D/CY3Ghw5o73xHvzRoOlhPZgeXMJgjNgFjA2orzueOPq28DyesQ6jJLxeZdedeENN97822efeT5CwHv24ApqL5tdv/v9Pe9657t2nnjiiRAtJMt7MbH2XDgLxnrDOuPsH32PJWHe4PgkjP74JMzf92QyYQ2NSYX7RWJ8Qo4lZQg5WSm7YsZAZilzlsy7upxdYeDw7m48IUM4LGTICHKS2SMGK4tZwvdzRonB7AqYd2/xeZxNoh2c+WKAQzwQGtqMgY72u+B+PM4bGp+UIQ2ZJbOUuY9oD4vZBfdL+XIGLMsQ+AxuM9qA9nAWjHWAjaMUMNYV1hmvv3jrkbNjrD/0Fe8fkvFbii++/JoLSMa/OXjwebM3JOG//OU1c+stt/3v5s2bL581axbvxcg9GOy5uHsvsnSEDS7WG9YZ1j1vMNFv7rPM+tEuzvhZwugH+oTvKr67UsIsYJWwxrSH+6VipJBBIim7YsYXOplsmTMrHsycXfmEzFmWm0W6u/Xy4BcGKe/Ws5wB/8/yxXNlNgkBQ2augPH5nE2yzNBOCA1txkBH+xkMetzift7QcPYv+8ZSlv1jKXOmjH6ymF1wPx7H87jNsmzCQsJGg9uMtqB9UsBSvlhXnCVK3PUIIXN27JfxW95SvP2yay74/n/ffOfTBw6aP/3xz+b2W2+/45xzzrmUHueNJeTKey5cVuKyEe/F4Dm88cT6w3rD+mYJo+/4XvDGEsuWs37e4Mi+uhLG99fNglXCGjMW7heMkTIGqQrZJ2Wf'
$j6 &= 'kHkwy+wqlpBdYfl262X2yGLmjJl34QEe44wSInczYMiMBexmkyxgzrIAZ5aQEoP/eSPD/WIpc98gC0iShcxZspQy+slidsH9eBzg+VLAcsMBQco2c2bIGbArYBaUxF2PycmY2nT21su233rbL3536y2337Fly1m4TgbWAe/BsJCxt8K1foC/eS+GBSz3XLDeeKPJ60slrPG6DvfLxkgZA5+Qk5Uyvvi+wewTcqIMmYXl7tbL7BFyxWAFEDTD93FG6csmpYC5BAHBoD0sMxYv2oy2Y6C74H7uF8uZpYz3ipclo49oB4sZ7XLB/YDli9f5Mnd8Fj6T24w2YZlj+fsEzOvNRQpZrj+8n0/G6IuV8Vnn7NhRVlaGejCvD2wMfSUllB7kwUgpYLwGG0/ecGJjhHWG/qPvqUoYfVIJaxx24X7xJFLIIJaUE4lZDmYWMmfJkAMGDYsrWSFzBimzR8gVkuXde4bvkxklXov3iCVgzibRHshMypezSrTfB29oWMyybxAX3pf7h8/CZ6KP+HwWM/qKdjEsXYDH8ByWL7dZChifJQUspeQKmDNEF3cd8vrD+ySSMdqLDQeWNdYLNoAQMpeUIFkuKQFZOpIC5g0o1h/WHdYb1j+WAZdf5LpiCWM98AYHfZX9TFbCQENjRsP3JWSkjBkpZZBIyhgI7oCOJeR4GXKs3XoMemRKgHfdGb6f5YvXJBIwZ8AsYClftJkHuQvul/1ypQxxyf65UkY/WczcXwmLF3D2izZLAXO78ZncZikln4B5nbnI9ccbVLwPyxifEU/GWN5Y9tgIQqaQKgsZ5QYuKTGyfITnchaM9Yh1jPXmSpj77UqYNziTkbCGxiEN9wvpImXMSCGDRELmAe0KmaXFWSSEggEuhYyBzqLi7JGljEEKIFoJ389ZJQaym01KAWNQu9mklBngQe6C+7lfsm8sZRYy+ofPwGdxH1nKaAtAfxm0kf/mx1m+3GbfhoM3GtxeV8K8jniducj1'
$j6 &= 'F0vGvIFBO9AHtBHLFcsYyxvrgPdeWMi+chL+xn0sYC4fcRaM9Yf1jfXG6wz9536jzyphjSMq3C+nDyljiStkHtA8qJMVMqTFQoZoWFYsKSllZEgsZh94TGaUMpv0CZizSRaZK18Wmg88JvsWr39SytxPKWcfeEzKF6/Fe+D9XAHjc2V7XSkxvM5c5PqT6w7v6ZMx2iRljGWODR82hLKcxKUkWU7i/zkD5j0YvJY3nrzhxEYIyyCWhGP1l/vF31X3O62h8boI94vrIoUM4g3qWFJmYWFgSWFJWUFIMoNkMUOwDAuX4ayS5ctSY5lJAcsMmAUsBzcPcB/8OJ7r9k0KmbNkV8xSzj7wGOD2snzxfskIOJaUfMh1J2XMfZIyRlvQLpYxljOWOzZ+2BgiO2Yho8wA0cpSEpePpIC5fIT3wHth/fGGE8sCy0AlrPGGDfdL7CIHM+BBIAe1HNiJhCVFxZKSmSMGJ4uZgQjk/1K+nE1KoUmZJSNg7oMLP859c/sXq4+Apcz99cGPc3u5zSxgX7u5vVj2yUqYcdcb94v7E0vGWNZYB7znguyYhcylJFlCAriPS0h4Ll7DWTDeC++J91YJa2h4wv1iM3JAAzmoeWDLwZ1IyCwqDHgpZc6UGciWhctw5gvwOpZaKgLm9nL7Y8HP477J/rl9lP3kvnJ/ffDj/Hxus6/d/NncZl7+Ukog0bqT6437hPfnfvhkjOWNdcDZsRSyLCOh7AD4fy4jSQFzFswbT3wGPouXA/ou+83Lnvss++L2U0PjiAz3iy6RA0IObneAs7SksGJJWYqZwWAF8j48xydfKbNEImO47YzsDyOfz2Lg9+P+cR+5n9xX7q8Pfly2l9ss282f6baZl79v/fjwrS/uC/cD7UDbsCyxXLGMscx5zwWZLO+loLzA5SLIVsL3uyUkvIcvC8Zn8jKQ/U6lvxoaR3T4vvSAB4Yc3HKAy0HOA51FJSUlpcxilrBwGX4eyzdVAcu2yj7E'
$j6 &= 'Qj6f30P2T/aR+8l95f668GMMv4bfI167Zdt86yUebp+4L9wHbi+WpZSxzI5ZyFxCgmhZzCxewGUk3qNx92Dw3vgMud6479xvt8++PmlovKHCNwgADxJ3gPMglwMduJJiIbOUJZAtI+/n5/Mg5oHsyow/Xw5qObAlsfrEyNdz/9w+MtwG7m8s5PP4tbLN8dot28vI8D0O3P5wH7jdaJeUMZY9bxCRyUKmnCFz6QhilvD9XEbivRreqPL6jCdh7nuy/dXQeEOFb0DwYGF4kMuBzoOdBzwPeillBgM0Fvwcfp2UGr//ZEUWC/k6IN+TP0f20+1vPOTz5XvJz5Cf7WtfvPA93+0Htx3tkesFy5s3kLy3whmylLIL7mf5yjISCxjvyetQrju5DGS/fX3Q0NCg8A0OwIOHkYOdBzwPekaKOVn4Nfwe/L5yIMvBDHztlXD4HmPk+zH8WbKfPtw2usj3cT/D1xaQSsjX8fvKdsv1gmXMG0gpZMhUSpnFLOH78RxZRpJ7MbwO5fqTyyBevzU0NJzwDRQeRAwPLh7wDIuJByPDkvXhPpffg99TfpZsg6+dTKzwPVci3x/Iz/bha6OL+56+z2UmE/L1/Bn82e46wfKOJ2SWsg+WrytgXxbM689dBrKtQENDI0G4g4bhQcXwYOOBz/CATAX5evm+8vN8bWKSDd9rXeRn+pDtc9vow/cZksmG+z78edwuuT6kjF0hs5QZKV2Gn+cKWErYXX+x+q+hoZFCuANIwoOM4cHnwoPTh+/5wH1v3+cz6Qjf+8bCbRvje24s0hnue8s28fLEsuYNHgvZlTKL2Qc/zs9n+SYSMJBt09DQmELIweQiB52EB2Uy+F7v+yzJdITvc9LJdIX7OXI58jJmWUoh+6QcC36eFLBKWEPjEIQcWD7kIJwsvveVzGT4Pj8VZjJ8n8/LlCUZT8gMC1dKl+HXpCJgoKGhMQ3hDrSZ4HCLw7WNbpukIH1CllKOh3y+fB/5/sD9'
$j6 &= 'fA0NjRkMdwBOFo2ph2+5usKUMgVStBL3ecB9L+D7TA0NDY03dPjECFyB+kTrw32dxPc5GhoaGhoUPkECn0xTwfeeEg0NDQ0NJ3yynA40NDQ0NBKET57pQENDQ0MjxfDJNFk0NDQ0NNIYPtHGQkNDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0PjdRlziTXBnxoaGhoaMx2Q8C7iffY/DQ0NDY0ZjSbiJ4QhVMQaGhoaMxxSwipiDQ0NjRkOV8IqYg0NDY0ZDJ+EVcQaGhoaMxSxJKwi1tDQ0JiBgIR/TPgkDFTEGhoaGtMYiSQMVMQaGhoa0xSNRCIJAxWxhoaGxjREshIGKmINDQ2NNEcqEgYqYg0NDY00RqoSBipiDQ0NjTTFZCQMVMQaGhoaaQhI+CbCJ9pEqIg1NDQ0phhTkTBQEWtoaGhMIaYqYaAi1tDQ0JhkNBBTlTBQEWtoaGhMItIlYaAi1tDQ0Egx0ilhoCLW0NDQSCHSLWGgItbQ0NBIMiDhHxE+mU4FFbGGhoZGEjFdEgYqYg0NDY0EMZ0SBipiDQ0NjThRT0ynhIGKWENDQyNGzISEgYpYQ0NDwxMzJWGgItbQ0NBwAhL+IeGT5nSgItbQ0NAQMdMSBipiDQ0NjVDMJXYRPllOJw8T+Kl9RTmc0NCY8TgUmbCiHM5oaMxoqIQVJRoNjRmLOkIlrCjRaGjMSKiEFSU2GhrTHiphRYmPhsa0BiT8A8L35VMUJUBDY9pCJawoyaGhMS2hElaU5NHQSHuohBUlNTQ00hq1hEpYUVJDQyNtoRJWlMmhoZGWUAkryuTR0JhyQMI3Er4vmKIoidHQmFKohBVl6mhoTDpUwoqSHjQ0JhUqYUVJHxoaKccKQiWsKOlDQyOlUAkrSvrR0Eg6'
$j6 &= 'VMKKMj1oaCQVkPB/E74vkaIoU0NDI2GohBVletHQiBsqYUWZfjQ0YoZKWFFmBg0Nb9QQKmFFmRk0NKJCJawoM4uGRkSohBVl5tHQCAck/H3C90VRFGX60NCwoRJWlEOHhoaNbxG+L4iiKNOPhoYNzYgV5dChoREOlbGiHBo0NCJCZ00oysyjoREVKmNFmVk0NLyhMlaUmUNDI2botSYUZWbQ0IgbKmNFmX40NBKGylhRphcNjaRCZawo04eGRtIBGetv1ilK+tHQSClUxoqSfjQ0Ug6VsaKkFw2NSUUtoTJWlPSgoTHpUBkrSnrQ0JhSqIwVZepoaEw5VMaKMjU0NNISkPEPCN+XTFGU+GhopC1UxooyOTQ00hoqY0VJHQ2NtEcdoTJWlOTR0JiWUBkrSvJoaExbqIwVJTk0NKY1VMaKkhgNjWkPyPiHhO8LqCiKhsYMhcpYUWKjoTFjoTJWFD8aGjMa9YTKWFEi0dCY8VAZK0okGhqHJOYSuwjfl3I6eZj4iaIcZmhoHLI4FJnx+wgNDQ0NDREzLWMVsYaGhoYnIOMfET5xphsVsYaGhkaMmCkZq4g1NDQ04sRMyFhFrKGhoZEgplvGKmINDQ2NJKKBmC4Zq4g1NDQ0kozpkrGKWENDQyOFmA4Zq4g1NDQ0UgzI+CbCJ9XJoCLW0NDQmESkU8YqYg0NDY1JRrpkrCLW0NDQmEKkQ8YqYg0NDY0pxlRlrCLW0NDQSEM0EpOVsYpYQ0NDI00xWRmriDU0NDTSGJDxjwmfcGOhItbQ0NBIc6QqYxWxhoaGxjREKjJWEWtoaGhMUyQrYxWxhoaGxjRGMjJWEWtoaGhMczQR8WSsItbQ0NCYgYgnYxWxhoaGxgwFZPwTQkWsoaGhcQjDJ2MVsYaGhsYMhytjFbGGhobGIQgpYxWxhoaGxiGKucQuQkWsoaGhcQgDMl4T/KmhoaGRKN70pv8fdBu9A/zlqPAAAAAASUVORK5CYII='
Local $j4 = _1s3($j6)
If @error Then Return SetError(1, 0, 0)
$j4 = Binary($j4)
If $j1 Then
Local Const $j5 = FileOpen($j2 & "\Printer.png", 18)
If @error Then Return SetError(2, 0, $j4)
FileWrite($j5, $j4)
FileClose($j5)
EndIf
Return $j4
EndFunc
Func _1ru($j1 = False, $j2 = @TempDir)
Local $j7
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= 'Jps9ODQ4uGd8YmKouqqqtq2t7dyKWGxR0GgBAIRse97MmTObOzo7R/R9czq1rTxJRE69xo+nKDCj2PLAgkBTXQOWLlgES5zqVn9+T1gCQ2LPwD48cyCPzvHZcLwYQKx94ixtZsyazDHIE2ChyiOklCChHK+I/JdahyySiIpC4CMamciU9qGLHHRSHmqqJZYuyqOmysPAQBN2vzQfB1+rgetOT13O5XKDDz366HZ9s/ql6nkAcvGiRWDgnGlwazqWcua6bjoSiTSWPZ2NDQwMZMtIReHcs8+uIlXNFAijY2N7MLlf4VEnnU3t7VEwz3+zIySVTu86eODA/Vuff77HPwUAzuoVK566+OKLv25ZVlA7ElhC+AQuov8V37399h8B+DGAGVAVY3NbZs6cc+1HPvKPusn5cfHAQw99q7evz1dCjkRKfD+utH4VPn/DDTMty/opAk6evb29Dz786KNPOK7rE3DfQiANIN/Z3Y10Nvvf4UgkiEoiotFotVYmK/RcU1AivwwT0WKcgPHnuG6Kmb1wKFSU/guu25vNZh2cxDZmgvlsvI3J0slk8lA6nd47MDj42rbnn+9EyacrrRejIf0a1/ecd4SLeC0BN02HFI+Ojz+3Y8eOhw4eOjQ65cGqmAdaEYmEYhUVLUH3OTA4uO8ID2lFfLG9vd6V8r+gTV6ncR8fHBgYeOLll18+ODw66ocQi6QTAM9oaKg6a+3axTOami6prq5em0ilesoeOLPlqjGYLw2ap8jMhf0HDgyVEZncx6699lIhxG0IGipnRm939/2Pb978IgcgcetvuCEmVM5Z0Os+taL2mPcFC/GeoAMlm8v1J1KpI/nnle4ZohoE71Aymfyn068f7uj4zdPPPttR9p26QojHr7nqqg+0zpr1KQoo9YVCoeaqqqp6HTmpwOnXtvLEEzmwBAM53/T2mNKX6viOWDiCJXPno66mVpGft5u6sSx5wUEZuzGA0cwYntjXg5d6a1GQlUqFg+rcQEL1i4UQqq5VAlJIkKeLOMhSpI+g/9WKHAhhIlTa7jQWAYnVLbWKxFkRkAhpMYfRPDOM3Fglfvy9OiQnomB+M+fP8nBHx2/0zZRHyYOtAEA2NTcDUp71Zi+v4ziD/YODz73w4ovPJBKJAkspK6uqQssWL16waPHiSxKJxAEuTdI5AE4kFKoHc9BWRpycmDiEUmj22GauUlaCaPabGSiDg4MPPfTYYw9ks1mpP6/oz7R7z57OJUuX/qxl5syN01AjkyiZqPoLvUDJaNcBMHHm6tUrKWC+YKFQmBgcGhrXE6OfKH+kSdiByo2aWLJ4sRsOhb4KYEmQzxgbH3/h/gcffGwKORjWxEA9BBAhEol0IaDGLqUUUAnkUZRV8Woit/DN3dssC47T093d/exzzz//fMFxPABcW1sbXbl8+dI5c+deGI/HO/RCmDtZRI6Bi8UJzN056oOSlPmB/v7H4onE3q7OzpGOrq542QNSCqV+rWP6Hj9iCsLGDRuaCPg2Ao45ZpY9PT2/feCRR55gpczm9OdN6DGW1p/lXvbudy8i9R0HQmdX1/4pKlixEKV93TrhMH8NwGIKPibcsXh8+0MPP/zrZDJZTiYy+joVq0dHxsbEY5s3HwqFQk+fsWbNqoH+/iG9XRpTLCmkEJdTwAm4UCgMx+Nxn2jlrvv4x1eGQqG7oCphA51DT3f3bx967LEnWUqfxA0djcQBgBWNLmHmqsDWKB0dh6YQ6KPOqTfcdJMF5ouCksRhVZF9TP88MDcAaJiudUwmldr36JYtPxzo709OESayUkr3N7/97R2f+dSnKuvq6q4J9LBtWTH9kFmhoycnvG3l6afIkWAA8SCd/z93iFXFanVFFVYtXgbbsk/JSRGJEgHSkmLGyeL5Q4ex9VAYiVwENlR/VBa+qbHKeQNZOpTKAFuQQoVRBTFIkzmQBBFBCAHPY1TbLsLkgQM+6M6b1YB5s44ucPYefmvnPz4+vn3nrl179KBP'
$j7 &= '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'
$j7 &= 'LpebQuz7p8wjDACrVq60eBpFTPlCobOgLDrekPv6hfb2JlfKTUGvay6X63thx45Hykhc+X1cfBg7wkOV/2CR09v5HT9K84yUrRAiEKF0XTc/MjLS19LSEjvv7LO/FAqFgrU4Y5adHR3//cSTTz4zhcT1lZG4I4Y/WS2ugS2XCoVCj+M4Uwk0H+PYFgVV+zK5XFcmm3WPq/YRvWc643xkdHTHCy+80Kn3N6EJXK9e1yZV3FZUVo6CKDENYYKmzBXvbCI3uHMvL3jXWXuz2RyChFdty8KMhkZEItG3vVrVJ5ukP5cZKHgSO7uG8cyBDCbyNkCAJVQo9f9n7z3D5Diuc+G3qnvC5l3sYpEjQZAEM0ESpChRpEjlSMlB0rVEicISJCXZkv3Y1/fzc2X7yvHKvr7+HBQ/S7aCJZEyRYlZzAEEQSIDu1hsxKaZ2Z2cp7urzveju2d6Z1MNAkFSc/AMNs10V1c49dYJ7yHY8W/EGIgzSGEDOAYCpO1iBXMyWRl3LHTO+DsEyAFGaKkh0eFsgbhYPP7iQ4888oucXUrLBXERRxHnq9wX19WyCRVLpfCzzz77sKy4WVxlE6222sxjgRG/c/vtfmLsKtU7JhKJk5gblCsXORIrg0QppTHQ3/+j4ZERVxm4p7wI5sn20zi/ThnIEWVCdpJHmQR5HmVJjc3NGgHbmFp7S5FIxHvadTe/hYk8ia7likHFqVRqX75YdBVwwhlT97SLu3t6riGi3yTO70ENxduHRkae8WyOsxQ7q/Egkc1mhx557LHnUAkV8M6/nGd+VM8/wlngj2OcX0CKgBZ2TGmWiGS1t1DTtCbO+am6LXyBQOCOG264YfTH9977PWfM5sTH3d3T0w5AmXoml8sNvbJvn7t5Jp11MV11wPHONcYYU6qoQkQik81GHOvyLK5DALCk/DBjTDnBYWx8/LGTY2NpFcA5z5nf5Y0zPbqq/H6N8/WqNZdLpVKYMcbeecstPf5AQC2Jh4gmJyd/+cQzz7xgmmapCsS5B8oF9Z6QkjHOr2Bqt7LSmUzY4YX0lg5bqKoIA3Cd6u5tGMZkqVTyArk57b7z9tubmGIGsAOOc0ePHfPG7Eadfkl4LHHl9hNjBRAVVfc1J2vaGwLzhhYlJdIYbBouFg0TJJYs1eHz+bB65Ur4/X47X9RhFH7tTHJUBnNEwESyiEf6UhhN2PxvukPuSwIgzkAESAZo5JSIJdvNqpFdpcK22HFITwwdOAFCggFo0yywc5i5bAlRPNHf/6OXX331UNHekF0QF0LFPVZWlvfceWcb2ZmTqvpGTkciv0qmUq71qtr1Zi5g8Sgrxyaf7wqmSj4MYGxsbLgKuCzoGrtn585uApTdXMVicWTvvn3HUUkMmKm2QFV95O2q185kMhMeELegO5hr2tVMsSIAERV7+/rimM2JtqCF6Z6eHi6B66FALSOlNFOZzPjWrVuDPl3Pd3V2Bjra21d1dnXdoHO+g3H+XgCrnUB2VkM/9A0MDJz0tLkcM/P5u+5aK4RYoXoxKWVpdHT0AVQSUaLOqTziAXG0wPw7K4ZyKeV7mKK3wTCM2N5XXvl6Kp1OMzs7qjwnfD4fDwaDLW1tbavWrFp1aUdHx3bOuTLjN2NMb29v/7Nrt2/v27tv3ytVm5w7fy5kjCnHxh06cuRBp42um3IGC9CZAADX9fUkxFrFuWyEwuEZzOOC+/yuXbqQ8kbVPSmfz48/+fTTBz3reHoxwLmEE4fm+cM1qoTVpmnOXLdjx+80NzWpWtnF2Ojo/Y8//fTz81jilgRxAMB9vnWQUtV9a4anp6NQJFcnKTkYu4KpJaaJXC4XEkK4157Xg6L7fDuISFeuEpHJHPQcttOoxC4X59N/ba2tOlOM03TGzI2HesNb45SBXHt723QinSxBLl3slnMNy9o74PPpYK+x64G8qpsxRDJFPNQ7jYPhIkoObQhnNleb5DYe42RXoZBk05AwcEDalCUox8LZLlYJUQ6wYI5r'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '6JJx1k3IeYbqdrQ6Y7zBGeOF1j05Fp4pACPOtRYil3XX3hrnum5fsUXmv+Fc86Snv6rXAGeMNRBRh65pm9/ylrdcv2L58kt9Pl87gA4iyltC5KdnZib3Hzw4krFLLrp94ZaoigGIMsYSRJRzxm+lM6YrlxhTyxnTUUcHld2Wd/X06Aw4BMa2KaA4OT4x8ZP+/v6hdevXL29ubm5utIngdQDtIMqCMdM0zWI2l0uOj41NHevrC3v0rKsPc874ujxx3hJcb7qYuLMG5ABgxZXbvi0hd7oXbQwE8dH3fgBf3nk31q5aPc8dad7mCEk4MJ3Ff/VHMZwueqxo0nGtMocstwLipLRBnBBO3Jz7eyHt2DppAzc44I4kYFkEiyRMUQFzlpSwJEFICRKWDd6k/ZVLC5owwMwSWD4NVkxix/omvO/qTVjT2QzOvdQnTg0IjSOHSfTlfgS9LQ9/gNtVKBgDpLSrRxCQTLXg+RcvQP9QB4oFCWkWdwdbtHdM/udflM7AGPucTXyFoxQDSyiSnKOwp3Fm4gqYoxQbHAXZhUociLccEPMoX8ujdGKO0ow7C9jnfH4l7HR93xLPk3GeZ0ZhE9GczWOlo3QXA4nSaZ9bkzSrqDTm26Q6YJec8WN2rUvpcUu5p8680xcRR3EtRdHhnnJ9zj3aPK9mZ6Px67ruE0Iw8qaBV8CC9/5Fpw1ZjwLNYf4YROY8kzteS4Egq2q8ijj3cS2a02/dzqsRNVYtWWo784yxl4i76MzXYpWF8lStC9wz77zrsDkQCARLpZJr6aoGQClnvsWd74vO83c6OqVtCe+O6YDzsHMNVQ4v7tynwQFZHajUJW1gjAX8fr/PMAzvnPWuF8OzXrLO5p7yWDO9/eiue+8Y80XGq+DMTzfRxFpk7fmr9NVSMYaWa/10AF1+Hr3CPH3T7uiqLgAtfr+/wTRNjYh41dwqeg5eSU9fFJ33+Z0xXen0t+9UxvQLd9zRbWlamClwDkkpSwcOH/763r17B1AJFSEA3O/3a6ZpMk+yolcXueuk4LFWZ5yvrqfiTUUxclZdq7NWXYB9WRZxERhuAICCUcIrBw/g8PFj6O5aDr/P51KxOVORlbNHGdnEvURA1rTQO53DRKYIEk5WKQOktCk6yLW2lUGcE+MmXfer8xknsxVVXHLleDiQXbh+dhRduc4p8y5bIrcEAxg4mpub8d5r1+MDOzZjw/IW6E6ZHXJLeRE5hL8mDs7sB4cJpnFI4k5jATANRIRMtgmvHjgfx4c7YBQlpDBDUtBnzgCIg2fiu4AjA5d0b/73kseNcqZIE90TnKuQXO4rF0T4HKXEqkBcyaN8vLFArqILO9fhi5ycpefEplKShTwWr7znVM4W6Cs3zkTFylBtpXA3gJxzv2ZHMfuqgJy3P0oe5ZWDWlYxeTYt4dmcm5wNqwFA0LIsn/O8vOpzYp77Fz0/u6feefnB5hkvrYbxej0EJ7ttijvP7VtgTpzKuvD2sxfMed2RwgNQ6DSfw0ClekDOeabmUqnUUGWBsaosHW75L8PTFjcmKaqwBt11XMvm6j5vrqq9TQCaiChQKpX8VXNWVIG4guflWjLnq7VMVWO81Lp3121+icOb+17Xshz3zH+2iA42q/p7oTVdqFrTLYZhNDpjqVdZrQpVY1ny9AVzvnfbudSYCo8rc9aYWpzfzNSZgK3x8fEZ5zkTnsM6NwxDr9IV/z/e9VGaZ3yr6bJ+LUDcGQdyoT3Hspuvu+oLOaPwEBGtJiJMREJ47JmncNH5W7Fx7QawKqscQyVzlYFBEGEwVkBvNIe8IcvTRtpm2HKWKnkscTaIc+LaXBesqFjpyjFyLoiDDeRsbeQCOqqAPw95MHNfTi1UBkJncwAfu/p8fPzG87FmWTM07n2aSrwdA8NMfgjZ+DiYDxCwLYkQrFznNVcM4vChjeg7vgxGkSAsM8c0+YXEL/5m4AwOjbvQ3YW6mBLxLpgzGVfgVTwuUHSVje6xcEgPeBHz'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= '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'
$j7 &= 'uWsD4Ls97ufJM/we/3ZNhzgb5CzLsizrFyPeI2CsPSHglzkgvFuI4/+LIPdurVIY7141e68wxu8TLN8vtNHP+bgPRPsRG+Qsy7Is6x8mJLAABH2gAoJlWZYBaCD/YP4PzJPXQCt2VHyUAAAASQBFTkSuQmCC'
$j7 = _1s3($j7)
Local $j8 = DllStructCreate('byte[' & BinaryLen($j7) & ']')
DllStructSetData($j8, 1, $j7)
Local $j9
_1s4($j8, $j9, 45195)
$j8 = 0
Local Const $j4 = Binary(DllStructGetData($j9, 1))
If $j1 Then
Local Const $j5 = FileOpen($j2 & "\LogoAppPrinterBackup.png", 18)
If @error Then Return SetError(1, 0, 0)
FileWrite($j5, $j4)
FileClose($j5)
EndIf
Return $j4
EndFunc
Func _1ry($ja, $jb, $jc, $jd, $je)
Dim $jf, $jg, $jh
$jf = WinGetPos($ja)
$jg = DllCall("gdi32.dll", "long", "CreateRoundRectRgn", "long", $jb, "long", $jc, "long", $jf[2], "long", $jf[3], "long", $jd, "long", $je)
If $jg[0] Then
$jh = DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $ja, "long", $jg[0], "int", 1)
If $jh[0] Then
Return 1
Else
Return 0
EndIf
Else
Return 0
EndIf
EndFunc
Func _1rz()
Local $2x = DllCall("Wtsapi32.dll", "int", "WTSQuerySessionInformationW", "int", 0, "dword", -1, "int", 5, "dword*", 0, "dword*", 0)
If @error Or $2x[0] = 0 Then Return SetError(1, 0, 0)
Local $ji = BinaryToString(DllStructGetData(DllStructCreate("byte[" & $2x[5] & "]", $2x[4]), 1), 2)
DllCall("Wtsapi32.dll", "int", "WTSFreeMemory", "ptr", $2x[4])
Return $ji
EndFunc
Func _1s0()
Local $jj = '\\sjkfs13\pacotes$\Rollout Assistant\Binaries\sqlite3.dll'
$jk = _1ca($jj, True, 1)
If @error Then
MsgBox(16, "SQLite Error", "SQLite3.dll can't be Loaded!" & @CRLF & @CRLF & "Not FOUND in @SystemDir, @WindowsDir, @ScriptDir or @WorkingDir")
Exit -1
EndIf
Global $jl = _1cc($iu)
If @error Then
MsgBox(16, "SQLite Error", "Can't open or create the Database!")
Exit -1
EndIf
EndFunc
Func _1s1()
_1cq($jl)
_1cb()
EndFunc
Func _1s3($jm)
Local $jn = DllCall("Crypt32.dll", "bool", "CryptStringToBinaryA", "str", $jm, "dword", 0, "dword", 1, "ptr", 0, "dword*", 0, "ptr", 0, "ptr", 0)
If @error Or Not $jn[0] Then Return SetError(1, 0, "")
Local $jo = DllStructCreate("byte[" & $jn[5] & "]")
$jn = DllCall("Crypt32.dll", "bool", "CryptStringToBinaryA", "str", $jm, "dword", 0, "dword", 1, "struct*", $jo, "dword*", $jn[5], "ptr", 0, "ptr", 0)
If @error Or Not $jn[0] Then Return SetError(2, 0, "")
Return DllStructGetData($jo, 1)
EndFunc
Func _1s4(ByRef $4p, ByRef $jp, $jq)
$jp = DllStructCreate("byte[" & $jq & "]")
If @error Then Return SetError(1, 0, 0)
Local $1n = DllCall("ntdll.dll", "uint", "RtlDecompressBuffer", "ushort", 0x0002, "struct*", $jp, "ulong", $jq, "struct*", $4p, "ulong", DllStructGetSize($4p), "ulong*", 0)
If @error Then Return SetError(2, 0, 0)
If $1n[0] Then Return SetError(3, $1n[0], 0)
Return $1n[6]
EndFunc
_1rs(True)
_1ru(True)
Global $ix, $go, $gp
Global $jr = False
Global $js = False
Global $jt
Global $ju
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
_14z()
_2f("RolloutAssistant")
$jv = _14v("Printer Backup 2.0", 960, 600, -1, -1)
GUISetFont(10, 400, 0, "Segoe UI")
GUISetBkColor($25)
_1ry($jv, 3, 3, 20, 20)
$9f = _14y(True, False, True, False, False)
$iz = $9f[0]
$j0 = $9f[3]
$jw = _16u(@TempDir & '\LogoAppPrinterBackup.png', '', 30, 5, 235, 60)
_16u(_1rt(True), '', 440, 200, 100, 131)
GUICtrlSetResizing(-1, 0x0002 + 0x0100 + 0x0200 + 0x0020)
$jx = _16u(@TempDir & '\LogoStefanini.png', '', 815, 560, 110, 25)
$jy = GUICtrlCreateListView("    Impressoras instaladas - " & @ComputerName, 33, 60, 380, 406, 0x00800000, 0x00000020 + 0x00000004)
GUICtrlSendMsg(-1, $20, 0, 400)
GUICtrlSendMsg(-1, $20, 1, 400)
GUICtrlSendMsg(-1, $20, 2, 400)
$jz = GUICtrlCreateListView("    Impressoras salvas para este usuário - " & StringUpper($iv), 547, 60, 380, 406, 0x00800000, 0x00000020 + 0x00000004)
GUICtrlSendMsg(-1, $20, 0, 400)
GUICtrlSendMsg(-1, $20, 1, 400)
GUICtrlSendMsg(-1, $20, 2, 400)
$k0 = _159("Salvar Impressoras", 157, 476, 120, 45)
$k1 = _159("Instalar impressoras", 680, 476, 120, 45)
$k2 = GUICreate('', 13, 17, 555, 68, 0x80000000, 0x00000040 + 0x00080000, $jv)
GUISetBkColor(0xABCDEF)
_qs($k2, 0xABCDEF)
$k3 = GUICtrlCreateCheckbox('', 0, 0, 100, 17)
GUISetState(@SW_SHOWNA)
GUICtrlSetResizing(-1, 0x0008 + 0x0040 + 0x0300 + 0x0004)
$k4 = GUICreate('', 13, 17, 41, 68, 0x80000000, 0x00000040 + 0x00080000, $jv)
GUISetBkColor(0xABCDEF)
_qs($k4, 0xABCDEF)
$k5 = GUICtrlCreateCheckbox('', 0, 0, 100, 17)
GUISetState(@SW_SHOWNA)
GUICtrlSetResizing(-1, 0x0008 + 0x0040 + 0x0300 + 0x0004)
GUISetState(@SW_SHOW, $jv)
_1s8()
_1iz($jy, 0, -2)
_1s9()
_1iz($jz, 0, -2)
While 1
$k6 = GUIGetMsg()
Switch $k6
Case $iz
if MsgBox(4 + 0x00040000 + 32, "Printer Backup", "Deseja realmente sair?") = 6 Then
_14x($jv)
Exit
EndIf
Case $j0
GUISetState(@SW_MINIMIZE, $jv)
Case $k0
_1s7()
Case $k1
_1s6()
Case $k3
$jt = "Saved"
_1s5()
Case $k5
$jt = "Installed"
_1s5()
EndSwitch
WEnd
Func _1s5()
If $jt = "Saved" Then
$1p = _1gw($jz)
If $1p > 0 Then
If $jr = False Then
For $w = 0 To $1p
_1jb($jz, $w)
Next
$jr = True
Else
For $w = 0 To $1p
_1jb($jz, $w, False)
Next
$jr = False
EndIf
EndIf
EndIf
If $jt = "Installed" Then
$1p = _1gw($jy)
If $1p > 0 Then
If $js = False Then
For $w = 0 To $1p
_1jb($jy, $w)
Next
$js = True
Else
For $w = 0 To $1p
_1jb($jy, $w, False)
Next
$js = False
EndIf
EndIf
EndIf
EndFunc
Func _1s6()
$k7 = _1gw($jz)
If $k7 <> '' And $k7 > 0 Then
if MsgBox(4 + 0x00040000 + 32, "Printer Backup", "Deseja realmente instalar a(as) impressora(as)?") = 6 Then
Local $k8 = WinGetPos($jv)
Local $k9 = GUICreate("", 461, 235, -1, -1, 0x80880000)
Local $k8 = WinGetPos($k9)
GUISetBkColor($d7)
GUISetFont(10, 400, 0, "Segoe UI")
$ka = GUICtrlCreateLabel("Instalando", 0, 80, $k8[2] - 2, 50, 0x1)
Local $kb = GUICtrlCreateProgress(104, 121, 252, 11, 0x8)
_o7(GUICtrlGetHandle($kb), $24, 1, 30)
GUISetState(@SW_SHOW)
For $w = 0 To $k7
$kc = _1gv($jz, $w)
If $kc = True Then
$kd = _1hh($jz, $w, 0)
GUICtrlSetData($ka, "Instalando" & @CRLF & $kd)
_1n($kd)
$ke = _1r()
For $8o = 1 To $ke[0]
If $ke[$8o] = $kd Then
GUICtrlCreateListViewItem($kd, $jy)
ExitLoop
EndIf
Next
EndIf
Next
Sleep(2000)
GUIDelete($k9)
_1sa($jv, '')
WinActivate($jv)
EndIf
EndIf
EndFunc
Func _1s7()
$k7 = _1gw($jy)
If $k7 <> '' And $k7 > 0 Then
if MsgBox(4 + 0x00040000 + 32, "Printer Backup", "Deseja realmente salvar a(as) impressora(as)?") = 6 Then
Local $k8 = WinGetPos($jv)
Local $k9 = GUICreate("", 461, 235, -1, -1, 0x80880000)
Local $k8 = WinGetPos($k9)
GUISetBkColor($d7)
GUISetFont(10, 400, 0, "Segoe UI")
$ka = GUICtrlCreateLabel("Salvando", 0, 80, $k8[2] - 2, 50, 0x1)
Local $kb = GUICtrlCreateProgress(104, 121, 252, 11, 0x8)
_o7(GUICtrlGetHandle($kb), $24, 1, 30)
GUISetState(@SW_SHOW)
For $w = 0 To $k7
$kc = _1gv($jy, $w)
If $kc = True Then
$kd = _1hh($jy, $w, 0)
GUICtrlSetData($ka, "Salvando" & @CRLF & $kd)
_1s0()
_1cm(-1, 'Select Printer from Printers Where UserName = "' & StringUpper($iv) & '" AND AnalystName = "' & $iw & '"', $ix, $go, $gp)
_1s1()
$kf = False
For $8o = 1 To UBound($ix) - 1
If $kd = $ix[$8o][0] Then
$kf = True
ExitLoop
EndIf
Next
If $kf = False Then
_1s0()
_1ce(-1, StringFormat("Insert Into Printers VALUES('%s', '%s', '%s')", $kd, StringUpper($iv), $iw))
_1s1()
GUICtrlCreateListViewItem($kd, $jz)
EndIf
EndIf
Next
Sleep(2000)
GUIDelete($k9)
_1sa($jv, '')
WinActivate($jv)
EndIf
EndIf
EndFunc
Func _1s8()
_1fl($jy)
$ke = _1r()
For $w = 1 To $ke[0]
If StringInStr($ke[$w], "\\") Then
GUICtrlCreateListViewItem($ke[$w], $jy)
EndIf
Next
EndFunc
Func _1s9()
_1fl($jz)
_1s0()
_1cm(-1, 'Select Printer from Printers Where UserName = "' & StringUpper($iv) & '"', $ix, $go, $gp)
_1s1()
For $w = 1 To UBound($ix) - 1
GUICtrlCreateListViewItem($ix[$w][0], $jz)
Next
EndFunc
Func _1sa($kg, $kh = Default)
If $kh <> Default Then
GUIDelete($ju)
GUISetState(@SW_ENABLE, $kg)
Return 0
EndIf
Local $k8 = WinGetPos($kg)
GUISetState(@SW_DISABLE, $kg)
$ju = GUICreate('', $k8[2] - 15, $k8[3] - 8, -5, -35, 0x80000000, 0x00000040, $kg)
GUISetBkColor(0x000000)
GUISetState(@SW_SHOW, $ju)
GUISetState(@SW_DISABLE, $ju)
EndFunc
Func _1sb()
If UBound($cmdline) - 1 > 0 Then
Switch $cmdline[1]
Case "/execPrinterBackup"
Return 0
Case Else
MsgBox(64 + 0x00040000, "Rollout Assistant", "Esta aplicação não pode ser executada separadamente!")
Exit
EndSwitch
Else
MsgBox(64 + 0x00040000, "Rollout Assistant", "Esta aplicação não pode ser executada separadamente!")
Exit
EndIf
EndFunc
