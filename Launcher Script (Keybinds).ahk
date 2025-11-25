#Requires AutoHotkey v1
#NoEnv ; Prevents Unnecessary Environment Variable lookup
#Warn ; Warn All (All Warnings Enabled)
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input ; Send works as SendInput
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

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
    Tooltip, SSJ-Intra Keybinds`nFaster Assigning: Alt+S`nBYOD Parent Ticket: Alt+P`nParent Ticket (General): Ctrl+Alt+P`nIT Asset Move: Alt+T`nClear + Toggle/Print Button Normalize: Alt+R`nSearch Window Quick Resize: Alt+Space`nFocus Scan Field: Alt+E`nFocus Alias Field: Alt+A`nCTRL+ALT+T: SHOWS TOOLTIP AGAIN
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

^Esc::Reload
