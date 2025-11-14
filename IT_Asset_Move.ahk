#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
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
    MouseClick, left, 300, 120
    Sleep 200
    MouseClick, left, 130, 850, 2
    Sleep 300
    Send {space}it-
    Sleep 250
    SendInput, {Enter}
    Sleep 500
    SendInput, {Down}
    Sleep 500
    MouseClick, left, 1035, 185
    Sleep 300
    MouseClick, left, 1060, 185
    Sleep 300
    MouseClick, left, 1100, 365, 2
    Sleep 500
    Send mid
    Sleep 300
    SendInput, {Enter}
    Sleep 200
    MouseClick, left, 1100, 650, 2
    Sleep 200
    Send SEA124
    Sleep 200
    SendInput, ^f
    Sleep 750
    MouseClick, left, 110, 725
    Sleep 300
    SendInput, {Down}
    Sleep 300
    MouseClick, left, 185, 575
    Sleep 300
    SendInput, {Enter}
    Sleep 300
    MouseClick, left, 875, 770 ; Clicks Search, allow time to load, implement 10 sec timeout.
    WinWait, Search Results:, , 8 
    if ErrorLevel
    {
        Return    
    } 
    SendInput, !{space}
    Sleep 100
    SendInput, s
    Sleep 100
    SendInput, {Right}
    Sleep 100
    SendInput, {Down}
    MouseMove, 2050, 1025
    Sleep 100
    SendInput, {Enter}
Return

#IfWinActive, Intra Desktop Client - Update
!t::
    MouseClick, left, 190, 205
    Sleep 200
    Loop, 10
    {
        MouseClick, WheelUp
        Sleep 50
    }
    Sleep 150
    MouseClick, left, 190, 228
Return

#IfWinActive ; Clears context as to remove this condition that can affect other hotkeys