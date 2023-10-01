
spyTab1	dta b(3,33,19,-2)
		dta b(-2,22,29,9)

		dta b(6,12,0,4)
spyTab3		dta b(1,-1)	


przepisz5duszka	equ *
		ldx #0
@		lda enemy,x		;poszukaj pustego duszka
		beq @+
		inx
		bne @-
		
@		lda enemyEkran+5			;kopiuj obecnego przeciwnika na pozycję 0
		sta enemyEkran,x
		lda enemyWybuch+5
		sta enemyWybuch,x
		mva #1 enemy,x
		sta enemyEkran+5
		mva #0 enemy+5
		sta enemyWybuch+5
		lda enemyNegatyw+5
		sta enemyNegatyw,x
		lda enemyOraTab+5
		sta enemyOraTab,x
		lda enemyShapeH+5
		sta enemyShapeH,x
		lda enemyFaza+5
		sta enemyFaza,x
		lda enemyDX+5
		sta enemyDX,x
		lda enemyDY+5
		sta enemyDY,x
		lda enemyX+5
		sta enemyX,x
		lda enemyY+5
		sta enemyY,x
		lda enLicznik+5
		sta enLicznik,x
		lda enRotate+5
		sta enRotate,x
		
		rts

losuj	equ *
		lda poziom
		cmp #spy_from_level			;spy od x poziomu
		bcs *+3
		rts
@		dec losuj1				;sprawdzaj co opoz_dlosuj
		beq @+
		rts
@		mva opoz_dlosuj losuj1
		lda ile_enemy
		cmp #4			;jeśli na ekranie jest więcej niż 3 przeciwnikow to wyjdz
		bcc @+
		rts
@		lda jestSpy		;nie może być szpiega
		ora nobanner
		ora enemyWybuch+5 ;brak wybuchu szpiega
		ora licznikSpyScore
		ora formacja_stan	;brak formacji
		beq *+3
		rts
		ldx timeLevel
		lda kondycja
		cmp con1enemy,x
		bcs *+3
		rts
		cmp spyEnd,x
		bcc *+3
		rts
		
		lda random
		and #%00011111
		cmp #%011
		beq @+
		cmp #%101
		bne @+1
		
@		mva #1 jestSpy		;spy ship sighted
		lda #2				
		jmp set_sample		
		
@		cmp #%1011
		beq @+
		cmp #%1001
		beq @+
		
		rts
		
@		lda poziom
		cmp #formation_from_level			;formacja od 4 poziomu
		bcs *+3
		rts
@		inc formacja_stan
		ldx #5
@		lda enemy,x
		beq @+
		lda enemyWybuch,x
		bne @+
		mva #0 enLicznik,x	;przyspiesz opuszczenie ekranu przez wrogów
		mva #1 enRotate,x
@		dex
		bpl @-1
		
		lda random		;losujemy typ formacji
		and formacja_maska		;0,1 lub 3
		clc
		adc #1
		sta formacja_typ
	
		jsr pisz_formation
	
		mva #$26 conditionColor1
		mva #$34 conditionColor
		lda #3
		jmp set_sample		;battle_station sample
		

spy		equ *
		lda jestSpy
		bne @+
		rts
		
@		cmp #1
		beq dodajSpy
		
		cmp #2		;zabezpieczenie , inna procedura moze przerwac sampla i dodac odrazu spy
		bne moveSpy
		
dodajSpy	equ *
		lda nobanner
		beq *+3
		rts
		
		mva #3 jestSpy
		lda enemy+5		;czy czasami nie jest zajety?
		beq @+
		
		jsr przepisz5duszka
		
@		mva #1 enemy+5
		lda Random
.if .def UC
		anc #%11
.else		
		and #%11
		clc
.endif		
		tax
		lda posX
		adc spyTab1,x
.if .def UC
		anc #127
.else		
		and #127
		clc
.endif		
		sta enemyX+5
		lda posY
		adc spyTab1+4,x
		sta enemyY+5
		lda spyTab1+8,x
		sta enemyFaza+5
		lda random
		and #%11110000
		sta enemyDX+5
		lda random
		and #%11110000
		sta enemyDY+5
		mva #EKOLOR1 enemyNegatyw+5
		lda #0
		sta enemyWybuch+5
		mva #>scolor2 enemyOraTab+5
		mva #spyShape1 enemyShapeH+5 
		mva #20-10 spylicznik	;opoznienie zmiany kierunku
		mva #240 spylicznik1	;jak dlugo duszek musi byc na ekranie
		rts

moveSpy	lda enemyWybuch+5
		ora enemy+5
		bne @+1
		sta jestSpy			;po zakończeniu wybuchu, A=0
		lda spyScore
		bpl @+
		mva opoz_dlosuj losuj1
		rts
@		mva #20 licznikSpyScore		;czas wyświetlania
		mva #EKOLOR0 enemyNegatyw+5	;napis bez negatywu
		mva #0 enemyDY+5			;przesuniecie DX i DY napisu
		mva #128 enemyDX+5
		mva #>scolor3 enemyOraTab+5
		rts
		
@		lda enemyWybuch+5
		beq @+
		rts
		
		
			
@		lda enemyFaza+5			;przesun duszka
		ora spySpeed		;predkosc szpiega
		ldy spylicznik1
		cpy #232
		bcc @+
		and #%00011111
		ora #224
@		tay

		clc
		lda enemyDX+5
		adc enemyTabX,y	
		sta enemyDX+5
		lda enemyX+5
		adc enemyTabX+16,y
		and #127
		sta enemyX+5

		
		clc
		lda enemyDY+5
		adc enemyTabY,y
		sta enemyDY+5
		lda enemyY+5
		adc enemyTabY+16,y
		sta enemyY+5		
				
		lda ramka		;zmniejszaj licznik tylko przy parzystej ramce
		bne @+1
		lda spylicznik1
		beq @+
		dec spylicznik1
		bne @+1
@		lda enemyEkran+5
		beq @+
		mva #0 enemy+5		;wyłącz spy
		sta jestSpy
msp1	ldx timeLevel	;poziom trudnosci
		lda kondycja
		cmp conYellow,x	;jesli con=green to daruj ucieczke szpiega
		bcs *+3
		rts
		
		lda conred,x
		;sec
		sbc #2
		sta kondycja		;przejdź natychmiast do condition red
		rts		

		
@		dec spylicznik
		beq @+
		rts		
						
@		lda #8 
		sta spylicznik
		lda enemyEkran+5
		bne @+
		
		lda random
.if .def UC
		anc #1
.else		
		and #1
		clc
.endif		
		tax
		lda enemyFaza+5
		adc spyTab3,x
		and #15
		sta enemyFaza+5	
		
		rts	

;korekcja lotu szpiega poza ekranem		
@		ldx #5
		jmp korekcjaLotu
		
		
;print spy score
printSpyScore	equ *
		lda licznikSpyScore
		bne @+
		rts
		
@		dec licznikSpyScore
		bne @+
		mva opoz_dlosuj losuj1
		
@		mva #$4c duszkiPrint._jmp	;jmp
		mwa #duszkiPrint._adres duszkiPrint._jmp+1	;adres skoku
		
		ldy spyScore
		ldx #0				;rysujemy wynik w buforze
@		lda spyCyfra,y
		sta shpBuf,x
		lda spyZero,x
		sta shpBuf+24,x
		sta shpBuf+48,x
		iny
		inx
		cpx #9
		bne @-
		lda #0
@		sta shpBuf,x
		sta shpBuf+24,x
		sta shpBuf+48,x
		inx
		cpx #16
		bne @-
		
		ldx #5
		jsr duszkiPrint
		beq @+
		mva #0 licznikSpyScore	;score poza ekranem

@		mva #$bd	duszkiPrint._jmp	;lda $ffff,x
		mwa #enemyFaza duszkiPrint._jmp+1

		mva #1 enemyEkran+5
		rts
		
		
spyCyfra	equ *
		dta b(%00001100)	;2
		dta b(%00110111)
		dta b(%11011101)
		dta b(%00111101)
		dta b(%00110111)
		dta b(%11011100)
		dta b(%11011111)
		dta b(%11010101)
		dta b(%00111111)
		:7 dta b(0)
		
		dta b(%00001100)	;3
		dta b(%00110111)
		dta b(%11011101)
		dta b(%00111101)
		dta b(%00110111)
		dta b(%00001101)
		dta b(%11011101)
		dta b(%00110111)
		dta b(%00001100)
		:7 dta b(0)
		
		dta b(%00110000)	;4
		dta b(%11011111)
		dta b(%11011101)
		dta b(%11011101)
		dta b(%00110101)
		dta b(%00001101)
		dta b(%00001101)
		dta b(%00001101)
		dta b(%00000011)
		:7 dta b(0)
		
		dta b(%00001100)	;8
		dta b(%00110111)
		dta b(%11011101)
		dta b(%11011101)
		dta b(%00110111)
		dta b(%11011101)
		dta b(%11011101)
		dta b(%00110111)
		dta b(%00001100)
		:7 dta b(0)

		
		
spyZero	equ *
		dta b(%00001100)
		dta b(%00110111)
		dta b(%11011101)
		dta b(%11011101)
		dta b(%11011101)
		dta b(%11011101)
		dta b(%11011101)
		dta b(%00110111)
		dta b(%00001100)
		
		
		
		