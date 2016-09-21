; -*- encoding: utf-8 -*-

SetWorkingDir, %A_ScriptDir%
#include %A_ScriptDir%\


; Revision Information (don't moun)
#include *i source\_subwcrev1.generated.ahk

; die Compose-Definitionen
#include *i source\compose.generated.ahk
#include *i source\compose-tainted.generated.ahk
#include *i source\compose.user.ahk
#include    source\compose-gen.ahk

; Hier liegt die Tastaturbelegung
#include    source\BuT_keydefinitions.ahk

; Shortcuts, um die Zeichen wieder sauber zur Applikation bringen zu können
#include    source\performance.ahk
#include    source\BuT_shortcuts.ahk

; Good-old AHK-Skripts, enthalten die ersten Key-Hooks für Mod-Tasten
; Achtung: Hinter dem ersten Keyboard-Hook werden keine globalen Variablen
; mehr gesetzt!
#include    source\BuT_initialize.ahk
#include    source\BuT_resources.ahk

; Das Herz von neo20.ahk: die Tasten- und Zeichen-Behandlungsroutinen
#include    source\BuT_varsfunctions.ahk
#include    source\BuT_diakfunctions.ahk

; Die Bildschirmtastatur
#include    source\BuT_screenkeyboard.ahk
#include    source\BuT_Menuebuttons.ahk

; Mitgelieferte Belegungsvarianten
;#include    source\langstastatur.ahk
;#include    source\einhandneo.ahk
;#include    source\lernmodus.ahk
#include    source\BuT_layouts.ahk
#include    source\tools.ahk

; individuelle Einstellungen
;#include *i %A_AppData%\Neo2\custom.ahk

#include    source\BuT_tray.ahk
#include    source\keyhooks.ahk
#include    source\BuT_levelfunctions.ahk
#include    source\keyboardleds.ahk
