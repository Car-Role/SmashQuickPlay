#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

 if not A_IsAdmin
 {
  Run *RunAs "%A_ScriptFullPath%"
  ExitApp
 }

Gui, 1:Add, Button, x262 y109 w90 h30 +Center, Cancel
Gui, 1:Add, Button, x165 y109 w90 h30 , Remove
Gui, 1:Add, Text, x32 y20 w351 h78 , Would you like to add or remove SmashQuickPlay from startup on your computer (no longer needing to keep running this software)?
Gui, 1:Add, Button, x67 y109 w90 h30 , Add
; Generated using SmartGUI Creator for SciTE
Gui, 1:Show, w425 h154, SmashQuickPlay
return

1GuiClose:
KillProcess()
ExitApp
return

ButtonAdd:
FileCreateShortcut, %A_ScriptDir%\NetPlayHotkey.exe, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Start_up_file_for_hotkey.lnk, %A_ScriptDir%
Gui Destroy
MsgBox,, SmashQuickPlay, Added to startup! Run this again if you ever wish to remove it.
KillProcess()
ExitApp
Return

ButtonRemove:
FileDelete, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Start_up_file_for_hotkey.lnk
Gui Destroy
sleep 1000
MsgBox,, SmashQuickPlay, Remove from startup! Run this again if you ever wish to Add it.
KillProcess()
ExitApp
Return

ButtonCancel:
KillProcess()
ExitApp
Return

KillProcess() {

IfExist "Shortcut Maker.ahk"
{
 Process, Close, Shortcut Maker.ahk
  Loop {
    Process, Close, Shortcut Maker.ahk
    if !ErrorLevel
       break

    return
  MsgBox,, Done!
 }
 }
}