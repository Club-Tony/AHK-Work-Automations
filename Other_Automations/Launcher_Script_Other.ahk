#Requires AutoHotkey v1
#NoEnv ; Prevents Unnecessary Environment Variable lookup
#Warn ; Warn All (All Warnings Enabled)
#SingleInstance, Force ; auto-reloads script when making changes
SendMode Input
SetWorkingDir, %A_ScriptDir%

; ; Keybind: Ctrl+Alt+R Opens RS-related scripts
^!r:: 
    Run, C:\Users\Davey\Documents\AutoHotkey\Focus_RS_Window.ahk ; Keybind: Alt+Z
    Sleep 150
    Tooltip, RS Window Focus: Alt+Z
    Sleep 5000
    Tooltip
Return

~!t::
    ToolTip, Alt+S: Toggle / for left-click`nCtrl+Alt+R: Run Focus RS Window Script`nCtrl+Shift+Alt+C: Coord Helper`nAlt+T: Trigger this tooltip again, 50, 50
    Sleep 5000
    ToolTip
Return

^+!c::
    Run, "C:\Users\Davey\Documents\GitHub\Repositories\AHK-Automations\Other_Automations\Coordinate Capture Helper\Coord_Capture.ahk"
    ToolTip, Coord Helper: Click to capture
    SetTimer, HideCoordTip, -4000
Return

^+!o::
    ToggleCoordTxt()
Return

HideCoordTip:
    ToolTip
Return

ToggleCoordTxt()
{
    capturePath := "C:\Users\Davey\Documents\GitHub\Repositories\AHK-Automations\Other_Automations\Coordinate Capture Helper\coord.txt"
    captureTitle := "coord.txt - Notepad"
    DetectHiddenWindows, On
    hwnd := WinExist(captureTitle)
    DetectHiddenWindows, Off
    if (hwnd)
    {
        if (WinActive("ahk_id " hwnd))
        {
            SendInput, ^w  ; Close the active coord.txt tab
            Sleep 150
        }
        else
        {
            WinActivate, ahk_id %hwnd%
            WinWaitActive, ahk_id %hwnd%,, 1
        }
        return
    }
    Run, notepad.exe "%capturePath%"
    WinWaitActive, %captureTitle%,, 2
}
