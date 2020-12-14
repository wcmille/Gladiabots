ChooseMode(mode, ByRef win)
{
  win := win . "`n===MODE=== " . mode . "`n"
  Y := 44 * (mode - 1) + 144
  Click, 83, %Y%
  Sleep, 500
}

ChooseBot(bot, ByRef win)
{
  win := win . "`n===BOT=== " . bot . "`n"
  Send, 4
  Sleep, 500
  BotX := 308 * (bot - 1) + 344
  Click, %BotX%, 1030
  Sleep, 500
}


RunBotL(first, last, ByRef result)
{
  Send, 2
  Sleep, 500
  Loop
  {
    ChapterL(first, result)
    first++
  }
  Until first > last
  result := RTrim(result, ", ")
}

ChapterL(theChapter, ByRef resultText)
{
  DoChap := 43 * (theChapter - 1) + 103
  Click, 629, %DoChap%
  Sleep, 1000
  ClickY := 100
  Loop, 6
  {
    theLevel := A_Index
    Click, 1211, %ClickY%
    resultText .= RunMatch() . ", "
 
    ClickY += 43
  }
  Return
}

RunBot(first, last, ByRef win, ByRef losses, ByRef draws)
{
  Send, 2
  Sleep, 500
  win := win . "Bot: "
  Loop
  {
    Chapter(first, win, losses, draws)
    first++
  }
  Until first > last
  win := win . "`n"
}

RunLevelL(theChapter, level, ByRef result)
{
  DoChap := 43 * (theChapter - 1) + 103
  Click, 629, %DoChap%
  Sleep, 1000

  Y := 43 * (level -  1) + 103
  Click, 1211, %Y%
  Sleep, 500

  return RunMatch()
}

RunLevel(theChapter, level, ByRef win, ByRef losses, ByRef draws)
{
  DoChap := 43 * (theChapter - 1) + 103
  Click, 629, %DoChap%
  Sleep, 1000

  Y := 43 * (level -  1) + 103
  Click, 1211, %Y%
  Sleep, 500

  result := RunMatch()
  if (result = 1)
  {
    win := win . theChapter . "." . level . " "
  }
  else if (result = -1)
  {
    losses .= theChapter . "." . level . " "
  }
  else
  {
    draws .= theChapter . "." . level . " "
  }
}

Chapter(theChapter, ByRef win, ByRef losses, ByRef draws)
{
  DoChap := 43 * (theChapter - 1) + 103
  Click, 629, %DoChap%
  Sleep, 1000
  ClickY := 100
  Loop, 6
  {
    theLevel := A_Index
    Click, 1211, %ClickY%
    result := RunMatch()
    if (result = 1)
    {
       win := win . theChapter . "." . theLevel . " "
    }
    else if (result = -1)
    {
      losses .= theChapter . "." . theLevel . " "
    }
    else
    {
      draws .= theChapter . "." . theLevel . " "
    }
    ClickY += 43
  }
  Return
}

RunMatch()
{
  FoundX := 0
  Sleep, 5000
  Send, {Space}
  Sleep, 500
  Send, F
  Sleep, 500
  Count := 0
check:
  Sleep, 3000
  ImageSearch, FoundX, FoundY, 1136, 1062, 1300, 1100, C:\Users\Wayne\Desktop\Gladia\Next.bmp
  if (FoundX > 1)
  {
    Goto, skip
  }
  ImageSearch, FoundX, FoundY, 813, 84, 1130, 120, *10 C:\Users\Wayne\Desktop\Gladia\Victory.bmp
  if (FoundX > 1)
  { 
    FoundX := 1200
    Goto, skip
  }
  ImageSearch, FoundX, FoundY, 813, 86, 1130, 120, *10 C:\Users\Wayne\Desktop\Gladia\CampaignComplete.bmp
  if (FoundX > 1)
  {
    FoundX := 1200
    Goto, skip
  }
  ImageSearch, FoundX, FoundY, 900, 84, 1020, 120, C:\Users\Wayne\Desktop\Gladia\Defeat.bmp
  if (count > 109)
  {
    return -99
  }
  if (FoundX < 1)
  {
    Count++
    Goto, check
  }
skip:
  if (FoundX > 1100)
  {
    Send, {Esc}
    Sleep, 1000
    return 1
  }
; Test for Draw or Defeat
  Click, 872, 1082
  Send, {Space}
  Sleep, 200
  Us := GetBlueScore()
  Them := GetRedScore()
  Draw := Them - Us
  ; MsgBox, % "Score: " . Format("0x{1:X}", Us) . " Them: " . Format("0x{1:X}", Them)
  Send, {Esc}
  Sleep, 1000
  if (Draw = 0)
    return 0
  return -1
}

; ====================================================

MultiBot(matches)
{
  ; Send, 3
  Sleep, 200
  Loop
  {
    MultiMatch()
    matches--
  }
  Until matches <= 0
}

MultiMatch()
{
  Sleep, 3000
  Send, {Space}
  Sleep, 15000
  Send, {Space}
  Sleep, 200
  Send, F
  Sleep, 40000
  Send, N
}

; ========================================================

GetBlueScore()
{
  tolerance := "*96"
  FoundX := -1
  FoundY := -1
  ImageSearch, FoundX, FoundY, 900, 0, 1100, 70, *Trans0xFF00FF %tolerance% C:\Users\Wayne\Desktop\Gladia\Numbers\0Blue.png
  if (FoundX > 0)
  {
    return 0
  }
  ImageSearch, FoundX, FoundY, 900, 0, 1100, 70, *Trans0xFF00FF %tolerance% C:\Users\Wayne\Desktop\Gladia\Numbers\1Blue.png
  ; PixelGetColor, color, 944, 47, RGB
  ; color |= 0x030F0F
  ; if (0x37DFFF = color)
  if (FoundX > 0)
  {
    return 1
  }
  ; PixelGetColor, color, 948, 60, RGB
  ; color |= 0x030303
  ; if (0x3BE3FF = color)
  ImageSearch, FoundX, FoundY, 900, 0, 1100, 255, *Trans0xFF00FF %tolerance% C:\Users\Wayne\Desktop\Gladia\Numbers\2Blue.png
  if (FoundX > 0)
  {
    return 2
  }
  ; PixelGetColor, color, 941+7, 45, RGB
  ; color |= 0x0F0F0F
  ; if (0x3FEFFF = color)
  ImageSearch, FoundX, FoundY, 900, 0, 1100, 255, *Trans0xFF00FF %tolerance% C:\Users\Wayne\Desktop\Gladia\Numbers\3Blue.png
  if (FoundX > 0)
  {
    return 3
  }
  PixelGetColor, color, 937, 54, RGB
  color |= 0x030303
  if (0x37E3FF = color)
  {
    return 4
  }
  PixelGetColor, color, 947, 42, RGB
  color |= 0x030303
  if (0x3BE3FF = color)
  {
    return 5
  }
  PixelGetColor, color, 938 + 7, 42, RGB
  color |= 0x0F0F0F
  if (0x3FDFFF = color)
  {
    return 6
  }
  PixelGetColor, color, 936 + 7, 54, RGB
  color |= 0x0F0F0F
  if (0x3FDFFF = color)
  {
    return 7
  }
  PixelGetColor, color, 931 + 7, 56, RGB
  color |= 0x0F0F0F
  if (0x3FDFFF = color)
  {
    return 8
  }
  return %color%
}

GetRedScore()
{
  tolerance := "*80"
  ; PixelGetColor, color, 979 + 7, 51, RGB
  ; color |= 0x0F0F0F
  ; if (0xFF6F6F = color)
  ; {
    ; return 0
  ; }

  FoundX := -1
  FoundY := -1
  ImageSearch, FoundX, FoundY, 900, 0, 1100, 70, *Trans0xFF00FF %tolerance% C:\Users\Wayne\Desktop\Gladia\Numbers\0Red.png
  if (FoundX > 0)
  {
    return 0
  }
  ImageSearch, FoundX, FoundY, 900, 0, 1100, 70, *Trans0xFF00FF %tolerance% C:\Users\Wayne\Desktop\Gladia\Numbers\1Red.png
  if (FoundX > 0)
  {
    return 1
  }
  ImageSearch, FoundX, FoundY, 900, 0, 1100, 70, *Trans0xFF00FF %tolerance% C:\Users\Wayne\Desktop\Gladia\Numbers\2Red.png
  if (FoundX > 0)
  {
    return 2
  }

  PixelGetColor, color, 940+7+50, 45, RGB
  color |= 0x0F0F0F
  if (0xFF6F6F = color)
  {
    return 3
  }

  ; PixelGetColor, color, 937+50, 54, RGB
  PixelGetColor, color, 989+7, 55, RGB
  color |= 0x0F0F0F
  if (0xFF6F6F = color)
  {
    return 4
  }

  PixelGetColor, color, 947+50, 42, RGB
  color |= 0x0F0F0F
  if (0xFF6F6F = color)
  {
    return 5
  }

  PixelGetColor, color, 988+7, 42, RGB
  color |= 0x0F0F0F
  if (0xFF6F6F = color)
  {
    return 6
  }
  return %color%
}