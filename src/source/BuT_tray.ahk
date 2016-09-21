; -*- encoding: utf-8 -*-

TrayAktivieren() {
  global
  menu,tray,icon,%ResourceFolder%\BuT_enabled.ico,,1
  menu,tray,nostandard
  menu,tray,add,Öffnen,open
    menu,helpmenu,add,About,about
    menu,helpmenu,add,Autohotkey-Hilfe,help
    menu,helpmenu,add
    menu,helpmenu,add,http://autohotkey.com/,autohotkey
    menu,helpmenu,add,http://ragnar-f.github.io/docs/AutoHotkey.htm,autohotkeydeutsch
    menu,helpmenu,add,http://www.adnw.de/,ausderneowelt
    menu,helpmenu,add,http://www.neo-layout.org/,neo
  menu,tray,add,Hilfe,:helpmenu
  menu,tray,add
  menu,tray,add,%disable%,togglesuspend
  menu,tray,add
  menu,tray,add,Bearbeiten,edit
  menu,tray,add,Custom 30 Layout eingeben/ändern,custom30edit
  menu,tray,add,Custom Layout eingeben/ändern,customedit 
  menu,tray,add,Bildschirmtastatur [M3+F1],Screen
  menu,tray,add,Neu Laden [M3+ESC],reload
  menu,tray,add
  menu,tray,add,Nicht im Systray anzeigen,hide
  menu,tray,add,%name% beenden, exitprogram
  menu,tray,default,%disable%
  menu,tray,tip,%name%
  return

help:
  Run, %A_WinDir%\hh mk:@MSITStore:autohotkey.chm
return

togglesuspend:
  Traytogglesuspend()
return

about:
  TrayAbout()
return

neo:
  run http://neo-layout.org/
return

ausderneowelt:
  run http://www.adnw.de/
return

autohotkey:
  run http://autohotkey.com/
return

autohotkeydeutsch:
  run http://ragnar-f.github.io/docs/AutoHotkey.htm
return

open:
  ListLines    ; shows the Autohotkey window
  ListHotkeys
  ListVars
  KeyHistory
return

edit:
  edit
return

Screen:
  CharProc__BST1()
return

Customedit:
  IniRead,customlayout,%ini%,Global,customlayout,0
  nch := 5
  CustomInput()
return

Custom30edit:
  IniRead,custom30layout,%ini%,Global,custom30layout,0
  nch := 8
    Custom30Input()
return

Nch:
  GuiControlGet, nch
  if (nch < 8) && (nch != 5) {
  NordtastInput()
  return
 }
  else if (nch = 8) {
  IniRead,custom30layout,%ini%,Global,custom30layout,0
  custom30Input()
  return
 }
 else if (nch = 5) {
  IniRead,customlayout,%ini%,Global,customlayout,0
  CustomInput()
  return
 }

chlang:
  GuiControlGet, islang  
  Changelang(islang,oldlang)
return

reload:
  Reload
return

hide:
  menu, tray, noicon
return

exitprogram:
  SetOldLockStates()
  exitapp
return

}

Traytogglesuspend() {
  global
  if A_IsSuspended {
    menu, tray, rename, %enable%, %disable%
    menu, tray, tip, %name%
    menu, tray, icon, %ResourceFolder%\BuT_enabled.ico,,1
    SetNEOLockStates()
    suspend, off ; Schaltet Suspend aus -> NEO
  } else {
    menu, tray, rename, %disable%, %enable%
    menu, tray, tip, %name% : Deaktiviert
    menu, tray, icon, %ResourceFolder%\BuT_disabled.ico,,1
    SetOldLockStates()
    suspend, on  ; Schaltet Suspend ein -> QWERTZ
  }
}

TrayAbout() {
  global
  msgbox, 64, %name%  Ergonomische Tastaturbelegung, 
  (
  %name% 
  `nDas Neo-Layout ersetzt das übliche deutsche 
  Tastaturlayout mit der Alternative Neo, 
  beschrieben auf http://neo-layout.org/. 
  `nDazu sind keine Administratorrechte nötig. 
  `nWenn Autohotkey aktiviert ist, werden alle Tastendrücke 
  abgefangen und statt dessen eine Übersetzung weitergeschickt. 
  `nDies geschieht transparent für den Anwender, 
  es muss nichts installiert werden. 
  `nDie Zeichenübersetzung kann leicht über das Icon im 
  Systemtray deaktiviert werden.
  `nInformationen zu AdNW, BuTeck, KOY: http://www.adnw.de `n
  )
}

TrayAktivieren()
