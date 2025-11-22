#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!f::

    ToolTip, Quick Search Hotkeys activated`nAlt+D: Docksided items`nAlt+O: On-shelf items`nAlt+C: Clear Search
    Sleep 7000
    ToolTip
return