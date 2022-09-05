﻿#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%\Assets
FileCreateDir,%A_ScriptDir%\Assets
FileInstall,me.png,%A_ScriptDir%\Assets\me.png,1
FileInstall,mana.png,%A_ScriptDir%\Assets\mana.png,1
FileInstall,stance.png,%A_ScriptDir%\Assets\stance.png,1
FileInstall,combo.png,%A_ScriptDir%\Assets\combo.png,1
FileInstall,booster.png,%A_ScriptDir%\Assets\booster.png,1
FileInstall,mw.png,%A_ScriptDir%\Assets\mw.png,1 ;; maple warrior
#SingleInstance, force
#InstallKeybdHook
#MaxThreadsPerHotkey 2
winactivate, ahk_class MapleStoryClass
starttime1 := A_Now
FormatTime, Starttime1, HHMMSS , Time
; LeftX := 60
; RightX := 120
gui, +Alwaysontop
gui, color, e8ebe7
gui, show,x1500 y150 w175 h120, ;y120
gui, font, s10
gui, add, text, x120 y6, = F4
gui, add, button, w100 h24 x10 y1 gReload1, Reload
gui, add, text, x120 y31, = F7
gui, add, button, w100 h24 x10 y26 gStart1, Start
gui, add, text, x120 y56, = F8
gui, add, button, w100 h24 x10 y51 gPause1, Pause
gui, add, text, x120 y81, = F6
gui, add, button, w100 h24 x10 y76 gClick1, Sell
gui, add, text, w40 x15 y110 vCX,
gui, add, text, w40 x60 y110 vCY,
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
Click1:
    SellInventory()
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

F6::
    SellInventory()
return

SellInventory(){
    Loop 80 {
        Click
        sleep 200
        SendInput, {enter}
        sleep 200
    }
    return
}

CheckPosition(Lval, Rval) {
    ImageSearch, meX, meY, 5, 35, 200, 220, *1 me.png
    guicontrol, , CX, %meX%
    guicontrol, , CY, %meY%
    Lval2 := Lval
    Rval2 := Rval
    if (meX > Rval) {
        AdjustToLeft(Lval2, Rval2)
    }
    else if (meX < Lval) {
        AdjustToRight(Lval2, Rval2)
    }
    else return
Return
}
AdjustToLeft(Lval2, Rval2) {
    Loop {
        SendInput, {Left down}
        sleep 200
        SendInput, {v} ;;rush
        sleep 600
        ; SendInput, {v}
        ; sleep 600
        SendInput, {Left up}
        sleep 100
        ImageSearch, meX, meY, 5, 35, 200, 220, *1 me.png
        if (meX < Rval2) {
            break
        }
    }
return
}
AdjustToRight(Lval2, Rval2) {
    Loop {
        SendInput, {c}
        sleep 650
        SendInput, {Right down}
        sleep 200
        SendInput, {v} ;; rush
        sleep 700
        SendInput, {v}
        sleep 700
        ; SendInput, {v}
        ; sleep 600
        SendInput, {Right up}
        sleep 100
        ImageSearch, meX, meY, 5, 35, 200, 220, *1 me.png
        if (meX > Lval2) {
            break
        }
    }
return
}
checkMana() {
    ImageSearch,manaX,manaY,390,760,560,795, *100 mana.png
    if(manaX) {
        loop, 1 {
            sendinput, {s} ;; potion
            sleep 100
        }
        sleep 500 
    }
return
}
checkHP() {
    ImageSearch,hpX,hpY,240,760,400,795, *100 hp.png
    if (hpX) {
        loop, 1 {
            sendinput, {s} ;;potion
            sleep 100
        }
        sleep 600
    }
return
}
stance() {
    ImageSearch,stanceX, stanceY,940,40,1360,115, *50 stance.png
    if (stanceX) {
        loop, 3 { 
            SendInput, {x} ;;stance
            sleep 300
        }
        sleep 600
    }
return
}
mapleWarrior() {
    ImageSearch,mwX, mwY,940,40,1360,115, *50 mw.png
    if (mwX) {
        loop, 3 { 
            SendInput, {f} ;; maple warrior
            sleep 300
        }
        sleep 600
    }
return
}
combo(){
    ImageSearch, comboX, comboY,940,40,1360,115, *100 combo.png
    if (comboX) { ;;if combo skill is there, do nothing
        return
    }
    else{  ;;if combo skill is not there, activate it
        loop, 5 {
            SendInput, {o} ;;combo
            sleep 300
        }
        sleep 1000
    }
Return
}

booster() {
    ImageSearch, boosterX, boosterY,940,40,1360,115, *50 booster.png
    if (boosterX) {
        loop, 5 {
            SendInput, {a} ;;booster + PG macro
            sleep 300
        }
        sleep 2000
    }
return
}

F7::
    atk(){
        winactivate, ahk_class MapleStoryClass
        LeftX := 95
        RightX := 145

        ;buff at the beginning 
            sleep 1000
            SendInput, {a} ;; booster + PG macro
            sleep 2000
            Sendinput, {o} ;; combo orbs
            sleep 1000
            SendInput, {x} ;; stance
            sleep 700
            buffed = true


        loop{
            

            Loop 4 {
                Loop 80 {
                    Sendinput, {space} ;;3x soul driver macro
                    sleep 50
                }
               ; CheckPosition(LeftX, RightX)
                sleep 500
                SendInput, {c}
                sleep 750
                SendInput, {v}
                sleep 650
                SendInput, {c}
                sleep 500 
                booster() 
                combo()
                stance()
                mapleWarrior()
                CheckPosition(LeftX, RightX)

            }
            Loop 70 {
                    Sendinput, {space} ;;3x soul driver macro
                    sleep 50
                }
            sleep 500
            SendInput, {right down}
            sleep 400
            SendInput, {right up}
            sleep 400
            SendInput, {c}
            sleep 750
            SendInput, {v}
            sleep 650
            SendInput, {c}
            sleep 500

            Loop 4 {
                Loop 80 {
                    Sendinput, {space} ;;3x soul driver macro
                    sleep 50
                }
               ; CheckPosition(LeftX, RightX)
                sleep 500
                SendInput, {c}
                sleep 750
                SendInput, {v}
                sleep 650
                SendInput, {c}
                sleep 500 
                booster() 
                combo()
                stance()
                mapleWarrior()
                CheckPosition(LeftX, RightX)

            }
            Loop 70 {
                    Sendinput, {space} ;;3x soul driver macro
                    sleep 50
                }
            sleep 500
            SendInput, {left down}
            sleep 300
            SendInput, {left up}
            sleep 400
            SendInput, {c}
            sleep 750
            SendInput, {v}
            sleep 650
            SendInput, {c}
            sleep 500

        }

        return

    }
