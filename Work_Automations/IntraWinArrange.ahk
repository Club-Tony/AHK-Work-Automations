#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2  ; Partial matches for Intra window names.

assignTitle := "Intra Desktop Client - Assign Recip"
updateTitle := "Intra Desktop Client - Update"
pickupTitle := "Intra Desktop Client - Pickup"

; Window coordinates taken from existing Intra scripts/window spy for consistency.
assignPos := {x: -7, y: 0, w: 1322, h: 1399}      ; from latest Assign Recip window spy
updatePos := {x: 1713, y: 0, w: 1734, h: 1399}    ; from latest Update window spy

^Esc::Reload

^!w::  ; Align Assign/Update/Pickup windows
    ArrangeIntraWindows()
return

ArrangeIntraWindows()
{
    global assignTitle, updateTitle, pickupTitle, assignPos, updatePos

    if !(WinExist(assignTitle) && WinExist(updateTitle) && WinExist(pickupTitle))
    {
        ShowTimedTooltip("Make sure 3 client instances open for Assign Recip, Update, and Pickup before using this hotkey", 3000)
        return
    }

    ; 1) Maximize Pickup.
    WinActivate, %pickupTitle%
    WinWaitActive, %pickupTitle%,, 1
    WinMaximize, %pickupTitle%
    Sleep 100

    ; 2) Put Update on the right (window spy coordinates).
    WinActivate, %updateTitle%
    WinWaitActive, %updateTitle%,, 1
    WinRestore, %updateTitle%
    Sleep 75
    WinMove, %updateTitle%,, % updatePos.x, % updatePos.y, % updatePos.w, % updatePos.h
    Sleep 100

    ; 3) Put Assign Recip on the left (same sizing used by prior scripts).
    WinActivate, %assignTitle%
    WinWaitActive, %assignTitle%,, 1
    WinRestore, %assignTitle%
    Sleep 75
    WinMove, %assignTitle%,, % assignPos.x, % assignPos.y, % assignPos.w, % assignPos.h

    ; 4) Confirm completion.
    ShowTimedTooltip("Windows aligned.", 3000)
}

ShowTimedTooltip(msg, duration := 3000)
{
    ToolTip, %msg%
    Sleep %duration%
    ToolTip
}
