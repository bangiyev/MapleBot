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
gui, color, ADD8E6
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
gui, add, text, w40 x15 y140, SPIDER(4):
gui, add, text, w40 x120 y140 vSPIDER,

gui, add, text, w40 x15 y160, FMA4(4):
gui, add, text, w40 x120 y160 vFMA,

gui, add, text, w200 x15 y180, MAP: WSD 1/2

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
    LeftX := 70
    RightX := 205
    spider := 4 
    sword := 2
    fma := 2
    totem := 1
    loop{
      if (totem = 1) {
        loop, 5 {
          sendinput, {6} ; TOTEM ON
          sleep 100
        }
        totem := totem + 1
      }
      sleep 200
      if (sword = 2){
        loop, 5 {
          sendinput, {PgDn}
          sleep 100
        }
        sleep 1000 
      }
      loop, 5 {
        sendinput, {o} ; weapon aura or remove? 
        sleep 100
      }
      sleep 500
      loop {
        ImageSearch,vX,vY,1,1,1920,1080, *1 me.png
        guicontrol, , CX, %vX%
        guicontrol, , CY, %vY%
        if (vY < 131) {
          sendinput, {down down}
          sleep 150
          sendinput, {alt}
          sleep 300
        } 
        else {
          break
        }
      }
        sendinput, {down up}
        loop 4 {
          Loop {
            Sendinput, {Left down}
            sleep 30
            sendinput, {Alt}
            sleep 75
            sendinput, {Alt}
            sleep 75
            sendinput, {Alt}
            sleep 75
            sendinput, {Space}
          
            sleep 600
            ImageSearch,vX,vY,1,1,1920,1080, *1 me.png
            guicontrol, , CX, %vX%
            guicontrol, , CY, %vY%
            if vX <%LeftX%
              Break
          }
          Sendinput, {Left up}
          loop {
            ImageSearch,vX,vY,1,1,1920,1080, *1 me.png
            guicontrol, , CX, %vX%
            guicontrol, , CY, %vY%
            if (vY < 131) {
              sendinput, {down down}
              sleep 150
              sendinput, {Alt}
              sleep 300
            } else {
              break
            }
          }
          sendinput, {down up}
					; 50% chance to cast Rising Rage on the left
					Random,castSpell,1,3
					if (castSpell == 1) {
						sendinput, {Alt}
						sleep 75
						sendinput, {Alt}
						sleep 75
						sendinput, {Alt}
						sleep 75
						sendinput, {b}
						sleep 600
					}
          if (spider = 4){
            sleep 1000
            loop 5 {
              SendInput, {t} ;Will skill
              sleep 100
            }
            spider := 0
          }
          if (totem = 3){ ; need to check how totem gets to 3
            loop, 5 {
              sendinput, {6} ; respawn totem
              sleep 100
            }
            totem := 0
          }
            if (fma = 2){
              loop, 2{
                sendinput, {Del}
                sleep 100
              }
              fma := 0
            }
            Loop {
              Sendinput, {Right down}
              sleep 30
              sendinput, {Alt}
              sleep 75
              sendinput, {Alt}
              sleep 75
              sendinput, {Alt}
              sleep 75
              sendinput, {Space}
              sleep 600
              ImageSearch,vX,vY,1,1,1920,1080, *1 me.png
              guicontrol, , CX, %vX%
              guicontrol, , CY, %vY%
              if vX> %RightX%
                Break
            }
            Sendinput, {Right up}
            sleep 50
            loop {
              ImageSearch,vX,vY,1,1,1920,1080, *1 me.png
              guicontrol, , CX, %vX%
              guicontrol, , CY, %vY%
              if (vY < 131) {
                sendinput, {down down}
                sleep 150
                sendinput, {Alt}
                sleep 300
              } else {
                break
              }
            }
            sendinput, {down up}
          }
          loop {
            ImageSearch,vX,vY,1,1,1920,1080, *1 me.png
            guicontrol, , CX, %vX%
            guicontrol, , CY, %vY%
            if (vY > 114) { 
              ;  other plat is 113
              Loop {
                Sendinput, {Left down}
                sleep 50
                ImageSearch,vX,vY,1,1,1920,1080, *1 me.png
                guicontrol, , CX, %vX%
                guicontrol, , CY, %vY%
                if vX < 200
                  Break
              }
              SendInput, {x} ;upjump
              sleep 400
              SendInput, {Del}
              sleep 500
              SendInput, {c}
              sleep 100

            } 
            else {
              break
            }
          }
          sleep 750
          totem := totem + 1
          spider := spider + 1
          fma := fma + 1
          guicontrol, , SPIDER, %spider%
          guicontrol, , FMA, %fma%
        }
        return
      }