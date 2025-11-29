#Requires AutoHotkey v1
#NoEnv
#Warn
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%

SetTitleMatchMode, 2
TooltipActive := false
TooltipLocked := false
TooltipCooldownMs := 30000 ; 30 seconds

^Esc::Reload

#If ( WinActive("Intra Desktop Client - Assign Recip")
    || WinActive("Intra Desktop Client - Update") )

^!t::
    if (TooltipActive) {
        Gosub, CloseIntraTooltip
        Return
    }
    if (TooltipLocked) {
        Return
    }
    TooltipLocked := true
    SetTimer, UnlockTooltip, % -TooltipCooldownMs
    TooltipActive := true
    Tooltip, SSJ-Intra Keybinds`nIntra - Assign Recip Hotkeys:`nYellow Pouch to SEA22: Alt+I`nClear + Toggle/Print Button Normalize: Alt+R`nPrint Label: Alt+3`nSearch Windows Quick Resize: Alt+Space`nFocus Scan Field: Alt+E`nFocus Alias Field: Alt+A`nFocus Name Field: Alt+N`nFocus Package Type: Alt+1`nFocus BSC Location: Alt+2`nToggle Item Var + Apply All: Alt+D`nIntra - Update Hotkeys:`nAlt+P: Status Select -> Pickup from BSC`nAlt+D: Status Select -> Delivery`nAlt+C: Clear All`nAlt+V: Status Select -> Void`nAlt+S: Click Status Field`nCTRL+ALT+T: SHOWS TOOLTIP AGAIN
    Hotkey, Esc, CloseIntraTooltip, On
    SetTimer, TooltipTimeout, -10000
Return

CloseIntraTooltip:
    SetTimer, TooltipTimeout, Off
    SetTimer, UnlockTooltip, Off
    TooltipLocked := false
    Tooltip
    Hotkey, Esc, CloseIntraTooltip, Off
    TooltipActive := false
Return

TooltipTimeout:
    Gosub, CloseIntraTooltip
Return

#If TooltipActive
Esc::Gosub CloseIntraTooltip
~!s::Gosub CloseIntraTooltip
~!p::Gosub CloseIntraTooltip
~^!p::Gosub CloseIntraTooltip
~!i::Gosub CloseIntraTooltip
~!t::Gosub CloseIntraTooltip
~!r::Gosub CloseIntraTooltip
~!Space::Gosub CloseIntraTooltip
~!e::Gosub CloseIntraTooltip
~!a::Gosub CloseIntraTooltip
~!n::Gosub CloseIntraTooltip
~!1::Gosub CloseIntraTooltip
~!2::Gosub CloseIntraTooltip
~!3::Gosub CloseIntraTooltip
~!d::Gosub CloseIntraTooltip
~!c::Gosub CloseIntraTooltip
#If

UnlockTooltip:
    TooltipLocked := false
Return
