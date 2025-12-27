#Requires AutoHotkey v1
#NoEnv
#Warn
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

TooltipActive := false

^Esc::Reload

^!t::
    if (TooltipActive) {
        Gosub, HideTooltips
        Return
    }
    TooltipActive := true
    tooltipText =
    (
Window Switch (Personal)
Win+E       - Focus/Minimize/Cycle Explorer
Win+Alt+E   - Open new Explorer window
Win+F       - Focus/Minimize/Launch Firefox
Ctrl+Alt+T  - Show this tooltip again
    )
    Tooltip, %tooltipText%
    Hotkey, Esc, HideTooltips, On
    SetTimer, HideTooltips, -15000
return

HideTooltips:
    TooltipActive := false
    Hotkey, Esc, HideTooltips, Off
    Tooltip
return

#If (TooltipActive)
~#e::Gosub HideTooltips
~#!e::Gosub HideTooltips
~#f::Gosub HideTooltips
~^!t::Gosub HideTooltips
#If
