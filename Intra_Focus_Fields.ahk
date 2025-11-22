#Requires AutoHotkey v1
#NoEnv ; Prevents Unnecessary Environment Variable lookup
#Warn ; Warn All (All Warnings Enabled)
SendMode Input ; Send works as SendInput
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2
#If ( WinActive("Intra Desktop Client - Assign Recip")
    || WinActive("Intra Desktop Client - Update") )

^!t::
    Tooltip, SSJ-Intra Keybinds`nFaster Assigning: Alt+S`nBYOD Parent Ticket: Alt+P`nParent Ticket (General): Ctrl+Alt+P`nIT Asset Move: Alt+T`nClear + Toggle/Print Button Normalize: Alt+R`nSearch Window Quick Resize: Alt+Space`nFocus Scan Field: Alt+E`nFocus Alias Field: Alt+A`nCTRL+ALT+T: SHOWS TOOLTIP AGAIN
    Sleep 10000
    Tooltip
Return

!e::
    MouseClick, Left, 200, 245, 2
Return

!a::
    Sleep 250
    MouseClick, left, 930, 830, 2
    Sleep 250
    MouseClick, left, 925, 855
Return

#If