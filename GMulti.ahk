#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
  SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
  SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include GladiaLib.ahk

  CoordMode, Mouse, Relative
  if WinExist("Gladiabots")
	WinActivate
  win := "Wins:`n"
  MultiBot(250)

  ; FileDelete, C:\Users\Wayne\Desktop\Gladia\Results.txt
  ; FileAppend, %win%, C:\Users\Wayne\Desktop\Gladia\Results.txt
  ; Run, Notepad.exe C:\Users\Wayne\Desktop\Gladia\Results.txt
  MsgBox, Done
  Return

