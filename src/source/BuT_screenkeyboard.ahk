; -*- encoding:utf-8 -*-


BSTalwaysOnTop := 1

UnZipSFXSourceLink := "ftp://ftp.info-zip.org/pub/infozip/win32/unz600xn.exe"
UnZipSFXLocalFile  := ResourceFolder . "\unzipsfx.exe"

UnZipLocalFile := ResourceFolder . "\unzip.exe"

UniFontVersion  := "2.33"
UniFontFilename := "DejaVuSans-Bold.ttf"
UniFontName     := "DejaVu Sans"

UniFontZipFilename   := "dejavu-fonts-ttf-" . UniFontVersion . ".zip"
UniFontZipLocalFile  := ResourceFolder . "\" . UniFontZipFilename

UniFontZipSourceLink := "http://downloads.sourceforge.net/project/dejavu/dejavu/" . UniFontVersion . "/" . UniFontZipFilename

UniFontLocalFilePath := ApplicationFolder
UniFontLocalFile := UniFontLocalFilePath . "/" . UniFontFilename
UniFontZipFontPath := "dejavu-fonts-ttf-" . UniFontVersion . "/ttf/" . UniFontFilename

Check_BSTUpdate(DoBSTUpdate = 0) {
  global
  if (useDBST) {
    if (!useBST and ((Comp != "") or (EbeneC == 5) or (EbeneC == 6))) {
      useBST := 1
      BSTLastComp := ""
      CharProc__BST1()
    } else if (useBST and ((Comp == "") and (EbeneC != 5) and (EbeneC != 6))) {
      useBST := 0
      BSTLastComp := ""
      CharProc__BST0()
    }
  }
  if (useBST 
      and (DoBSTUpdate
           or (Comp != BSTLastComp)
           or (EbeneC != BSTLastEbeneC)
           or (EbeneNC != BSTLastEbeneNC)))
    BSTUpdate()
}

BSTUpdate() {
    global
    static WM_SETTEXT := 0x0C
    {
      BSTLastComp := Comp
      BSTLastEbeneC := EbeneC
      BSTLastEbeneNC := EbeneNC
      VarSetCapacity(ptrU,20)
      loop,parse,GuiKeyList,`,
      {
        GuiPhysKey := A_LoopField
        if (EbeneC<3) {
          if (NOC%GuiPhysKey%==1) {
            GuiEb := EbeneNC
          } else {
        GuiEb := EbeneC
          }
        } else
          GuiEb := EbeneC
        if (TransformBSTProc != "")
          GuiVirtKey := TransformBST%TransformBSTProc%(GuiPhysKey)
        else
          GuiVirtKey := GuiPhysKey
    CurrentComp := Comp
        GuiComp := ""
rerun_bstnupdate:
        GuiComp1 := CurrentComp . CP%GuiEb%%GuiVirtKey%
        if (GSYM%GuiComp1% != "") {
          GuiComp .= GSYM%GuiComp1%
        } else if (CD%GuiComp1% != "") {
      G_Sym    := CD%GuiComp1%
          if (GSYM%G_Sym% != "") 
            GuiComp .= GSYM%G_sym%
          else
            GuiComp .= CD%GuiComp1%
        } else if (CM%GuiComp1% == 1) {
          GuiComp .= "U00002AU00002A"
        } else if (CF%CurrentComp% != "") {
      if (IM%GuiVirtKey% != 1)
            GuiComp .= CF%CurrentComp%
      CurrentComp := ""
          goto rerun_bstnupdate
        } else if (CurrentComp == "") {
          GuiComp .= GuiComp1
        }
    GuiPos := 0
        loop {
          if (GuiComp=="")
            break
      if (SubStr(GuiComp,1,1)=="U") {
            Charcode := "0x" . Substr(GuiComp,2,6)
          if (charCode < 0x10000) {
            if (charCode == 0x26) {
          ; double any Ampersand (&) to avoid being replaced with
          ; underscore (Windows Shortcut Key terminology)
          NumPut(CharCode, ptrU, GuiPos, "UShort")
          GuiPos := GuiPos + 2
        }
        NumPut(CharCode, ptrU, GuiPos, "UShort")
              } else {
                ; surrogates
                NumPut(0xD800|((charCode-0x10000)/1024) , ptrU, GuiPos, "UShort")
        GuiPos := GuiPos + 2
                NumPut(0xDC00|((charCode-0x10000)&0x3FF), ptrU, GuiPos, "UShort")
              }
            GuiPos := GuiPos + 2
      }
          GuiComp := SubStr(GuiComp,8)
        }
        NumPut(0x0   ,ptrU,GuiPos,"UShort") ; End of string 
        DllCall("SendMessageW", "UInt",GuiKey%GuiPhysKey%, "UInt",WM_SETTEXT, "UInt",0, "Uint",&ptrU)
      }
    }
    if (30keys == 0)
      GuiControl,MoveDraw,Picture0
    else 
      GuiControl,MoveDraw,Picture1
}

GuiAddKeyS(sc,x,y) {
  global
  GuiAddKey(vksc%sc%,x,y)
}

GuiAddKeySM(sc,x,y) {
  global
  vksc := vksc%sc%
  IM%vksc% := 1
  GuiAddKey(vksc,x,y)
}

GuiAddKeySN(sc,x,y) {
  global
  GuiAddKey(vkscn1%sc%,x,y)
}

GuiAddKey(key,x,y) {
  global
  x:=x-4
  y:=y-10
  GuiPosx%key% := x
  GuiPosy%key% := y
  Gui, Add, Text, x%x% y%y% w38 h38 Center 0x200 vGuiKey%key% hwndGuiKey%key% BackgroundTrans
  GuiKeyList := GuiKeyList . key . ","
}

CharProc__BSTt() {
  global                                                ; Bildschirmtastatur togglen
  useBST := !(useBST)
  if (useBST)
    CharProc__BST1()
  else
    CharProc__BST0()
}

CharProc_DBSTt() {
  global
  useDBST := !(useDBST)
  if (useDBST) {
    if (zeigeModusBox)
      TrayTip,Dynamische Bildschirmtastatur,Die dynamische Bildschirmtastatur wurde deaktiviert.,10,1
  } else {
    if (zeigeModusBox)
      TrayTip,Dynamische Bildschirmtastatur,Die dynamische Bildschirmtastatur wurde aktiviert. Zum Deaktivieren`, Mod3+F3 drücken.,10,1
  }
}

BSTOnClose() {
  global
  useBST := 0
  CharProc__BST0()
}

BSTOnSize() {
  global
  Gui, Show, % "Y" . yposition . " W" . A_GuiWidth . " H" . Round(A_GuiWidth*200/568,0) . " NoActivate", BUTECK • ‏BUTECK-XCV • ADNW • KOY • CUSTOM ••• PUQ30 • OUMF30 • CUSTOM 30
  Gui, Font, % "s" . Round(A_GuiWidth*12/568,0) . " bold", % UniFontName
  loop,parse,GuiKeyList,`,
  {
    GuiPhysKey := A_LoopField
    GuiControl,Font,GuiKey%GuiPhysKey%
    GuiControl,Move,GuiKey%GuiPhysKey%, % "x" . Round(GuiPosx%GuiPhysKey%*A_GuiWidth/568,0) . " y" . Round(GuiPosy%GuiPhysKey%*A_GuiWidth/568,0) . " w" . Round(38*A_GuiWidth/568,0) . " h" . Round(38*A_GuiWidth/568,0)
    
    GuiControl,Move,islang, % "x" . Round(2*A_GuiWidth/568,0) . " y" . Round(2*A_GuiWidth/568,0) . " w" . Round(52*A_GuiWidth/568,0) 
    GuiControl,Move,ok, % "x" . Round(53*A_GuiWidth/568,0) . " y" . Round(2*A_GuiWidth/568,0) . " w" . Round(18*A_GuiWidth/568,0)
    GuiControl,Move,nch, % "x" . Round(2*A_GuiWidth/568,0) . " y" . Round(21*A_GuiWidth/568,0) . " w" . Round(70*A_GuiWidth/568,0)
    GuiControl,Move,%rev%, % "x" . Round(434*A_GuiWidth/568,0) . " y" . Round(187*A_GuiWidth/568,0) . " w" . Round(50*A_GuiWidth/568,0) 
  }

  if (30keys == 0)
    GuiControl,,Picture0, % "*w" . A_GuiWidth . " *h-1 " . ResourceFolder . "\BuX_ebene0.png"
  else
    GuiControl,,Picture1, % "*w" . A_GuiWidth . " *h-1 " . ResourceFolder . "\Bux30_ebene0.png" 
}

CharProc__BST0() {
  global
  GuiCurrent := ""
  Gui, Destroy
  DllCall( "GDI32.DLL\RemoveFontResourceEx", Str, UniFontLocalFile ,UInt,(FR_PRIVATE:=0x10), Int,0)
}

CharProc__BST1() {
  global
  if (GuiCurrent!="")
    %GuiCurrent%OnClose()

  if (FileExist(ResourceFolder)!="") {
     FileInstall,Bux30_ebene0.png,%ResourceFolder%\Bux30_ebene0.png,1
     FileInstall,BuX_ebene0.png,%ResourceFolder%\BuX_ebene0.png,1
  }

  if (FileExist(UniFontLocalFile)=="") {
    if (FileExist(UnZipLocalFile)=="") {
      Progress,0,Herunterladen des gepackten Entpack-Programms ...
      UrlDownloadToFile,%UnZipSFXSourceLink%,%UnZipSFXLocalFile%
      if (FileExist(UnZipSFXLocalFile)=="") {
        Msgbox,Konnte Unzip-Programm nicht finden und nicht installieren!
      } else {
        Progress,25,Entpacken des Entpack-Programms ...
        RunWait,% """" . UnZipSFXLocalFile . """ -d """ . ResourceFolder . """ unzip.exe",,Hide
      }
    }

    if (FileExist(UniFontZipLocalFile)=="") {
      Progress,50,Herunterladen des Fonts ...
      UrlDownloadToFile,%UniFontZipSourceLink%,%UniFontZipLocalFile%
    }

    Progress,75,Entpacken des Archivs ...
    RunWait,% """" . UnZipLocalFile . """ -j """ . UniFontZipLocalFile . """ """ . UniFontZipFontPath . """",%UniFontLocalFilePath%,Hide
    Progress,OFF
  }

  DllCall( "GDI32.DLL\AddFontResourceEx", Str, UniFontLocalFile ,UInt,(FR_PRIVATE:=0x10), Int,0)

  SysGet, WorkArea, MonitorWorkArea
  yPosition := WorkAreaBottom - 230

  Gui, Color, 808080                                                            ;FFFFFF

 if (30keys == 0) 
   Gui, Add, Picture, AltSubmit x0 y0 vPicture0, % ResourceFolder . "\BuX_ebene0.png"
 else 
   Gui, Add, Picture, AltSubmit x0 y0 vPicture1, % ResourceFolder . "\Bux30_ebene0.png"

   Gui, Font, S6  Bold, %UniFontName%
   Gui, Add, DDL, gchlang vislang x2 y2 w50 h198 ,DE|FR|ES|PT|MT|DK|LV|LT|EE|HU|RO|TR|PL|CZ|SK|ESPO|EXOT|
   GuiControl, choose, islang, |%islang% 
 if (30keys == 1) 
   GuiControl, enable, islang
 else 
   GuiControl, disable, islang

  Gui, Add, Button, greload vok +center +default  x53 y2 w19 h19, ×
  Gui, Add, DDL, Altsubmit gNch vNch x2 y21 w70 h198 Choose%Nch%  ,BUTECK|BUT–XCV|ADNW|KOY|CUSTOM|PUQ 30|OUMF 30|CUS’M 30|

  Gui, Font, c000040 s5, %UniFontName%
  Gui, Add, Text, x434 y187 BackgroundTrans,%rev%
  
  Gui, Font, c000040 s12 bold, %UniFontName% 
  GuiKeyList := ""

  GuiAddKeyS("002",76,15)
  GuiAddKeyS("003",112,15)
  GuiAddKeyS("004",147,15)
  GuiAddKeyS("005",183,15)
  GuiAddKeyS("006",219,15)
  GuiAddKeyS("029",269,15)
  GuiAddKeyS("007",318,15)
  GuiAddKeyS("008",353,15)
  GuiAddKeyS("009",389,15)
  GuiAddKeyS("00A",426,15)
  GuiAddKeyS("00B",462,15)
  GuiAddKeyS("00C",497,15)
  GuiAddKeyS("00D",533,15)
  
  GuiAddKey("tab",4,54)
  GuiAddKeyS("028",40,54)
  GuiAddKeyS("010",76,54)
  GuiAddKeyS("011",112,54)
  GuiAddKeyS("012",147,54)
  GuiAddKeyS("013",183,54)
  GuiAddKeyS("014",219,54)
  GuiAddKeyS("015",318,54)
  GuiAddKeyS("016",353,54)
  GuiAddKeyS("017",389,54)
  GuiAddKeyS("018",425,54)
  GuiAddKeyS("019",461,54)
  GuiAddKeyS("01A",497,54)
  GuiAddKeyS("01B",533,54)
  
  GuiAddKey("del",270,54)                           ;Mitte
  GuiAddKey("enter",268,94)
  GuiAddKey("backspace",269,134)
  GuiAddKeySM("136",270,174)

  
  GuiAddKeyS("01E",76,94)
  GuiAddKeyS("01F",111,94)
  GuiAddKeyS("020",147,94)
  GuiAddKeyS("021",183,94)
  GuiAddKeyS("022",219,94)
  GuiAddKeyS("023",318,94)
  GuiAddKeyS("024",353,94)
  GuiAddKeyS("025",389,94)
  GuiAddKeyS("026",426,94)
  GuiAddKeyS("027",462,94)
 
  GuiAddKeySM("02B",532,94)                         ;M3 keys
  GuiAddKeySM("03A",4,94)
  
  GuiAddKeyS("02C",76,134)
  GuiAddKeyS("02D",111,134)
  GuiAddKeyS("02E",147,134)
  GuiAddKeyS("02F",183,134)
  GuiAddKeyS("030",219,134)
  GuiAddKeyS("031",318,134)
  GuiAddKeyS("032",353,134)
  GuiAddKeyS("033",390,134)
  GuiAddKeyS("034",426,134)
  GuiAddKeyS("035",462,134)
  
  GuiAddKeySM("02A",4,174)                          ;M4 untere Reihe Daumen
  GuiAddKeySM("056",148,174)
  GuiAddKey("05C",202,174)
  GuiAddKey("space",337,174)
  GuiAddKeySM("138",390,174)

; GuiAddKeyS("145",588,15)                          ;KP
; GuiAddKeyS("135",624,15)
; GuiAddKeyS("037",660,15)
; GuiAddKeyS("04A",696,15)
;
; GuiAddKeySN("047",588,54)
; GuiAddKeySN("048",624,54)
; GuiAddKeySN("049",660,54)
; 
; GuiAddKeyS("04E",696,74)
;
; GuiAddKeySN("04B",588,94)
; GuiAddKeySN("04C",624,94)
; GuiAddKeySN("04D",660,94)
;
; GuiAddKeySN("04F",588,134)
; GuiAddKeySN("050",624,134)
; GuiAddKeySN("051",660,134)
; 
; GuiAddKey("numpadenter",696,154)
;
; GuiAddKeySN("052",588,174)
; GuiAddKeySN("053",660,174)

  Gui, +AlwaysOnTop +ToolWindow +Resize -MaximizeBox -DPIScale +Caption
  Gui, Show, y%yposition% w568 h199 NoActivate, Neo-Bildschirmtastatur
  BSTUpdate()
  BSTalwaysOnTop := 1
  GuiCurrent := "BST"
}

BSTToggleAlwaysOnTop() {
  global
  if (BSTalwaysOnTop) {
    Gui, -AlwaysOnTop
    BSTalwaysOnTop := 0    
  } else {
    Gui, +AlwaysOnTop
    BSTalwaysOnTop := 1
  }
}

CharProc__BSTA() {
  global
  ; Bildschirmtastatur AlwaysOnTop
  if (useBST or useDBST)
    BSTToggleAlwaysOnTop()
}

GUISYM(sym,chars) {
  global
  GSYM%sym% := EncodeUniComposeA(chars)
}

BSTSymbols() {
  global
  ; diverse Symbole für Spezialzeichen
  GUISYM("T__cflx","◌̂")
  GUISYM("T__cron","◌̌")
  GUISYM("T__turn","↻")
  GUISYM("T__abdt","◌̇")
  GUISYM("T__hook","◌˞") ; not perfect
  GUISYM("T__bldt",".") ; not perfect

  GUISYM("T__grav","◌̀") 
  GUISYM("T__cedi","◌̧")
  GUISYM("T__abrg","◌̊")
  GUISYM("T__drss","◌̈")
  GUISYM("T_dasia","◌῾") ; not perfect
  GUISYM("T__mcrn","◌̄")

  GUISYM("T__acut","◌́")
  GUISYM("T__tlde","◌̃")
  GUISYM("T__strk","◌̷")
  GUISYM("T__dbac","◌̋")
  GUISYM("T_psili","◌᾿") ; not perfect
  GUISYM("T__brve","◌̆")

  GUISYM("T__diak","☠")  ;diacritica key
  GUISYM("S__comp","♫")  ;diacritica key compose

  GUISYM("S__Sh_L","⇧")
  GUISYM("S__Sh_R","⇧")
  GUISYM("S__Caps","⇪")
  GUISYM("S___Del","⌦")
  GUISYM("S___Ins","⎀")
  GUISYM("S____Up","⇡")
  GUISYM("S__Down","⇣")
  GUISYM("S__Rght","⇢")
  GUISYM("S__Left","⇠")
  GUISYM("S__PgUp","⇞")
  GUISYM("S__PgDn","⇟")
  GUISYM("S__Home","↸")
  GUISYM("S___End","⇲")

  GUISYM("S__N__0","0")
  GUISYM("S__N__1","1")
  GUISYM("S__N__2","2")
  GUISYM("S__N__3","3")
  GUISYM("S__N__4","4")
  GUISYM("S__N__5","5")
  GUISYM("S__N__6","6")
  GUISYM("S__N__7","7")
  GUISYM("S__N__8","8")
  GUISYM("S__N__9","9")
  GUISYM("S__NDiv","÷")
  GUISYM("S__NMul","×")
  GUISYM("S__NSub","-")
  GUISYM("S__NAdd","+")
  GUISYM("S__NDot",",")
  GUISYM("S__NEnt","⏎")

  GUISYM("S__NDel","⌦")
  GUISYM("S__NIns","⎀")
  GUISYM("S__N_Up","⇡")
  GUISYM("S__N_Dn","⇣")
  GUISYM("S__N_Ri","⇢")
  GUISYM("S__N_Le","⇠")
  GUISYM("S__NPUp","⇞")
  GUISYM("S__NPDn","⇟")
  GUISYM("S__NHom","↸")
  GUISYM("S__NEnd","⇲")

  GUISYM("S_SNDel","⌦")
  GUISYM("S_SNIns","⎀")
  GUISYM("S_SN_Up","⇡")
  GUISYM("S_SN_Dn","⇣")
  GUISYM("S_SN_Ri","⇢")
  GUISYM("S_SN_Le","⇠")
  GUISYM("S_SNPUp","⇞")
  GUISYM("S_SNPDn","⇟")
  GUISYM("S_SNHom","↸")
  GUISYM("S_SNEnd","⇲")

  GUISYM("U00001B","⌧")
  GUISYM("U000008","⌫")
  GUISYM("U000009","↹")
  GUISYM("U00000D","⏎")

  GUISYM("P__M2LD","⇧")
  GUISYM("P__M2RD","⇧")
  GUISYM("P__M3LD","M3") 
  GUISYM("P__M3RD","M3")
  GUISYM("P__M4LD","M4")
  GUISYM("P__M4RD","M4")

  GUISYM("U000020","␣")
  GUISYM("U0000A0","⍽")
  GUISYM("U00202F",">⍽<")
}

BSTRegister() {
  global

  CP3F1 := "P__BSTt"
  CP3F2 := "P__BSTA"
  CP3F3 := "P_DBSTt"
  BSTSymbols()

  IniRead,useBST,%ini%,Global,useBST,0
  if (useBST)
    CharProc__BST1()

  IniRead,useDBST,%ini%,Global,useDBST,0
}

BSTRegister()
