			
bazyRodzaj	equ $1300		;:maxBaz dta b(0)  ;rodzaj (pozioma czy pionowa)
bazyStan	equ $1310		;:maxBaz dta b(0)	  ;stan zniszczenia
bazyRakieta	equ $1320 	;:maxBaz dta b(0)		;numer rakiety przypisanej do bazy 255=brak
bazyX		equ $1330 	;:maxBaz dta b(0)  ;pozycja x
bazyX0		equ $1340		;:maxBaz dta b(0)	;pozycja X na ekranie
bazyY		equ $1350		;:maxBaz dta b(0)	;pozycja Y
bazyY0		equ $1360	;:maxBaz dta b(0)	;pozycja Y na ekranie

rakietyStan	equ $1370	;:8 dta b(0)
rakietyTyp	equ $1378	;:8 dta b(0)
rakietyX	equ $1380	;:8 dta b(0)
rakietyX0	equ $1388	;:8 dta b(0)
rakietyY	equ $1390	;:8 dta b(0)
rakietyY0	equ $1398	;:8 dta b(0)
rakietyMove	equ $13A0	;:8 dta b(0)

mwybuchyX		equ $13A8	;org *+mwyb	;8b
mwybuchyY		equ $13B0	;org *+mwyb
mwybuchyLicznik	equ $13B8	;org *+mwyb


wybuchyX0		equ $13C0	;org *+maxWybuchow
wybuchyY0		equ $13E0	;org *+maxWybuchow

wybuchyX		equ $1400	;org *+maxWybuchow	;32b
wybuchyY		equ $1420	;org *+maxWybuchow
wybuchyLicznik	equ $1440	;org *+maxWybuchow


mwybuchyTyp		equ $1460	;org *+mwyb   ;8b
pociskiX		equ $1468	;dta b(0,0,0,0,0)
pociskiX0		equ $146e	;dta b(0,0,0,0,0)
pociskiY		equ $1474	;dta b(0,0,0,0,0)
pociskiY0		equ $147a	;dta b(0,0,0,0,0)
pociskiDX		equ $1480	;$dta b(0,0,0,0,0)
pociskiDX0		equ $1486	;dta b(0,0,0,0,0)		;pociskiDX/4+pozycja znakowa *4
pociskiDY		equ $148c	;dta b(0,0,0,0,0)
pociskiDY0		equ $1492	;dta b(0,0,0,0,0)		;pociskiDY/4
pociskiPlusX	equ $1498	;dta b(0,0,0,0,0)
pociskiPlusY	equ $149e	;dta b(0,0,0,0,0)
pociskiZnakY	equ $14a4	;dta b(0,0,0,0,0)
	
			//org $2100+$20
			org $2000
dlist_title	equ *
		dta b($70)
		dta b($42),a(obraz1)
		dta b($30)
		dta b($1b),b($5b),a(obraz1+32),b($5b),a(obraz1+32)
		dta b($1b),b($5b),a(obraz1+52),b($5b),a(obraz1+52)
		dta b($1b),b($5b),a(obraz1+72),b($5b),a(obraz1+72)
		dta b($1b),b($5b),a(obraz1+92),b($5b),a(obraz1+92)
		dta b($1b),b($5b),a(obraz1+112),b($5b),a(obraz1+112)
		dta b($1b),b($5b),a(obraz1+132),b($5b),a(obraz1+132)
		
		dta b($70,$30)
		dta b($6)
		dta b($10)
		dta b($2)
		dta b($30)
		dta b($6+$10)
		dta b($10)
		dta b($2)
		dta b($30,$6,$10,$2)		;
		dta b(112,$50)
		dta b($2)
		dta b($40)
		dta b($6,$10,$6,$10,$6,$10,$6,$10,$6)
		dta b($70,$00),b($0f,0,$0f,0,$0f,0,$0f,0,$0f,0,$0f)		;
		dta b($41),a(dlist_title)

hsdlist	dta b(112,$10)
		dta b(64+4),a(hscr)
		dta b(64+4),a(hscr+48)
		dta b(64+2),a(hscr+2*48)
		dta b(64+4),a(hscr+3*48)
		dta b($30)
		dta b(64+2),a(hscr+4*48)
		dta b(64+4),a(hscr+5*48)
		dta b(64+2),a(hscr+6*48)
		dta b(64+4),a(hscr+7*48)
		dta b(64+4),a(hscr+8*48)
		dta b($20)
		dta b(64+2),a(hscr+9*48)
		dta b(64+4),a(hscr+10*48)
		dta b(64+2),a(hscr+11*48)
		dta b(64+4),a(hscr+12*48)
		dta b(64+2),a(hscr+13*48)
		dta b(64+4),a(hscr+14*48)
		dta b(64+2),a(hscr+15*48)
		dta b(64+4),a(hscr+16*48)
		dta b(64+2),a(hscr+17*48)
		dta b(64+4),a(hscr+18*48)
		dta b(64+2),a(hscr+19*48)
		dta b(64+4),a(hscr+20*48)
		dta b(64+2),a(hscr+21*48)
		dta b(64+4),a(hscr+22*48)
		dta b(64+4),a(hscr+23*48)
		dta b(64+4),a(hscr+24*48)
		dta b(64+4),a(hscr+25*48)
		dta b(64+4),a(hscr+26*48)
		dta b(65),a(hsdlist)
		
hsdlist1	dta b(112,$10)
		dta b(64+4),a(hscr)
		dta b(64+4),a(hscr+48)
		dta b(64+2),a(hscr+48*2)		;CONGRATULATIONS !!
		dta b(64+4),a(hscr+48*3)
		dta b($40)
		dta b(64+2),a(hscr+48*4)		;THE HIGH SCORE
		dta b(64+4),a(hscr+48*5)
		dta b($40)
		dta b(64+2),a(hscr+48*6)		;OF THE DAY
		dta b(64+4),a(hscr+48*7)
		dta b(64+4),a(hscr+48*8)
		
		dta b(64+4),a(hscr+48*9)		;WYNIK
		dta b(64+4),a(hscr+48*10)
		dta b(64+4),a(hscr+48*11)
		dta b(64+4),a(hscr+48*12)
		dta b(64+4),a(hscr+48*13)
		dta b(64+4),a(hscr+48*14)
		dta b(64+4),a(hscr+48*15)
		dta b($30)		
		dta b(64+4),a(hscr+48*16)
		dta b(64+4),a(hscr+48*17)
		dta b($40)
		dta b(64+2),a(hscr+48*18)		;GO FOR THE
		dta b(64+4),a(hscr+48*19)
		dta b($40)
		dta b(64+2),a(hscr+48*20)		;SPACE RECORD NOW
		dta b(64+4),a(hscr+48*21)
		dta b(64+4),a(hscr+48*22)
		dta b(65),a(hsdlist1)
		
		
		
czyscObraz1	equ *
		lda #128
		ldx #34
@		:30 sta obraz1-1-48+#*48,x
		dex
		bpl @-
		
		rts

czyscObraz2	equ *
		lda #128
		ldx #34
@		:30 sta obraz2-1-48+#*48,x
		dex
		bpl @-
		
		rts		
		
nmi		bit $d40f
		bmi dli
		jmp vblk	
	
dli		equ *
		sta dli_reja

		mwa #pokey $fffe
			
		lda #pozWyniki
		sta HPOSP    ;hiscore
		lda #pozWyniki+8
		sta HPOSP+1
		lda #pozWyniki+16
		sta HPOSP+2
		lda #pozWyniki+24
		sta HPOSM+2
		lda #pozWyniki+26
		sta HPOSM+1
		lda #pozWyniki+28
		sta HPOSM
		lda #0
		sta SIZEM
			
		lda #kolorHiscore
		sta COLPM
		sta COLPM+1
		sta COLPM+2
		
		mva #36 AUDF4
		sta WSYNC
		
				
		mva #0 IRQEN
		mva #4 IRQEN

dli_reja	equ *+1		
		lda #$ff
		rti 
		
sam_rpt	dta b(0)		
sample_table	dta a(blastoff_wav),1		;0 = blastoff
				dta a(alive_wav),2				;1 = alarm
				dta a(spy_wav),1					;2 = spy
				dta a(formation_wav),1		;3 = formation
				dta a(conred_wav),2			;4 = condition red
				dta a(gameover_wav),1		;5 = game over
				
set_sample	equ *
			sta rodzajSpeech
			sta ssm_1
			asl
			;:2 asl
ssm_1		equ *+1			
			adc #$ff
			tay
			lda sample_table,y
			sta sam
			sta sam_l
			lda sample_table+1,y
			sta sam+1
			sta sam_h
			;lda sample_table+2,y
			;sta sam_end
			;lda sample_table+3,y
			;sta sam1_end
			lda sample_table+2,y
			sta sam_rpt
			mva #1 nobanner
			mva #255 ile_rpt
			mva #$88 probka1
			
			rts
		
pok_s1	equ *
		sta rejA
probka1	equ *+1
		lda #$ff
		sta AUDC4
		
		lda ile_rpt		
		bmi @+ 
		
		dec ile_rpt				;powtarzamy ciszę
		bmi @+
		mwa #pok_s2 $fffe
		
		mva #0 IRQEN			;zakoncz przerwanie
		mva #4 IRQEN
		lda rejA
		rti
			
@		sty rejY
		ldy #0
@		lda (sam),y
		bne @+1
		
		dec sam_rpt		;jesli koniec sampla to sprawdz czy go powtorzyc
		beq @+
sam_l	equ *+1		
		lda #$ff
		sta sam
sam_h	equ *+1		
		lda #$ff
		sta sam+1
		mva #255 ile_rpt
		jmp @-			;ponownie odczytaj probke
		
;konczy odtwarzanie sampla		probka=0
@		lda #$00
		sta AUDF4
		sta $d20e
		sta sirq

		lda rejA
		ldy rejY
		rti

;dekodowanie probki		
@				
		cmp #$10
		bcs @+
		
		and #$0f
		sta ile_rpt
		lda #%11000
		sta probka1
		sta probka2
		
		inc sam			;ustaw na nastepny bajt
		bne *+4
		inc sam+1
		
		mwa #pok_s2 $fffe
		sty IRQEN				;zakoncz przerwanie
		mva #4 IRQEN
		ldy rejY
		lda rejA
		rti	

;zwykla probka		
@		
		:4 lsr
		ora #%10000
		sta probka2
		
		mwa #pok_s2 $fffe		
		sty IRQEN		;zakoncz przerwanie
		mva #4 IRQEN
		ldy rejY
		lda rejA
		rti
			
		
pok_s2	equ *
		sta rejA
probka2	equ *+1
		lda #$ff
		sta AUDC4
		
		lda ile_rpt
		bmi @+				;koncz przerwanie
		
		mwa #pok_s1 $fffe	;nic nie zmieniaj bo powtarzamy cisze	
		mva #0 IRQEN
		mva #4 IRQEN
		
		lda rejA
		rti		
		
@		sty rejY
		ldy #0
		lda (sam),y
		and #%1111
		ora #%10000
		sta probka1
		
		inc sam
		bne *+4
		inc sam+1
		
		mwa #pok_s1 $fffe
		sty IRQEN
		mva #4 IRQEN
		
		lda rejA
		ldy rejY
		rti
		
		
pokey	equ *
		sta rejA
		
		mva #35 AUDF4
		lda #kolorLiczby		;pod Hiscore
		sta COLPM
		sta COLPM+1
		sta COLPM+2
		mva #pozWyniki+2 HPOSP
		mva #pozWyniki+10 HPOSP+1
		mva #pozWyniki+18 HPOSP+2
		
		mwa #pokey1 $fffe
		
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e
		
		lda rejA
		rti
		
pokey1	equ *
		sta rejA
		
		
		mva #pozWyniki HPOSP		;1up
		mva #pozWyniki+8 HPOSP+1
kolor1up	equ *+1
		mva #kolor1ups COLPM
		sta COLPM+1
		
		mwa #pokey2 $fffe
		mva #35 AUDF4
		
		
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e
		
		lda rejA
		rti

pokey2	equ *
		sta rejA
			
		mva #pozWyniki+2 HPOSP		;score
		mva #pozWyniki+10 HPOSP+1
		mva #kolorLiczby COLPM
		sta COLPM+1
		
		mwa #pokey3 $fffe
		
		lda #100
		sta AUDF4
				
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e

		lda rejA
		rti		
	

pokey3	equ *
		sta rejA
		
duszek4pos	equ *+1		
		mva #$ff HPOSP+3
		
		lda formacja_stan
		beq @+
		cmp #5
		bne pk3a
		
@		mva #pozWyniki HPOSM+2
duszek4kolor	equ *+1
		mva #$ff COLPM+3
		mwa #pokey4 $fffe

		
		lda #81
		sta AUDF4
				
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e

		
		lda rejA
		rti		

pk3a	mva #pozWyniki-1 HPOSM+2	
		lda conditionColor	;w czasie formacji mryga czerwonym napisem
		sta COLPM
		sta COLPM+1
		sta COLPM+2
		
		mwa #pokey4 $fffe
		
		lda #81
		sta AUDF4
			
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e
		
		lda rejA
		rti		
		
pokey4	equ *
		sta rejA
		lda #255			;condition napis
		sta AUDF4
conditionColor	equ *+1		
		lda #$ff		;conditionColor
		sta COLPM+1
		sta COLPM+2
conditionColor1	equ *+1
		lda #$ff
		sta COLPM
		
		mwa #pokey5 $fffe
				
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e
		
		lda rejA
		rti
		
pokey5	equ *
		sta rejA
		
		
		mva #kolorMapa	COLPM+3
		mva #pozWyniki-1 HPOSP+3
			
		mva #ColorShip COLPM
		
		lda #16+4
		sta SIZEM
		mva #$f6 COLPM+1
		
		sta COLPM+2
		mva #pozWyniki+19 HPOSM+2
		mva #pozWyniki+23 HPOSM+1
		
radarX1	equ *+1
		mva #$ff HPOSM  ;pozycja statku na radarze
		mva #1 SIZEP+2		;przeciwnicy na radarze
		mva #pozWyniki+3 HPOSP+2
		
		
		lda #185
		sta AUDF4
		
		mva #1+32 GTIACTL
		
		mwa #pokey5a $fffe
			
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e
		
		lda startMapy
		cmp #10
		bcs @+		
		
		lda #108 	;pozWyniki-1-68		;statek srodek 108
		sta HPOSP
		sta HPOSP+1	
		
		lda rejA
		rti
		
@		mva #0 HPOSP
		sta HPOSP+1
		
		lda rejA
		rti
		
pokey5a	equ *
		sta rejA
		
		lda #110-18
		sta AUDF4
		mwa #pokey6 $fffe
				
		lda #$00
		sta $d20e
		lda #$04
		sta $d20e
		
		lda rejA
		rti
		
pokey6	equ *
		sta rejA

		
		mva #$0d COLPM	
		sta COLPM+1
		
		sta COLPM+2
		mva #0 COLPM+3		;koniec mapy zapasowe statki
		
		sta SIZEP+2	
		sta $d20e

		mva #1+4+16+64 SIZEM
				;zakonczenie mapy
		
poz2lives equ *+1
		mva #$ff HPOSP+2		
		mva #$ff HPOSP+1
		mva #$ff HPOSP
poz2mlives	equ *+1		
		mva #$ff HPOSM+2
		mva #$ff HPOSM+1
		mva #$ff HPOSM
		mva #1+16 GTIACTL
		
		mwa #pokey7 $fffe
		
		lda #26
		sta AUDF4
				
		lda #$04
		sta $d20e

		lda rejA
		rti
			

	
pokey7	equ *
		sta rejA
			
		lda #0
		sta AUDF4
		sta SIZEM
		sta $d20e
		sta sirq
		
		mva #1 GTIACTL
		mva #pozWyniki HPOSP
		mva #pozWyniki+8 HPOSP+1
		mva #pozWyniki+16 HPOSM+1		;Round
		mva #pozWyniki+18 HPOSM
		mva #pozWyniki+22 HPOSP+2
		mva #kolorLevel COLPM+2
		mva #kolorRound COLPM
		sta COLPM+1
		
		lda rejA
		rti


sounds		equ *
/*
@			lda extraLicznik
			beq @+
			dec extraLicznik
			jmp @+3				;pomin dzwiek silnika i strzaly
		
@			lda sfx_extra
			bmi @+
			mva #30 extraLicznik		;czas trwania
			lda #0
			tax
			ldy #13*2
			jsr RASTERMUSICTRACKER+15
			mva #255 sfx_extra
			sta sfx_effect
			jmp @+2

@			lda licznikStrzal
			beq @+
			dec licznikStrzal
			bne @+
			ldy #16*2			;dzwiek silnika statku
			;ldx #0		
			lda #0
			tax
			;jsr RASTERMUSICTRACKER+15	

@			ldy sfx_effect
			bmi @+
											;dzwiek strzalu statku
									; * 2
										;Y = 2,4,..,16	instrument number * 2 (0,2,4,..,126)
			;ldx #0						;X = 3			channel (0..3 or 0..7 for stereo module)
			lda #0						;A = 12			note (0..60)
			ldx #1
			jsr RASTERMUSICTRACKER+15	;RMT_SFX start tone (It works only if FEAT_SFX is enabled !!!)

			lda #$ff
			sta sfx_effect				

@			lda sfxLicznik1
			beq @+1
			dec sfxlicznik1			
			lda sfxLicznik1
			cmp #40
			bne @+1
			
			lda formacja_stan
			cmp #3
			beq @+
			cmp #4			;formacja gdy goni ma wartosc 3 lub 4
			bne @+1
@			lda trafienie
			bne @+
			lda #0
			jsr cisza		;dzwiek alarmu, wlacz po wybuchu

@			ldy sfx_wybuch
			bmi @+
			
			mva #70 sfxLicznik1
			ldx #1
			lda #0
			jsr RASTERMUSICTRACKER+15
			
			lda #$ff
			sta sfx_wybuch

@			lda formacja_stan			;czy aby nie ma dzwieku formacji?
			cmp #3
			beq @+1
			cmp #4
			beq @+1
			
			ldy sfx_rakieta			
			bmi @+
			lda sfxlicznik1			;jesli licznik <40 to dodaj dzwiek rakiety
			cmp #40
			bcs @+
			
			mva #39 sfxlicznik1
			ldx #1
			lda #0
			jsr RASTERMUSICTRACKER+15
			jmp @+1
			
			
@			ldy sfx_antyair
			bmi @+1 
			
			lda sfxlicznik1
			bne @+
			
			ldx #1						;jesli nie ma zadnych innych dzwiekow to dodaj dzwiek strzalu dzialka
			lda #0
			jsr RASTERMUSICTRACKER+15
			
@			lda #$ff
			sta sfx_antyair
			sta sfx_rakieta
			
			
			
@			ldy sfx_dzialko		;wybuch dzialka bazy
			bmi @+
			
			ldx #2-1
			lda #0
			jsr RASTERMUSICTRACKER+15
			jmp eChannel2
			
@			ldy sfx_bomba
			bmi @+
			
			ldx #2-1
			lda #0
			jsr RASTERMUSICTRACKER+15
			jmp eChannel2			
			
@			ldy sfx_enemyHit
			bmi @+
			
			ldx #2-1
			lda #0
			jsr RASTERMUSICTRACKER+15
			jmp eChannel2
			
@			ldy sfx_asteroid
			bmi @+
			
			ldx #2-1
			lda #0
			jsr RASTERMUSICTRACKER+15		


eChannel2	equ *
			lda #$ff
			sta sfx_asteroid
			sta sfx_enemyHit
			sta sfx_bomba
			sta sfx_dzialko


@			ldy sfx_dead
			bmi @+
			
			
			ldx #0+1
			lda #0
			ldy sfx_dead
			jsr RASTERMUSICTRACKER+15
			
			lda #$ff
			sta sfx_dead	 */			
				
			
@			lda muzyka
			beq graj
			cmp #1
			bne @+
			
			ldx <(rmt_goto+$0*4)		;START	
			ldy >(rmt_goto+$0*4)
			stx p_song
			sty p_song+1
			jsr GetSongLine
			jmp graj
			
		
@			cmp #2				;nowy level
			bne @+
			
			
			ldx <(rmt_goto+$4*4)		; NEXTLEVEL
			ldy >(rmt_goto+$4*4)
			stx p_song
			sty p_song+1
			jsr GetSongLine

@			equ *
						
graj		mva #0 muzyka
			rts		
			
;przerwanie vblk
vblk		equ *
			sta vblA

			inc zegar
			;lda opoznienieFire
			;bmi @+
			;dec opoznienieFire
;@			
			lda stan_gry
			jeq vblk1
			cmp #1
			bne @+

			
			stx vblX
			sty vblY
			
			jsr rmt_play
			
			
			ldx vblX
			ldy vblY
			
			jmp vblk1

@			equ *
			lda pauza
			bne @+			;podczas pauzy nie odgrywaj dzwiekow

			jsr sfx.play_fx
			
			lda formacja_stan
			beq for2
			cmp #5
			bcs for0
			bcc for1
for2			
			lda petla1
			beq for0
			mva #0 kanal1
			sta petla
			beq for0
for1			
			lda petla1
			bne for0
			sty vblY
			ldy #fx_alarm
			lda #3
			jsr sfx.add_fx1
			ldy vblY
for0			
			
_vbsnd1		equ *+1			
			lda #$ff		;zamiast SETPOKEY
			sta $d200
_vbsnd2		equ *+1			
			lda #$ff
			sta $d201
_vbsnd3		equ *+1			
			lda #$ff
			sta $d200+2
_vbsnd4		equ *+1			
			lda #$ff
			sta $d201+2
_vbsnd5		equ *+1			
			lda #$ff
			sta $d200+4
_vbsnd6		equ *+1			
			lda #$ff
			sta $d201+4
			
_vbsnd7		equ *+1			
			lda #$ff
			sta $d208		
			
			lda #0
			sta _vbsnd2			;nie zapamietuj dzwiekow
			sta _vbsnd4
			sta _vbsnd6
			
@			lda vblFlaga
			beq vblk1
	
			lda trafienie		
			ora startMapy
			bne vblk1
			
			pla
			sta znacznik
			pla
			sta vb_ad+1		;adres powrotu
			pla
			sta vb_ad+2
			beq vblk2
				
			lda #>vb_strzal
			pha
			lda #<vb_strzal		;adres pod ktory skoczymy po zakonczeniu przerwania
			pha	
			lda znacznik
			pha					;znacznik

			rti					;opusc przerwanie
			
vblk1		equ *
			
			lda vblA

			rti
			
vblk2			
			pha					;jeślśli vblk przerwie irq to pomin strzal
			lda vb_ad+1
			pha
			lda znacznik
			pha
			lda vblA
			dec vblFlaga
			rti			
tab_movx	dta 0,0,0,0,1,1,1,0,-1,-1,-1	
tab_movy	dta 0,-2,2,0,0,-2,2,0,0,-2,2
movx2		dta 0
movy2		dta 0
		
;wywołanie procedury podczas przerwania vblk			
vb_strzal	equ *	
			php
			cld		
			
			stx vblX
			sty vblY
			dec ramka
			lda ramka4
			eor #4
			sta ramka4
			
/*			lda zegar
			cmp #1
			bne @+
			beq @+

			ldx sJoy
			clc
			lda movX1
			adc tab_movx,x
			sta hscrol
			sta movx1
			sec
			lda #12
			sbc movx1
			sta movx2
			
			
			clc
			lda movy1
			adc tab_movy,x
			sta movy1
			bpl pp0
			sec
			lda dlist+2
			sbc #48
			sta dlist+2
			bcs *+5
			dec dlist+3
			lda #6
pp0			
			sta vscrol
			
			clc
			lda movy1
			sta movYs
			bpl *+5
			sec
			lda #$ff
			ror
			sta movy2		
			
			
@			*/
			
			;jsr moveStrzal
			;jsr obliczStrzalXY2
			jsr printStrzal

			

			mva movx0 movx2
			mva movy0 movy2
			mva movY movYs
			
			 
			inc ramka
			lda ramka4
			eor #4
			sta ramka4
			
			dec vblFlaga
			
			ldx vblX		;przywroc rejestry i znaczniki
			ldy vblY
			lda vblA
			plp
vb_ad		jmp $ffff		
		
		
playerNapis2	dta b(116,121,117,123,0,0,125,118,123,124)

zmaz_radar	equ *
		ldy rads		;wymaz pozycje statku/formacji na radarze
		lda sprites+$300+startWyniki+84,y
		and #%11111100
		sta sprites+$300+startWyniki+84,y
		lda sprites+$300+startWyniki+84+1,y
		and #%11111100
		sta sprites+$300+startWyniki+84+1,y
		lda sprites+$300+startWyniki+84+2,y		;dodatkowe 2 punkty zmazujemy po formacji
		and #%11111100
		sta sprites+$300+startWyniki+84+2,y
		rts
		
game_over	equ *
		jsr init_fx	;jsr mute
		;jsr playFX
		
		jsr sumaPunkty		;dodaj i wyświetl punkty jeśli gra nie zdążyła dodać
		lda scoreZmiana
		bne @+
		jsr piszScore1		
		jsr czyHscore
@		equ *
		
		jsr livesRedOff
		
		mva #0 sfxlicznik1

@		ldx #104		;12znakow
@		lda player1chars-1,x
		sta znaki1-1+115*8,x
		sta znaki2-1+115*8,x
		dex
		bne @-
		
		ldx #9
@		lda playerNapis2,x
		beq @+
		ora #128
		sta obraz1+11+14*48,x
		sta obraz2+11+14*48,x
@		dex
		bpl @-1
	
		;jsr waitvbl
		
		ldy #25
		jsr wait
		

		
		
		mva #5 rodzajSpeech
		jsr set_sample
		jsr schowaj_duszki
		
		mva #0 hposp
		sta hposp+1			;schowaj statek
			
		mva #%01000000 NMIEN
		sei
		mwa #pok_s1 $fffe
		lda #15
		sta AUDF4
		mvy #0 IRQEN		;odpal sampel
		cli
		
		mva #4 sirq
		sta IRQEN
		
		mva #0 zegar
		
wa1		cmp zegar
		beq *-2
		
		ldx #1
		jsr changePanelColor
		
		lda zegar
		cmp #70
		bcc wa1
		
gov2	;jsr cisza
		;jsr playFX
		lda FIRE
		beq *-3
		jsr waitvbl
		
		mva #0 DMACTL	
		jsr pokaz_duszki
		
		mva #0 AUDF4
		sta nobanner
		
		mva #%11000000 NMIEN
		
		sta stan_gry	;nie graj dzwiekow
		
		sta formacja_stan		;A=0
		jsr piszCondition
		ldy kondycja_stan
		jsr setCondition
			
@		pla		;usuwamy adres powrotu po jsr PrintShip
		pla
		
		jsr zmaz_radar
		
		jsr gameover1	;jsr highscore  
		
		jmp title_s

hscNick1	dta c'A',b(91),c'R',b(0)
hscNick2	dta c'T',b(91),c'U',b(0)
hscNick3	dta c'A',b(91),c'L',b(0)
hscNick4	dta c'R',b(91),c'E',b(0)
hscNick5	dta c'I',b(91),c'Z',b(0)	
hscScore1	dta b($00,$20,$00),(2)	
hscScore2	dta b($00,$20,$00),(2)
hscScore3	dta b($00,$20,$00),(2)
hscScore4	dta b($00,$20,$00),(2)
hscScore5	dta b($00,$20,$00),(2)


;inicjuje efekty dzwiekowe
init_fx	equ *
		ldx #<MODUL					;low byte of RMT module to X reg
		ldy #>MODUL					;hi byte of RMT module to Y reg
		lda #2						;starting song line 0-255 to A reg 	
		jsr RASTERMUSICTRACKER
		jmp playFX
		
playFX	equ *		;dodaje fx'y do kolejki
		jsr RMT_P1
		
		lda trackn_audf+0		;zamiast SETPOKEY
		sta _vbsnd1
		lda trackn_audc+0
		sta _vbsnd2
		lda trackn_audf+1
		sta _vbsnd3
		lda trackn_audc+1
		sta _vbsnd4
		lda trackn_audf+2
		sta _vbsnd5
		lda trackn_audc+2
		sta _vbsnd6
			
		lda v_audctl
		sta _vbsnd7	
			
		rts
		
cisza	equ *
		rts
		bmi @+
		tya
		pha
		ldy #fx_alarm
		lda #1
		jsr sfx.add_fx1
		pla
		tay
		rts
@
		mva #0 kanal1
		rts

		
mute	equ *
		ldx <(rmt_goto+$02*4)		
		ldy >(rmt_goto+$02*4)
		stx p_song
		sty p_song+1
		jmp GetSongLine		
		
wait	equ *	;czas w Y
		tya
		clc
		adc zegar
@		cmp zegar
		bne @-
		rts
		
waitvbl	equ *
		lda zegar
@		cmp zegar
		beq @-
		rts
		
		