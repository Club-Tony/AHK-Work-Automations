#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; 945, 850 = coordinates for alias field
; 200, 245 = coordinates for Scan field
; 930, 830 = coordinates for alias field filter dropdown
; 925, 850 = coordinates for alias field filter dropdown: 'starts with' selection
; Window Position: x: -7 y: 0 w: 1322 h: 1339

; Script Function: if window active, alt+s selects 'start with' delimiter, then alias field, at which point you type, upon hitting
; -enter, triggers hit down arrowkey, then clicks Scan field. Upon scan, sends F5 for submission and repeats alt+s function again
; alt+s is hotkey for script 
; Esc = End alt+s loop

Esc::ExitApp
#IfWinActive, Intra Desktop Client - Assign Recip
SetKeyDelay 50
global cancelLoop := false

!s::
    cancelLoop := false
    Sleep 250
    MouseMove, 930, 830
    Sleep 500
    MouseClick, left
    Sleep 250
    MouseMove, 925, 850
    Sleep 250
    MouseClick, left
Return

; Cancel/stop key        
^Esc::
    cancelLoop := true
Return

Enter::
    SendInput, {enter}
    Sleep 250
    Send, {Down}
    Sleep 250
    MouseMove 200, 245
    Sleep 250
    MouseClick, left, , , 2

    ; insert text detection here, where upon text detected under mouse, wait for it to finish and then send so it mimicks scanner carriage return
    MouseGetPos, , , winID, ctrlUnderMouse
    ControlGetText, oldText, %ctrlUnderMouse%, ahk_id %winID%

    Loop {
        if (cancelLoop)
        {
            Break
        }
        
        Sleep 100
        ControlGetText, newText, %ctrlUnderMouse%, ahk_id %winID%
        if (newText != oldText && newText != "") {
            Sleep 100
            ControlSend, %ctrlUnderMouse%, {Enter}, ahk_id %winID%
            Sleep 100
            Send, {F5}
            Sleep 2000
            Gosub, !s
            Break
        }
    }
Return

#IfWinActive, Intra Desktop Client - Assign Recip ; Cleanly closes out Active window state, freeing alt+s for global use