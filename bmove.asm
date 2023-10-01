llinii	equ 100		;liczba linii
szerEkranu equ 128  ;szerokosc ekranu w bajtach
maxBombyEkran	equ 32



BazyEkran			equ $101		;12b numery baz widocznych na ekranie
BombyEkran			equ BazyEkran+12		;:maxBombyEkran dta b(0)
bombX0				equ BombyEkran+maxBombyEkran	;:maxBombyEkran dta b(0)
bombY0				equ bombX0+maxBombyEkran		;:maxBombyEkran dta b(0)

ileGwiazd 	equ 18

znakXa	equ znaki2+100*8
znakYa	equ znakXa+ileGwiazd

gwiazdyPixel	dta b(%11,%1100,%110000,%11000000)

znakUp1		dta b(28)
			:29 dta b(#)
			dta b(0)
			
znakDown1	equ znakUp1+2

znakMinus1	dta b(32)
			:33 dta b(#)
			dta b(0)
			
znakPlus1 	equ znakMinus1+2

			
;rysuje obiekty na ekranie (bazy,meteory,bomby)
printEkran	equ *
		ldx bazyIle		;ile mamy baz
		mva #0 licznikBazyEkran		;zerujemy licznik widocznych baz
		sta licznikBombyEkran
pre0	lda bazyRodzaj-1,x	
		bmi pre0a		;negatyw to nie ma bazy
		bne @+
		jmp printBazaA1
@		jmp printBazaB1
pre0a	dex
		bne pre0
		
		
pre1a	ldy posY	
		ldx tabBomb1,y
		cpx #255
		bne pre2a		;nie ma zadnej bomby na ekranie
pre2b	jmp pre3
pre2a	lda tabBomb2,y
		sta pre2+1
		mva bombIle pre2_+1
pre1	lda bombRodzaj-1,x
		bpl @+
pre2	cpx #$ff
		beq pre2b	;narysowano juz wszystkie
		inx
pre2_	cpx #$ff
		bcc pre1
		beq pre1
		ldx #1
		jmp pre1	
		
@		sec
		lda bombX-1,x
		sbc posX
		tay
		lda tabX,y
		clc
		adc #1
		cmp #34
		bcs pre2
		
		ldy licznikBombyEkran
		sta bombX0,y		;pozycja x+1 na ekranie
		
		adc #7
		sta pom0
		
		sec
		lda bombY-1,x
		sbc posY
		clc
		adc #1
		cmp #lenDlist+1
		bcs pre3
		
		sta bombY0,y		;pozycja y+1 na ekranie
		sta pom1
			
		txa
		sta bombyEkran,y	;nr+1
		inc licznikBombyEkran
		
		ldy pom1
		
		lda ramka
		bne @+
		
		clc
		lda obraz1La+7,y
		adc pom0
		sta pom
		lda obraz1Ha+7,y
		adc #0
		sta pom+1
		jmp @+1	;skok bezwarunkowy
@		clc
		lda obraz2La+7,y
		adc pom0
		sta pom
		lda obraz2Ha+7,y
		adc #0
		sta pom+1

@		lda bombRodzaj-1,x
		bne @+
		
		
		ldy #0
		lda #firstBombaChar
		sta (pom),y
		
		iny
		lda #firstBombaChar+2
		sta (pom),y
		
		ldy #48
		lda #firstBombaChar+1
		sta (pom),y
		
		iny
		lda #firstBombaChar+3
		sta (pom),y
		jmp pre2
		
@		ldy #0
		lda #firstMeteorChar+128		
		sta (pom),y
		
		iny
		lda #firstMeteorChar+128+2
		sta (pom),y
		
		ldy #48
		lda #firstMeteorChar+128+1
		sta (pom),y
		
		iny
		lda #firstMeteorChar+128+3
		sta (pom),y
		jmp pre2
		
		
pre3	lda startMapy
		bne *+3
		rts
		
		cmp #145
		beq @+
		
		cmp #60
		beq @+
		
		cmp #12
		bne @+2
		
@		ldx #104		;12znakow
@		lda player1chars-1,x
		sta znaki1-1+115*8,x
		sta znaki2-1+115*8,x
		dex
		bne @-
		
		
.if .def UC
@		lda #10
		dcp startMapy
.else		
@		dec startMapy		
		lda startMapy
		cmp #10
.endif		
		bne @+
		
		jsr graj_sampla
		mva #1 licznikstrzal
		
@		lda startMapy
		cmp #11
		bcc @+2		;do rts
		
		ldx #9
@		lda playerNapis1,x
		ora #128
		sta obraz1+11+13*48,x
		sta obraz2+11+13*48,x
		dex
		bpl @-
		
		ldx #4
@		lda playerNapis1+10,x
		ora #128
		sta obraz1+13+15*48,x
		sta obraz2+13+15*48,x
		dex
		bpl @-
		
@		rts

		
playerNapis1	dta b(119,120,121,122,123,124,0,125,126,123,124,123,121,115,122)

				
player1chars	dta b(%01010000)		;115 D
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01011100)
				dta b(%11110000)	
				
				dta b(%00010100)		;116 G
				dta b(%01111100)
				dta b(%01000000)
				dta b(%01000000)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01010100)
				dta b(%11111100)

				dta b(%01000100)		;117 M
				dta b(%01010100)
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%11001100)
				
				dta b(%01000100)		;118 V
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%11011100)
				dta b(%00110000)
				
				dta b(%01010100)		;119 P
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01010100)
				dta b(%01111100)
				dta b(%01000000)
				dta b(%01000000)
				dta b(%11000000)
				
				dta b(%01000000)		;120 L
				dta b(%01000000)
				dta b(%01000000)
				dta b(%01000000)
				dta b(%01000000)
				dta b(%01000000)
				dta b(%01010100)
				dta b(%11111100)
				
				dta b(%00010000)		;121 A
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01010100)
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%11001100)
				
				dta b(%01000100)		;122 Y
				dta b(%01000100)
				dta b(%01000100)
				dta b(%11011100)
				dta b(%00010000)
				dta b(%00010000)
				dta b(%00010000)
				dta b(%00110000)
				
				dta b(%01010100)		;123 E
				dta b(%01111100)
				dta b(%01000000)
				dta b(%01010000)
				dta b(%01110000)
				dta b(%01000000)
				dta b(%01010100)
				dta b(%11111100)
				
				dta b(%01010000)		;124 R
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01010000)
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%11001100)
				
				dta b(%00010100)		;125 O
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01011100)
				dta b(%11110000)
				
				dta b(%01010000)		;126 N
				dta b(%01110100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%01000100)
				dta b(%11001100)
				
				

printBazaA1	equ *
		sec
		lda bazyX-1,x
		sbc posX
		tay
		lda tabX,y
		sta bazyX0-1,x
		clc
		adc #8
		
		cmp #41
		bcc @+
		jmp pre0a

@		sta pom0
		
		sec
		lda bazyY-1,x
		sbc posY
		sta bazyY0-1,x
		clc
		adc #7	
		cmp #lenDlist+7
		bcc @+
		jmp pre0a
		
@		sta pom0a
		
		
		lda czyRakiety		;czy na mapie sa rakiety?
		beq @+
		lda startMapy
		ora trafienie
		bne @+
		lda bazyRakieta-1,x
		bpl @+
		DODAJRAKIETAA
@		txa
		ldy licznikBazyEkran
		sta BazyEkran,y
		inc licznikBazyEkran
		
@		ldy pom0a
		lda ramka
		bne @+
		
		clc
		lda obraz1La+1,y
		adc pom0
		sta pom
		sta pom1
		lda obraz1Ha+1,y
		adc #0
		sta pom+1
		adc #1
		sta pom1+1
		jmp @+1	;skok bezwarunkowy
@		clc
		lda obraz2La+1,y
		adc pom0
		sta pom
		sta pom1
		lda obraz2Ha+1,y
		adc #0
		sta pom+1
		adc #1
		sta pom1+1

@		lda bazystan-1,x
		sta pom0b
		
		cpy #29
		bcc @+
		
		lda tab_prbaz1-29,y
		sta pom2
		lda tab_prbaz1+7-29,y
		sta pom2+1
		ldy #0
		lda (pom2),y
		sta _zapCom+1		;zapamietaj poprzednia komende
		lda #96				;kod komendy RTS
		sta (pom2),y
		jsr _rysBazA		;rysuj baze od poczatku
_zapCom	lda #0
		ldy #0
		sta (pom2),y
		jmp pre0a
		
@		cpy #7
		bcs @+
		
		lda tab_prbaz1,y
		sta prb1_skok+1
		lda tab_prbaz1+7,y
		sta prb1_skok+2
prb1_skok	equ *
		jmp $ffff

tab_prbaz1	dta b(<lin7a,<lin6a,<lin5a,<lin4a,<lin3a,<lin2a,<lin1a)		
			dta b(>lin7a,>lin6a,>lin5a,>lin4a,>lin3a,>lin2a,>lin1a)

_rysBazA	equ *			
@		lda bazyCannon0a-1,x
		beq @+
		ldy #2
		sta (pom),y
@		ldy #3
		lda bazyCannon0b-1,x
		sta (pom),y
		ldy #5
		lda bazyCannon1a-1,x
		sta (pom),y
		
		lda bazyCannon1b-1,x
		beq lin1a
		ldy #6
		sta (pom),y
		
lin1a	ldy #50
		lda bazyCannon0c-1,x
		sta (pom),y
		iny
		lda bazyCannon0d-1,x
		sta (pom),y
		ldy #53
		lda bazyCannon1c-1,x
		sta (pom),y
		iny
		lda bazyCannon1d-1,x
		sta (pom),y
		
lin2a	ldy #97
		lda #b+9
		sta (pom),y

		lda pom0b		;jesli zbite dzialko 0
		and #%1
		beq @+
		
		ldy #98
		lda #b+8
		sta (pom),y
@		ldy #99
		lda #b+10
		sta (pom),y
		ldy #101
		lda #b+11
		sta (pom),y

		lda pom0b		;jesli zbite dzialko 1
		and #%10
		beq @+
		
		ldy #102
		lda #b+6
		sta (pom),y
		
@		ldy #103
		lda #b+7
		sta (pom),y
		
lin3a	lda bazyCannon5a-1,x
		beq @+
		ldy #144
		sta (pom),y
@		ldy #145
		lda bazyCannon5b-1,x
		sta (pom),y
		iny
		lda #b+4
		sta (pom),y
		iny
		lda #b
		sta (pom),y
		iny
_bazaAJadro0	equ *
		lda #b+16+128
		sta (pom),y
		iny
		lda #b+2
		sta (pom),y
		iny
		lda #b+4
		sta (pom),y
		iny
		lda bazyCannon2a-1,x
		sta (pom),y
		
		lda bazyCannon2b-1,x
		beq lin4a
		ldy #152
		sta (pom),y
		
lin4a	lda bazyCannon5c-1,x
		beq @+
		ldy #192
		sta (pom),y
@		ldy #193
		lda bazyCannon5d-1,x
		sta (pom),y
		iny
		lda #b+5
		sta (pom),y
		iny
		lda #b+1
		sta (pom),y
		iny
_bazaAJadro1	equ *
		lda #b+17+128
		sta (pom),y
		iny
		lda #b+3
		sta (pom),y
		iny
		lda #b+5
		sta (pom),y
		iny
		lda bazyCannon2c-1,x
		sta (pom),y
		
		lda bazyCannon2d-1,x
		beq lin5a
		ldy #200
		sta (pom),y
		
lin5a	ldy #241
		lda #b+6
		sta (pom),y

		lda pom0b		;jesli zbite dzialko 4
		and #%10000
		beq @+
		
		ldy #242
		lda #b+7
		sta (pom),y
@		ldy #243
		lda #b+11
		sta (pom),y
		ldy #245
		lda #b+10
		sta (pom),y

		lda pom0b	;jesli zbite dzialko 3
		and #%1000
		beq @+
		
		ldy #246
		lda #b+9
		sta (pom),y
@		ldy #247
		lda #b+8
		sta (pom),y
		
lin6a	ldy #34
		lda bazyCannon4a-1,x
		sta (pom1),y
		iny
		lda bazyCannon4b-1,x
		sta (pom1),y
		ldy #37
		lda bazyCannon3a-1,x
		sta (pom1),y
		iny
		lda bazyCannon3b-1,x
		sta (pom1),y
		
lin7a	lda bazyCannon4c-1,x
		beq @+
		ldy #82
		sta (pom1),y
@		ldy #83
		lda bazyCannon4d-1,x
		sta (pom1),y
		ldy #85
		lda bazyCannon3c-1,x
		sta (pom1),y
		
		lda bazyCannon3d-1,x
		beq @+
		ldy #86
		sta (pom1),y
		
@		jmp pre0a

printBazaB1	equ *
		sec
		lda bazyX-1,x
		sbc posX
		tay
		lda tabX,y
		sta bazyX0-1,x
		clc
		adc #7
		
		cmp #40
		bcc @+
		jmp pre0a
		
@		adc #1
		sta pom0
		
		sec
		lda bazyY-1,x
		sbc posY
		sta bazyY0-1,x
		clc
		adc #8	
		cmp #lenDlist+8
		bcc @+
		jmp pre0a

@		sta pom0a
		
		lda czyRakiety
		beq @+
		lda startMapy
		ora trafienie
		bne @+
		lda bazyRakieta-1,x
		bpl @+
		DODAJRAKIETAB
@		txa
		ldy licznikBazyEkran
		sta BazyEkran,y
		inc licznikBazyEkran
		
		ldy pom0a
		lda ramka
		bne @+
		
		clc
		lda obraz1La,y
		adc pom0
		sta pom
		sta pom1
		lda obraz1Ha,y
		adc #0
		sta pom+1
		adc #1
		sta pom1+1
		jmp @+1	;skok bezwarunkowy
@		clc
		lda obraz2La,y
		adc pom0
		sta pom
		sta pom1
		lda obraz2Ha,y
		adc #0
		sta pom+1
		adc #1
		sta pom1+1

@		lda bazyStan-1,x
		sta pom0b
		
		cpy #31
		bcc @+
		
		lda tab_prbaz2-30,y
		sta pom2
		lda tab_prbaz2+8-30,y
		sta pom2+1
		ldy #0
		lda (pom2),y
		sta _zapCom1+1		;zapamietaj poprzednia komende
		lda #96				;kod komendy RTS
		sta (pom2),y
		jsr _rysBazB		;rysuj baze od poczatku
_zapCom1 lda #0
		ldy #0
		sta (pom2),y
		jmp pre0a
		
@		cpy #8
		bcs @+
		
		lda tab_prbaz2,y
		sta prb2_skok+1
		lda tab_prbaz2+8,y
		sta prb2_skok+2
prb2_skok	equ *
		jmp $ffff

tab_prbaz2	dta b(<lin8b,<lin7b,<lin6b,<lin5b,<lin4b,<lin3b,<lin2b,<lin1b)		
			dta b(>lin8b,>lin7b,>lin6b,>lin5b,>lin4b,>lin3b,>lin2b,>lin1b)

_rysBazB	equ *			
@		ldy #3
		lda bazyCannon0a-1,x
		sta (pom),y
		iny
		lda bazyCannon0b-1,x
		sta (pom),y
		
lin1b	ldy #50
		lda #b+25
		sta (pom),y
		iny
		lda bazyCannon0c-1,x
		beq @+
		ldy #51
		sta (pom),y
@		lda bazyCannon0d-1,x
		beq @+
		ldy #52
		sta (pom),y
@		ldy #53
		lda #b+27
		sta (pom),y
		
lin2b	lda bazyCannon5a-1,x
		beq @+
		ldy #96
		sta (pom),y
@		ldy #97
		lda bazyCannon5b-1,x
		sta (pom),y

		lda pom0b		;jesli zbite dzialko 5
		and #%100000
		beq @+
		
		ldy #98
		lda #b+24
		sta (pom),y
@		ldy #99
		lda #b+12
		sta (pom),y
		iny
		lda #b+13
		sta (pom),y

		lda pom0b		;jesli zbite dzialko 1
		and #%10
		beq @+
		
		ldy #101
		lda #b+26
		sta (pom),y
@		ldy #102
		lda bazyCannon1a-1,x
		sta (pom),y
		
		lda bazyCannon1b-1,x
		beq lin3b
		ldy #103
		sta (pom),y
		
lin3b	ldy #144
		lda bazyCannon5c-1,x
		sta (pom),y
		iny
		lda bazyCannon5d-1,x
		sta (pom),y
		iny
		lda #b+14
		sta (pom),y
		iny
		lda #b
		sta (pom),y
		iny
		lda #b+2
		sta (pom),y
		iny
		lda #b+15
		sta (pom),y
		iny
		lda bazyCannon1c-1,x
		sta (pom),y
		iny
		lda bazyCannon1d-1,x
		sta (pom),y
		
lin4b	ldy #195
_bazaBJadro0	equ *
		lda #b+18+128
		sta (pom),y
		iny
_bazaBJadro1	equ *
		lda #b+19+128
		sta (pom),y
		
lin5b	ldy #240
		lda bazyCannon4a-1,x
		sta (pom),y
		iny
		lda bazyCannon4b-1,x
		sta (pom),y
		iny
		lda #b+15
		sta (pom),y
		iny
		lda #b+1
		sta (pom),y
		iny
		lda #b+3
		sta (pom),y
		iny
		lda #b+14
		sta (pom),y
		iny
		lda bazyCannon2a-1,x
		sta (pom),y
		iny
		lda bazyCannon2b-1,x
		sta (pom),y
		
lin6b	lda bazyCannon4c-1,x
		beq @+
		ldy #32
		sta (pom1),y
@		ldy #33
		lda bazyCannon4d-1,x
		sta (pom1),y

		lda pom0b		;jesli zbite dzialko 4
		and #%10000
		beq @+
		
		ldy #34
		lda #b+27
		sta (pom1),y
@		ldy #35
		lda #b+12
		sta (pom1),y
		iny
		lda #b+13
		sta (pom1),y

		lda pom0b		;jesli zbite dzialko 2
		and #%100
		beq @+
		
		ldy #37
		lda #b+25
		sta (pom1),y
@		ldy #38
		lda bazyCannon2c-1,x
		sta (pom1),y
		
		lda bazyCannon2d-1,x
		beq lin7b
		ldy #39
		sta (pom1),y
		
lin7b	ldy #82
		lda #b+26
		sta (pom1),y
		iny
		lda bazyCannon3a-1,x
		sta (pom1),y
		iny
		lda bazyCannon3b-1,x
		sta (pom1),y
		iny
		lda #b+24
		sta (pom1),y
		
lin8b	lda bazyCannon3c-1,x
		beq @+
		ldy #131
		sta (pom1),y
		
@		lda bazyCannon3d-1,x
		beq @+
		ldy #132
		sta (pom1),y
		
@		jmp pre0a
		
		
gwiazdyInit	equ *	
		mva gwiazdyPixel znaki1+8
		sta znaki2+8
		and #%01010101
		sta znaki1+16
		sta znaki2+16

		
		mva #0 znakX1
		sta znakY1
		sta znakDX
		sta znakDY
		sta muzyka
		
		ldx #35
@		lda znakXa,x
		sta znakX,x
		dex
		bpl @- 

		rts

gwiazdyRysuj2	equ *
		lda #0
_gwzmaz1 sta znaki2+8
		sta znaki2+16
		lda znakDY
		ora #%1000
		sta _gwzmaz1+1
		eor #%11000
		sta _gwzmaz1+4

		ldx znakDX
		lda gwiazdyPixel,x 	;narysuj gwiazde w nowej pozycji
		ldy znakDY
		sta znaki2+8,y
		and #%01010101
		sta znaki2+16,y

		bne gwiazdyPrint		;skok bezwarunkowy
		
gwiazdyRysuj1 equ *  ;narysuj gwiazdy na pustych polach
		lda #0
_gwzmaz		sta znaki1+8
			sta znaki1+16
		lda znakDY
		ora #%1000
		sta _gwzmaz+1
		eor #%11000
		sta _gwzmaz+4

		ldx znakDX
		lda gwiazdyPixel,x 	;narysuj gwiazde w nowej pozycji
		ldy znakDY
		sta znaki1+8,y
		and #%01010101
		sta znaki1+16,y
	
gwiazdyPrint equ *
		lda gwiazdyLicznik
		beq @+
		lda #2+128	;kolor
		ldx #17		;start
		ldy #11		;end-1
		jsr stars
		
		lda gwiazdyLicznik
@		cmp #1
		beq @+
		
		lda #1+128
		ldx #11
		ldy #5
		jsr stars
		
		lda gwiazdyLicznik
@		cmp #2
		bne @+
		rts
@		lda #1
		ldx #5
		ldy #255
		jmp stars
	
		
movLeft	equ *
		lda gwx
		sec
		sbc ruch
		and #1
		sta gwx
		bcs ml11
		
		ldx znakDX ; czy zmienic pozycje X gwiazdy
		cpx #3
		bne ml12
		
		
		ldy znakX1
		lda znakMinus1,y
		sta znakX1
		
		ldx #255
ml12	inx
		stx znakDX	

ml11	lda movX
		clc
		adc ruch
		cmp #13
		bcs ml1
		sta movX
		jmp l02
ml1		
		sbc #4
		sta movX
		dec posX
		bpl ml2
		mva #127 posX
			
ml2		ldy znakX1
		lda znakPlus1,y
		sta znakX1	
		
		jmp l02

				
movRight equ *		;statek w prawo tlo w lewo
		lda gwx
		sec
		sbc ruch
		and #1
		sta gwx
		bcs mr11
		
		ldx znakDX		;czy zmienic pozycje X gwiazd
		bne mr12
		
		ldy znakX1
		lda znakPlus1,y
		sta znakX1
		
		ldx #4
mr12	dex
		stx znakDX	
		
mr11	lda movX			;przesow tla
		sec
		sbc ruch
		cmp #9
		bcc mr1
		sta movX
		jmp l02
mr1		
		adc #4
		sta movX
		
		inc posX
		bpl mr2
		mva #0 posX
		
mr2		ldy znakX1
		lda znakMinus1,y
		sta znakX1
		
		jmp l02
		

movUp	equ *
		sec
		lda gwy
		sbc ruchy
		and #%10
		sta gwy
		bcs mu11


		ldy znakDY ; czy zmienic pozycje Y gwiazdy
		bne mu12
		
@		ldy znakY1
		lda znakUp1,y
		sta znakY1
		
		ldy #8
mu12	dey
		dey
		sty znakDY
	
mu11	lda movY
		;beq mu1
		sec
		sbc ruchy
		bmi mu1
		sta movY
		jmp l04
mu1		and #7
		sta movy
		dec posY

		ldy znakY1
		lda znakDown1,y
		sta znakY1	
		
		jmp l04
		

movDown	equ *
		sec
		lda gwy
		sbc ruchy
		and #%10
		sta gwy
		bcs md11


		ldx movY
		ldy znakDY ; czy zmienic pozycje Y gwiazdy
		cpy #6
		bne md12
		
@		ldy znakY1
		lda znakDown1,y
		sta znakY1
		
		ldy #-2
md12	iny
		iny
		sty znakDY

md11	lda movY
		clc
		adc ruchy
		cmp #8
		bcs md1
		sta movY
		jmp l04
md1		
		and #7
		sta movY
		inc posY
		
		ldy znakY1
		lda znakUp1,y
		sta znakY1
		jmp l04
		

joyTable	dta 0,15,47,0,79,143,239,0,111,175,207

			
wybuch0		equ *
			:16*4 dta b(0)			
			
			;3
			:2 dta b(0)
			:3 dta b(%00010000)
			dta b(%00101000)
			:3 dta b(%01000100)
			dta b(%00101000)
			:3 dta b(%00010000)
			:3 dta b(0)
			
			;2
			:3 dta b(0)
			:3 dta b(%00010000)
			dta b(%00111000)
			dta b(%01101100)
			dta b(%00111000)
			:3 dta b(%00010000)
			:4 dta b(0)
			
			;1
			:4 dta b(0)
			:2 dta b(%00010000)
			dta b(%00111000)
			dta b(%01111100)
			dta b(%00111000)
			:2 dta b(%00010000)
			:5 dta b(0)
			
			;0
			:6 dta b(0)
			dta b(%00010000)
			dta b(%00111000)
			dta b(%00010000)
			:7 dta b(0)
			
			
wybuch1		equ *
			:16 dta b(0)				
	
			;6
			dta b(%00010000)
			:2 dta b(0)
			dta b(%00101000)
			dta b(0)
			dta b(%01000100)
			dta b(0)
			dta b(%10000010)
			dta b(0)
			dta b(%01000100)
			dta b(0)
			dta b(%00101000)
			:2 dta b(0)
			dta b(%00010000)
			dta b(0)
			
			;5
			dta b(%00010000)
			dta b(0)
			:3 dta b(%00101000)
			dta b(%01000100)
			dta b(0)
			dta b(%10000010)
			dta b(0)
			dta b(%01000100)
			:3 dta b(%00101000)
			dta b(0)
			dta b(%00010000)
			dta b(0)
			
			;4
			:2 dta b(%00010000)
			:2 dta b(%00111000)
			dta b(%00101000)
			dta b(%01101100)
			dta b(%01000100)
			dta b(%11000110)
			dta b(%01000100)
			dta b(%01101100)
			dta b(%00101000)
			:2 dta b(%00111000)
			:2 dta b(%00010000)
			dta b(0)
			
			;3
			:2 dta b(%00010000)
			dta b(0)
			:2 dta b(%00101000)
			dta b(%01000100)
			dta b(%00101000)
			dta b(%10000010)
			dta b(%00101000)
			dta b(%01000100)
			:2 dta b(%00101000)
			dta b(0)
			:2 dta b(%00010000)
			dta b(0)
			
			;2
			dta b(0)
			:2 dta b(%00010000)
			dta b(0)
			:2 dta b(%00101000)
			dta b(%01000100)
			dta b(%10010010)
			dta b(%01000100)
			:2 dta b(%00101000)
			dta b(0)
			:2 dta b(%00010000)
			:2 dta b(0)
			
			;1
			:3 dta b(0)
			dta b(%00010000)
			:2 dta b(%00101000)
			dta b(%01000100)
			dta b(0)
			dta b(%01000100)
			:2 dta b(%00101000)
			dta b(%00010000)
			:4 dta b(0)
			
			;0
			:4 dta b(0)
			dta b(%00010000)
			dta b(0)
			dta b(%00101000)
			dta b(%01000100)
			dta b(%00101000)
			dta b(0)
			dta b(%00010000)
			:5 dta b(0) 

			
printShip	equ * ;przemieszczaj statek		
		lda startMapy
		beq *+3
		rts
		
		lda trafienie
		bne @+
		jmp prsp1
		
@		lda fazaWybuch
		jmi @+3	
		cmp #62
		bne @+1
		
		jsr exploAllEnemy
		mva #0 licznikStrzal
		lda conditionColor		;jeśli 0 to jest red condition , trzeba narysować
		bne prs_1
		lda conditionC+2
		sta conditionColor
		sta conditionColor1	 
prs_1	mva #15 opoz_potrafieniu
		lda sfxlicznik1
		cmp #41
		bcs @+			;jeśli wybuch to nie wyciszaj
		
		lda #128
		jsr cisza
		
@		equ *
		lda fazaWybuch		
@		asl
		and #%11110000		;rysuje nastepna faze wybuchu statku	
		tay
		ldx #0
		stx licznikStrzal		;nie wlaczaj dzwięku silnika
@		lda wybuch0,y
		sta sprites+$400+118,x
		lda wybuch1,y
		sta sprites+$500+118,x
		iny
		inx
		cpx #16
		bne @-
		;sec		;c=1
		lda fazaWybuch
		sbc #3
		sta fazaWybuch
		rts
		
@		equ *		;koniec gry
		dec opoz_potrafieniu
		bmi @+
		beq *+3
		rts
				
		lda #0
		ldx #5
_skx1	sta enemy,x
		dex
		bpl _skx1
		rts
		
@		dec lives
		bpl @+
		jmp game_over
		
@		jsr printlives
		lda zbiteBazy		;czy zbito juz wszystkie bazy
		cmp bazyIle
		bne @+
		inc poziom			;to nastepny poziom
		
		
		lda poziom		;jeśli poziom = 161 to ustaw 129 , zapetlamy
		cmp #161
		bcc skpoz1
		lda #129
		sta poziom
skpoz1	equ *
		
		jsr wczytajLevel		;ztaranowana ostatnia baza
		

		mva #2 muzyka
		
		mva #60 startMapy
		mva #54 licznikStrzal	;opoznienie dzwieku silnika
		jsr pokazBazyRadar
		jsr waitvbl
		mva movy vscrol
		mva movx hscrol
		
		mva #0 zegar
		rts
		
@		lda sfxlicznik1
		cmp #20
		bcs @+			;jeśli wybuch to nie wyciszaj
		
		lda #128
		jsr cisza
		

@		equ *
		mva #0 formacja_stan
		lda startX		
		sta posX
		lda startY
		sta posY
		
		ldy bazyIle			;wyczysc rakiety w bazach
		lda #255
@		sta bazyRakieta-1,y
		dey
		bne @-
		
		jmp initPoziom
	
		
tabjoy	dta b(0,1,2,0,4,5,6,0,8,9,10,0,0,0,0,0)
		
prsp1	lda JOY
		and #%1111
		eor #%1111
		tax
		lda tabjoy,x
		beq mryganieStatek
@		tay
		cmp sJoy
		beq mryganieStatek
@		sta sJoy
		lda licznikStrzal
		bne printShip1
		inc licznikStrzal	;zmiana kierunku= dzwiek silnikow od poczatku
printShip1	equ *
		ldx joyTable,y
		beq rrts
		jmp rstatek

		
mryganieStatek	equ *
		ldy sJoy
		bne @+
rrts	rts
@		lda statekTab+11,y
		beq rrts
		sta statek_skok+2
		lda statekTab,y
		sta statek_skok+1
statek_skok	equ *
		jmp $ffff
	
statekTab	dta b(0),b(<mstatekUp),b(<mstatekDown),b(0),b(<mstatekLeft),b(<mstatekUpLeft)	;1,2,4,5
			dta b(<mstatekDownLeft),b(0),b(<mstatekRight),b(<mstatekUpRight),b(<mstatekDownRight) ;6,8,9,10
			dta b(0),b(>mstatekUp),b(>mstatekDown),b(0),b(>mstatekLeft),b(>mstatekUpLeft)	;1,2,4,5
			dta b(>mstatekDownLeft),b(0),b(>mstatekRight),b(>mstatekUpRight),b(>mstatekDownRight) ;6,8,9,10
			
mstatekUp	equ *
		lda sprites+$500+118+14
		eor #%10010010
		sta sprites+$500+118+14
		lda sprites+$500+118+13
		eor #%10010010
		sta sprites+$500+118+13
		rts
		
mstatekDown	equ *
		lda sprites+$500+118+1
		eor #%10010010
		sta sprites+$500+118+1
		lda sprites+$500+118+2
		eor #%10010010
		sta sprites+$500+118+2
		rts
		
mstatekLeft	equ *
		lda sprites+$500+118+1
		eor #%00000001
		sta sprites+$500+118+1
		lda sprites+$500+118+2
		eor #%00000001
		sta sprites+$500+118+2
		lda sprites+$500+118+13
		eor #%00000001
		sta sprites+$500+118+13
		lda sprites+$500+118+14
		eor #%00000001
		sta sprites+$500+118+14
		lda sprites+$500+118+7
		eor #%00000001
		sta sprites+$500+118+7
		lda sprites+$500+118+8
		eor #%00000001
		sta sprites+$500+118+8	
		rts		

mstatekRight	equ *
		lda sprites+$500+118+1
		eor #%10000000
		sta sprites+$500+118+1
		lda sprites+$500+118+2
		eor #%10000000
		sta sprites+$500+118+2
		lda sprites+$500+118+13
		eor #%10000000
		sta sprites+$500+118+13
		lda sprites+$500+118+14
		eor #%10000000
		sta sprites+$500+118+14
		lda sprites+$500+118+7
		eor #%10000000
		sta sprites+$500+118+7
		lda sprites+$500+118+8
		eor #%10000000
		sta sprites+$500+118+8
		rts	
		
mstatekUpLeft	equ *
		lda sprites+$500+118+7
		eor #%00000001
		sta sprites+$500+118+7
		lda sprites+$500+118+6
		eor #%00000001
		sta sprites+$500+118+6
		lda sprites+$500+118+14
		eor #%00010000
		sta sprites+$500+118+14
		lda sprites+$500+118+15
		eor #%00010000
		sta sprites+$500+118+15
		lda sprites+$500+118+14
		eor #%00000010
		sta sprites+$500+118+14
		rts

mstatekUpRight	equ *
		lda sprites+$500+118+7
		eor #%10000000
		sta sprites+$500+118+7
		lda sprites+$500+118+8
		eor #%10000000
		sta sprites+$500+118+8
		lda sprites+$500+118+14
		eor #%00010000
		sta sprites+$500+118+14
		lda sprites+$500+118+15
		eor #%00010000
		sta sprites+$500+118+15
		lda sprites+$500+118+14
		eor #%10000000
		sta sprites+$500+118+14
		rts

mstatekDownRight	equ *
		lda sprites+$500+118+0
		eor #%00010000
		sta sprites+$500+118+0
		lda sprites+$500+118+1
		eor #%00010000
		sta sprites+$500+118+1
		lda sprites+$500+118+9
		eor #%10000000
		sta sprites+$500+118+9
		lda sprites+$500+118+8
		eor #%10000000
		sta sprites+$500+118+8
		lda sprites+$500+118+2
		eor #%10000000
		sta sprites+$500+118+2
		rts		

mstatekDownLeft	equ *
		lda sprites+$500+118+0
		eor #%00010000
		sta sprites+$500+118+0
		lda sprites+$500+118+1
		eor #%00010000
		sta sprites+$500+118+1
		lda sprites+$500+118+8
		eor #%00000010
		sta sprites+$500+118+8
		lda sprites+$500+118+9
		eor #%00000010
		sta sprites+$500+118+9
		lda sprites+$500+118+2
		eor #%00000010
		sta sprites+$500+118+2
		rts
		
rstatek	equ *
		ldy #15
@		lda statek,x
		sta sprites+$476,y
		lda statek+16,x
		sta sprites+$576,y
		dex
		dey
		bpl @-
	
		rts	
		
copyShip
		lda nobanner
		bne *+3
		rts
		
		ldx #15
@		lda sprites+$476,x			;kopiuj podczas sampla
		sta sprites1+$476,x
		lda sprites+$576,x
		sta sprites1+$576,x
		dex
		bpl @-
	
		rts
	
moveShip	equ *	;przesun ekran	
		sta ruch
		asl
		sta ruchy

		lda startMapy		;czy opoznienie po wlaczeniu nowej mapy
		cmp #10-4
		bcc *+3
		rts
		
		lda trafienie
		beq *+3
		rts
		
		lda sJOY
		and #%0100
		beq l01
		jmp movLeft

l01		lda sJOY
		and #%1000
		beq l02
		jmp movRight
	
l02		lda sJOY
		and #%0001
		beq l03
		jmp movUp

l03		lda sJOY
		and #%0010
		beq l04
		jmp movDOWN
		
l04		sec
		lda #12
		sbc movX
		sta movX0		;15-movX
		
		lda movY
		lsr @
		sta movY0		;movy/2

		rts

ksztaltJadroAL	dta b(<ksztaltJadroA0),b(<ksztaltJadroA1),b(<ksztaltJadroA2),b(<ksztaltJadroA3)
				dta b(<ksztaltJadroA4),b(<ksztaltJadroA5),b(<ksztaltJadroA6)
ksztaltJadroAH	dta b(>ksztaltJadroA0),b(>ksztaltJadroA1),b(>ksztaltJadroA2),b(>ksztaltJadroA3)
				dta b(>ksztaltJadroA4),b(>ksztaltJadroA5),b(>ksztaltJadroA6)
ksztaltJadroBL	dta b(<ksztaltJadroB0),b(<ksztaltJadroB1),b(<ksztaltJadroB2),b(<ksztaltJadroB3)
				dta b(<ksztaltJadroB4),b(<ksztaltJadroB5),b(<ksztaltJadroB6)
ksztaltJadroBH	dta b(>ksztaltJadroB0),b(>ksztaltJadroB1),b(>ksztaltJadroB2),b(>ksztaltJadroB3)
				dta b(>ksztaltJadroB4),b(>ksztaltJadroB5),b(>ksztaltJadroB6)
		
;przygotuj liczniki i wyglad jadra
initJadra	equ *
		ldy #15
@		lda ksztaltJadroA4,y
		sta znaki1+(b+16)*8,y
		sta znaki2+(b+16)*8,y
		lda ksztaltJadroB4,y
		sta znaki1+(b+18)*8,y
		sta znaki2+(b+18)*8,y
		dey
		bpl @-
			
		lda czasOtwarcia
		cmp #255
		bne @+
		
		sta openA		;jesli wartosc ujemna to zablokuj jadra
		sta openB
		mva #1 czyJadroA
		sta czyJadroB
		
		mvy #b+16+128 _bazaAJadro0+1	 ;jeśli jadra caly czas otwarte
		iny
		sty _bazaAJadro1+1
		iny
		sty _bazaBJadro0+1
		iny 
		sty _bazaBJadro1+1

		
		rts
		
@		mva #0 openA
		sta openB
		sta czyJadroA
		sta czyJadroB
		
		mva #4 licznikJadroA
		mva #20 licznikJadroB
		rts

;Animacja Jadra A
animacjaJadraA	equ *
		lda openA
		beq @+1
		cmp #255
		beq @+			;jesli ujemna wartosc to nie zmieniaj stanu
		dec openA
@		rts
	
@		mva #0 czyJadroA
		inc licznikJadroA
		lda licznikJadroA
		cmp #3
		bne @+
		mvx czasZamkniecia openA
@		cmp #19
		bne @+
		mvx czasOtwarcia openA
		odpalRakietyA		;MACRO
		mva #4 opozCoreA
		mva #1 liczCoreA
		sta czyJadroA
		rts

@		lsr @				;spowolnienie
		lsr @
		cmp #7
		bcc @+
		
		mva #0 licznikJadroA		;reset licznika
	
@		tax
		cpx #4
		bne @+
		mva #1 czyJadroA
		
@		ldy ad_jadra,x

		stx r_x1
		ldx #0
		lda ramka
		bne @+
		
jr_0	lda ksztaltJadroA0,y
		sta znaki1+(b+16)*8,x
		iny
		inx
		cpx #16
		bcc jr_0
		bcs @+1
		
@		equ *
jr_1	lda ksztaltJadroA0,y
		sta znaki2+(b+16)*8,x
		iny
		inx
		cpx #16
		bcc jr_1

r_x1	equ *+1		
@		ldx #$ff
		cpx #4		
		bne @+
		mvy #b+16+128 _bazaAJadro0+1
		iny
		sty _bazaAJadro1+1	
		rts
		
@		cpx #5
		beq @+
		rts
		
@		mvy #b+16 _bazaAJadro0+1
		iny
		sty _bazaAJadro1+1
		rts

ksztaltCoreA	equ *
		dta b(0)
		:2 dta b(%00110000)
		:2 dta b(%00111100)
		dta b(%11111011)
		dta b(%11100111)
		:2 dta b(%11010111)
		dta b(%11011011)
		dta b(%11101111)
		:2 dta b(%00111100)
		:2 dta b(%00001100)
		dta b(0)
;1
		dta b(0,0)
		:2 dta b(%00110000)
		:2 dta b(%00111100)
		dta b(%11111011)
		dta b(%11100111)
		dta b(%11011011)
		dta b(%11101111)
		:2 dta b(%00111100)
		:2 dta b(%00001100)
		dta b(0,0)
;2
		dta b(0,0,0)
		:2 dta b(%00110000)
		dta b(%00111100)
		dta b(%11111100)
		:2 dta b(%11101011)
		dta b(%00111111)
		dta b(%00111100)
		:2 dta b(%00001100)
		dta b(0,0,0)
;3	
		dta b(0,0,0,0,0)
		dta b(%00110000)
		dta b(%00111100)
		dta b(%11101111)
		dta b(%11111011)
		dta b(%00111100)
		dta b(%00001100)
		dta b(0,0,0,0,0)
		
ksztaltCoreB	equ *
		dta b(0)
		dta b(%00000011)
		dta b(%00001101)
		dta b(%11110101)
		dta b(%00111001)
		dta b(%00001101)
		dta b(%00000011)
		dta b(0,0)
		dta b(%11000000)
		dta b(%01110000)
		dta b(%01101100)
		dta b(%01011111)
		dta b(%01110000)
		dta b(%11000000)
		dta b(0)
;1
		dta b(0)
		dta b(%00000011)
		dta b(%00001101)
		dta b(%00110101)
		dta b(%00111101)
		dta b(%00001111)
		dta b(0,0,0)
		dta b(%11000000)
		dta b(%10110000)
		dta b(%01111100)
		dta b(%01011100)
		dta b(%01110000)
		dta b(%11000000)
		dta b(0)
;2
		dta b(0)
		dta b(%00000011)
		dta b(%00001011)
		dta b(%00001101)
		dta b(%00001001)
		dta b(%00001111)
		dta b(0,0,0,0)
		dta b(%11110000)
		dta b(%01100000)
		dta b(%01110000)
		dta b(%11100000)
		dta b(%11000000)
		dta b(0)
;3		
		dta b(0,0)
		dta b(%00000011)
		dta b(%00001101)
		dta b(%00000010)
		dta b(%00000011)
		dta b(0,0,0,0)
		dta b(%11000000)
		dta b(%10000000)
		dta b(%01110000)
		dta b(%11000000)
		dta b(0,0)
		
		
tabCoreA	dta b(0,16,32,48,48,32,16,0)
		
coreWaveA	equ *
		lda licznikJadroA		;jeśli otwarte jądro
		cmp #19
		beq @+
		lda openA
		cmp #255
		beq @+
		rts
@		dec opozCoreA		;opoznienie animacji
		bne @+ 
		mva #4 opozCoreA
		
		dec liczCoreA		;numer fazy animacji
		bpl @+
		mva #7 liczCoreA
		
@		ldx liczCoreA
		ldy tabCoreA,x
	
		lda ramka
		bne @+
		
		ldx #0
jad1	lda ksztaltCoreA,y
		sta znaki1+(b+16)*8,x
		iny
		inx
		cpx #16
		bne jad1

		rts
@		equ *
		ldx #0
jad2	lda ksztaltCoreA,y
		sta znaki2+(b+16)*8,x
		iny
		inx
		cpx #16
		bne jad2
		
		rts
		
;Animacja Jadra B
animacjaJadraB	equ *
		lda openB
		beq @+1
		cmp #255
		beq @+			;jesli ujemna wartosc to nie zmieniaj stanu
		dec openB
@		rts
	
@		mva #0 czyJadroB
		inc licznikJadroB
		lda licznikJadroB
		
		cmp #3
		bne @+
		mvx czasZamkniecia openB
@		cmp #19
		bne @+
		mvx czasOtwarcia openB
		odpalRakietyB		;MACRO
		mva #4 opozCoreB
		mva #1 liczCoreB
		sta czyJadroB
		rts
		
@		lsr @				;spowolnienie
		lsr @
		cmp #7
		bcc @+
		mva #0 licznikJadroB		;reset licznika
		
@		tax
		cpx #4
		bne @+
		lda licznikJadroB
		and #1
		beq @+
		sta czyJadroB	;A=1
		
@		ldy ad_jadra,x
		stx r_x2
		ldx #0
		
		lda ramka
		bne @+
		
rj_2	lda ksztaltJadroB0,y
		sta znaki1+(b+18)*8,x
		iny
		inx
		cpx #16
		bcc rj_2
		bcs @+1

@		equ *
rj_3	lda ksztaltJadroB0,y
		sta znaki2+(b+18)*8,x
		iny
		inx
		cpx #16
		bcc rj_3

r_x2	equ *+1		
@		ldx #$ff
		cpx #4		
		bne @+
		mvy #b+18+128 _bazaBJadro0+1
		iny
		sty _bazaBJadro1+1
		rts
		
@		cpx #5
		beq @+
		rts
		
@		mvy #b+18 _bazaBJadro0+1
		iny
		sty _bazaBJadro1+1
		rts
		
coreWaveB	equ *
		lda licznikJadroB		;jeśli otwarte jądro
		cmp #19
		beq @+
		lda openB
		cmp #255
		beq @+
		rts
@		dec opozCoreB		;opoznienie animacji
		bne @+ 
		mva #4 opozCoreB
		
		dec liczCoreB		;numer fazy animacji
		bpl @+
		mva #7 liczCoreB
		
@		ldx liczCoreB
		ldy tabCoreA,x
	
		lda ramka
		bne @+
		
		ldx #0
jad1b	lda ksztaltCoreB,y
		sta znaki1+(b+18)*8,x
		iny
		inx
		cpx #16
		bne jad1b
		rts
@		equ *
		ldx #0
jad2b	lda ksztaltCoreB,y
		sta znaki2+(b+18)*8,x
		iny
		inx
		cpx #16
		bne jad2b
		
		rts
		
exploAllEnemy	equ *
		ldx #5
@		lda enemy,x			;w momencie trafienia wszystkie statki wybuchaja
		beq @+
		lda enemyWybuch,x
		bne @+
		
		mva enemyFaza,x enemyLastFaza,x
		mva #8 enemyWybuch,x
		mva #EKOLOR1 enemyNegatyw,x	
		mva #>scolor2 enemyOraTab,x
		mva #exploshape enemyShapeH,x
		mva #5*2 sfx_enemyHit

@		dex
		bpl @-1
		
		ldx #7
@		lda rakietyMove,x
		beq @+	
		lda #0	
		sta rakietyStan,x
		sta rakietyMove,x
		jsr dodajMalyWybuch		;dodaj male wybuchy
		
@		dex
		bpl @-1
		
		
		lda jestSpy
		beq eal
		cmp #3
		bcs eal
		mva #0 jestSpy		;zabezpieczenie przed pojawieniem się spy
eal		rts		
				
		