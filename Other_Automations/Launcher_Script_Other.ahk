#Requires AutoHotkey v1
#NoEnv ; Prevents Unnecessary Environment Variable lookup
#Warn ; Warn All (All Warnings Enabled)
#SingleInstance, Force ; Removes script already open warning when reloading scripts
SendMode Input
SetWorkingDir, %A_ScriptDir%

^Esc::Reload

; ; Keybind: Ctrl+Alt+R Opens RS-related scripts
^!r:: 
    Run, C:\Users\Davey\Documents\AutoHotkey\Focus_RS_Window.ahk ; Keybind: Alt+Z
    Sleep 150
    Tooltip, RS Window Focus: Alt+Z
    Sleep 5000
    Tooltip
Return

^+!c::
    Run, "C:\Users\Davey\Documents\GitHub\Repositories\AHK-Automations\Other_Automations\Coordinate Capture Helper\Coord_Capture.ahk"
    ToolTip, Coord Helper: Click to capture
    SetTimer, HideCoordTip, -4000
Return

^+!o::
    Run, "C:\Users\Davey\Documents\GitHub\Repositories\AHK-Automations\Other_Automations\Coordinate Capture Helper\coord.txt"
Return

HideCoordTip:
    ToolTip
Return
