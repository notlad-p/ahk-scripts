#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

; Windows Terminal
switchToWindowsTerminal(shift) {
  ; if terminal is launched
  IfWinExist, ahk_exe WindowsTerminal.exe
  {
    ; if terminal is the active window
    if WinActive("ahk_exe WindowsTerminal.exe") {
      ; Shift Tab through open tabs
      Sendinput % shift ? "+^{tab}" : "^{tab}"
    } else {
      ; else make terminal active window
      WinActivate ahk_exe WindowsTerminal.exe
    }
  } else 
  {
    ; Make terminal launch then resize to 70% width and 100% height, right aligned
    SysGet, Monitor2, Monitor, 2
    Run, wt.exe
    WinWait, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinMove,,, Floor(A_ScreenWidth * 0.3) - 60, 0, Floor(A_ScreenWidth * 0.7), A_ScreenHeight
  }
}