#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn,
SendMode Input  
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance ignore
#WinActivateForce 
DetectHiddenWindows, on
CoordMode, Pixel, Relative
SetTitleMatchMode, 2
SetTitleMatchMode, fast
SetKeyDelay, -1

;Top of the traytip Menu
Menu, tray, add, Advertise, Advertiser
Menu, tray, add, RegionMap, RegionSelector  ; Creates a new menu item.
Menu, tray, add  ; Creates a separator line.
;end of custom traytip Menu
Menu, Tray, NoStandard
Menu, Tray, Standard


; create the GUI for later use
Gui, Add, Picture, x-8 y-1 w780 h620 , C:\Users\Carl\Pictures\new-regions-2017.png
Gui, Add, CheckBox, vCW x102 y59 w40 h20 , CW
Gui, Add, CheckBox, vCN x262 y59 w40 h20 , CN
Gui, Add, CheckBox, vON x402 y89 w40 h20 , ON
Gui, Add, CheckBox, vCE x522 y89 w40 h20 , CE
Gui, Add, CheckBox, vNW x82 y159 w40 h20 , NW
Gui, Add, CheckBox, vN x302 y149 w40 h20 , N
Gui, Add, CheckBox, vMW x442 y229 w40 h20 , MW
Gui, Add, CheckBox, vEC x542 y229 w40 h20 , EC
Gui, Add, CheckBox, vSE x452 y319 w40 h20 , SE
Gui, Add, CheckBox, vC x292 y229 w33 h20 , C
Gui, Add, CheckBox, vMT x182 y229 w40 h20 , MT
Gui, Add, CheckBox, vWC x72 y269 w40 h20 , WC
Gui, Add, CheckBox, vS x292 y329 w33 h20 , S
Gui, Add, CheckBox, vMX x212 y399 w40 h20 , MX
Gui, Add, Text, x5 y500 w300 h24, Area you are from (EG. Minnesota, southeast Mexico, Ontario)
Gui, Add, Edit, vState x5 y525 w400 h24 , test ;Area you are from (EG. Minnesota, southeast Mexico, Ontario)
Gui, Add, button, gsave x600 y450 w60 h60, SAVE

;-------------
; the RegionList is just for looping purpose
RegionList = CW-CN-ON-CE-NW-N-MW-EC-SE-C-MT-WC-S-MX-State

return

RegionSelector:
loop, parse, RegionList,-
{
    IniRead, %A_Loopfield%, MyRegions.ini, Regions, %A_Loopfield% , 0
    GuiControl, , %A_Loopfield% , % %A_Loopfield%
}
Gui, Show, w774 h621, Faster Melee Region Map
return

Save:
Gui, Submit
loop, parse, RegionList,-
{   
    IniWrite, % %A_Loopfield%, MyRegions.ini, Regions, %A_Loopfield%
}
return

Advertiser:

Hoster()
AdvertiseString := "I am looking for a match in"
loop, parse, RegionList,-
{
    IniRead, %A_Loopfield%, MyRegions.ini, Regions, %A_Loopfield% , 0
    if (%A_Loopfield% = 1)
        AdvertiseString .= " @#" . A_Loopfield
}
AdvertiseString .= " and I'm from " State "`nMy Code is: "
AdvertiseString .= RoomID 
Clipboard = %AdvertiseString%
return

^f11:: 
Hoster()
return
			
^f12:: 
Connecter()
Return

~^up::
ControlSend, Edit3 , {up}, Dolphin NetPlay
return

~^down::
ControlSend, Edit3 , {down}, Dolphin NetPlay
return

LoopLimitHost:
	If FlagHost != 1
		MsgBox,, Something Went Wrong With SmashQuickPlay!, Send me an email at CoCaptainJack@gmail.com if this error is consistant! Press Ok to reload the script.
		Reload
Return

LoopLimitconnect:
	If FlagConnect != 1
		MsgBox,, Something Went Wrong With SmashQuickPlay!, Send me an email at CoCaptainJack@gmail.com if this error is consistant! Press Ok to reload the script.
		Reload
Return


Hoster() {
	global
	;~ flaghost 
	FlagHost := 0
	SetTimer, LoopLimitHost, -12000 ;<-- set a oneshot 12 second timer to stop the loop
	WinGet, active_id, ID, A
	IfWinExist, Dolphin NetPlay 
		WinClose		
	else 	{
		IfWinExist, Ishiiruka-Dolphin ;Only the dolphin emulator open
			WinActivate Ishiiruka-Dolphin
		else{
			Run "Dolphin - Shortcut" ;nothing open;
			WinActivate Ishiiruka-Dolphin
			DirectoryLoad()
			}
		}
	HomeWindowHandler()
	NetPlaySetupHandlerHost()
	NetPlayWindowHandler()	
	Sleep 200
	FlagHost := 1 ;Hotkey successfully completed
	If (active_id != 0x3f1112)
		WinActivate, ahk_id %active_id% ;Returns users to whichever Window they were in
	
	return RoomID
}

Connecter() {
	global
	;~ FlagConnect
	FlagConnect := 0
	SetTimer, LoopLimitconnect, -7000 ;<-- set a oneshot 7second timer to stop the loop
	Clipboard =  ;Clears Clipboard
	Send ^c
	sleep 150
	Clipboard = %Clipboard%
	if clipboard = 
	{
	FlagConnect := 1
	MsgBox, Please highlight text before pressing Ctrl+F12!
    Exit
	}
	StringLen, CodeLen, Clipboard
	If (CodeLen > 12) 	{
	FlagConnect := 1
	MsgBox,, Warning, Host code size is too large. `nPlease recheck that you have the correct code
    Exit
	}
	IfWinExist, Dolphin NetPlay 
		{	
		WinClose
		WinActivate Ishiiruka-Dolphin
		}
		IfWinNotExist Ishiiruka-Dolphin ;Only the dolphin emulator open
		{
			Run "Dolphin - Shortcut" ;nothing open;
			WinActivate, Ishiiruka-Dolphin
			DirectoryLoad()
		}
	HomeWindowHandler()
	NetPlaySetupHandlerConnect()
	sleep, 200
	FlagConnect := 1
return
	
	
}	


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
	global
	WinActivate, Ishiiruka-Dolphin
	Sleep 50
	hwnd := winexist()
	Send, {alt down}{t}{n}{alt up} 
return
}

NetPlayWindowHandler(){
	WinWait Dolphin NetPlay
	WinActivate Dolphin NetPlay
	;~ msgbox,, netplay window found
	Sleep 50
	hwnd := winexist()
	global RoomID
	RoomID = ""
	while !(RoomID ~= "[0-9a-f]{8}")
		controlgettext, RoomID, Static1,  Dolphin NetPlay
	Clipboard = %RoomID%
return RoomID
}

NetPlaySetupHandlerHost(){
	global
	winwait Dolphin NetPlay Setup
	Sleep 50
	;~ MsgBox,, break1
	hwnd := winexist()  ; lock target handle to last found window
	;~ MsgBox,, break2
	WinActivate, ahk_id %hwnd%
	ControlSend, _wx_SysTabCtl321, ^{tab}, ahk_id %hwnd%
	sleep 50
	;~ MsgBox,, break3
	;~ control tabright,, _wx_SysTabCtl321, ahk_id %hwnd%
	;~ controlclick Button4, ahk_id %hwnd%,,,,NA  ;randomly not Clicking button 4...
	ControlFocus, button5, ahk_id %hwnd%
	ControlSend, button5, {enter}, ahk_id %hwnd%
	;~ MsgBox,, break4
return
}

NetPlaySetupHandlerConnect(){	
	global
	winwait Dolphin NetPlay Setup
	Sleep 50
	hwnd := winexist()  ; lock target handle to last found window
	WinActivate, ahk_id %hwnd%
	ControlSetText, edit3, %Clipboard%, ahk_id %hwnd%
	ControlFocus, button3, ahk_id %hwnd%
	ControlSend, button3, {enter}, ahk_id %hwnd%
return
}


~^End::
	WinActivate, ahk_id 0x520fc2
	Send ^s
	Reload


;~ Abandoned features
;~ ~^Left::
	;~ FileGetShortcut, Dolphin - Shortcut.lnk,, ODir
	;~ TF_Replace(ODir "\User\GameSettings\GALE01.ini", "32", "16")
	Msgbox,,, %ODir%\User\GameSettings\GALE01.ini
	;~ return

;~ ~^Right::
	;~ ControlSend, Edit3 , {down}, Dolphin NetPlay
	;~ return	
