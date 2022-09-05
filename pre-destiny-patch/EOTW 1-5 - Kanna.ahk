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

gui, add, text, w200 x15 y180, MAP: EOTW 2-5 kanna

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
    ;totem := 1
    loop{

      sendinput, {b} ; Big red thing 
      sleep 100
      sendinput, {PgUp} ; totem
      sleep 200

      sendinput, {right down}
      sleep 30
      sendinput, {s} ;teleport
      sleep 30
      sendinput, {s} 
      sleep 30
      sendinput, {s} 
      sleep 30

      loop {
        ImageSearch, vX, vY, 1, 1, 1920, 1080, *1 me.png
        GuiControl, , CX, %vX%
        GuiControl, , CY, %vY%

        if (vX < 144) {
          sendinput, {right down}
        }

        else {
          break
        }
      }
      sendinput, {right up} ;stop walking right

      ;tele up at the right
      sendinput, {up down} 
      sleep 30 ;adjust ??
      sendinput, {s} 
      sleep 30
      sendinput, {up up}
      sleep 30 
      sendinput, {left down}
      sleep 30
      sendinput, {left up}

      ;attacking loop

      Loop 13 {
        ;attack first platform
        sendinput, {d}
        sleep 50
        sendinput, {d}
        sleep 50
        sendinput, {d}
        sleep 100
        ;go up 1 platform
        sendinput {up down}
        sleep 30
        sendinput {s}
        sleep 30
        sendinput {up up}
        ;attack top
        sendinput, {d}
        sleep 50
        sendinput, {d}
        sleep 50
        sendinput, {d}
        sleep 100
        ;go back down
        sendinput {down down}
        sleep 30
        sendinput {s}
        sleep 30
        sendinput {down up}

      }
      
      ;go back to start position
      sleep 200
      sendinput {down down}
      sleep 30
      sendinput {s}
      sleep 30
      sendinput {down up}

      sendinput, {left down}
      sleep 30
      sendinput, {s} ;teleport
      sleep 30
      sendinput, {s} 
      sleep 30
      sendinput, {s} 
      sleep 30

      ;might need to search for vX < 81 as well but we'll see

      loop {
        ImageSearch, vX, vY, 1, 1, 1920, 1080, *1 me.png
        GuiControl, , CX, %vX%
        GuiControl, , CY, %vY%

        if (vX > 81) {
          sendinput, {right down}
        }

        else {
          break
        }
      }
      sendinput, {left up} ;stop walking right
    }
    return
  }
