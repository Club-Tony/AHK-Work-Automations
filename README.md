# Note: Not recommended for use if unfamiliar with functionality - Test and QC hotkey actions before using for any work tasks
### -----Additionally, due to lack of automatic coordinate scaling functionality based on window size/monitor size, the following requirements are necessary to ensure all scripts function properly-----
## Requirements:  
1. #### 3440 x 1440p (21:9 Aspect Ratio) Ultra-Wide monitor [As main monitor]
2. #### 2 separate desktop instances for logistics software, one for Assign Recip, and one for Update [Add a third for Pickup if using desk signature pad for customer signatures]
3. #### Assign Recip should be hooked to left side of screen while active (WinKey+Left), and Update hooked to the right side (WinKey+Right) [If using Pickup as well, it should be maximized]
4. #### Firefox*, Chrome, or Edge Browser *(Firefox preferred)
---
# Setup:
## Recommended: add shortcuts for the following files (if needed) into Startup folder [Run Dialog (Win+R - Shell:Startup)], as they are meant to always be running and don't launch through Launcher Script: 
- **Launcher Script (Keybinds)** — loads global hotkeys and launcher bindings
- **Alt+Q Map to Alt+F4** — remaps Alt+Q to behave like Alt+F4
- **Alt+R_Post_Parent_Normalize** — restores parent window focus/state after Alt+R actions
- **DSRF-to-UPS_WS-Legacy** — bridges DSRF inputs to legacy UPS workspace controls
- **Intra_Buttons** — adds quick-access hotkeys for common Intra buttons
- **Intra_Desktop_Search_Shortcuts** — hotkeys for desktop search and navigation
- **Intra_Focus_Fields** — jump-to-field shortcuts within Intra forms
- **Intra_Pickup_Shortcuts** — accelerates pickup workflow with mapped keys
- **Intra_Posters_Full_Auto.ahk** — automates the full posters workflow end-to-end
- **Intra_Update_Tab_Shortcuts** — shortcuts for Update tab navigation/actions
- **IntraWinArrange** — arranges and snaps Intra windows to preset layouts
- **Resize_Intra_Search_Window** — auto-resizes the Intra search window for visibility
- **Right Click** — helper script for context/right-click actions
- **Slack_Shortcuts** — custom Slack navigation and messaging hotkeys
- **ToolTips** — displays tooltip reminders for active shortcuts
- **UPS_WS_Shortcuts** — UPS workspace task shortcuts and macros
- **Window_Switch** — quick window switching and cycling hotkeys
- **Yellow_Pouch** — shortcuts/macros for Yellow Pouch workflows
---
## Run 'Launcher Script (Keybinds)' to launch certain scripts with Hotkeys 
### Hotkeys:
#### -Ctrl+Alt+T = ToolTips (Displays relevant Hotkey Menus depending on currently active window)
#### -Esc key = Exit certain launched scripts + Stop automations early
#### -Ctrl+Esc = Reloads all scripts + Stop automations early
