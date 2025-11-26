#Requires AutoHotkey v1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force  ; Reload without prompt when Esc is pressed.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2  ; Allow partial matches on Firefox window titles.
CoordMode, Mouse, Window  ; Work with positions relative to the active Intra window.
SetDefaultMouseSpeed, 0

; Window Coordinates (Intra Interoffice Request - Mozilla Firefox):
; Active Window Position: x: 1721 y: 0 w: 1718 h: 1391
; Envelope button (green icon): x: 820 y: 240
; Submit button: x: 1470 y: 1066

EnvelopeBtnXR := 0.482166  ; 730 / 1514
EnvelopeBtnYR := 0.258807  ; 360 / 1391
LoadBtnXR := 0.581242      ; 880 / 1514
LoadBtnYR := 0.585909      ; 815 / 1391
SubmitBtnXR := 0.303831    ; 460 / 1514
SubmitBtnYR := 0.943925    ; 1313 / 1391
NameFieldXR := 0.320343    ; 485 / 1514
NameFieldYR := 0.618260    ; 860 / 1391
AliasFieldXR := 0.663804   ; 1005 / 1514
AliasFieldYR := 0.618260   ; 860 / 1391
PackageTypeXR := 0.317212  ; 480 / 1514
PackageTypeYR := 0.895758  ; 1246 / 1391
SpecialInstrXR := 0.336856 ; 510 / 1514
SpecialInstrYR := 0.884256 ; 1230 / 1391
BuildingFieldXR := 0.309115 ; 468 / 1514
BuildingFieldYR := 0.583013 ; 811 / 1391
PackagesCountXR := 0.317212 ; 480 / 1514
PackagesCountYR := 0.829618 ; 1154 / 1391
NeutralClickXR := 0.895425 ; 1370 / 1530
NeutralClickYR := 0.506830 ; 705 / 1391

#IfWinActive, Intra: Interoffice Request ahk_exe firefox.exe
^Enter::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{End}
    Sleep 150
    ClickAtRatio(SubmitBtnXR, SubmitBtnYR)
return

!s::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)  ; neutral click to defocus controls
    Sleep 150
    SendInput, ^{Home}  ; scroll to top
    Sleep 150
    ClickAtRatio(EnvelopeBtnXR, EnvelopeBtnYR)
return

!a::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{Home}
    Sleep 150
    ClickAtRatio(AliasFieldXR, AliasFieldYR, 2)
return

!p::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{Home}
    Sleep 150
    Gosub, HandleEnvelopeClick
    Sleep, 500
    SendInput, poster
    Sleep 150
    SendInput, {Enter}
    Sleep 200
    ClickAtRatio(LoadBtnXR, LoadBtnYR)
    Sleep 150
    ClickAtRatio(NameFieldXR, NameFieldYR)
return

^!a::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{Home}
    Sleep 150
    Gosub, HandleEnvelopeClick
    Sleep, 500
    SendInput, ACP
    Sleep 150
    SendInput, {Enter}
    Sleep 200
    ClickAtRatio(LoadBtnXR, LoadBtnYR)
    Sleep 500
    ClickAtRatio(AliasFieldXR, AliasFieldYR)
return

HandleEnvelopeClick:
    ClickAtRatio(EnvelopeBtnXR, EnvelopeBtnYR)
    Sleep 150
return

^!s::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{End}
    Sleep 150
    ClickAtRatio(SpecialInstrXR, SpecialInstrYR)
    Sleep 150
    SendInput, ^a
    Sleep 80
    SendInput, {Backspace}
    Sleep 120
    SendInput, Order:{Space}
    Tooltip, Alt+Space to enter building code + recipient alias.
    SetTimer, HideSpecialTooltip, -4000
return

!t::
    ShowHotkeyTooltip()
return

!3::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{Home}
    Sleep 150
    ClickAtRatio(PackagesCountXR, PackagesCountYR)
return

!4::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{Home}
    Sleep 150
    ClickAtRatio(PackageTypeXR, PackageTypeYR)
return

!l::
    Send {Tab 4}
    Sleep 50
    Send {Space}
return

!Space::
    EnsureIntraWindow()
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{End}
    Sleep 150
    buildingText := CopyFieldText("", BuildingFieldXR, BuildingFieldYR)
    Sleep 150
    ClickAtRatio(SpecialInstrXR, SpecialInstrYR)
    Sleep 100
    SendInput, {Space 2}
    Sleep 100
    ClipSaved := ClipboardAll
    Clipboard := buildingText
    SendInput, ^v
    Sleep 100
    SendInput, {Space 2}
    Sleep 150
    ; capture alias after finishing and return focus to Special Instructions
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    aliasText := CopyFieldText("Top", AliasFieldXR, AliasFieldYR)
    Sleep 150
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    SendInput, ^{End}
    Sleep 200
    ClickAtRatio(NeutralClickXR, NeutralClickYR, 2)
    Sleep 150
    ClickAtRatio(SpecialInstrXR, SpecialInstrYR)
    Clipboard := aliasText  ; leave alias on clipboard after finishing
    Sleep 100
    SendInput, ^v
    Sleep 100
    SendInput, @
return

EnsureIntraWindow()
{
    WinMove, Intra: Interoffice Request ahk_exe firefox.exe,, 1917, 0, 1530, 1399
    Sleep 150
}

CopyFieldText(scrollPos, xRatio, yRatio)
{
    if (scrollPos = "Top")
        SendInput, ^{Home}
    else if (scrollPos = "Bottom")
        SendInput, ^{End}

    Sleep 200
    ClickAtRatio(xRatio, yRatio)
    Sleep 200
    ClipSaved := ClipboardAll
    Clipboard :=
    SendInput, ^a
    Sleep 80
    SendInput, ^c
    ClipWait, 0.5
    if (ErrorLevel)
        text := ""
    else
        text := Clipboard
    Clipboard := ClipSaved
    ClipSaved := ""
    return text
}

GetFieldText(scrollPos, xRatio, yRatio, promptText := "")
{
    text := CopyFieldText(scrollPos, xRatio, yRatio)
    if (text = "" && promptText != "")
    {
        InputBox, userText, Field Required, %promptText%
        if (!ErrorLevel)
            text := userText
    }
    return text
}

ShowHotkeyTooltip()
{
    tooltipText =
    (
Alt+S  - Focus envelope icon
Alt+A  - Focus alias field
Ctrl+Enter - Scroll to bottom and Submit
Ctrl+Alt+S - Fill Special Instructions
Ctrl+Alt+A - ACP preset -> Alias
Alt+P  - Load "posters" preset -> Name field
Alt+3  - Focus "# of Packages"
Alt+4  - Focus Package Type
Alt+L  - Click Load button
    )
    Tooltip, %tooltipText%
    SetTimer, HideHotkeyTooltip, -15000
}

HideHotkeyTooltip()
{
    Tooltip
}

HideSpecialTooltip()
{
    Tooltip
}

ClickAtRatio(xRatio, yRatio, clicks := 1)
{
    WinGetPos,,, winW, winH, A
    targetX := Floor(winW * xRatio)
    targetY := Floor(winH * yRatio)
    MouseClick, left, %targetX%, %targetY%, %clicks%
}

#IfWinActive
