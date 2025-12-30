#Requires AutoHotkey v1
#NoEnv
#Warn
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

; Built-in Slack “jump” is Ctrl+K (or Cmd+K on macOS). These hotkeys wrap it.

slackExe := "slack.exe"
slackWindow := "ahk_exe " slackExe

^Esc::Reload

; Jump to specific channels (edit the names to your workspace).
!1::JumpToSlackChannel("leona-array")
!2::JumpToSlackChannel("sps-byod")

JumpToSlackChannel(channel)
{
    if (!FocusSlack())
        return
    SendInput, ^k
    Sleep 150
    SendInput, %channel%
    Sleep 150
    Send, {Enter}
}

FocusSlack()
{
    global slackWindow
    if WinExist(slackWindow)
    {
        WinActivate
        WinWaitActive, %slackWindow%,, 1
        return !ErrorLevel
    }
    return false
}
