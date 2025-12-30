#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2  ; Allow partial matches on Intra tab titles.
CoordMode, Mouse, Window  ; Work with positions relative to the active Intra window.
SetDefaultMouseSpeed, 0
SetKeyDelay, 50

posterWinTitle := "Intra: Interoffice Request"
posterWinExes := ["firefox.exe", "chrome.exe", "msedge.exe"]  ; priority order
exportedReportTitle := "ExportedReport.pdf"
intraButtonsPath := A_ScriptDir "\Intra_Buttons.ahk"
posterHotkeyRunning := false
posterHotkeyCancelled := false
posterMsgId := 0x5555
posterActionAltE := 1
posterActionAltL := 2
posterActionAltP := 3
posterActionAlt2 := 4
posterActionAltN := 5
posterActionCtrlAltN := 6
posterActionCtrlAltEnter := 7
posterActionCtrlW := 8

; Scope: Intra: Interoffice Request (browser) poster automation (priority: Firefox > Chrome > Edge).
^Esc::Reload

^!p::  ; TODO: full poster automation
    posterHotkeyCancelled := false
    posterHotkeyRunning := true
    startTick := A_TickCount
    if (!FocusPosterWindow())
    {
        ShowTimedTooltip("Open Intra: Interoffice Request in Firefox/Chrome/Edge", 3000)
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
        sleep, 100
        send, {Enter}
        sleep, 150
    }
    Sleep 500

    ; Return to the original tab.
    Loop, 15
    {
        send, ^+{Tab}
        sleep, 50
        if (!WinActive(GetPosterWindowTitle()))
        {
            send, ^l
            sleep, 100
            send, ^v
            sleep, 100
            send, {Enter}
            sleep, 200
        }
    }

    Sleep 1000
    
    curTitle := GetPosterWindowTitle()
    if (curTitle = "" || !WinActive(curTitle))
    {
        ShowTimedTooltip("Hotkey break: IO Request window N/A or Unknown", 5000)
        Gosub, PosterHotkeyCleanup
        return
    }

    EnsureIntraButtonsScript()

    ; Add further poster automation steps here (form fills, clicks, etc.)
    
    ; Mid-Size Boxes
    Loop, 3
    {
        CallIntraButtonsHotkey(posterActionAltP)
        Sleep 2000
        CallIntraButtonsHotkey(posterActionAlt2)
        Sleep 500
        Send mid
        Sleep 150
        Send, {Enter}
        Sleep 100
        Send ^{Tab}
        Sleep 100
    }

    ; Envelopes
    Loop, 13
    {
        CallIntraButtonsHotkey(posterActionAltP)
        Sleep 2000
        Send ^{Tab}
        Sleep 100
    }

    ; Name Fields
    names := [107,83,33,129,129,129,99,99,132,125,114,111,109,74,93,69]
    Loop % names.Length()
    {
        CallIntraButtonsHotkey(posterActionCtrlAltN)
        Sleep 1000
        SendInput, % names[A_Index] "-r"
        Sleep 3000
        Send {Enter}
        Sleep 50
        CallIntraButtonsHotkey(posterActionCtrlAltEnter)
        WaitForExportedReportAndPrint(10000)
        Sleep 300
        Send ^{Tab}
        Sleep 150
    }
     ; Close relevant tabs/end the script
    CallIntraButtonsHotkey(posterActionCtrlW)
    Sleep 300
    SendInput, c
    ShowHotkeyRuntime(startTick)
return

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
    for _, exe in posterWinExes
    {
        candidate := posterWinTitle " ahk_exe " exe
        if (WinExist(candidate))
            return candidate
    }
    return ""
}

GetExportedReportWindow()
{
    global exportedReportTitle, posterWinExes
    for _, exe in posterWinExes
    {
        candidate := exportedReportTitle " ahk_exe " exe
        if (WinExist(candidate))
            return candidate
    }
    return ""
}

WaitForExportedReportAndPrint(timeoutMs := 10000)
{
    deadline := A_TickCount + timeoutMs
    target := ""
    while (A_TickCount < deadline)
    {
        target := GetExportedReportWindow()
        if (target != "")
            break
        Sleep 200
    }
    if (target = "")
        return false

    WinActivate, %target%
    WinWaitActive, %target%,, 2
    SendInput, ^p
    Sleep 400
    SendInput, {Enter}
    Sleep 400
    return true
}

ShowTimedTooltip(msg, duration := 3000)
{
    ToolTip, %msg%
    SetTimer, HideTimedTooltip, -%duration%
}

HideTimedTooltip:
    ToolTip
return

ShowHotkeyRuntime(startTick)
{
    elapsedMs := A_TickCount - startTick
    elapsedSec := Round(elapsedMs / 1000.0, 2)
    ToolTip, Hotkey Runtime: %elapsedSec% seconds
    SetTimer, HideRuntimeTooltip, -4000
}

HideRuntimeTooltip:
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
    global posterMsgId, intraButtonsPath
    DetectHiddenWindows, On
    if (!WinExist("Intra_Buttons.ahk ahk_class AutoHotkey") && FileExist(intraButtonsPath))
        Run, %intraButtonsPath%
    if WinExist("Intra_Buttons.ahk ahk_class AutoHotkey")
        PostMessage, %posterMsgId%, %combo%, 0,, Intra_Buttons.ahk ahk_class AutoHotkey
    DetectHiddenWindows, Off
    Sleep 100
}

PosterHotkeyCleanup:
    posterHotkeyRunning := false
    posterHotkeyCancelled := false
return

#If (posterHotkeyRunning)
Esc::
    ; Treat Esc like a reload/cancel while the poster hotkey is running.
    posterHotkeyCancelled := true
    Reload
return
#If
