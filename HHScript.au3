#include <array.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$HHScriptConfig = GUICreate("HHScript", 265, 357)


$ApplicationList = GUICtrlCreateList("", 8, 48, 249, 227, BitOR($GUI_SS_DEFAULT_LIST, $LBS_MULTIPLESEL))    ;==> Create box for list of Running Apps
GUISetState()

$lbl_HHScript = GUICtrlCreateLabel("HHScript", 88, 16, 93, 23)
GUICtrlSetFont(-1, 12, 800, 0, "Times New Roman")   ;==> Setting title of program

$Btn_Start = GUICtrlCreateButton("Start", 8, 320, 75, 25)
$btn_Stop = GUICtrlCreateButton("Stop", 96, 320, 75, 25)
$btn_close = GUICtrlCreateButton("Close", 184, 320, 75, 25)
$lbl_freq = GUICtrlCreateLabel("Cycle Time (secs)", 56, 288, 87, 17)
$txt_freq = GUICtrlCreateInput("30", 152, 286, 33, 21)

PopulateList()

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $btn_close 
            Exit
        Case $Btn_Start
            $aSelections = _GUICtrlListBox_GetSelItemsText($ApplicationList)
            Start()
        Case $btn_Stop
            


    EndSwitch
WEnd


Func PopulateList()
    $WinArray = WinList()
    For $i = 1 To $WinArray[0][0]
        If _isVisible($WinArray[$i][1]) And $WinArray[$i][0] <> "" Then
            GUICtrlSetData($ApplicationList, $WinArray[$i][0])
        EndIf
    Next
EndFunc   ;==>PopulateList

Func _isVisible($hWin)
    $state = WinGetState($hWin)
    If BitAND($state, 2) Then
        Return True
    Else
        Return False
    EndIf
EndFunc   ;==>_isVisible



Func Start()

    $a = $aSelections[0]
    $freq = GUICtrlRead($txt_freq) * 1000

    While 1

        WinActivate($aSelections[1], "")
        Sleep($freq)
        WinActivate($aSelections[2], "")
        Sleep($freq)
    WEnd


EndFunc   ;==>Start