#Requires AutoHotkey v2.0
SendMode 'Event'
SetKeyDelay 50
Esc::ExitApp
^!s:: {
    Send '{Tab 2}'  
    Send '{Space}'
    Send '{Tab 2}' 
    Send '{Space}'
    Send '{Tab}' 
    Send 'daveyuan'
    Send '{Tab}'
    Send 'bsc'
    Sleep 100 
    Send '{Enter down}'
    Sleep 50
    Send '{Enter up}'
    Sleep 100
    Send '{Tab 16}'
    Send '{Space}'
    Send '{Tab}'
    Send 'ouroboros-bsc@amazon.com'
    Loop 13 {
        Send '+{Tab}'
    } 
}