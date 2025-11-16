#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2  ; Allow partial matches on Firefox window titles.
CoordMode, Mouse, Window  ; Work with positions relative to the active Intra window.
SetDefaultMouseSpeed, 0

; Window Coordinates (Intra Interoffice Request - Mozilla Firefox):
; Active Window Position: x: 1721 y: 0 w: 1718 h: 1391
; Envelope button (green icon): x: 820 y: 240
; Submit button: x: 1470 y: 1066

EnvelopeBtnXR := 0.477  ; Relative to window width (820 / 1718)
EnvelopeBtnYR := 0.172  ; Relative to window height (240 / 1391)
SubmitBtnXR := 0.856    ; Relative to window width (1470 / 1718)
SubmitBtnYR := 0.767    ; Relative to window height (1066 / 1391)

#IfWinActive, Intra Interoffice Request
^Enter::
    ClickTarget("Bottom", SubmitBtnXR, SubmitBtnYR)
return

!s::
    ClickTarget("Top", EnvelopeBtnXR, EnvelopeBtnYR)
return

!p::
    ClickTarget("Top", EnvelopeBtnXR, EnvelopeBtnYR)
    Sleep 300
    SendInput, {Down}
    Sleep 150
    SendInput, {Enter}
    Sleep 200
    SendInput, {Tab}
    Sleep 150
    SendInput, {Enter}
    Sleep 200
    SendInput, {Tab 7}
return
#IfWinActive

ClickTarget(scrollPos, xRatio, yRatio)
{
    if (scrollPos = "Top")
        SendInput, ^{Home}
    else if (scrollPos = "Bottom")
        SendInput, ^{End}

    Sleep 200
    WinGetPos,,, winW, winH, A
    targetX := Floor(winW * xRatio)
    targetY := Floor(winH * yRatio)
    MouseClick, left, %targetX%, %targetY%
}
