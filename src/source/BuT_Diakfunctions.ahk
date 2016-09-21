 ; -*- encoding: utf-8 -*-
 ; (ɔ) 2015 Wolf Belschner

 
 DLang(lang) {                                          
  global
  DE   := object(1,"T__drss",3,"T__acut",5,"T__grav",7,"T__cflx",9,"T__tlde",11,"T__abrg",13,"T__strk") 
  FR   := object(1,"T__acut",3,"T__grav",5,"T__cflx",7,"T__drss") 
  ES   := object(1,"T__acut",3,"T__tlde",5,"T__drss",7,"T__grav")  
  PT   := object(1,"T__acut",3,"T__tlde",5,"T__cflx",7,"T__grav",9,"T__drss") 
  MT   := object(1,"T__strk",3,"T__abdt",5,"T__grav",7,"T__acut")
  DK   := object(1,"T__abrg",3,"T__strk",5,"T__drss",7,"T__acut",9,"T__grav",11,"T__cflx")
  LV   := object(1,"T__cedi",3,"T__abdt",5,"T__mcrn")
  LT   := object(1,"T__mcrn",3,"T__cron",5,"T__cedi") 
  EE   := object(1,"T__drss",3,"T__tlde",5,"T__cron")
  HU   := object(1,"T__acut",3,"T__drss",5,"T__dbac")   
  RO   := object(1,"T__brve",3,"T__cedi",5,"T__cflx")   
  TR   := object(1,"T__cedi",3,"T__drss",5,"T__brve",7,"T__cflx")  
  PL   := object(1,"T__acut",3,"T__strk",5,"T__cedi",7,"T__abdt")
  CZ   := object(1,"T__acut",3,"T__cron",5,"T__abrg")
  SK   := object(1,"T__cron",3,"T__acut",5,"T__drss",7,"T__cflx")  
  ESPO := object(1,"T__cflx",3,"T__brve")
  EXOT := object(1,"T__bldt",3,"T_dasia",5,"T_psili",7,"T__hook",9,"T__turn",11,"T__dbac")
  
  MaxInd := LANG.MaxIndex()
}

Diakritika(lang,diak) {                                ; select diacritica function
  global
  if LANG.HasKey(diak) == 1 {
     key := diak
  for diak, value in LANG
    if (diak == key)
      break 
    comp := value
    }
}

Composite(char,pchar1,pchar2,pchar3) {                 ; reverse compose function
  global
  if (IsDown = 0)
    comp := char 
    CompNew := comp . pchar3 . pchar2 . pchar1
    char := CD%CompNew%
    send {BS}

    if (strlen(char) > 7) && (scomp = 0) {
      send {BS}
      Comp := ""
      CharStarDown(PhysKey, ActKey, char)
  } if (strlen(char) > 7) && (scomp = 1) {             ; if shift pressed after T__diak
      send {BS}{BS}
      Comp := ""
      CharStarDown(PhysKey, ActKey, char)
  } else if (strlen(char) = 7) {
      send {BS}
      CharOutDown(char)
      send {BS}
 
} else
  Compnew := comp . pchar2 . pchar1
    char := CD%CompNew%

    if (strlen(char) > 7) && (scomp = 0) {
      Comp := ""
      CharStarDown(PhysKey, ActKey, char)
  } if (strlen(char) > 7) && (scomp = 1) {
      Comp := ""
      send {BS}
      CharStarDown(PhysKey, ActKey, char)
  } If (strlen(char) = 7) && (scomp = 0) {
      CharOutDown(char)
  } else If (strlen(char) = 7) && (scomp = 1) {
      send {BS}
      CharOutDown(char)
  }
  scomp := 0
  Comp := ""
}       
