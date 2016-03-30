; Author: fwompner gmail com
; sends Esc when Caps Lock pressed and released
; threats Caps Lock as Ctrl when used in key combo
#InstallKeybdHook
SetCapsLockState, alwaysoff
Capslock::
Send {LControl Down}
KeyWait, CapsLock
Send {LControl Up}
if ( A_PriorKey = "CapsLock" )
{
    Send {Esc}
}
return

^BS::  Winset, Alwaysontop, , A

!^f::
    WinSet, Style, -0xC40000, A ;0xC40000 is the code for the titlebar/border around a window. The - in-front tells AHK to remove that styling (make the window borderless)
    WinMove, A, , 0, 0, 1920, 1080 ;moves the (A)ctive window to strech from 0,0 to 1920,1080
    ;IF YOU HAVE A DIFFERENT RESOLUTION MONITOR, YOU MUST CHANGE THE LAST TWO NUMBERS TO MATCH!
return ;this return just means the end of the code, and allows the hotkey to be used as many times as you like as long as the macro is running. In other words, the macro won't close after the first use.
