#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
  SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
  SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include GladiaLib.ahk
  validInput := 0
  While(NOT ValidInput)
  {
    InputBox, numRuns, "GladiabotMulti", "How many runs would you like to perform?"

    if ErrorLevel
    {
      MsgBox, "Canceled"
      return
    }

    if(numRuns is digit)
    {
      validInput := 1
    }
  }

  CoordMode, Mouse, Relative
  if(WinExist("Gladiabots"))
  {
    MsgBox, You have 10 seconds to select the Gladiabots window.
    WinWaitActive, Gladiabots, , 10
    if ErrorLevel
    {
      MsgBox, You need to select Gladiabots window.
    }
    else
    {
      MsgBox, "Window Active!"
      win := "Wins:`n"
      MultiBot(numRuns)
    }
  }
  ; FileDelete, C:\Users\Wayne\Desktop\Gladia\Results.txt
  ; FileAppend, %win%, C:\Users\Wayne\Desktop\Gladia\Results.txt
  ; Run, Notepad.exe C:\Users\Wayne\Desktop\Gladia\Results.txt
  MsgBox, Exiting
  Return

