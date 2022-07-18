#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

#Include, firefox.ahk
#Include, windowsterminal.ahk

;--- Hotkeys ---;

; Windows Terminal
F1::
  switchToWindowsTerminal(false)
return

+F1::
  switchToWindowsTerminal(true)
return

; Firefox
F2::
activateFirefox(false)
return

+F2::
activateFirefox(true)
return

!F2::
switchFirefoxWindow()
return

Numpad1::
openNewFirefox(true)
return

Numpad2::
openNewFirefox(false)
return

; Kill Wallpaper Engine
#w::
RunWait, Taskkill /f /im wallpaper32.exe
return

; convert Windows path to WSL path
#p::
replaceCount = 0
wslPath := RegExReplace(clipboard, "^([a-zA-Z]):(.*)", "/mnt/$L1$2", replaceCount)

if replaceCount <= 0
{
  winPath := RegExReplace(clipboard, "^\/mnt\/([a-zA-Z])(.*)", "$U1:$2", replaceCount)

  if replaceCount >= 1
  {
    StringReplace, winPath, winPath, /, \, All
    clipboard := winPath
  }
}
else
{
  StringReplace, wslPath, wslPath, \, /, All
  clipboard := wslPath
}
return

;Suspend hotkeys
#s::
suspend, toggle
return

; Exit ahk
#x::ExitApp 