#Requires AutoHotkey v1
#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2  ; Allow partial matches for coord.txt window title

; Simple helper to capture window-relative mouse coordinates for any active window.
; Usage: left-click each target in order; captures 10 clicks (labeled 1..10). Press Esc to quit.

CoordMode, Mouse, Window

fields := ["1.","2.","3.","4.","5.","6.","7.","8.","9.","10."]
captureFile := A_ScriptDir "\coord.txt"
captureHeader := "Capture started " A_Now
entries := []
idx := 1

InitializeCapture(entries, captureFile, captureHeader, fields)

^+!o::
    ToggleCaptureFile(captureFile)
return

~LButton::
    if (idx > fields.Length())
        return
    CloseCaptureFile(captureFile)
    MouseGetPos, x, y
    entries[idx] := fields[idx] ": {x: " x ", y: " y "}"
    WriteCapture(entries, captureFile, captureHeader)
    ToolTip, % "Saved " entries[idx]
    SetTimer, ClearTip, -1000
    idx++
    if (idx > fields.Length())
    {
        Sleep 1000
        ToolTip, % "Done. Saved to " captureFile "`nCtrl+Shift+Alt+O - View the coords.txt"
        SetTimer, ClearTip, -2000
    }
return

ClearTip:
    ToolTip
return

Esc::
    WriteCapture(entries, captureFile, captureHeader)
    Sleep 1000
    ToolTip, % "Done. Saved to " captureFile "`nCtrl+Shift+Alt+O - View the coords.txt"
    Sleep 2000
    ToolTip
    ExitApp

InitializeCapture(entries, captureFile, captureHeader, fields)
{
    CloseCaptureFile(captureFile)
    if (entries.Length())
        entries.RemoveAt(1, entries.Length())  ; Clear any previous values when script reloads.
    Loop % fields.Length()
        entries[A_Index] := fields[A_Index] ": {x: , y: }"
    WriteCapture(entries, captureFile, captureHeader)
}

WriteCapture(entries, captureFile, captureHeader)
{
    FileDelete, %captureFile%
    FileAppend, % captureHeader "`n`n", %captureFile%
    Loop % entries.Length()
        FileAppend, % entries[A_Index] "`n", %captureFile%
}

CloseCaptureFile(captureFile)
{
    SplitPath, captureFile, fileName
    captureTitle := fileName " - Notepad"
    DetectHiddenWindows, On
    hwnd := WinExist(captureTitle)
    DetectHiddenWindows, Off
    ; Only close if coord.txt tab is already the active Notepad window.
    if (hwnd && WinActive("ahk_id " hwnd))
    {
        SendInput, ^w  ; Close the active tab
        Sleep 150
    }
}

ToggleCaptureFile(captureFile)
{
    SplitPath, captureFile, fileName
    captureTitle := fileName " - Notepad"
    DetectHiddenWindows, On
    hwnd := WinExist(captureTitle)
    DetectHiddenWindows, Off
    if (hwnd)
    {
        if (WinActive("ahk_id " hwnd))
        {
            SendInput, ^w  ; Close coord.txt tab when it's the active Notepad window
            Sleep 150
        }
        else
        {
            WinActivate, ahk_id %hwnd%
            WinWaitActive, ahk_id %hwnd%,, 1
        }
        return
    }
    Run, notepad.exe "%captureFile%"
    WinWaitActive, %captureTitle%,, 2
}
