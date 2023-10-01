maxBaz	equ 16		;maksymalna liczba baz
maxObiektow	equ 128	;maksymalna liczba reszty obiektow, meteory i bomby

maxPoziomow	equ 32		


;poziom trudności
spy_from_level			equ 3		;od którego poziomu pojawia się spy
formation_from_level	equ 4		;od którego poziomu pojawia się formacja
formation_speedUp_level1	equ 6		;od którego poziomu przyspiesza formacja
formation_speedUp_level2	equ 12		;max speed formacji
formation_speedUp_level3	equ 18
formation_speedUp_level4	equ 24

enemy_show_speed2		equ 2		;od którego poziomu szybciej pojawiają sie przeciwnicy
enemy_show_speed3		equ 9		;od którego poziomu szybciej pojawiają sie przeciwnicy
enemy_show_speed4		equ 17		;od którego poziomu szybciej pojawiają sie przeciwnicy
enemy_show_speed5		equ 25		;od którego poziomu szybciej pojawiają sie przeciwnicy
enemy_show_speed6		equ 35

formSpy_show_speed2		equ 6		;od którego poziomu szybciej pojawia się formacja i spy
formSpy_show_speed3		equ 11		;od którego poziomu szybciej pojawia sie formacja i spy
formSpy_show_speed4		equ 37
show_6enemy				equ 25		;od którego poziomu pojawia sie dodatkowy przeciwnik podczas formacji

timeLevel1_up			equ 8
timeLevel2_up			equ 16		;od którego poziomu zmieniają się czasy condition
timeLevel3_up			equ 39
timeLevel4_up			equ 60

//może tylko 2 poziomy szybkosci obrotu?
fast_rotate1			equ 19		;od którego leveu przyspiesza rotacja
fast_rotate2			equ 21
fast_rotate3			equ 35
fast_rotate4			equ 54

ilePociskow4			equ 12		;od którego poziomu bedą 4 pociski
ilePociskow5			equ 24		;od którego poziomu bedzie 5 pocisków
cannonAngle1			equ 7		;od którego levelu zwieksza się kąt strzalu dzialek
cannonAngle2			equ 18
cannonMaxAngle			equ 32		;maksymalny kat

//może tylko 2 poziomy predkosci?
enemy_speedUp_level1	equ 6		;kiedy przeciwnicy przyspieszają
enemy_speedUp_level2	equ 17
enemy_speedUp_level3	equ 28
enemy_speedUp_level4	equ 42		;max speed

spy_speedUp1			equ 15
spy_speedUp2			equ 31
spy_speedUp3			equ 52

levelAdr	dta a(level1)	;adresy zapisanych leveli
			dta a(level2)
			dta a(level3)
			dta a(level4)
			dta a(level5)
			dta a(level6)
			dta a(level7)
			dta a(level8)
			dta a(level9)
			dta a(level10)
			dta a(level11)
			dta a(level12)
			dta a(level13)
			dta a(level14)
			dta a(level15)
			dta a(level16)
			dta a(level17)
			dta a(level18)
			dta a(level19)
			dta a(level20)
			dta a(level21)
			dta a(level22) 	
			dta a(level23)
			dta a(level24)
			dta a(level25)
			dta a(level26)
			dta a(level27)
			dta a(level28)
			dta a(level29)
			dta a(level30)
			dta a(level31)
			dta a(level32)


openTab	dta b(255,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170)
closeTab dta b(30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180)

	
bazyCannon0a	equ $f940	;:(maxBaz*4) dta b(0)
bazyCannon0b	equ bazyCannon0a+maxBaz
bazyCannon0c	equ bazyCannon0b+maxBaz
bazyCannon0d	equ bazyCannon0c+maxBaz

bazyCannon1a	equ $f980	;:(maxBaz*4) dta b(0)
bazyCannon1b	equ bazyCannon1a+maxBaz
bazyCannon1c	equ bazyCannon1b+maxBaz
bazyCannon1d	equ bazyCannon1c+maxBaz

bazyCannon2a	equ $f9c0	;:(maxBaz*4) dta b(0)
bazyCannon2b	equ bazyCannon2a+maxBaz
bazyCannon2c	equ bazyCannon2b+maxBaz
bazyCannon2d	equ bazyCannon2c+maxBaz

bazyCannon3a	equ $fa00	;:(maxBaz*4) dta b(0)
bazyCannon3b	equ bazyCannon3a+maxBaz
bazyCannon3c	equ bazyCannon3b+maxBaz
bazyCannon3d	equ bazyCannon3c+maxBaz

bazyCannon4a	equ $fa40	;:(maxBaz*4) dta b(0)
bazyCannon4b	equ bazyCannon4a+maxBaz
bazyCannon4c	equ bazyCannon4b+maxBaz
bazyCannon4d	equ bazyCannon4c+maxBaz

bazyCannon5a	equ $fa80	;:(maxBaz*4) dta b(0)
bazyCannon5b	equ bazyCannon5a+maxBaz
bazyCannon5c	equ bazyCannon5b+maxBaz
bazyCannon5d	equ bazyCannon5c+maxBaz


level1		ins 'levels/level1.bin'
level2		ins 'levels/level2.bin'
level3		ins 'levels/level3.bin'
level4		ins 'levels/level4.bin'
level5		ins 'levels/level5.bin'
level6		ins 'levels/level6.bin'	
level7		ins 'levels/level7.bin'		
level8		ins 'levels/level8.bin'
level9		ins 'levels/level9.bin'
level10		ins 'levels/level10.bin'
level11		ins 'levels/level11.bin'
level12		ins 'levels/level12.bin'
level13		ins 'levels/level13.bin'
level14		ins 'levels/level14.bin'
level15		ins 'levels/level15.bin'
level16		ins 'levels/level16.bin'
level17		ins 'levels/level17.bin'
level18		ins 'levels/level18.bin'
level19		ins 'levels/level19.bin'
level20		ins 'levels/level20.bin'
level21		ins 'levels/level21.bin'			
level22		ins 'levels/level22.bin'
level23		ins 'levels/level23.bin'
level24		ins 'levels/level24.bin'			
level25		ins 'levels/level25.bin'
level26		ins 'levels/level26.bin'
level27		ins 'levels/level27.bin'			
level28		ins 'levels/level28.bin'
level29		ins 'levels/level29.bin'
level30		ins 'levels/level30.bin'			
level31		ins 'levels/level31.bin'
level32		ins 'levels/level32.bin'
	
;dodaje punkty
dodajPunkty	equ *
		cmp #$ff		;trafiony spy punkty od 200 do 400
		bne dpun1
		lda random
		and #%11
		sty dpunY
		tay
		beq @+
		dey
@		tya
		:4 asl
		sta spyscore
		lda spyScoreTab,y
dpunY	equ *+1
		ldy #$ff

dpun1	clc
		sed
		adc plusScore
		sta plusScore
		lda plusScore+1
		adc #0
		cld
		sta plusScore+1
		rts

initPoziom	equ *
		mva #1 sJoy		;zeruj flage trafienia statku
		ldx #15
		jsr rstatek
		
		mva #0 licznikSpyScore
		sta spyScore
		
		lda #255
		ldx #14
@		sta sfx_effect,x
		dex
		bpl @-
				
		ldx #16
		lda #0
@		sta formacja_stan,x
		dex
		bpl @-
		
		ldy #5
@		lda #0
		sta enemy,y
		sta enemyWybuch,y
		lda #1
		sta enemyEkran,y
		dey
		bpl @-
		
		ldy #7					;wyczysc rakiety
		lda #0
@		sta rakietyStan,y
		sta rakietyMove,y
		dey
		bpl @-
		
		sta mwybuchystop
		sta mwybuchystart
		sta wybuchystart
		sta wybuchystop
		sta plusScore
		sta plusScore+1
		sta nobanner
		
		mva #12 startMapy
		mva #opoznienieCondition punkty3
		mva #kondycja_start kondycja
		ldy #0
		jsr setCondition
		jsr piszCondition
		
		mva #4 opozCoreA
		sta opozCoreB
		mva #2 liczCoreA
		sta opozCoreB
		sta dowodca
		
		
;poziom trudności
;kąt strzału działek
		ldx #$0c
		lda poziom
		cmp #cannonAngle1
		bcc @+
		ldx #$0e
		cmp #cannonAngle2
		bcc @+
		ldx #$0f
@		stx kat1
		txa
		:4 asl
		sta kat2
		
		lda poziom				;maksymalny kat
		cmp #cannonMaxAngle
		bcc @+
		lda #255
		sta kat1
		sta kat2
@		equ *		
		
;predkosc przeciwników
		ldx #0*32
		lda poziom
		cmp #enemy_speedUp_level1
		bcc @+
		ldx #1*32
		cmp #enemy_speedUp_level2
		bcc @+
		ldx #2*32
		cmp #enemy_speedUp_level3
		bcc @+
		ldx #3*32
		cmp #enemy_speedUp_level4
		bcc @+
		ldx #4*32
@		stx speedEnemy0		;poczatkowa predkośc enemy	

;predkosc spy
		ldx #2*32
		lda poziom
		cmp #spy_speedUp1
		bcc @+
		ldx #3*32
		cmp #spy_speedUp2
		ldx #4*32
		cmp #spy_speedUp3
		ldx #5*32
@		stx spySpeed

;szybkosć pojawiania sie enemy zaleznie od poziomu
		ldx #40				
		lda poziom
		cmp #enemy_show_speed2
		bcc @+
		ldx #30
		cmp #enemy_show_speed3
		bcc @+
		ldx #28
		cmp #enemy_show_speed4
		bcc @+
		ldx #26
		cmp #enemy_show_speed5
		bcc @+
		ldx #24
		cmp #enemy_show_speed6
		bcc @+
		ldx #22
@		stx opoz_denemy
		stx opoz_denemy1
		stx dlicz1
		
		ldx #30			;jak często pojawiają sie spy i formacja
		lda poziom
		cmp #formspy_show_speed2
		bcc @+
		ldx #23
		cmp #formspy_show_speed3
		bcc @+
		ldx #17
		cmp #formspy_show_speed4
		bcc @+
		ldx #12
@		stx opoz_dlosuj
		stx losuj1
		
		ldx #0			;typu formacji tylko 0, 0 i 1 lub wszystkie
		lda poziom
		cmp #formation_from_level+3
		bcc @+
		ldx #%1
		cmp #formation_from_level+7
		bcc @+
		ldx #%11
@		stx formacja_maska

		ldx #2*32	;#64		;prędkośc formacji
		lda poziom
		cmp #formation_speedUp_level1
		bcc @+
		ldx #3*32
		cmp #formation_speedUp_level2
		bcc @+
		ldx #4*32		;szybko	
		cmp #formation_speedUp_level3
		bcc @+
		ldx #5*32
		cmp #formation_speedUp_level4
		bcc @+
		ldx #6*32
@		stx formacja_speed

		ldx #0			;czy podczas formacji maja pojawic sie dodatkowi przeciwnicy
		lda poziom
		cmp #show_6enemy
		bcc @+
		ldx #1
@		stx czy_6enemy

		ldx #0
		lda poziom
		cmp #timeLevel1_up
		bcc @+
		inx
		cmp #timeLevel2_up
		bcc @+
		inx
		cmp #timeLevel3_up
		bcc @+
		inx
		cmp #timeLevel4_up
		bcc @+
		inx
@		stx timeLevel

;predkość rotacji enemy
		ldx poziom
		mva #12 rotate_speed1
		mva #10 rotate_speed2
		cpx #fast_rotate1
		bcc @+
		dec rotate_speed1
		cpx #fast_rotate2
		bcc @+
		dec rotate_speed2
		cpx #fast_rotate3
		bcc @+
		dec rotate_speed1	
		cpx #fast_rotate4
		bcc @+
		dec rotate_speed2		
@		mva rotate_speed1 rotate_speed1d
		mva rotate_speed2 rotate_speed2d
		
;maksymalna liczba pociskow		
		ldx #2
		lda poziom
		cmp #ilePociskow4
		bcc @+
		inx
		cmp #ilePociskow5
		bcc @+
		inx
@		stx maxPociskow
		inx
		stx maxPociskow1
		
;szybkosc strzelania dzialka
		ldx #20
		lda poziom
		cmp #12
		bcc @+
		ldx #15
		cmp #15
		bcc @+
		ldx #13
		
@		stx opoznieniePocisku
		
		rts
		
			
wczytajLevel	equ *
			mva #0 zbiteBazy
			sta pom0	;liczba baz
			lda poziom
			sec
			sbc #1
			and #31		;zapętlamy levele
			
			asl @
			tax
			lda levelAdr,x
			sta pom
			lda levelAdr+1,x
			sta pom+1
				
			ldy #0
			lda (pom),y		;reset pozycji startowych
			and #%01111111
			
			ldx poziom		
			cpx #33
			bcc obrpoz3
			eor #255			;po zapetleniu obroc pozycje x startowa
			adc #97
obrpoz3		equ *	
			
			sta startX
			sta posX
			lda (pom),y
			and #128
			ldx poziom
			cpx #maxPoziomow+1
			bcc *+4
			lda #128		; zawsze bedą rakiety, jesli zapetlenie
			sta czyRakiety
			iny
			lda (pom),y
			sta startY
			sta posY
			iny
			lda (pom),y
			:4 lsr
			tax
			lda openTab,x
			sta czasOtwarcia
			lda (pom),y
			and #%00001111
			tax
			lda closeTab,x
			sta czasZamkniecia
			iny
			lda (pom),y
			and #%11110000
			ora #$0f
			
			sta COLPF0
			lda (pom),y
			:4 asl
			ora #$06
			sta COLPF2
			
			iny
			lda (pom),y
			sta bazyIle
			
			lda poziom				;jeśli zapętlenie poziomów to zwiększ poziom trudności
			cmp #33
			bcc @+1
			lda czasZamkniecia
			adc #4  ;c=1 -> +1
			sta czasZamkniecia
			lda czasOtwarcia
			cmp #255
			bne @+
			lda #50
@			sec
			sbc #5
			sta czasOtwarcia
@			equ *	
			
			jsr initPoziom
			
			jsr mute

			jsr piszPoziom
			jsr initJadra
		
			lda #60+85		;wydlużenie dla pierwszego poziomu
			sta startMapy
			mva #1 muzyka	;wlacz muzyke startowa
			
			clc
			lda pom
			adc #5
			sta pom
			bcc @+
			inc pom+1
			
@			ldx #0
wcl2		ldy #0
			lda (pom),y
			and #128
			asl
			rol
			sta bazyRodzaj,x		;rodzaj obiektu, 255=koniec
			
			lda #%00111111		;stan bazy
			sta bazyStan,x
			lda #255
			sta bazyRakieta,x		;wyzeruj rakiety
			lda (pom),y		;pozycja X
			and #127
			
			pha
			lda poziom 
			cmp #33
			bcc obrpoz1
			pla					;obracamy pozycje X bazy
			eor #255
			adc #120
			pha
obrpoz1		pla
			
			sta bazyX,x
			iny
			lda (pom),y		;pozycja Y
			sta bazyY,x
			clc
			lda pom
			adc #2
			sta pom
			bcc @+
			inc pom+1
			
@			lda #b
			sta bazyCannon0a,x
			sta bazyCannon1a,x
			sta bazyCannon2a,x
			sta bazyCannon3a,x
			sta bazyCannon4a,x
			sta bazyCannon5a,x
			lda #b+2
			sta bazyCannon0b,x
			sta bazyCannon1b,x
			sta bazyCannon2b,x
			sta bazyCannon3b,x
			sta bazyCannon4b,x
			sta bazyCannon5b,x
			lda #b+1
			sta bazyCannon0c,x
			sta bazyCannon1c,x
			sta bazyCannon2c,x
			sta bazyCannon3c,x
			sta bazyCannon4c,x
			sta bazyCannon5c,x
			lda #b+3
			sta bazyCannon0d,x
			sta bazyCannon1d,x
			sta bazyCannon2d,x
			sta bazyCannon3d,x
			sta bazyCannon4d,x
			sta bazyCannon5d,x
			
			inx
			cpx bazyIle
			jcc wcl2	
			
			
//losowe obiekty ;)			
			ldx poziom			
			;mva #128 bombile
			lda #64
			cpx #10
			bcc @+
			lda #96
			cpx #20
			bcc @+
			lda #128
@			sta bombile
			
			ldx #0
			
@			lda random
			and #1
			sta bombRodzaj,x
			
@			lda random
			and #%01111110	
			sta bombX,x
			lda random
			and #%11111110
			sta bombY,x

			jsr sprawdz_bazy
			bne @-		;pozycja pod bazą, jeszcze raz
			jsr sprawdz_obiekty
			bne @-
			jsr sprawdz_start
			bne @-
			
			inx
			cpx bombile
			bcc @-1
			
			
//segregowanie obiektów			
@			ldx #0
			stx pom0
			inx
			
@			lda bombY-1,x
			cmp bombY,x
			bcc segr_next
			beq segr_rowne
			bcs segr_zamien
			//gdy rowne
segr_rowne			
			lda bombX-1,x
			cmp bombX,x
			bcc segr_next
			beq segr_next
			//zamiana
segr_zamien
			lda bombX-1,x
			ldy bombX,x
			sta bombX,x
			tya
			sta bombX-1,x
			lda bombY-1,x
			ldy bombY,x
			sta bombY,x
			tya
			sta bombY-1,x
			inc pom0
segr_next	
			inx
			cpx bombIle
			bcc @-
			lda pom0
			bne @-1
			
			ldy bazyIle			;wyczysc rakiety w bazach
			lda #255
@			sta bazyRakieta-1,y
			dey
			bne @-  
			
			jmp tabBomby

sprawdz_bazy	
			ldy bazyIle
@			sec
			lda bazyX-1,y
			sbc bombX,x
			bcs *+6
			eor #255
			adc #1
			cmp #9
			bcs @+
			
			sec
			lda bazyY-1,y
			sbc bombY,x
			bcs *+6
			eor #255
			adc #1
			cmp #9
			bcs @+
			
			lda #1		;na bazie
			rts
			
@			dey
			bne @-1
			
			lda #0		;ok
			rts
			
sprawdz_obiekty
			txa
			bne *+3
			rts
			tay
			dey
			
@			lda bombY,x
			sec
			sbc bombY,y
			bcs *+6
			eor #255
			adc #1
			cmp #3
			bcs @+
			
			lda bombX,x
			sec
			sbc bombX,y
			bcs *+6
			eor #255
			adc #1
			cmp #3
			bcs @+
			
			lda #1		;pokrywa się z inną bombą
			rts
			
@			dey
			bpl @-1
spr_ok			
			lda #0		;ok
			rts
			
sprawdz_start	
			clc
			lda startx
			adc #15
			sec
			sbc bombX,x
			bcs @+
			eor #255
			adc #1
@			cmp #8
			bcs spr_ok
			
@			clc
			lda startY
			adc #14
			sec
			sbc bombY,x
			bcs @+
			eor #255
			adc #1
@			cmp #8
			bcs spr_ok
			
			lda #1		;za blisko startu
			rts
			
			

tabBomby	equ *
			lda #255
			ldx #0
@			sta tabBomb1,x
			sta tabBomb2,x
			dex
			bne @-

			ldx bombIle
			bne @+
			rts
			
@			lda bombY-1,x
			clc
			adc #1
			tay
			stx pom0			;nr bomby w pom0
			
			cpx bombIle
			bne *+4
			sty pom0b			;koncowy indeks, ustalany na poczatku
			
			ldx #28+2		;licznik 28+wysokoscBomby	
			
			lda pom0				;wypelniaj pola wartoscia danej bazy
@			sta tabBomb1,y
			dey
			cpy pom0b
			beq @+
			dex
			bne @-
			
@			tax
			dex
			bne @-2			;next bomba
			
			
;ostatnia bomba
			ldx #1
			
@			lda bombY-1,x		;pozycja startowa Ybomby-28
			sec
			sbc #28
			tay
			
			cpx #1
			bne *+4
			sty pom0b			;koncowy indeks
			
			stx pom0			;nr bomby
			
			ldx #28+2				;licznik 28+wysokość bomby
			
			lda pom0
@			sta tabBomb2,y
			iny
			cpy pom0b
			beq @+			;next
			dex
			bne @-
			
@			tax
			inx
			cpx bombIle
			bcc @-2
			beq @-2
			
			rts 

			
			
;pokazuje/ukrywa baze na radarze  , nr bazy w Y
eorBazaradar	equ *
			lda bazyX-1,y
			lsr @
			lsr @
			lsr @
			sec
			sbc #2
			bpl *+4
			lda #0
			
erb_0		tax
			lda radarBazy1,x
			sta pom3
			lda radarBazy2,x
			sta pom3+1
			lda bazyY-1,y
			jsr div100	
			;lda tabDiv100,x
			tax
			
			stx erb_1+1
			inx
			inx
@			lda sprites+$600+startWyniki+84,x
			eor pom3
			sta sprites+$600+startWyniki+84,x
			lda sprites+$300+startWyniki+84,x
			eor pom3+1
			sta sprites+$300+startWyniki+84,x
			dex
erb_1		cpx #$ff
			bcs @-

			rts
			
;pokazuje bazy na radarze	(wszystkie)		
pokazBazyRadar	equ	*
			lda #0
			ldy #100		;czyszczenie baz na radarze
@			sta sprites+$600+startWyniki+84,y
			sta sprites+$300+startWyniki+84,y
			dey
			bne @-
			
			ldy bazyIle
			
@			jsr eorBazaRadar
			
			dey
			bne @-
			
			rts			



;rysyje polozenie statku na radarze
radar	equ *		
		lda rads1	
		bmi @+		;<0 nic nie trzeba zmazywac
		
		ldy rads		;wymaz w poprzedniej pozycji
		lda sprites+$300+startWyniki+84,y
		and #%11111100
		sta sprites+$300+startWyniki+84,y
		lda sprites+$300+startWyniki+84+1,y
		and #%11111100
		sta sprites+$300+startWyniki+84+1,y
		
		lda rads1
		beq @+		;wszystko juz zmazane
		lda sprites+$300+startWyniki+84+2,y		;dodatkowe 2 punkty zmazujemy po formacji
		and #%11111100
		sta sprites+$300+startWyniki+84+2,y

@		equ *		
		inc mryganieRadarX
		lda mryganieRadarX
		and #%100
		beq @+		;puste lub formacja
		
		lda posY			;narysuj w nowej
		clc
		adc #13
		;tax
		jsr div100
		;ldy tabDiv100,x
		tay
		
		sty rads
		lda sprites+$300+startWyniki+84,y
		ora #2 
		sta sprites+$300+startWyniki+84,y
		lda sprites+$300+startWyniki+84+1,y
		ora #2
		sta sprites+$300+startWyniki+84+1,y
		
		lda posX  ;pozycja X dzielimy przez 4
		clc
		adc #15
.if .def UC
		alr #127
.else		
		and #127
		lsr @
.endif		
		lsr @
		clc
		adc #pozWyniki-1
		sta RadarX1
		mva #0 rads1		;do zmazania bedzie statek
		
		rts	
		
@		equ *
		ldy formacja_radar
		bne @+
		sty RadarX1		;y=0 poza ekranem
		dey
		sty rads1		;y=-1 nic nie będzie do zmazania
		rts
		
@		lda mryganieRadarX
		and #%10
		bne @+
		rts
@		lda enemyY+5
		jsr div100
		tay
		;ldy tabDiv100,x
		
		sty rads
		lda sprites+$300+startWyniki+84+2,y
		ora #3 
		sta sprites+$300+startWyniki+84+2,y
		lda sprites+$300+startWyniki+84,y
		ora #3
		sta sprites+$300+startWyniki+84,y
		lda sprites+$300+startWyniki+84+1,y
		ora #3 
		sta sprites+$300+startWyniki+84+1,y
		
		lda enemyX+5
		lsr
.if .def UC
		alr #$fe
.else		
		lsr
		clc
.endif		
		adc #pozWyniki-1
		sta RadarX1
		mva #1 rads1		;do zmazania formacja
		
		rts

div100	equ *
		asl
		sta pom
		lda #0
		rol
		asl pom
		rol
		sta pom+1	;x4
		
		sta pom1+1
		lda pom
		asl
		rol pom1+1
		asl
		rol pom1+1		;x32
		asl
		rol pom1+1
		sta pom1
		
		asl
		sta pom2
		lda pom1+1		;x64
		rol
		sta pom2+1
		
		clc
		lda pom
		adc pom1
		sta pom
		lda pom+1
		adc pom1+1
		sta pom+1
		
		lda pom
		adc pom2
		lda pom+1
		adc pom2+1
		rts 

		
;condition w y 0=green,1=yellow,2=red
setCondition	equ *
		;stx pom0			;x jest nieużywany
		sty kondycja_stan
	
		lda formacja_stan
		beq @+
		cmp #5
		beq @+
		rts
	
@		lda conditionC,y
		sta conditionColor
		sta conditionColor1
		tya
		asl @
		asl @
		asl @
		tay
		
		ldx #3
@		lda #255
		sta sprites+$400+startWyniki+60,x
		sta sprites+$400+startWyniki+60+11,x
		sta sprites+$500+startWyniki+60,x
		sta sprites+$500+startWyniki+60+11,x
		sta sprites+$600+startWyniki+60,x
		sta sprites+$600+startWyniki+60+11,x
		lda #63
		sta sprites+$300+startWyniki+60,x
		sta sprites+$300+startWyniki+60+11,x
		dex
		bpl @-
		
		ldx #6
@		sta sprites+$300+startWyniki+64,x
		dex
		bpl @-
		
		
		ldx #0
@		lda condition1,y
		sta sprites+$400+startWyniki+64,x
		lda condition2,y
		sta sprites+$500+startWyniki+64,x
		lda condition3,y
		sta sprites+$600+startWyniki+64,x
		inx
		iny
		cpx #7
		bne @-

		
		mva #0 sprites+$400+startWyniki+75
		sta sprites+$400+startWyniki+76

		rts	
		
;Wyswietlamy liczbe zyc
printLives	equ *
		lda lives
		cmp #4
		bcc @+
		lda #3		;maksymalnie wyswietlamy 3 statki
@		sta pom0
		
		ldx #2
@		ldy tab5,x
		lda tablives,x
		cpx pom0
		bcc @+
		lda #0
@		sta poz2lives,y
		beq @+
		clc
		adc #2
@		sta poz2mlives,y
		dex
		bpl @-2
				
		rts


		
;czy ukonczono level
czyNowyLevel	equ *
		lda trafienie
		beq *+3
		rts
		
		lda zbiteBazy		;czy zbito juz wszystkie bazy
		cmp bazyIle
		beq @+ 
		rts
		
@		lda nobanner
		cmp #2
		bcc @+
		
		lda #0		;wylacz przerwanie
		sta IRQEN
		sta sirq
		sta AUDF4
		

@		lda formacja_stan
		beq @+
		mva #0 formacja_stan
		sta formacja_radar
		jsr piszCondition
		ldy kondycja_stan		;poprzednia kondycja
		jsr setCondition
		
@		mva #9 startMapy	
		lda waitWybuch
		bmi @+1
		cmp #14
		bne @+
		
		jsr exploAllEnemy
		ldy sJoy
		mva #0 sJoy
		sta licznikStrzal
		jsr printShip1
		lda conditionColor		;jeśli 0 to jest red condition , trzeba narysować
		bne @+
		lda conditionC+2
		sta conditionColor
		sta conditionColor1	 
		
@		dec waitWybuch
		rts

@		inc poziom			;to nastepny poziom	

		ldx #<MODUL
		ldy #>MODUL
		lda #2
		jsr rmt_init
		
		mva #0  _vbsnd4
		sta kanal
		sta audc2
		
		lda poziom		;jeśli poziom = 161 to ustaw 129 , zapetlamy
		cmp #161
		bcc skpoz2
		lda #129
		sta poziom
skpoz2	equ *

		jsr wczytajLevel
		
		
		mva #2 muzyka
		
		mva #60 startMapy
		mva #54 licznikStrzal	;opoznienie dzwieku silnika
		jsr pokazBazyRadar
		mva #1 zegar
		pla			;zdejmij po jsr
		pla
		jsr waitvbl
		mva movy vscrol
		mva movx hscrol

		jmp poczatek

;pisze napis CONDITION
piszCondition	equ *
		ldx #6
@		lda nap_condition,x
		sta sprites+startWyniki+$300+48,x
		lda nap_condition+7,x
		sta sprites+startWyniki+$400+48,x
		lda nap_condition+14,x
		sta sprites+startWyniki+$500+48,x
		lda nap_condition+21,x
		sta sprites+startWyniki+$600+48,x
		dex
		bpl @-
		
		lda #0
		sta sprites+startWyniki+$300+47
		sta sprites+startWyniki+$400+47
		sta sprites+startWyniki+$500+47
		sta sprites+startWyniki+$600+47

		ldx #4
@		sta sprites+startWyniki+$300+55,x
		sta sprites+startWyniki+$500+55,x
		sta sprites+startWyniki+$600+55,x
		dex
		bpl @-
			
		rts
;formation Attack
pisz_formation	equ *		
		ldx #11
@		lda nap_form1,x
		sta sprites+startWyniki+$300+48-1,x
		lda nap_form1+12,x
		sta sprites+startWyniki+$400+48-1,x
		lda nap_form1+24,x
		sta sprites+startWyniki+$500+48-1,x
		lda nap_form1+36,x
		sta sprites+startWyniki+$600+48-1,x
		dex
		bpl @-

		
		lda formacja_typ
		asl
		asl
		asl
		asl
		tay
		lda #0
		sta sprites+startWyniki+$400+60
		sta sprites+startWyniki+$400+61
		sta sprites+startWyniki+$300+60
		sta sprites+startWyniki+$300+61
		
		ldx #6
@		sta sprites+startWyniki+$300+69,x
		dex
		bpl @-

		
		ldx #0
@		lda nap_form2-16,y
		sta sprites+startWyniki+$400+62,x
		lda #0
		sta sprites+startWyniki+$300+62,x
		sta sprites+startWyniki+$500+60,x
		sta sprites+startWyniki+$600+60,x
		iny
		inx
		cpx #16
		bne @-
		
		rts


POPRAWLIVES1	equ *
	lda #0
	ldx #6
@	sta obraz1+33+24*48,x
	sta obraz1+33+25*48,x
	sta obraz1+33+26*48,x
	dex
	bpl @-
	rts


POPRAWLIVES2	equ *
	lda #0
	ldx #6
@	sta obraz2+33+24*48,x
	sta obraz2+33+25*48,x
	sta obraz2+33+26*48,x
	dex
	bpl @-
	rts
	   
pisz_zycia	equ *
	ldx #15
@	lda statek_zapas,x
	sta sprites+startWyniki+$4c0,x
	sta sprites+startWyniki+$5c0,x
	sta sprites+startWyniki+$6c0,x
	dex
	bpl @-
	
	ldx #9
@	lda statekm_zapas,x
	sta sprites+startWyniki+$3c6,x
	dex
	bpl @-
	
	rts

czysc_duszki	equ *
	lda #0
	tax
@	sta sprites+$300,x
	sta sprites+$400,x
	sta sprites+$500,x
	sta sprites+$600,x
	sta sprites1+$600,x
	dex
	bne @-
	rts	

pisz_panel	equ *
	ldx #6
@	lda nap_hiscore,x
	sta sprites+startWyniki+$300,x
	lda nap_hiscore+7,x
	sta sprites+startWyniki+$400,x
	lda nap_hiscore+14,x
	sta sprites+startWyniki+$500,x
	lda nap_hiscore+21,x
	sta sprites+startWyniki+$600,x
	lda nap_1up,x
	sta sprites+$421+1,x
	lda nap_1up+7,x
	sta sprites+$521+1,x
	lda nap_0,x
	sta sprites+$319,x
	sta sprites+$32A,x
	lda nap_round,x
	sta sprites+$3e9-3,x
	lda nap_round+7,x
	sta sprites+$4e9-3,x
	lda nap_round+14,x
	sta sprites+$5e9-3,x
	dex
	bpl @-

	rts

	
		