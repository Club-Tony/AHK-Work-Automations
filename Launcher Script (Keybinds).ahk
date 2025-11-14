#Requires AutoHotkey v2.0
; Launch: Smartsheets ; Keybind: Ctrl+Alt+L
^!l:: {
    Run "C:\Users\daveyuan\Documents\AutoHotkey\Daily_Audit.ahk"
    Sleep 150
    Run "C:\Users\daveyuan\Documents\AutoHotkey\Daily_Smartsheet.ahk"
    Sleep 150
    Tooltip("Daily Audit: Ctrl+Alt+D`nDaily Smartsheet: Ctrl+Alt+S")
    Sleep 10000
    Tooltip
}

; Launch: Super Saiyan Intra ; Keybind: Ctrl+Alt+I
^!i:: {
    Run "C:\Users\daveyuan\Documents\AutoHotkey\IT_Requested_IOs-Faster_Assigning.ahk" ; Keybind: Alt+S
    Sleep 150
    Run "C:\Users\daveyuan\Documents\AutoHotkey\Parent_Ticket_Creation-(BYOD).ahk" ; Keybind: Alt+P
    Sleep 150
    Run "C:\Users\daveyuan\Documents\AutoHotkey\Parent_Ticket_Creation-(GENERAL).ahk" ; Keybind: Ctrl+Alt+P
    Sleep 150
    Run "C:\Users\daveyuan\Documents\AutoHotkey\IT_Asset_Move.ahk" ; Keybind: Alt+T
    Sleep 150
    Tooltip("SSJ-Intra Keybinds`nFaster Assigning: Alt+S`nBYOD Parent Ticket: Alt+P`nParent Ticket (General): Ctrl+Alt+P`nIT Asset Move: Alt+T`nClear + Toggle/Print Button Normalize: Alt+R")
    Sleep 10000
    Tooltip
}