#Requires AutoHotkey v1
#NoEnv
#SingleInstance, Force
#InstallMouseHook
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
SetBatchLines, -1
#MaxThreadsPerHotkey 1
SetTitleMatchMode, 2

CoordMode, Mouse, Screen

fields := ["1.","2.","3.","4.","5.","6.","7.","8.","9.","10."]
captureFile := A_ScriptDir "\coord.txt"
captureHeader := "Capture started " A_Now
entries := []
idx := 1
escConfirm := false

InitializeCapture()

; overlay with live coords
Gui, -Caption +AlwaysOnTop +ToolWindow +LastFound
Gui, Font, s32 q3, Arial
Gui, Add, Text, vCoordText c00FF00, XXXXX YYYYY
Gui, Color, Black
WinSet, TransColor, Black 150
SetTimer, Update, 50
Gui, Show, x0 y0 NA

return

^+!c::Reload
Esc::
    WriteCapture()
    if (!escConfirm)
    {
        escConfirm := true
        ToolTip, Done. Saved to coord.txt (Shortcut: Ctrl+Shift+Alt+O)
        SetTimer, ClearTip, -3000
        return
    }
    ExitApp

~LButton::
    if (idx > fields.Length())
        return
    CloseCaptureFile(captureFile)
    MouseGetPos, x, y
    entries[idx] := fields[idx] ": {x: " x ", y: " y "}"
    WriteCapture()
    ToolTip, % "Saved " entries[idx] " (" idx " of " fields.Length() ")"
    SetTimer, ClearTip, -800
    idx++
    if (idx > fields.Length())
    {
        Sleep 300
        ToolTip, % "Done. Saved to " captureFile
        SetTimer, ClearTip, -3000
    }
return

ClearTip:
    ToolTip
return

Update() {
    MouseGetPos, mouseX, mouseY
    GuiControl,, CoordText, %mouseX%, %mouseY%
}

InitializeCapture()
{
    global entries, captureFile, captureHeader, fields
    CloseCaptureFile(captureFile)
    if (entries.Length())
        entries.RemoveAt(1, entries.Length())
    Loop % fields.Length()
        entries[A_Index] := fields[A_Index] ": {x: , y: }"
    WriteCapture()
}

WriteCapture()
{
    global entries, captureFile, captureHeader
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
    if (hwnd && WinActive("ahk_id " hwnd))
    {
        SendInput, ^w
        Sleep 150
    }
}
