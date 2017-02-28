#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  
SendMode Input  
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance ignore
#WinActivateForce 
DetectHiddenWindows, on
CoordMode, Pixel, Relative
SetTitleMatchMode, 3
SetKeyDelay, -1



^f11:: 
	Flag := 0
	SetTimer, LoopLimit, -12000 ;<-- set a oneshot 12 second timer to stop the loop
	WinGet, active_id, ID, A
	IfWinExist, Dolphin NetPlay 
		WinClose		
	else 	{
		IfWinExist Ishiiruka-Dolphin727(0b00f1f) ;Only the dolphin emulator open
			WinActivate
		else{
			Run "Dolphin - Shortcut" ;nothing open;
			WinActivate
			DirectoryLoad()
			}
		}
	HomeWindowHandler()
	NetPlaySetupHanlderHost()
	NetPlayWindowHandler()	
	Sleep 200
	Flag := 1 ;Hotkey successfully completed
	If (active_id != 0x3f1112)
		WinActivate, ahk_id %active_id% ;Returns users to whichever Window they were in

return
			
^f12:: 
	Flag := 0
	SetTimer, LoopLimit, -7000 ;<-- set a oneshot 7second timer to stop the loop
	clipboard =  ;Clears Clipboard
	Send ^c
	sleep 150
	Clipboard = %Clipboard%
	if clipboard = 
	{
	Flag := 1
	MsgBox, Please highlight text before pressing Ctrl+F12!
    Exit
	}
	IfWinExist, Dolphin NetPlay 
		{	
		WinClose
		WinActivate Ishiiruka-Dolphin727(0b00f1f)
		}
		IfWinNotExist Ishiiruka-Dolphin727(0b00f1f) ;Only the dolphin emulator open
		{
			Run "Dolphin - Shortcut" ;nothing open;
			WinActivate, Ishiiruka-Dolphin727(0b00f1f)
			DirectoryLoad()
		}
	HomeWindowHandler()
	NetPlaySetupHanlderConnect()
	sleep, 200
	Flag := 1
return

~^up::
ControlSend, Edit3 , {up}, Dolphin NetPlay
return

~^down::
ControlSend, Edit3 , {down}, Dolphin NetPlay
return

LoopLimit:
	If Flag != 1
		MsgBox,, Something Went Wrong With SmashQuickPlay!, Send me an email at CoCaptainJack@gmail.com if this error is consistant! Press Ok to reload the script.
		Reload
Return


DirectoryLoad(){
	Loop
	{
	ImageSearch, FoundX, FoundY, 0, 0, 1000, 1000, Images\Profile.PNG
		if ErrorLevel = 0
		break ; image was found break loop and continue
	ImageSearch, FoundX, FoundY, 0, 0, 1000, 1000, Images\Flag_USA.PNG
		if ErrorLevel = 0
		break	
	ImageSearch, FoundX, FoundY, 0, 0, 1000, 1000, Images\Flag_Japan.PNG
		if ErrorLevel = 0		
		break
	ImageSearch, FoundX, FoundY, 0, 0, 1000, 1000, Images\Flag_Unknown.PNG
		if ErrorLevel = 0		
		break				
	}
return
}

HomeWindowHandler(){
	WinActivate, Ishiiruka-Dolphin727(0b00f1f)
	Sleep 50
	hwnd := winexist()
	Send, {alt down}{t}{n}{alt up} 
return
}

NetPlayWindowHandler(){
	WinWait Dolphin NetPlay
	Sleep 50
	hwnd := winexist()
	RoomID = ""
	while !(RoomID ~= "[0-9a-f]{8}")
		controlgettext, RoomID, Static1, ahk_id %hwnd%
	Clipboard = %RoomID%
return
}

NetPlaySetupHanlderHost(){
	winwait Dolphin NetPlay Setup
	Sleep 50
	hwnd := winexist()  ; lock target handle to last found window
	WinActivate, ahk_id %hwnd%
	ControlSend, ahk_parent, ^{tab}, ahk_id %hwnd%
	;~ control tabright,, _wx_SysTabCtl321, ahk_id %hwnd%
	;~ controlclick Button4, ahk_id %hwnd%,,,,NA  ;randomly not Clicking button 4...
	ControlFocus, button4, ahk_id %hwnd%
	ControlSend, button4, {enter}, ahk_id %hwnd%
return
}

NetPlaySetupHanlderConnect(){	
	winwait Dolphin NetPlay Setup
	Sleep 50
	hwnd := winexist()  ; lock target handle to last found window
	WinActivate, ahk_id %hwnd%
	ControlSetText, edit3, %Clipboard%, ahk_id %hwnd%
	ControlFocus, button2, ahk_id %hwnd%
	ControlSend, button2, {enter}, ahk_id %hwnd%
return
}


~^End::
	WinActivate, ahk_id 0x520fc2
	Send ^s
	Reload