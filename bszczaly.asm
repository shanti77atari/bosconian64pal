STRZALSPEED	equ 2+1
skosspeed=2

pushFire		equ *
			;mva movY movYs
			
			lda opoznienieFire
			bmi @+
			dec opoznienieFire
			bpl @+1
		
@			lda FIRE
			bne @+
			jmp dodajStrzal
pf0			mva #6 opoznienieFire
			bne pf1
			
@			lda FIRE
			beq pf1
			cmp sFIRE
			beq pf1
			mva #0 opoznienieFire
			
pf1			mva FIRE sFIRE
			rts

dodajStrzal		equ *
			ldx #0
			lda strzal,x
			ora strzal+1,x
			beq @+
			ldx #2
			lda strzal,x
			ora strzal+1,x
			bne pf0			
			
@			;mva #6*2	sfx_effect
			;mva #12 licznikStrzal		;dlugosc dzwieku strzalu
			
			ldy #fx_strzal
			lda #1
			jsr sfx.add_fx
			
			ldy	sJoy
			bne @+
			ldy #1	;jesli nie poruszono jeszcze joystickiem to wybierz gore
@			lda strzalTab5,y
			sta _strzalJump0+1
			lda strzalTab5+11,y
			sta _strzalJump0+2
			
_strzalJump0	equ *
			jmp $ffff
			
strzalTab5	dta b(<_rts,<goraDol,<goraDol,<_rts,<lewoPrawo,<skos1,<skos2,<_rts,<lewoPrawo,<skos2,<skos1)
			dta b(>_rts,>goraDol,>goraDol,>_rts,>lewoPrawo,>skos1,>skos2,>_rts,>lewoPrawo,>skos2,>skos1)
			
;prawoGora i lewoDol
skos2		equ *
			mva #1 strzal,x
			sta strzal+1,x
			
			mva #3 strzalKierunek,x
			sta strzalKierunek+1,x	

			mva #17*4-1 strzalX,x
			mva #13*4 strzalY,x
			
			mva #15*4-1 strzalX+1,x
			mva #15*4 strzalY+1,x
			
			jmp pf0
			
;LewoGora i prawoDol
skos1		equ *
			mva #1 strzal,x
			sta strzal+1,x
			
			mva #2 strzalKierunek,x
			sta strzalKierunek+1,x
			
			mva #15*4 strzalX,x
			mva #13*4 strzalY,x
			
			mva #17*4 strzalX+1,x
			mva #15*4 strzalY+1,x
			
			jmp pf0
			
;strzaly poruszaja sie w gore i dol			
goraDol		equ *
			mva #1 strzal,x
			sta strzal+1,x
			
			sta strzalKierunek,x
			sta strzalKierunek+1,x
			
			mva #16*4-1 strzalX,x
			sta strzalX+1,x
			
			mva #12*4+3 strzalY,x
			mva #15*4+1 strzalY+1,x
			
_rts		jmp pf0	

;strzaly poruszają się w prawo i w lewo			
lewoPrawo	equ *
			mva #1 strzal,x
			sta strzal+1,x

			mva #0 strzalKierunek,x
			sta strzalKierunek+1,x
			
			mva #15*4-1 strzalX,x
			mva #17*4+1 strzalX+1,x
			
			mva #14*4 strzalY,x
			sta strzalY+1,x
			
			jmp pf0

;poruszaj strzalami			
movestrzal	equ *
			ldx #2
@			lda strzal,x
			ora strzal+1,x
			beq mst1
			ldy strzalKierunek,x
			lda strzalTab1,y
			sta _strzalJump+1
			lda strzalTab1+4,y
			sta _strzalJump+2
_strzalJump	jmp $ffff
mst1		dex
			dex
			bpl @- 
			
			rts

strzalTab1	dta b(<moveStrzalLP,<moveStrzalGD,<moveStrzalSkos1,<moveStrzalSkos2)
			dta b(>moveStrzalLP,>moveStrzalGD,>moveStrzalSkos1,>moveStrzalSkos2)


;prawoGora i lewoDol
moveStrzalSkos2	equ *
			lda strzal,x
			beq @+
			clc
			lda strzalX,x
			adc #skosspeed
			sta strzalX,x
			;sec
			lda strzalY,x
			sbc #skosspeed-1
			sta strzalY,x
			bpl @+
			mva #0 strzal,x
			
@			lda strzal+1,x
			beq @+
			sec
			lda strzalX+1,x
			sbc #skosspeed
			sta strzalX+1,x
			;clc
			lda strzalY+1,x
			adc #skosspeed-1
			sta strzalY+1,x
			cmp #112
			bcc @+
			mva #0 strzal+1,x
						
@			jmp mst1
			
;lewoGora i PrawoDol
moveStrzalSkos1	equ *
			lda strzal,x
			beq @+
			sec
			lda strzalX,x
			sbc #skosspeed
			sta strzalX,x
			lda strzalY,x
			sbc #skosspeed
			sta strzalY,x
			bpl @+
			mva #0 strzal,x
			
@			lda strzal+1,x
			beq @+
			clc
			lda strzalX+1,x
			adc #skosspeed
			sta strzalX+1,x
			lda strzalY+1,x
			adc #skosspeed
			sta strzalY+1,x
			cmp #112
			bcc @+
			mva #0 strzal+1,x
			
@			jmp mst1

;os pionowa
moveStrzalGD	equ *
			lda strzal,x
			beq @+
			sec
			lda strzalY,x
			sbc #STRZALSPEED
			sta strzalY,x
			bpl @+
			mva #0 strzal,x
			
@			lda strzal+1,x
			beq @+
			clc
			lda strzalY+1,x
			adc #STRZALSPEED
			sta strzalY+1,x
			cmp #112
			bcc @+
			mva #0 strzal+1,x
			
@			jmp mst1
			
;os pozioma			
moveStrzalLP	equ *
			lda strzal,x
			beq @+
			sec
			lda strzalX,x
			sbc #STRZALSPEED
			sta strzalX,x
			bpl @+
			mva #0 strzal,x
			
@			lda strzal+1,x
			beq @+
			clc
			lda strzalX+1,x
			adc #STRZALSPEED
			sta strzalX+1,x
			bpl @+
			mva #0 strzal+1,x
		
@			jmp mst1

			
;obliczamy obecną pozycję X,Y pocisku (X1,Y1)
obliczStrzalXY2	equ *
			ldx #3
					
@			lda strzal,x
			beq @+
			
			lda strzalX,x
			clc
			adc movX2
			
			sta strzalX3,x	;pozycja z poprawka przesuniecia obrazu
			and #%11
			sta strzalXbit,x
			lda strzalX3,x
			lsr @
			lsr @
			sta strzalX2,x
			
			clc
			lda movY2
			adc strzalY,x
			sta strzalY3,x	;pozycja z poprawka przesuniecia obrazu
			and #%11
			sta strzalYbit,x
			lda strzalY3,x
			lsr @
			lsr @
			sta strzalY2,x
			
@			dex
			bpl @-1
			
			rts
/*			
locateStrzal1	equ *
			ldx #3
@			lda strzal,x
			beq @+
			
			ldy strzalY2,x
			
			clc
			lda obraz1L,y
			adc strzalX2,x
			sta pom1
			lda obraz1H,y
			adc #0
			sta pom1+1
			
			ldy #0	
			lda (pom1),y
			sta strzalTlo1,x		;do zmazania 
			and #127
			cmp #firstStrzalChar
			bcc @+
			cmp #firstPociskChar
			bcs @+
			lda strzalTlo,x			;ta sama pozycja co ostatnio
			sta strzalTLo1,x
			
@			dex
			bpl @-1
			rts
			
locateStrzal2	equ *
			ldx #3
@			lda strzal,x
			beq @+
			
			ldy strzalY2,x
			
			clc
			lda obraz2L,y
			adc strzalX2,x
			sta pom1
			lda obraz2H,y
			adc #0
			sta pom1+1	
			
			ldy #0	
			lda (pom1),y
			sta strzalTlo1,x		;do zmazania 
			and #127
			cmp #firstStrzalChar
			bcc @+
			cmp #firstPociskChar
			bcs @+
			lda strzalTlo,x			;ta sama pozycja co ostatnio
			sta strzalTLo1,x
			
@			dex
			bpl @-1
			rts  */

			
;obliczenia ktore powtarzaja sie podczas rysowania pociskow				
obliczStrzal	equ *
			lda strzalXbit,x
			tay
			lda strzalTab6,y
			sta strz0b		;ora
			
			ldy strzalY2,x
			cpy #$3f
			bne *+4
			ldy #0
			
			lda ramka
			bne @+
			
			clc
			lda obraz1L,y
			adc strzalX2,x
			sta strz1
			sta zmazTab,x
			lda obraz1H,y
			adc #0
			sta strz1+1
			sta zmazTab+4,x
			jmp @+1		;skok bezwarunkowy
			
@			clc
			lda obraz2L,y
			adc strzalX2,x
			sta strz1
			sta zmazTab,x
			lda obraz2H,y
			adc #0
			sta strz1+1	
			sta zmazTab+4,x
			
@			ldy #0	
			lda (strz1),y
			;sta strzalTlo,x		;do zmazania 
			tay
			and #128
			ora strzalTab0,x
			tax
			
			lda adresZnakL,y	;nr znaku pod pociskiem
			sta strz
			lda adresZnakH,y
			ora ramka4
			sta strz+1
			
			ldy #0
			txa
			sta (strz1),y
			lda adresZnakL,x
			sta strz1
			
			lda adresZnakH,x
			ora ramka4
			sta strz1+1			
			rts
		
;narysuj strzaly na ekranie, albo je usun(poza ekranem)			
printStrzal	equ *
			ldx #3
@			lda strzal,x
			beq @+
			ldy strzalKierunek,x
			sty strz0f
			lda strzalTab2,y
			sta _strzalJump1+1
			lda strzalTab2+4,y
			sta _strzalJump1+2
			
			stx strz0d
_strzalJump1	equ *
			jmp $ffff
pst1		ldx strz0d
@			dex
			bpl @-1
			
			rts

strzalTab2	dta b(<printStrzalLP,<printStrzalGD,<printStrzalSkos1,<printStrzalSkos1)
			dta b(>printStrzalLP,>printStrzalGD,>printStrzalSkos1,>printStrzalSkos1)

strzalTab0		:4 dta b(firstStrzalChar+#)

;strzaly lewoGora i prawoDol
printStrzalSkos1	equ *
			lda vblFlaga
			beq @+
			
			ldy #0
			lda zmazTab,x
			sta strz
			lda zmazTab+4,x
			sta strz+1
			;lda strzalTlo,x
			lda #$80
			sta (strz),y
			
@			jsr obliczStrzal
			
			ldx strz0d
			lda strzalYbit,x
			
			tay				
			lda strzalTab8,y
			sta _strzalSkos1+1
			lda strzalTab8+4,y
			sta _strzalSkos1+2
_strzalSkos1	equ *
			jmp $ffff
			
@			
		
strzalSkos10	equ *
			ldy #7			;0010
@			lda (strz),y		;0000
			sta (strz1),y	;0000
			dey				;0000
			cpy #1
			bne @-

@			lda (strz),y
			eor strz0b
			sta (strz1),y
			dey
			bpl @-
			
			jmp pst1
			
strzalSkos11	equ *			
@			ldy #7			;na gorze
@			lda (strz),y		;0100
			sta (strz1),y	;0010
			dey				;0000
			cpy #3			;0000
			bne @-
			
@			lda (strz),y
			eor strz0b
			sta (strz1),y
			dey
			cpy #1
			bne @-
			
			lda strz0f
			cmp #3
			beq @+
			
			asl strz0b
			asl strz0b	;skos1  \
			lda (strz),y
			eor strz0b
			sta (strz1),y
			dey
			bpl *-7
			
			jmp pst1
			
@			lsr strz0b
			lsr strz0b		;skos2 /
			
			lda (strz),y
			eor strz0b
			sta (strz1),y
			dey
			bpl *-7
			
			jmp pst1
			
strzalSkos12	equ *
			ldy #7					;0000
@			lda (strz),y			;0100
			sta (strz1),y			;0010
			dey						;0000
			cpy #5
			bne @-		
							
@			lda (strz),y
			eor strz0b
			sta (strz1),y
			dey
			cpy #3
			bne @-
			
			lda strz0f
			cmp #3
			beq @+
			
			asl strz0b
			asl strz0b	;skos1  \
			lda (strz),y
			eor strz0b
			sta (strz1),y
			dey
			cpy #1
			bne *-9
			
			lda (strz),y
			sta (strz1),y
			dey
			bpl *-5

			jmp pst1	
			
@			lsr strz0b
			lsr strz0b		;skos2 /
			
			lda (strz),y
			eor strz0b
			sta (strz1),y
			dey
			cpy #1
			bne *-9
			
			lda (strz),y
			sta (strz1),y
			dey
			bpl *-5

			jmp pst1	

strzalSkos13	equ *	
			ldy #7
@			lda (strz),y		;na dole
			eor strz0b
			sta (strz1),y		;0000
			dey					;0000
			cpy #5				;0100
			bne @-				;0010
			
			lda strz0f
			cmp #3
			beq @+
			
			asl strz0b
			asl strz0b	;skos1  \
			lda (strz),y		
			eor strz0b
			sta (strz1),y
			dey
			cpy #3
			bne *-9
			
			lda (strz),y
			sta (strz1),y
			dey
			bpl *-5
			
			jmp pst1
			
@			lsr strz0b
			lsr strz0b		;skos2 /
			
			lda (strz),y		
			eor strz0b
			sta (strz1),y
			dey
			cpy #3
			bne *-9
			
			lda (strz),y
			sta (strz1),y
			dey
			bpl *-5
			
			jmp pst1
			
strzalTab8	dta b(<strzalSkos10,<strzalSkos11,<strzalSkos12,<strzalSkos13)
			dta b(>strzalSkos10,>strzalSkos11,>strzalSkos12,>strzalSkos13)			


strzalTab3		dta b(%01000000,%01010000,%00010100,%00000101)

printStrzalLP	equ *
;rejestr X (nr pocisku) w strz0d
			lda vblFlaga
			beq @+1
			;lda strzalTlo,x
			lda #$80
			ldy ramka
			bne @+			;odwrotne obrazy
			ldy strzalX1,x
			sta obraz1+14*48,y
			jmp @+1
@			ldy strzalX1,x
			sta obraz2+14*48,y
			
@			lda strzalX3,x
			
			and #%11
			tay
			
			lda strzalTab3,y
			sta strz0b		;Ora
					
			lda strzalX2,x
			tay
			sta strzalX1,x		;do zmazania
			lda strzalY2,x
			sta strzalY1,x		;do zmazania
			
			
			lda ramka
			bne @+
		
			lda obraz1+14*48,y
			sta strzalTlo,x		;do zmazania 
			
			lda obraz1+14*48,y
			and #128
			ora strzalTab0,x

			sta obraz1+14*48,y
			tay
			lda adresZnakL,y 	;adres znaku pocisku
			sta strz1
			lda adresZnakH,y
			sta strz1+1
			
			ldy strzalTlo,x
			
			lda adresZnakL,y 	;adres znaku pod pociskiem
			sta strz
			lda adresZnakH,y
			sta strz+1	
			
			jmp slp1		;jmp
				
				
@			lda obraz2+14*48,y
			sta strzalTlo,x		;do zmazania 
			
			lda obraz2+14*48,y
			and #128
			ora strzalTab0,x

			sta obraz2+14*48,y
			tay
			lda adresZnakL,y 	;adres znaku pocisku
			sta strz1
			lda adresZnakH,y
			ora #4
			sta strz1+1
			
			ldy strzalTlo,x
			
			lda adresZnakL,y 	;adres znaku pod pociskiem
			sta strz
			lda adresZnakH,y
			ora #4
			sta strz+1	
			
slp1		equ *			
			ldy #7
@			lda (strz),y
			cpy movYs
			bne *+4
			eor strz0b
			sta (strz1),y
			dey
			bpl @-
			
			jmp pst1
			

						
strzalTab6	dta b(%01000000,%00010000,%00000100,%00000001)
			dta b(%00111111,%11001111,%11110011,%11111100)
				
printStrzalGD	equ *
			lda vblFlaga
			beq @+
			
			ldy #0
			lda zmazTab,x
			sta strz
			lda zmazTab+4,x
			sta strz+1
			;lda strzalTlo,x
			lda #$80
			sta (strz),y
			
@			jsr obliczStrzal	
			
			ldx strz0d
			lda strzalYbit,x
			
			tay					;skok z OBLICZ przy pustym znaku
			lda strzalTab7,y
			sta _strzalGD+1
			lda strzalTab7+4,y
			sta _strzalGD+2
_strzalGD	jmp $ffff
			
	
strzalGD0	equ *
			ldy #7
@			lda (strz),y
			cpy #2
			bcs *+4
			eor strz0b
			sta (strz1),y
			dey
			bpl @-

			jmp pst1

strzalGD1	equ *			
			ldy #7			;na gorze
@			lda (strz),y
			cpy #4
			bcs *+4
			eor strz0b
			sta (strz1),y
			dey
			bpl @-
			
			jmp pst1
			
strzalGD2	equ *
			ldy #7
@			lda (strz),y
			cpy #2
			bcc *+8
			cpy #6
			bcs *+4
			eor strz0b
			sta (strz1),y
			dey
			bpl @-

			jmp pst1
			
strzalGD3	equ *	
			ldy #7
@			lda (strz),y		;na dole
			cpy #4
			bcc *+4
			eor strz0b
			sta (strz1),y	
			dey
			bpl @-

			
			jmp pst1
			
strzalTab7	dta b(<strzalGD0,<strzalGD1,<strzalGD2,<strzalGD3)
			dta b(>strzalGD0,>strzalGD1,>strzalGD2,>strzalGD3)
			