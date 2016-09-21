 ; -*- encoding: utf-8 -*-
 ; (ɔ) 2015 Wolf Belschner

CustomInput() {
global
   Inputbox, customlayout, Custom Layout editieren:,Es müssen die 33 Standardzeichen der deutschen Tastatur in Kleinbuchstaben angegeben werden also a–z ä ö ü ß Punkt Komma und Bindestrich. Das erste Zeichen entspricht dem ß auf QWERTZ. Dann von links nach rechts: `nObere Zeile - Grundlinie - untere Zeile.`nKein 30key Layout! `nBeispiel Qwertz: ßäqwertzuiopüasdfghjklöyxcvbnm`,`.-, ,330,260,,,,,%customLayout%
  if errorlevel = 1 
return
  else
  newlayoutstring := customlayout
  IniWrite,%Nch%,%ini%,Global,isLayout
  IniWrite,%customlayout%,%ini%,Global,customlayout
  InitializeButtons()
  30keys := 0
  Change1256Layout(newlayoutstring)
  CharProc__BST1()
  useBST := 1
}

Custom30Input() {
global
   Inputbox, custom30layout, Custom 30 Tasten Layout editieren:,Es müssen 33 Standardzeichen der deutschen Tastatur in Kleinbuchstaben angegeben werden also a–z Punkt Komma Bindestrich Apostroph usw. ohne Umlaute und ß. Das erste Zeichen entspricht dem ß auf QWERTZ. Dann von links nach rechts: `nObere Zeile - Grundlinie - untere Zeile. `nAls Platzhalter für Diakritikataste ein "ö" eingeben.`nNur 30key Layout!`nBeispiel PUQ30: -»puö`,`qgclmf«hieaodtrnsky.’xjvwbz, ,330,260,,,,,%custom30Layout%
  if errorlevel = 1
return
  else
  newlayoutstring := custom30layout
  IniWrite,%Nch%,%ini%,Global,isLayout
  IniWrite,%custom30layout%,%ini%,Global,custom30layout
  InitializeButtons()
  30keys := 1
  Change1256Layout(newlayoutstring)
  CharProc__BST1()
  useBST := 1
}

NordtastInput() {
global
  IniWrite,%Nch%,%ini%,Global,isLayout
  InitializeButtons()
  if (Islayout <= 5) 
   30keys := 0
  else 
    30keys := 1
  ActivateNordTast()
  CharProc__BST1()
  useBST := 1
 } 
 
InitializeButtons() {
  global
  IniRead,islayout,%ini%,Global,isLayout,0
  if (Islayout > 0)
    nch := IsLayout
  IniWrite,%nch%,%ini%,Global,IsLayout
}

InitializeLanguage() {
global
 IniRead,IsLang,%ini%,Global,IsLang,%A_Space% 
     if (IsLang == "error") 
  or if (IsLang = "") {                        
      nlang := 1
      IsLang := "DE"
     IniWrite,%IsLang%,%ini%,Global,IsLang
     IniRead,IsLang,%ini%,Global,IsLang,%A_Space%         ; get diacritica language
  } else (Lang := %Islang%) 
}

 ChangeLang(islang,oldlang) {
  global
  if (IsLang != oldlang)
    IniWrite,%IsLang%,%ini%,Global,IsLang
    IniRead,IsLang,%ini%,Global,IsLang,%A_Space%
}