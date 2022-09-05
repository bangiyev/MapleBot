#NoEnv
DetectHiddenWindows, On
SetTitleMatchMode, 2
SendMode Input
SetWorkingDir %A_ScriptDir%\Assets
FileCreateDir,%A_ScriptDir%\Assets
;FileInstall,me.png,%A_ScriptDir%\Assets\me.png,1
FileInstall,player.png,%A_ScriptDir%\Assets\player.png,1
; FileInstall,guildie.png,%A_ScriptDir%\Assets\guildie.png,1
; FileInstall,rune.png,%A_ScriptDir%\Assets\rune.png,1
; FileInstall,friend.png,%A_ScriptDir%\Assets\friend.png,1
; FileInstall,bosshp.png,%A_ScriptDir%\Assets\bosshp.png,1
FileInstall,LDok.png,%A_ScriptDir%\Assets\LDok.png,1
FileInstall,LDbomb.png,%A_ScriptDir%\Assets\LDbomb.png,1
; FileInstall,ebClock.png,%A_ScriptDir%\Assets\ebClock.png,1
#SingleInstance, force
#InstallKeybdHook
#MaxThreadsPerHotkey 2
winactivate, ahk_class MapleStoryClass
; Variables
global IgnoreAll
global IgnoreRune
global IgnorePlayer
global IgnoreFriend
global IgnoreGuildie
global IgnoreEboss
global CheckInterval := 5000
;global runeExists := 0
gui, +Alwaysontop
gui, color, FAFAFA
gui, show, x1700 y100 w200 h180,
gui, font, s12
; GUI left-side
gui, add, button, x10 y1 w100 h24 gReload1, Reload
gui, add, button, x10 y25 w100 h24 gStart1, Start
gui, add, button, x10 y50 w100 h24 gPause1, Pause
;gui, add, CheckBox, x15 y75 vIgnoreAll gSubmit_All1, Ignore All %IgnoreAll%
;gui, add, CheckBox, x15 y95 vIgnoreRune gSubmit_All1, Ignore Rune %IgnoreRune%
gui, add, Checkbox, x15 y75 vIgnorePlayer gSubmit_All1, Ignore Player %IgnorePlayer%
;gui, add, Checkbox, x15 y135 vIgnoreGuildie gSubmit_All1, Ignore Guildie %IgnoreGuildie%
;gui, add, Checkbox, x15 y155 vIgnoreFriend gSubmit_All1, Ignore Friend %IgnoreFriend%
;gui, add, Checkbox, x15 y175 vIgnoreEboss gSubmit_All1, Ignore Eboss %IgnoreEboss%

gui, add, edit, x15 y100 w60 limit4 vCheckInterval gSubmit_All1, %CheckInterval%
; GUI right-side detectors
;gui, add, text, x150 y1 w220 cff66ff vRune,
; TODO: ADD GUI FOR vPlayer vGuildie vFriend, vEtc
; ADD HERE
; ADD HERE
; ADD HERE
; ADD HERE
; variables for development
gui, add, text, x10 y130 w220 vBotState, Status: OFF
gui, add, text, x10 y150, Version: Luna 1.0.0 ; updated eboss detect + ignore
;gui, add, text, x10 y250 w220 vLdText,

Submit_All1:
  Gui, Submit, NoHide
  return

WriteLog(text) {
  FormatTime, vDate,A_Now, yyyy-dd-MMM hh-mm-ss tt ;12-hour
	FileAppend, % vDate ": " text "`n", %A_ScriptDir%\safety.txt ; can provide a full path to write to another directory
}

_Check_Rune() {
  if (IgnoreRune) {
    ;guicontrol, , Rune, Rune: Ignore Rune
    return
  }
  ImageSearch,runeX,runeY,1,1,1920,1080, *1 rune.png
  if (runeX) {
    ;runeExists := runeExists + 1
    ;guicontrol, , Rune, Rune: %runeX%, %runeY% %runeExists%
    SoundPlay, %A_ScriptDir%\Sounds\rune.wav

  }
  return
  ; else {
  ;   guicontrol, , Rune, Rune: -
  ; }
}
_Check_Player() {
  if (IgnorePlayer) {
    return
  }
  ImageSearch,playerX,playerY, 5, 35, 200, 220, *1 player.png
  if(playerX) {
     SoundPlay %A_ScriptDir%\Sounds\player.wav   
  }
  return
}
_Check_Guildie() {
  if (IgnoreGuildie) {
    return
  }
  ImageSearch,guildieX,guildieY,1,1,1920,1080, *1 guildie.png
  if(guildieX) {
     SoundPlay %A_ScriptDir%\Sounds\guildie.mp3   
  }
  return
}
_Check_Friend() {
  if (IgnoreFriend){
    return
  }
  ImageSearch,friendX,friendY,1,1,1920,1080, *1 friend.png
  if(friendX) {
     SoundPlay %A_ScriptDir%\Sounds\friend.mp3   
  }
  return
}
_Check_Eboss() {
  if(IgnoreEboss) { 
    Return
  }
  ImageSearch, ebossX, ebossY,1,1,1920,1080, *1 ebClock.png
  if(ebossX) {
    SoundPlay, %A_ScriptDir%\Sounds\eboss.mp3
  }
  return
}
_Check_LD() {
  ImageSearch, LDokX, LDokY,1,1,1920,1080, *1 LDok.png ;unsure if either of these will be detected so using 2 options isntead of 1
  ImageSearch, LDbombX, LDbombY,1,1,1920,1080, *1 LDbomb.png
  if(LDokX || LDbombX) {
    SoundPlay, %A_ScriptDir%\Sounds\LD.mp3
  }
  return
}
; Managing Bot State
Pause_Bot() {
  Loop, 0xFF
  {
    Key := Format("VK{:02X}",A_Index)
    IF GetKeyState(Key)
      Send, {%Key% Up}
  }
  Pause ,,1
  if A_IsPaused
  {
    guicontrol, , BotState, Status: Paused
  }
  else {
    winactivate, ahk_class MapleStoryClass
    guicontrol, , BotState, Status: Resumed
  }
}
Reload_Bot() {
  Reload
  guicontrol, , BotState, Status: None
}
return

guiclose:
  ExitApp
return
; GUI Button Functions
Start1:
  winactivate, ahk_class MapleStoryClass
  atk()
return
Pause1:
  Pause_Bot()
return
Reload1:
  Reload_Bot()
return
Remind_Check:
  SoundPlay, %A_ScriptDir%\Sounds\twitter.mp3
return
Full_Check() {
  ; if (IgnoreAll) {
  ;   _Check_LD()
  ;   ; guicontrol, , Rune, Rune: Chat Mode
  ;   ; guicontrol, , Player, Player: Chat Mode
  ;   ; guicontrol, , Guildie, Guildie: Chat Mode
  ;   ; guicontrol, , Friend, Friend: Chat Mode
  ;   return
  ; }
  ;_Check_Guildie()
  ;_Check_Friend()
  _Check_Player()
  ;_Check_Rune()
  ;_Check_Eboss()
  _Check_LD()
}
return
; SET Hotkeys
F7::
atk(){
  winactivate, ahk_class MapleStoryClass
  guicontrol, , BotState, Status: Running
  ;Settimer, Remind_Check, 60000 
  Loop {
    Full_Check()
    ;_Check_LD()
    sleep % CheckInterval
  }
  return
}