#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%\Assets
FileCreateDir,%A_ScriptDir%\Assets
FileInstall,me.png,%A_ScriptDir%\Assets\me.png,1
FileInstall,illusion.png,%A_ScriptDir%\Assets\illusion.png,1
FileInstall,reaver.png,%A_ScriptDir%\Assets\reaver.png,1
FileInstall,spider.png,%A_ScriptDir%\Assets\spider.png,1
FileInstall,aura.png,%A_ScriptDir%\Assets\aura.png,1
FileInstall,rising.png,%A_ScriptDir%\Assets\rising.png,1
#SingleInstance, force
#InstallKeybdHook
#MaxThreadsPerHotkey 2
winactivate, ahk_class MapleStoryClass
starttime1 := A_Now
FormatTime, Starttime1, HHMMSS , Time
gui, +Alwaysontop
gui, color, e8ebe7
gui, show,x1500 y120 w175 h100,
gui, font, s10
gui, add, text, x120 y6, = F4
gui, add, button, w100 h24 x10 y1 gReload1, Reload
gui, add, text, x120 y31, = F7
gui, add, button, w100 h24 x10 y26 gStart1, Start
gui, add, text, x120 y56, = F8
gui, add, button, w100 h24 x10 y51 gPause1, Pause
gui, add, text, w40 x15 y86 vCX,
gui, add, text, w40 x60 y86 vCY,
;gui, Add, DropDownList, x1  vMapChoice, EOTW 1-5||WSD 1

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

SeekRune() {
  ImageSearch, runeX, runeY, 1, 1, 1920, 1080, *1 CornerRune.png
  if (runeX) {
    SoundPlay %A_ScriptDir%\Sounds\rune.wav
  }
  Return
}
SeekPlayer() {
  ImageSearch,playerX,playerY,1,1,1920,1080, *1 player.png
  if(playerX) {
     SoundPlay %A_ScriptDir%\Sounds\player.wav   
  }
  return
}
WeaponAura() {
  ImageSearch,auraX,auraY,800,720,1360,790, *100 aura.png
  if(auraX) {
    loop, 3 {
      sendinput, {\}
      sleep 100
    }
    sleep 500        
  }
  return
}
RisingRage() {
  ImageSearch,risingX,risingY,800,720,1360,790, *100 rising.png
  if (risingX) {
    loop, 1 {
      sendinput, {b}
      sleep 100
    }
    sleep 600
  }
  return
}
Worldreaver() {
  ImageSearch,reaverX,reaverY,800,720,1360,790, *100 reaver.png
  if (reaverX) {
    loop, 1 {
      SendInput, {del}
      sleep 100
    }
    sleep 500
  }
  return
}
SwordIllusion(){
  ImageSearch, illusionX, illusionY, 800,720,1360,790, *100 illusion.png
  if (illusionX) {
    loop, 1 {
      SendInput, {c}
      sleep 100
    }
    sleep 1000
  }
  return
}
spider() {
  ImageSearch, spiderX, spiderY, 800,720,1360,790, *100 spider.png
  if (spiderX) {
    loop, 1 {
      SendInput, {t}
      sleep 100
    }
    sleep 500
  }
  return
}


F7::
  atk(){
    winactivate, ahk_class MapleStoryClass
    LeftX := 65
    RightX := 116
    spider := 8 
    sword := 2
    worldreaver := 3
    totem := 1
    risingrage := 0
    loop{
      sleep 1000
      if (totem = 1) {
        loop, 5 {
          sendinput, {6} 
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

      WeaponAura()

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
        sleep 500

        if (totem = 3){
          loop, 5 {
            sendinput, {6}
            sleep 100
          }
          totem := 0
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
        sleep 300 
        RisingRage()

        ; upjump at the right

        sendinput, {x}
        sleep 75
        sendinput, {left down}
        sleep 75
        sendinput, {left up}
        sleep 500 

        SwordIllusion()
        Worldreaver()
        sleep 2000
        spider()

        ;jump down
        sleep 100
        sendinput {down down}
        sleep 100
        sendinput {Alt}
        sleep 100
        sendinput {down up}
        sleep 100

      }

      sleep 750
      ;increments and gui controls
      totem := totem + 1
    }

    return

  }
