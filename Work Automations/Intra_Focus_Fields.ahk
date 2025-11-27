#Requires AutoHotkey v1
#NoEnv ; Prevents Unnecessary Environment Variable lookup
#Warn ; Warn All (All Warnings Enabled)
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input ; Send works as SendInput
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2
#If ( WinActive("Intra Desktop Client - Assign Recip")
    || WinActive("Intra Desktop Client - Update") )

^!t::
    Tooltip, SSJ-Intra Keybinds`nIntra - Assign Recip Hotkeys:`nFaster Assigning: Alt+S`nBYOD Parent Ticket: Alt+P`nParent Ticket (General): Ctrl+Alt+P`nIT Asset Move: Alt+T`nClear + Toggle/Print Button Normalize: Alt+R`nSearch Window Quick Resize: Alt+Space`nFocus Scan Field: Alt+E`nFocus Alias Field: Alt+A`nFocus Name Field: Alt+N`nFocus Package Type: Alt+1`nFocus BSC Location: Alt+2`nToggle Item Var + Apply All: Alt+D`nIntra - Update Hotkeys:`nAlt+P: Status Select -> Pickup from BSC`nAlt+D: Status Select -> Delivery`nAlt+C: Clear All`nCTRL+ALT+T: SHOWS TOOLTIP AGAIN
    Hotkey, Esc, CloseIntraTooltip, On
    SetTimer, TooltipTimeout, -10000
Return

CloseIntraTooltip:
    SetTimer, TooltipTimeout, Off
    Tooltip
    Hotkey, Esc, CloseIntraTooltip, Off
Return

TooltipTimeout:
    Gosub, CloseIntraTooltip
Return

!e:: ; focus scan field
    MouseClick, Left, 200, 245, 2 
Return

!a:: ; focus alias field
    Sleep 250
    MouseClick, left, 930, 830, 2
    Sleep 250
    MouseClick, left, 925, 855
Return

!n:: ; focus name field
    Sleep 250
    MouseClick, left, 130, 850, 2
Return

#If WinActive("Intra Desktop Client - Assign Recip")
!1:: ; focus package type field
    Sleep 250
    MouseClick, left, 1100, 365, 2
Return

!2:: ; focus BSC location field
    Sleep 250
    MouseClick, left, 1100, 650, 2
Return

!d:: ; click item var lookup + apply-all buttons
    Sleep 200
    MouseClick, left, 1035, 185
    Sleep 200
    MouseClick, left, 1060, 185
    Sleep 200
    MouseMove, 1100, 365
    Sleep 100
    Loop 50
    {
        MouseClick, WheelUp
    }
Return

#If ( WinActive("Intra Desktop Client - Assign Recip")
    || WinActive("Intra Desktop Client - Update") )
