#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Window Coordinates (Intra Desktop Client - Assign Recip):
; Window Position: x: -7 y: 0 w: 1322 h: 1339
; 200, 245 = Scan field
; 130, 850 = Name field
; 1035, 185 = enable item var lookup button
; 1060, 185 = applying to all item vars button
; 1100, 365 = Package type
; 1100, 650 = BSC Location (Destination)
; 300, 1025 = Select Preset
; 350, 900 = Docksided items preset select 
; 725, 190 = Enable Parent Item #
; 300, 120 = Print Label button
; 190, 205 = Status field

SetTitleMatchMode, 2 ; allows for partial window title matches
Esc::ExitApp
SetKeyDelay 150
#IfWinActive, Intra Desktop Client - Assign Recip

!t::
    ; Attempt parent ticket creation first
    MouseClick, left, 130, 850, 2
    Sleep 250
    Send {space}it-
    Sleep 250
    SendInput, {Enter}
    Sleep 2000
    SendInput, {Down}
    Sleep 250
    MouseClick, left, 1035, 185
    Sleep 250
    MouseClick, left, 1060, 185
    Sleep 250
    MouseClick, left, 1100, 365, 2
    Sleep 250
    Send mid
    Sleep 250
    SendInput, {Enter}
    Sleep 250
    MouseClick, left, 1100, 650, 2
    Sleep 250
    Send SEA124
    Sleep 250
    MouseClick, left, 200, 245, 2
    Sleep 250
    SendInput, ^n
    Sleep 750
    Send, {F5}
    Sleep 3500
    MouseClick, left, 130, 850, 2
    Sleep 250
    Send {space}it-
    Sleep 250
    SendInput, {Enter}
    Sleep 2000
    SendInput, {Down}
    Sleep 250
    MouseClick, left, 1100, 365, 2
    Sleep 250
    Send mid
    Sleep 250
    SendInput, {Enter}
    Sleep 250
    MouseClick, left, 300, 120  ; Click print label button
    Sleep 250
    MouseClick, left, 725, 190, 2  ; Enable Parent Item #
    Sleep 250
    ToolTip, Scan parent label to continue script
    Sleep 4000
    ToolTip
    Sleep 250
    ; Wait for scan/input into the Parent Item field before continuing.
    ControlGetFocus, focusedCtrl, A
    if (focusedCtrl != "")
    {
        ControlGetText, initialText, %focusedCtrl%, A
        changed := false
        Loop 150  ; ~30 seconds total at 200 ms intervals
        {
            Sleep 200
            ControlGetText, newText, %focusedCtrl%, A
            if (newText != initialText && newText != "")
            {
                changed := true
                break
            }
        }
        if (!changed)
            return
    }
    
    ; Resume rest of script
    Sleep 500
    SendInput, ^f
    Sleep 750
    MouseClick, left, 110, 725
    Sleep 300
    MouseClick, left, 185, 575
    Sleep 500
    MouseClick, left, 875, 770 ; Click Search
    Sleep 1500
    WinWait, Search Results:, , 10
    if ErrorLevel
    {
        Return    
    }
    Sleep 200
    SendInput, !{space}
    Sleep 300
    SendInput, s
    Sleep 300
    SendInput, {Right}
    Sleep 300
    SendInput, {Down}
    MouseMove, 2050, 1025
    Sleep 300
    SendInput, {Enter}
    Sleep 300
    MouseMove, 945, 70
Return
#If