#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%\Assets
FileCreateDir,%A_ScriptDir%\Assets
FileInstall,me.png,%A_ScriptDir%\Assets\me.png,1
#SingleInstance, force
#InstallKeybdHook
#MaxThreadsPerHotkey 2
winactivate, ahk_class MapleStoryClass
starttime1 := A_Now
FormatTime, Starttime1, HHMMSS , Time
gui, +Alwaysontop
gui, color, e8ebe7
gui, show,x500 y800 w215 h225,
gui, font, s14
gui, add, text, x120 y1, = F4
gui, add, button, w100 h24 x10 y1 gReload1, Reload
gui, add, text, x120 y26, = F7
gui, add, button, w100 h24 x10 y26 gStart1, Start
gui, add, text, x120 y51, = F8
gui, add, button, w100 h24 x10 y51 gPause1, Pause
gui, add, text, w40 x15 y75 vCX,
gui, add, text, w40 x60 y75 vCY,
; variables for development
; gui, add, text, w40 x15 y140, REDTHING:
; gui, add, text, w40 x120 y140 vREDTHING,

; gui, add, text, w40 x15 y160, FMA4(4):
; gui, add, text, w40 x120 y160 vFMA,

gui, add, text, w200 x15 y180, MAP: PHANTOM FOREST

return
guiclose:
ExitApp
return
Start1:
  winactivate, ahk_class MapleStoryClass
  atk()
return
Pause1:
  Loop, 0xFF
  {
    Key := Format("VK{:02X}",A_Index)
    IF GetKeyState(Key)
      Send, {%Key% Up}
  }
  Pause ,,1
  if A_IsPaused
  {
    TrayTip, `t, BOT HAS PAUSED
  }else {
    winactivate, ahk_class MapleStoryClass
    TrayTip, `t, BOT HAS RESUMED
  }
return
Reload1:
  Reload
return
F4::
  Reload
return
F8::
  Loop, 0xFF
  {
    Key := Format("VK{:02X}",A_Index)
    IF GetKeyState(Key)
      Send, {%Key% Up}
  }
  Pause ,,1
  if A_IsPaused
  {
    TrayTip, `t, BOT HAS PAUSED
  }else {
    winactivate, ahk_class MapleStoryClass
    TrayTip, `t, BOT HAS RESUMED
  }
return
F7::
  atk(){
    winactivate, ahk_class MapleStoryClass
    LeftX := 81
    RightX := 144
    totem := 0
    loop{

        sleep 1000

        if (totem = 0) {
            loop 3{
                SendInput, {6}
                sleep 500
                totem = 20

            }
        }

        i := 0
        sendinput {left down}
        sleep 70

        while (i < 40) {
            sendinput {v}
            sleep 100
            i++            
        }

        totem--
        sleep 300
        SendInput, {left up}
        sleep 500

        i := 0
        SendInput, {right down}
        sleep 70

        while (i < 40) {
            sendinput {v}
            sleep 100
            i++
        }

        totem--
        sleep 300
        SendInput, {right up}
        sleep 500

        if (totem < 2) {
            totem = 0
        }

    }
  }

