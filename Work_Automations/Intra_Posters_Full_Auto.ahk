#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2  ; Allow partial matches on Intra tab titles.
CoordMode, Mouse, Window  ; Work with positions relative to the active Intra window.
SetDefaultMouseSpeed, 0

posterWinTitle := "Intra: Interoffice Request"
posterWinExes := ["firefox.exe", "chrome.exe", "msedge.exe"]  ; priority order
intraButtonsPath := A_ScriptDir "\Intra_Buttons.ahk"
posterHotkeyRunning := false
posterHotkeyCancelled := false

; Scope: Intra: Interoffice Request (browser) poster automation (priority: Firefox > Chrome > Edge).
^Esc::Reload

#If PosterWindowExists()
^!p::  ; TODO: full poster automation
    posterHotkeyCancelled := false
    posterHotkeyRunning := true
    if (!FocusPosterWindow())
    {
        ShowTimedTooltip("Open Intra - Interoffice Request in Firefox/Chrome/Edge", 3000)
        Gosub, PosterHotkeyCleanup
        return
    }
    ; First action: capture current URL and open duplicates.
    send, ^l
    sleep, 50
    send, ^c
    sleep, 50

    Loop, 15
    {
        send, ^t
        sleep, 150
        send, ^v
        sleep, 50
        send, {Enter}
        sleep, 250
    }
    Sleep 250

    ; Return to the original tab.
    Loop, 15
    {
        send, ^+{Tab}
        sleep, 150
    }

    if (!WinActive(posterWinTitle))
    {
        ShowTimedTooltip("Hotkey break: IO Request window N/A or Unknown", 5000)
        Gosub, PosterHotkeyCleanup
        return
    }

    EnsureIntraButtonsScript()
    if (CheckPosterAbort())
        return

    ; Add poster automation steps here (form fills, clicks, etc.)
    ; Example: CallIntraButtonsHotkey("^Enter")  ; reuse Intra_Buttons hotkeys when desired.

    if (!CheckPosterAbort())
        ShowTimedTooltip("Automation implemented thus far", 3000)
    Gosub, PosterHotkeyCleanup
return
#If

PosterWindowExists()
{
    return GetPosterWindowTitle() != ""
}

FocusPosterWindow()
{
    title := GetPosterWindowTitle()
    if (title = "")
        return false
    WinActivate, %title%
    WinWaitActive, %title%,, 1
    return !ErrorLevel
}

GetPosterWindowTitle()
{
    global posterWinTitle, posterWinExes
    variants := [posterWinTitle]
    for _, exe in posterWinExes
    {
        for _, variant in variants
        {
            candidate := variant " ahk_exe " exe
            if (WinExist(candidate))
                return candidate
        }
    }
    return ""
}

ShowTimedTooltip(msg, duration := 3000)
{
    ToolTip, %msg%
    SetTimer, HideTimedTooltip, -%duration%
}

HideTimedTooltip:
    ToolTip
return

EnsureIntraButtonsScript()
{
    global intraButtonsPath
    DetectHiddenWindows, On
    scriptRunning := WinExist("Intra_Buttons.ahk ahk_class AutoHotkey")
    DetectHiddenWindows, Off
    if (!scriptRunning && FileExist(intraButtonsPath))
        Run, %intraButtonsPath%
}

CallIntraButtonsHotkey(combo)
{
    SendInput, %combo%
    Sleep 100
}

CheckPosterAbort()
{
    global posterHotkeyRunning, posterHotkeyCancelled
    if (posterHotkeyCancelled)
    {
        Gosub, PosterHotkeyCleanup
        return true
    }
    return false
}

PosterHotkeyCleanup:
    posterHotkeyRunning := false
    posterHotkeyCancelled := false
return

#If (posterHotkeyRunning)
Esc::
    posterHotkeyCancelled := true
    ShowTimedTooltip("Poster automation cancelled", 1500)
return
#If
