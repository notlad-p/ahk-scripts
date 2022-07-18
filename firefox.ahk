#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

; Firefox functions

; opens firefox at cordinates and dimensions
openFirefoxNewWindow(x, y, width, height) {
  ; why do I have to wait twice?
  ; why is the PID returned from RunWait incorrect?
  ; the world may never know. 
  RunWait, firefox.exe
  WinWait, ahk_exe firefox.exe
  WinGet, active_id, ID, A

  WinMove, ahk_id %active_id%,, x, y, width, height
}

; focus firefox browser or go through tabs
activateFirefox(shiftPressed) {
  ; if firefox is already active window
  if WinActive("ahk_exe firefox.exe") {
    ; if shift key, send shift aswell
    if shiftPressed
      Sendinput +^{tab}
    else
      Sendinput ^{tab}
  } else {
    WinActivate ahk_exe firefox.exe
  }

  ; if firefox not open, open on main monitor next to terminal
  IfWinNotExist, ahk_exe firefox.exe 
  {
    Run, firefox.exe
    WinWait, ahk_exe firefox.exe
    WinMove,,, 0, 0, Floor(A_ScreenWidth * 0.3), A_ScreenHeight
  }
}

; switch firefox window
switchFirefoxWindow() {
  ; if firefox not open, open on main monitor next to terminal
  IfWinNotExist, ahk_exe firefox.exe
  {
    Run, firefox.exe
    WinWait, ahk_exe firefox.exe
    WinMove,,, 0, 0, Floor(A_ScreenWidth * 0.3), A_ScreenHeight
  } else 
  {
    ; if firefox detected, add to group
    GroupAdd, firefoxwindows, ahk_exe firefox.exe
    ; if firefox active, activate next window, else activate firefox
    if WinActive("ahk_exe firefox.exe") {
      GroupActivate, firefoxwindows, r
    } else {
      WinActivate ahk_exe firefox.exe
    }
  }
}

; open new firefox window
openNewFirefox(mainMonitor) {
  ; if monitor = 1, open on main monitor
  if (mainMonitor) {
    openFirefoxNewWindow(0, 0, Floor(A_ScreenWidth * 0.3), A_ScreenHeight)
  } else {
    ; else open on second monitor
    openFirefoxNewWindow(-1600, 140, 1600, 1440)
  }    
}