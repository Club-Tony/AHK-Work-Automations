#Requires AutoHotkey v1
#NoEnv ; Prevents Unnecessary Environment Variable lookup
#Warn ; Warn All (All Warnings Enabled)
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input ; Send works as SendInput
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
CoordMode, Mouse, Window

intraWinTitle := "Intra: Shipping Request Form ahk_exe firefox.exe"

; Launch: Smartsheets ; Keybind: Ctrl+Alt+L
^!l:: 
    Run, C:\Users\daveyuan\Documents\AutoHotkey\Daily_Audit.ahk ; Keybind: Ctrl+Alt+D
    Sleep 150
    Run, C:\Users\daveyuan\Documents\AutoHotkey\Daily_Smartsheet.ahk ; Keybind: Ctrl+Alt+S
    Sleep 150
    Tooltip, Daily Audit: Ctrl+Alt+D`nDaily Smartsheet: Ctrl+Alt+S
    Sleep 5000
    Tooltip
Return

; Launch: Super Saiyan Intra ; Keybind: Ctrl+Alt+I
^!i:: 
    Run, C:\Users\daveyuan\Documents\AutoHotkey\IT_Requested_IOs-Faster_Assigning.ahk ; Keybind: Alt+S
    Sleep 150
    Run, C:\Users\daveyuan\Documents\AutoHotkey\Parent_Ticket_Creation-(BYOD).ahk ; Keybind: Alt+P
    Sleep 150
    Run, C:\Users\daveyuan\Documents\AutoHotkey\Parent_Ticket_Creation-(GENERAL).ahk ; Keybind: Ctrl+Alt+P
    Sleep 150
    Run, C:\Users\daveyuan\Documents\AutoHotkey\IT_Asset_Move.ahk ; Keybind: Alt+T
    Sleep 150
    Tooltip, SSJ-Intra Keybinds`nFaster Assigning: Alt+S`nBYOD Parent Ticket: Alt+P`nParent Ticket (General): Ctrl+Alt+P`nIT Asset Move: Alt+T`nCTRL+ALT+I: Relaunch Scripts + Tooltip
    Sleep 10000
    Tooltip
Return

; Launch: Intra SSJ Search ; Keybind: Ctrl+Alt+F
^!f::
    Run, C:\Users\daveyuan\Documents\AutoHotkey\Intra_Desktop_Search_Shortcuts.ahk
    Sleep 150
    Tooltip, Intra SSJ Search`nCtrl+Alt+F: Load and reload search script`nAlt+D: Docksided items`nCtrl+Alt+D: Delivered items`nAlt+O: On-shelf items`nAlt+A: Arrived at BSC`nAlt+P: Pickup from BSC
    Sleep 7000
    Tooltip
Return

; Launch: DSRF-to-UPS WorldShip ; Keybind: Ctrl+Alt+C
^!c::
    ; Ensure Intra Window is focused and Mouse cursor is positioned
    FocusIntraWindow()
    EnsureIntraWindow()
    Sleep 50
    MouseMove, 410, 581 ; Move to Cost Center field for tooltip visibility

    ; Launch DSRF-to-UPS_WorldShip.ahk after declaring focus window variables
    Run, C:\Users\daveyuan\Documents\AutoHotkey\DSRF-to-UPS_WorldShip.ahk
    Sleep 150
    selectionTip := "Ctrl+Alt+B: Business Form`nCtrl+Alt+P: Personal Form`nCTRL+ALT+C: Launches DSRF-To-UPS_WorlShip.ahk"
    ToolTip, %selectionTip%
    SetTimer, ClearWorldShipTip, -10000
Return

~^!b::ToolTip
~^!p::ToolTip

ClearWorldShipTip:
    ToolTip
Return

FocusIntraWindow()
{
    global intraWinTitle
    WinActivate, %intraWinTitle%
    WinWaitActive, %intraWinTitle%,, 1
}

EnsureIntraWindow()
{
    global intraWinTitle
    ; Match the working dimensions used in Intra_Buttons. Adjust here if the target size changes.
    WinMove, %intraWinTitle%,, 1917, 0, 1530, 1399
    Sleep 150
}

^Esc::Reload
