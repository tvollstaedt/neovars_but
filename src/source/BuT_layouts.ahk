; -*- encoding:utf-8 -*-

; Aus der Neo-Welt (AdNW) von Andreas Wettstein, http://wettstae.home.solnet.ch/
; (c) 2010 Matthias Wächter
; (ɔ) 2015 Wolf Belschner

CharProcNordT1() {
  ; Tastaturbelegungsvariante BUTeck aktivieren
    Change1256Layout("-ßbu.,üpclmfxhieaodtrnskyöäqjgwvz")
  }

CharProcNordT2() {
  ; Tastaturbelegungsvariante BUTeck-XCV aktivieren
    Change1256Layout("-xfmlcpü,.ubßsnrtdoaeihzvwgjqäöyk")
}
 
CharProcNordT3() {
  ; Tastaturbelegungsvariante AdNW aktivieren
    Change1256Layout("-ßkuü.ävgcljfhieaodtrnsxyö,qbpwmz")
}
 
CharProcNordT4() {
  ; Tastaturbelegungsvariante K.O,Y aktivieren
  Change1256Layout("-ßk.o,yvgclfzhaeiudtrnsxqäüöbpwmj")
}

CharProcNordT5() {       ; Tastaturbelegungsvariante CUSTOM aktivieren
  global
  IniRead,customLayout,%ini%,Global,customLayout,%A_Space%
  if (customLayout != "")
         Change1256Layout(customLayout)
  else if (customLayout = "") 
    custominput()
  else
    Change1256LayoutNeo20()
}

CharProcNordT6() {        ; Tastaturbelegungsvariante PUQ30 aktivieren
  global 
  ED1256("010",1,"p","P","π","Π")
  ED1256("011",1,"u","U","" ,"⊂")
  ED1256("012",0,"T__diak","S__comp","ϵ","∩")
  ED1256("013",0,",","–","ϱ","⇒")
  ED1256("014",1,"q","Q","ϕ","ℚ")
  ED1256("015",1,"g","G","γ","Γ")
  ED1256("016",1,"c","C","χ","ℂ")
  ED1256("017",1,"l","L","λ","Λ")
  ED1256("018",1,"m","M","μ","⇔")
  ED1256("019",1,"f","F","φ","Φ")
  
  ED1256("01E",1,"h","H","ψ","Ψ")
  ED1256("01F",1,"i","I","ι","∫")
  ED1256("020",1,"e","E","ε","∃")
  ED1256("021",1,"a","A","α","∀")
  ED1256("022",1,"o","O","ο","∈")
  ED1256("023",1,"d","D","δ","Δ")
  ED1256("024",1,"t","T","τ","∂")
  ED1256("025",1,"r","R","ρ","ℝ")
  ED1256("026",1,"n","N","ν","ℕ")
  ED1256("027",1,"s","S","σ","Σ")
  
  ED1256("02C",1,"k","K","κ","×")
  ED1256("02D",1,"y","Y","υ","∇")
  ED1256("02E",0,".","•","ϑ","↦")
  ED1256("02F",1,"’","’","ς","∘")
  ED1256("030",1,"x","X","ξ","Ξ")
  ED1256("031",1,"j","J","θ","Θ")
  ED1256("032",1,"v","V","" ,"√")
  ED1256("033",1,"w","W","ω","Ω")
  ED1256("034",1,"b","B","β","⇐")
  ED1256("035",1,"z","Z","ζ","ℤ")
  
  ED1256("01A",1,"«","‹","φ","Φ")
  ED1256("028",1,"»","›","ς","∘")
  ED1256("00C",0,"-","—","‑","­") 		; -
}

CharProcNordT7() {           ; Tastaturbelegungsvariante OUMF30 aktivieren
  global
  ED1256("010",0,"T__diak","S__comp","ϵ","∩")
  ED1256("011",1,"o","O","ο","∈")
  ED1256("012",1,"u","U","" ,"⊂")
  ED1256("013",1,"m","M","μ","⇔")
  ED1256("014",1,"f","F","φ","Φ")
  ED1256("015",1,"v","V","" ,"√")
  ED1256("016",1,"w","W","ω","Ω")
  ED1256("017",1,"c","C","χ","ℂ")
  ED1256("018",1,"l","L","λ","Λ")
  ED1256("019",1,"k","K","κ","×")
  
  ED1256("01E",1,"i","I","ι","∫")
  ED1256("01F",1,"a","A","α","∀")
  ED1256("020",1,"e","E","ε","∃")
  ED1256("021",1,"s","S","σ","Σ")
  ED1256("022",1,"g","G","γ","Γ")
  ED1256("023",1,"d","D","δ","Δ")
  ED1256("024",1,"t","T","τ","∂")
  ED1256("025",1,"n","N","ν","ℕ")
  ED1256("026",1,"r","R","ρ","ℝ")
  ED1256("027",1,"h","H","ψ","Ψ")
  
  ED1256("02C",1,"y","Y","υ","∇")
  ED1256("02D",1,"x","X","ξ","Ξ")
  ED1256("02E",1,"’","’","ς","∘")
  ED1256("02F",0,".","•","ϑ","↦")
  ED1256("030",1,"q","Q","ϕ","ℚ")
  ED1256("031",1,"j","J","θ","Θ")
  ED1256("032",1,"p","P","π","Π")
  ED1256("033",0,",","–","ϱ","⇒")
  ED1256("034",1,"z","Z","ζ","ℤ")
  ED1256("035",1,"b","B","β","⇐")
  
  ED1256("01A",1,"«","‹","φ","Φ")
  ED1256("028",1,"»","›","ς","∘")
  ED1256("00C",0,"-","—","‑","­") 		; -
}

CharProcNordT8() {            ; Tastaturbelegungsvariante CUSTOM 30 aktivieren
  global
  IniRead,custom30Layout,%ini%,Global,custom30Layout,%A_Space%
  if (custom30Layout != "")
         Change1256Layout(custom30Layout)
  else if (custom30Layout = "") 
    custom30input()
  else
    Change1256LayoutNeo20()
}

ActivateNordTast() {
  global
  IniRead,isLayout,%ini%,Global,isLayout,0
  if (isLayout == 1) 
    CharProcNordT1()
  else if (isLayout == 2) 
    CharProcNordT2()
  else if (isLayout == 3) 
    CharProcNordT3()
  else if (isLayout == 4) 
    CharProcNordT4()
  else if (isLayout == 5)
    CharProcNordT5()
  else if (isLayout == 6)
    CharProcNordT6()
  else if (isLayout == 7)
    CharProcNordT7()
  else if (isLayout == 8)
    CharProcNordT8()
 }

ActivateNordTast()

