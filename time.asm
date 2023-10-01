punkty	dta b(0)	
punkty1	dta b(10)
punkty2	dta b(opoznienieRed)
punkty3	dta b(opoznienieCondition)

speedEnemy0	dta b(0)
timeBonus	dta b(20),b(19),(18),b(18),b(17)
kondycja_start	equ 1
conYellow		dta b(15),b(13),b(11),b(9),b(9)
con1enemy		dta b(17),b(16),b(15),b(14),b(12)
con2enemy		dta b(32),b(29),b(27),b(26),b(25)
con3enemy		dta b(74),b(59),b(44),b(33),b(26)
spyend			dta b(136),b(126),b(119),b(116),b(111)
conred			dta b(149),b(139),b(133),b(127),b(123)
con45enemy		dta b(153),b(143),b(137),b(131),b(127)
conUpSpeed		dta b(240),b(240),b(240),b(230),b(230)
opoznienieRed	equ 3
opoznienieCondition	equ 7		;50/2/7=3.5

;zdarzenia czasowe
timeEvents	equ *
		dec punkty		;mryganie "1UP"
		bne @+
		mva #5 punkty
		lda kolor1up
		eor #kolor1ups
		sta kolor1up

		
@		equ *
		dec punkty1		;mryganie gwiazd
		bne @+
		mva #10 punkty1
		dec gwiazdyLicznik
		bpl @+
		mva #2 gwiazdyLicznik		
@		equ *	
		
		lda trafienie
		ora startMapy
		ora formacja_stan		;formacja_stan musi byc =0
		beq *+3
		rts
		
	
		ldx timeLevel		;poziom trudnosci
		dec punkty3
		jne kmryg
		mva #opoznienieCondition punkty3
		lda kondycja		;ustawiamy kondycje
		jeq kmryg1
		inc kondycja
		cmp #1
		bne @+
		mva #0 max_Enemy
		tay	;0
		mva speedEnemy0 speedEnemy	
		jmp setCondition
		
@		cmp conYellow,x
		bne @+
		
		lda #1
		jmp set_sample		;a=1 -> alarm
		
@		cmp con1enemy,x
		bne @+
		mvy #1 max_Enemy
		jmp setCondition
		
@		cmp con2enemy,x
		bne @+
		mva #2 max_Enemy
		rts
		
@		cmp con3enemy,x
		bne @+
		mva #3 max_Enemy
		rts
		
@		cmp conred,x
		bne @+	
		
		
		lda #4
		jsr set_sample		
		
		
		;ldy #2		;sampel conred 2x
		;jsr setCondition
		jmp kmryg
		
@		cmp con45enemy,x
		bne @+
		ldy #2
		jsr setCondition
		mva #9 rotate_speed1
		mva #6 rotate_speed2
		mva #5 max_Enemy
		mva #8 opoz_denemy
		sta dlicz1
		jmp kmryg
		
@		cmp conUpSpeed,x
		bne kmryg
		mva #7*32 speedEnemy		;max speed
		mva #0 kondycja
		jmp kmryg1
		

kmryg		equ *
		
		lda kondycja				;mryganie
		beq kmryg1
		cmp conred,x
		bcc @+	
kmryg1	lda formacja_stan
		bne @+
		dec punkty2
		bne @+
		mva #opoznienieRed punkty2
		lda conditionColor
		eor conditionC+2
		sta conditionColor
		sta conditionColor1
@		equ *

		rts

opoz_denemy1	dta b(0)
		
;po zbiciu bazy zmniejsz kondycję o ustalona wartośc i ustaw odpowiedni stan kondycji (green,yellow,red)
zmniejszKondycja	equ *
		ldx timeLevel
		lda kondycja
		cmp conRed,x
		bcc zmKondycja1
		
		lda con2enemy,x
		sta kondycja
		mva speedEnemy0 speedEnemy	;=yellow po red
		mva opoz_denemy1 opoz_denemy
		mva rotate_speed1d rotate_speed1
		mva rotate_speed2d rotate_speed2
		mva opoz_dlosuj losuj1
		ldy #1			;ustaw yellow
		jmp setCondition

zmKondycja1	equ *	
		sec
		lda kondycja
		bne @+
		lda #255
@		ldx timeLevel
		sbc timeBonus,x
		beq @+	;jesli zero, lub <0 to ustaw kondycja_start
		bcs @+1	
@		lda #kondycja_start+1	
		sta kondycja
		rts

@		sta kondycja
		cmp conYellow,x
		bne zm1
		inc kondycja	;nie wlaczaj sampla
		rts				;=yellow
zm1		bcs @+
		
		mvy #0 max_Enemy		;<yellow, czyli green
		jmp setCondition		;ustaw green
		
@		cmp con1enemy,x
		bne *+3
		rts 
		bcs @+
		
		rts		;<con1enemy
		
@		cmp con2enemy,x
		bne *+3
		rts		;=con2enemy
		bcs @+
		
		mva #1 max_Enemy
		rts		;<con2enemy czyli = con1enemy
		
@		cmp con3enemy,x
		bne *+3
		rts
		bcs @+
		
		ldy #2
		sty max_Enemy	;<con3enemy, czyli con2enemy
		rts
		
@		rts
		

panelTab	.he 00,d0,b0,80,30,00

schowaj_duszki	equ *	
		lda #>SPRITES1
		sta PMBASE
		mva #$02 COLPM+3		;szare tlo panelu
		
		lda #0
		ldx #3
@		sta HPOSM,x
		dex
		bpl @-
		
		
		lda #pozWyniki+7		;kolor i pozycja duszka na panelu
		sta HPOSP+2
		mva #1 SIZEP+2
		
		lda #108		;statek srodek 108
		sta HPOSP
		sta HPOSP+1
		mva #ColorShip COLPM
		mva #$f6 COLPM+1
		
		ldx rodzajSpeech
		bne @+
		rts
		
@		lda panelTab,x
		sta kolorPanel
		cpx #1		;alarm!alarm!
		bne @+
		
		jsr picAlarm
		jmp picEnemy

		
@	    cpx #5		;gameover
		bne @+
		
		jsr clrAlarm

		jmp picSkull
	
@		cpx #2	;spy!
		bne @+
		
		jmp picSpy

				
@		jsr picAlarm
		jmp picFormation

clrAlarm	equ *
		lda #0
		ldx #26
@		sta sprites1+$630,x
		dex
		bpl @-

		rts
		
picFormation	equ *
		ldx #78
@		lda formationShape,x
		sta sprites1+$670,x
		dex
		bpl @-

		rts
picAlarm	equ *
		ldx #26
@		lda alarmShape,x
		sta sprites1+$630,x
		dex
		bpl @-
		
		rts
		
picEnemy	equ *
		ldy #12
		ldx #12*4
@		lda enemyShape,y
		sta sprites1+$670+$10,x
		sta sprites1+$671+$10,x
		sta sprites1+$672+$10,x
.if .def UC
		lda #$ff
		sbx #4
.else		
		dex
		dex
		dex
		dex
.endif		
		dey
		bpl	@-
		
		rts
		
picSkull	equ *
		jsr clr_banner

		ldx #70
@		lda skullShape,x
		sta sprites1+$660,x
		dex
		bpl @-
		
		rts
		
		
picSpy		equ *
		ldx #50
@		lda spyShape,x
		sta sprites1+$680,x
		dex
		bpl @-
		
		
		rts


spyShape	equ *
		:2 dta b(%00001000)
		dta b(0)
		dta b(%00001000)
		:2 dta b(%00011100)
		dta b(0)
		:3 dta b(%00111110)
		dta b(0)
		dta b(%00101010)
		:2 dta b(%01101011)
		dta b(0)
		:3 dta b(%01101011)
		dta b(0)
		:3 dta b(%01111111)
		dta b(0)
		:3 dta b(%01111111)
		dta b(0)
		:2 dta b(%01011101)
		dta b(%01001001)
		dta b(0)
		:3 dta b(%01001001)
		dta b(0)
		:3 dta b(%01001001)
		dta b(0)
		:3 dta b(%01001001)
		dta b(0)
		:3 dta b(%00001000)
		:5 dta b(0)
		
skullShape	equ *
		:2 dta b(%00011000)
		:2 dta b(%00111100)
		dta b(0)
		:3 dta b(%01111110)
		dta b(0)
		:3 dta b(%11111111)
		dta b(0)
		:3 dta b(%10011001)
		dta b(0)
		:2 dta b(%10011001)
		dta b(%11011011)
		dta b(0)
		:3 dta b(%11111111)
		dta b(0)
		:3 dta b(%11111111)
		dta b(0)
		:3 dta b(%01111110)
		dta b(0)
		dta b(%01111110)
		dta b(%00111100)
		dta b(%00100100)
		dta b(0)
		:3 dta b(%00100100)
		dta b(0)
		dta b(%00100100)
		dta b(%00111100)
		dta b(%00011000)
		dta b(0)
		:3 dta b(%00011000)
		dta b(0)
		:3 dta b(%01000010)
		dta b(0)
		:3 dta b(%11000011)
		dta b(0)
		:2 dta b(%00100100)
		:2 dta b(%00011000)
		:2 dta b(%00100100)
		dta b(0)
		:3 dta b(%11000011)
		dta b(0)
		:3 dta b(%01000010) 
		
alarmShape	equ *
		:3 dta b(%00001000)
		:3 dta b(0)
		dta b(%01000001)
		:2 dta b(%01001001)
		dta b(0)
		:2 dta b(%00011100)
		dta b(0)
		:2 dta b(%00111110)
		dta b(0)
		:2 dta b(%00111110)
		dta b(0)
		:2 dta b(%00111110)
		dta b(%01000001)
		:5 dta b(%01111111)
		
enemyShape	equ *
		dta b(%00001000)
		dta b(%00011100)
		dta b(%00010100)
		dta b(%00110110)
		:2 dta b(%00111110)
		dta b(%01110111)
		:2 dta b(%01100011)
		:4 dta b(%01000001)
	
formationShape	equ	*
		:2 dta b(%00010000)
		:2 dta b(%00111000)
		:2 dta b(%00101000)
		:2 dta b(%01101100)
		:3 dta b(%01111100)
		:2 dta b(%11101110)
		:4 dta b(%11000110)
		:8 dta b(%10000010)
		dta b(0,0)
		:2 dta b(%00001000)
		:2 dta b(%00011100)
		:2 dta b(%00010100)
		:2 dta b(%00110110)
		:3 dta b(%00111110)
		:2 dta b(%01110111)
		:4 dta b(%01100011)
		:8 dta b(%01000001)
		dta b(0,0)
		:2 dta b(%00010000)
		:2 dta b(%00111000)
		:2 dta b(%00101000)
		:2 dta b(%01101100)
		:3 dta b(%01111100)
		:2 dta b(%11101110)
		:4 dta b(%11000110)
		:8 dta b(%10000010)
		
pokaz_duszki	equ *
		lda #>SPRITES
		sta PMBASE
		
		mva #0 SIZEP+2
		mva #$0 COLPM+3
		lda #pozWyniki
		sta HPOSP 
		lda #pozWyniki+8
		sta HPOSP+1
clr_banner		
		lda #0
		ldx #104
@		sta sprites1+$660,x
		dex
		bpl @-
		rts
		

		