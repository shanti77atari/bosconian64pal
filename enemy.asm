
	
			
;Ucieczka przeciwnikow, korekcja ich lotu
Ucieczka	equ *
		ldy #0
		lda enemyY0,x
		bmi @+		;jesli wartosc ujemna to przyjmij 0
		cmp #14
		bcc @+
		ldy #2

@		lda enemyX0,x
		bmi @+
		cmp #16
		bcc @+
		iny
@		lda fazaTab1,y		
				
		sec
		sbc enemyFaza,x

		and #%1111
		bne @+
		rts			;nie zmieniaj fazy , sa równe
		
@		cmp #8
		bcs @+
		;clc
		lda enemyFaza,x
		adc #1
		and #%1111
		sta enemyFaza,x
		rts
@		lda enemyFaza,x
		;sec
		sbc #1
		and #%1111
		sta enemyFaza,x
		rts				
	
;korekcja kątu lotu
korekcjaLotu	equ *
		ldy #0
		lda enemyY0,x
		clc
		adc #1
		
		bpl @+		;jesli wartosc ujemna to przyjmij 0
		lda #0
@		lsr
		cmp #7
		bcc @+
		ldy #2
		eor #255
		adc #13		;c=1 +1
		bpl @+
		lda #0
@		asl 
		asl
		asl
		sta pom0

		lda enemyX0,x
		clc
		adc #1
		bpl @+
		lda #0
@		lsr
		cmp #8
		bcc @+
		iny
		eor #255		;II lub III cwiartka
		adc #15		;c=1 +1 zmiana znaku
		bpl @+
		lda #0		;poza ekranem
@		ora pom0
		sty cwiartka+1
		tay
		lda fazaTab,y
cwiartka equ *
		ldy #$ff
		
		cpy #1
		beq @+
		cpy #2
		bne @+1
		
@		eor #255
		sec
		adc #8
		
@		cpy #0
		beq @+
		cpy #2
		beq @+
		
		clc
		adc #8
				
@		sec
		sbc enemyFaza,x

		and #%1111
		bne @+
		rts			;nie zmieniaj fazy , sa równe
		
@		cmp #8
		bcs @+
		;clc
		lda enemyFaza,x
		adc #1
		and #%1111
		sta enemyFaza,x
		rts
@		lda enemyFaza,x
		;sec
		sbc #1
		and #%1111
		sta enemyFaza,x
		rts		

		
dodaj_przeciwnika	equ *	
		dec dlicz1
		beq @+
		rts
@		mva opoz_denemy dlicz1
		
		lda formacja_stan
		beq *+3
		rts		;jesli wlaczona formacja to nie dodawaj nowych statkow
		
		lda ile_enemy		;ilu przeciwnikow jest na ekranie
		cmp max_enemy		;czy jest maksymalna ilosc?
		bcc @+
		rts			;wystarczy;)
	
@		lda random		;czy ma sie pojawić?losuj
		and #%111
		cmp #%100
		bne @+
		rts			;nie
		
@		ldx #4		;szukaj nieuzywanego przeciwnika
@		lda enemy,x
		beq @+
		dex
		bpl @-
		rts		;zabezpieczenie jak beda wszystki zajete (nie powinno sie zdarzyc!)


dod_en1	equ *		;miejsce dodania enemy X
		lda ile_enemy		;czy dodajemy enemy podczas formacji?
		cmp #5
		bcc *+3
		rts
		lda enemy
		beq *+3
		rts
		
		dec dlicz1		;dodajmy opoznienie
		beq *+3
		rts
		mva opoz_denemy dlicz1		
		
@		lda #1
		sta enemyEkran,x		;1 na starcie
		lda random		;wylosuj pozycje startowa
		and #%1111
		tay
		clc
		lda enemyTab1,y
		adc posX
		and #127
		sta enemyX,x
		lda random
		and #%11100000
		sta enemyDX,x
		clc
		lda enemyTab1+16,y
		adc posY
		sta enemyY,x
		lda random
		and #%11100000
		sta enemyDY,x
		lda #EKOLOR0
		sta enemyNegatyw,x
		lda enemyTab1+32,y
		sta enemyFaza,x
		
		lda random				;losuj kolor
		lsr
		bcs @+
		mva #>scolor0 enemyOraTab,x
		jmp @+1
@		mva #>scolor1 enemyOraTab,x
@		equ *

		lda random
		lsr
		bcs @+
		mva #enemy1shape enemyShapeH,x 
		jmp @+1
@		mva #enemy2shape enemyShapeH,x
			
		
@		inc ile_enemy		;zwieksz liczbe obecnych przeciwnikow
		mva #1 enemy,x
		mva #0 enemyWybuch,x
		mva #20 enRotate,x
		mva #115+5 enLicznik,x
		
		
		rts


;poruszaj przeciwnikami
moveEnemy	equ *
		lda jestSpy
		beq @+
		lda enemyWybuch+5
		beq @+
		ldx #5
		bne @+1		;jmp, jesli spy jest w trakcie wybuchu

@		lda formacja_stan
		cmp #3
		bcc @+
		cmp #5
		beq @+
		ldx #0		;obsluguj tylko zerowego enemy
		beq @+1
		

@		ldx #4		;maks 5 przeciwnikow
@		equ *
		lda enemy,x
		bne @+
mven1	dex
		bpl @-
		rts
		
@		equ *		;animuj przeciwnika
		
		lda enemyEkran,x
		beq @+
		
		
		ldy enLicznik,x		;jak długo przeciwnik jest na ekranie
		cpy #104
		bcs @+				;jeśli >11 to nie usuwaj go jeszcze
		
		mva #0 enemy,x		;poza ekranem
		sta enemyWybuch,x
		dec ile_enemy
		stx lastEnemy		;zaoamietaj ostatnio usunietego przeciwnika
		jmp mven1
		
		
@		lda enemyWybuch,x
		beq @+ 			
		lda enemyLastFaza,x		;wybuch nie podlega korekcji lotu
		jmp mvruch1
		
@		lda enLicznik,x		;czas zycia enemy
		beq @+
		cmp #104
		bcc enzm1
		lda enemyEkran,x
		bne @+
enzm1	equ *
		dec enLicznik,x
		
@		dec enRotate,x		;czas do korekcji ruchu
		bne mvruch
		
		lda rotate_speed1		;normalny obrot
		ldy enemyShapeH,x
		cpy #enemy2shape			;czy drugi typ przeciwnika?
		bne @+
		lda rotate_speed2		;2 ksztalt,szybciej sie obraca
@		sta enRotate,x

		lda enLicznik,x
		bne @+
		jsr Ucieczka
		jmp mvruch
@		jsr korekcjaLotu
		
mvruch	lda enemyFaza,x			;przesun duszka
		//ldy enLicznik,x
		//cpy #104+4			;jesli >240 to podwojna predkosc
		//bcc mvruch1
		//ora #224			
		//jmp @+1		
		
mvruch1	ldy formacja_stan	
		cpy #2		;jesli 1 to formacja czeka
		bcc @+				;jeśli brak formacji to nie zmieniaj predkosci
		cpx #0
		beq @+				;jesli jest formacja to enemy 0 porusza się z normalna predkoscia
		ldy enemyWybuch,x	; nie przyspieszaj poruszania się wybuchu podczas formacji
		bne @+
		ora formacja_speed	;formacja ma swoją predkość
		jmp @+1
@		ora speedEnemy
@		tay
		clc
		lda enemyDX,x
		adc enemyTabX,y
		sta enemyDX,x
		lda enemyX,x
		adc enemyTabX+16,y
		and #127
		sta enemyX,x
		
		clc
		lda enemyDY,x
		adc enemyTabY,y
		sta enemyDY,x
		lda enemyY,x
		adc enemyTabY+16,y
		sta enemyY,x

		jmp mven1		;next
		
		
		
;Narysuj wszystkich przeciwnikow, lub ewentualne wybuchy
rysujEnemy	equ *
		ldx #5		;maksymalna ilosc przeciwnikow	
@		lda enemy,x
		beq ren1
		lda enemyWybuch,x
		bne @+
		jsr duszkiPrint		;rysujemy przeciwnika nr X
ren1	dex
		bpl @-
		rts
			
@		cpx #0
		beq @+1
		cmp #8			;poczatek wybuchu
		bne @+
		mvy #100 spylicznik1	;spy zginął, nie będzie kary
		inc formacja_zbite		;zwieksz liczbe zbitych przeciwnikow z formacji
@		cmp #1			;ostatni etap wybuchu
		bne @+
		ldy jestSpy			;jesli jest spy to zapisuj tylko pozycje dla enemy=5
		beq *+6
		cpx #5
		bne @+
		mvy enemyX,x spyscoreX
		mvy enemyY,x spyscoreY
		
@		sec			;rysujemy wybuch
		sbc #3
		bpl *+4
		lda #0
		lsr 
		sta enemyFaza,x
		jsr duszkiPrint
		bne @+
		dec enemyWybuch,x
		bne ren1
@		mva #0 enemyWybuch,x
		sta enemy,x
		mva #1 enemyEkran,x
		stx lastEnemy
		
		cpx #5
		bne @+
		lda formacja_stan
		beq ren1		;jesli 5=spy to pomin
@		dec ile_enemy
		jmp ren1
		
	