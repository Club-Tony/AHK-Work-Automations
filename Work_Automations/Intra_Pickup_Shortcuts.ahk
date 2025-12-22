#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2  ; Allow partial matches for Intra window names.
; Screen coordinates (Pickup):
SigPrintName := {x: 3250, y: 267}
ClearBtn     := {x: 513,  y: 244}
ScanField    := {x: 378,  y: 1356}

^Esc::Reload

#If WinActive("Intra Desktop Client - Pickup")
!1::  ; focus SigPrintName field
    MouseClick, left, % SigPrintName.x, % SigPrintName.y, 2
return

!e::  ; focus scan field
    MouseClick, left, % ScanField.x, % ScanField.y, 2
    Sleep 250
    MouseMove, % ScanField.x, % ScanField.y
return
#If
