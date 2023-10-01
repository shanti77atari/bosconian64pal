;poprawiona szybkość formacji, wybuchy wszystkich przeciwników i rakiet po zaliczeniu levelu
;nowa procedura rysuje przezroczyste napisy przy punktach za formację i spy
;enemy nie znikaja po trafieniu, po zderzeniu z enemy statek enemy wybucha

TITLESCREEN	= 1
UC=1		;undocumented

.IF .DEF TITLESCREEN
			opt h-
			ins "titlePALfix.xex"
			ins "logoPAL.xex"
			opt h+
 .ENDIF
			
			
			

CONSOL		equ $D01F
VCOUNT		equ $D40B
WSYNC		equ $D40A
COLPF0S		equ 708
COLPF1S		equ 709
COLPF2S		equ 710
COLPF3S		equ 711
COLBAKS		equ 712
COLBAK		equ $D01A
COLPF0		equ $D016
COLPF1		equ $D017
COLPF2		equ $D018
COLPF3		equ $D019
RANDOM		equ $D20A
DLPTRS		equ $0230
DLPTR		equ $D402
CHBAS		equ $02F4
CHBASE		equ $D409
GTIACTL		equ $D01B  ;priorytet wyswietlania kolorow i duszkow +piaty duszek
GTIACTLS	equ $26F
PMCTL		equ $D01D
DMACTLS		equ $022F
DMACTL		equ $D400
PMBASE		equ $D407
HPOSP		equ $D000
HPOSM		equ $D004
COLPM		equ $D012
COLPMS		equ $02C0
SIZEM		equ $D00C
SIZEP		equ $D008
VSCROL		equ $D405
HSCROL		equ $D404
AUDCTL		equ $D208
AUDF1		equ $D200
AUDF2		equ $D202
AUDF3		equ $D204
AUDF4		equ $D206
IRQEN		equ $D20E
VTIMER1		equ $0216
VTIMER4		equ $0214
STIMER		equ $D209
AUDC1		equ $D201
AUDC2		equ $D203
AUDC3		equ $D205
AUDC4		equ $D207
DLIV		equ $0200
NMIEN		equ $D40E
JOY			equ $D300
FIRE		equ $D010
VBLKI		equ $222
VBLKD		equ $224	
SKCTL		equ $d20f
GRAFP0		equ $d00d
GRAFP1		equ $d00e
GRAFP2		equ $d00f
GRAFP3		equ $d010
GRAFM		equ $d011
PORTB		equ $d301



;zmienne


sfx_effect		equ 0
sfx_extra		equ 1
sfx_wybuch		equ 2
sfx_dzialko 	equ 3
sfx_asteroid	equ 4
sfx_bomba		equ 5
sfx_dead		equ 6
sfx_antyair		equ 7
sfx_enemyHit	equ 8
sfx_rakieta		equ 9
pociski			equ 10 ;11,12,13,14

formacja_stan	equ 15
extraLicznik	equ 16
licznikStrzal	equ	17
sfxLicznik1		equ 18
liczbaPociskow	equ 19
newPoziom		equ 20
formacja_radar	equ 21
trafienie		equ 22
strzal			equ 23	;24,25,26
max_Enemy		equ 27
ile_Enemy		equ 28
jestSpy			equ 29
nobanner		equ 30
movY			equ 31

score			equ 32 ;33,34


posx 	equ 227	
posY	equ 228	
movX	equ 229	
mryganieRadarX equ 230	
movX0	equ 231	
movY0	equ 232	
movYs	equ 233	
sirq	equ 234	
ramka	equ 235	
vblFlaga	equ 236	
pauza	equ 237	
stan_gry	equ 238	
speedEnemy	equ 239	
startMapy	equ 240	
lastEnemy	equ 241	


vblX	equ 242	
vblY	equ 243	
vblA	equ 244	
znacznik	equ 245	
bazyIle	equ 246			;ile baz


pom0	equ 247	
pom0a	equ 248	
pom0b	equ 249	
pom0c	equ 250	
pom0d	equ 251	
pom0e	equ 252	
pom0f	equ 253	
kolpom0	equ 254
zegar	equ 255	; wcześniej 20

rodzajSpeech	equ 36
kolorPanel		equ 37
poz0			equ strz0a		;wykorzystane w title
kol0			equ strz0b
ile_rpt		equ 38
;komunikat	equ 36
;komunikatL1	equ 37
;komunikatS	equ 38
scoreZmiana	equ 39

licznikPokey	equ 40
rejX	equ 41
rejA	equ 42
kat1	equ 43
kat2	equ 44
znakDX	equ 45
znakDY	equ 46
znakX	equ 47 ;18
znakY	equ znakX+18	;18
muzyka	equ 83
rejY	equ 84
pom0g	equ 85
flaga	equ 86
maxPociskow equ 87
spySpeed	equ 88

ramka4	equ 89
bombIle	equ 90
czyRakiety	equ 91
rads	equ 92
powtorz	equ 93
sJoy	equ 94

strz0	equ 95
strz0a	equ 96
strz0b	equ 97
strz0c	equ 98
strz0d	equ 99
strz0e	equ 100
strz0f	equ 101
strz	equ 102
strz1	equ 104

sam		equ 126
pom		equ 128
pom1	equ 130
pom2	equ 132
pom3	equ 134
;od 136 do ~ 186 gwiazdy
screenL	equ 136 ;137
screenH	equ 138	;139


enemyColor	equ 188	;i 187

kondycja	equ 189
pociskiTlo	equ 190	;191,192,193,194
pociskiZnakX equ 195	;196,197,198,199



pozWyniki	equ 177  ;pozycja tabeli wynikow
OPTION		equ 4
SELECT		equ 2
START		equ 1

bufore3	equ $180


znaki1	equ $D800		;2 bit w starszym bajcie skasowany
znaki2	equ znaki1+$400	;drugi zestaw znakow
obraz1a	equ $200
obraz1	equ obraz1a+8+8*48
obraz2a	equ obraz1+28*48+48
obraz2	equ obraz2a+8+8*48

b					equ 3	;11		;nr pierwszego zanku bazy
firstBombaChar		equ b+28		;pierwszy znak bomby
firstMeteorChar		equ firstBombaChar+4		;meteoru
firstRakietaChar	equ firstMeteorChar+4
firstWybuchChar		equ firstRakietaChar+8	;47
firstMalyWybuchChar	equ firstWybuchChar+16	;+20	;63
firstStrzalChar		equ firstMalyWybuchChar+2 ;63+2=65	
firstPociskChar		equ firstStrzalChar+4	;65+4=69
											;69+5=74 duszki
startWyniki equ 16
lenDlist	equ 29	;ilosc linii ekranu w dlist

EKOLOR0		equ 0		;duszek przyjmuje kolor tła, oprócz gwiazd
EKOLOR1		equ 128		;duszek wymusza negatyw



;kolory
kolorCzerwony	equ $36		;PAL
kolorHiscore	equ $36  ;czerwony
kolorMapa		equ $50  ;fioletowy	
kolorRound		equ $4a
kolor1ups		equ $8a
kolorLevel		equ $ba
kolorLogo		equ $34
kolorYellow		equ $ea
kolorGreen		equ $b8
kolorRed		equ $34

ColorShip=$5a

KOLOR1			equ $28
KOLOR3			equ $34


kolorLiczby		equ $0c  ;bialy
pozliczby		equ 180


;zmienne
rads1			equ strzalY+52		;co zmazac 0->statek, 1->formacje <0 nic nie zmazuj
enlicznik		equ rads1+1		;6 bajtow
enRotate		equ rads1+7		;6 bajtow

formacja_typ	equ rads1+13
formacja_maska	equ rads1+14
formacja_speed	equ rads1+15
czy_6enemy		equ rads1+16
opoz_denemy		equ rads1+17 ;jak często pojawia się nowy enemy
opoz_dlosuj		equ rads1+18 ;jak czesto pojawiaja sie spy i formacja
flaghscore		equ rads1+19		
rotate_speed1	equ rads1+20
rotate_speed1d	equ rads1+21
rotate_speed2	equ rads1+22
rotate_speed2d	equ rads1+23

zbiteBazy	 	equ rads1+24
czasOtwarcia	equ rads1+25
czasZamkniecia	equ rads1+26
startX			equ rads1+27
startY			equ rads1+28
poziom			equ rads1+29
waitWybuch		equ rads1+30
plusScore		equ rads1+31	;2 bajty

spyScore		equ rads1+33
spyscoreX		equ rads1+34
spyscoreY		equ rads1+35
lives			equ rads1+36
kondycja_stan	equ rads1+37
antyairOpoznienie equ rads1+38

licznikBazyEkran  equ rads1+39	;liczba baz rysowanych na ekranie
licznikBombyEkran equ rads1+40
gwiazdyLicznik	  equ rads1+41
opoz_potrafieniu  equ rads1+42

czyJadroA		equ rads1+43
czyJadroB		equ rads1+44
licznikJadroA	equ rads1+45
licznikJadroB	equ rads1+46
openA			equ rads1+47
openB			equ rads1+48
opozCoreA		equ rads1+49
opozCoreB		equ rads1+50
liczCoreA		equ rads1+51
liczCoreB		equ rads1+52

opoznienieFire 	equ rads1+53
sFire			equ rads1+54



dlicz1			equ rads1+55

formacjaX		equ rads1+56
forLicznik		equ rads1+57
formacja_zbite	equ rads1+58
dowodca			equ rads1+59

fazaWybuch		equ rads1+60
przecinek		equ rads1+61
enemyPosX		equ rads1+62	;6b
enemyPosY		equ rads1+68	;6b	

rak_flag		equ rads1+74
timeLevel		equ rads1+75

enemyNegatyw	equ $171		;8b
enemyEkran		equ $179		;8b		
enemyLastFaza	equ $181		;8b
enemyWybuch		equ $189		;8b
enemyOraTab		equ $191		;8b 	

wybuchyStart	equ $199
wybuchyStop		equ $19a
mwybuchyStart	equ $19b
mwybuchyStop	equ $19c

spylicznik		equ zmazTab+8
spylicznik1		equ spylicznik+1
licznikSpyScore	equ spylicznik+2
losuj1 			equ spylicznik+3

			org $9000
dli_graph	dta b(112),b(112),b(112)
			dta b($4a),a(bosco_graph)
			dta b($4a),a(bosco_graph)
			dta b($a)
			dta b($4a),a(bosco_graph+$10)
			dta b($a)
			dta b($4a),a(bosco_graph+$20)
			dta b($a)
			dta b($4a),a(bosco_graph+$30)
			dta b($a)
			dta b($4a),a(bosco_graph+$40)
			dta b($a)
			dta b($4a),a(bosco_graph+$50)
			dta b($a)
			dta b($4a),a(bosco_graph+$60)
			dta b($a)
			dta b($4a),a(bosco_graph+$70)
			dta b($a)
			dta b($4a),a(bosco_graph+$80)
			dta b($a)
			dta b($4a),a(bosco_graph+$90)
			dta b($a)
			dta b($4a),a(bosco_graph+$a0)
			dta b($41),a(dli_graph)
			
bosco_graph	dta b(0)
			dta b(%01010101,%01000000)
			:14 dta b(0)
			dta b(%01010000,%01010000)
			:14 dta b(0)
			dta b(%10010000,%00010000)
			:14 dta b(0)
			dta b(%10100000,%10100000)
			:14 dta b(0)
			dta b(%10101010,%10000000)
			:14 dta b(0)
			dta b(%10100000,%10100000,%00010101,%00000001,%01010000,%00010101,%01000001,%01010000,%01000000,%01000100,%00010101,%00000100,%00000100)
			:3 dta b(0)
			dta b(%10100000,%00101000,%10100010,%01000110,%00000000,%01100000,%01001010,%00100100,%10010000,%10001000,%10100010,%01001001,%00001000)
			:3 dta b(0)
			dta b(%10100000,%00101000,%10000000,%10001010,%10100000,%10000000,%00001000,%00001000,%10101000,%10001000,%10000000,%10001010,%10001000)
			:3 dta b(0)
			dta b(%10100000,%00101000,%10000000,%10000000,%00101000,%10000000,%00001000,%00001000,%10001010,%10001000,%10101010,%10001000,%10101000)
			:3 dta b(0)
			dta b(%11101010,%10101100,%11100010,%10001100,%00101000,%11100000,%10001110,%00101000,%10000010,%10001000,%10000000,%10001000,%00101000)
			:3 dta b(0)
			dta b(%11111111,%11110000,%00111111,%00001111,%11110000,%00111111,%11000011,%11110000,%11000000,%11001100,%11000000,%11001100,%00001100)
			:2 dta b(0)					
			
iniscr		equ *
			lda 20
@			cmp 20
			beq @-

			mva #0 712
			sta COLBAK


			lda #$86	;PAL
			ldx #$34
			ldy #$fa
			
			sta colpf0s
			stx COLPF1s
			sty COLPF2s	
		
			mwa #dli_graph DLPTRs
		
			mva #57 DMACTLs		;pokaz ekran
			
			lda 20
@			cmp 20
			beq @-
						
			rts

			ini (iniscr)


			icl 'banki.asm'
			
			//inicjalizacja
			;org $2000
			org $1e00
			
			run		equ *	
		lda 20
@		cmp 20
		beq @-
		
		mva #0 DMACTL		;ukryj ekran
		;sta DMACTLS
		sta stan_gry
		sta $d208
		ldy #3
		sty $d20f
		
		sei
		sta NMIEN		;A=0
		sta $d20e
		sta HPOSM+3
		lda #pozWyniki-1
		sta HPOSP+3
		
		mva #BANK0 PORTB		;wylaczamy bios
		
		mva <nmi $fffa
		mva >nmi $fffa+1
		mwa #pokey $fffe
		
		mwa #dli DLIV ;wektor przerwania dli
		
		mva #%01000000 NMIEN ;zezwolenia na przerwania VBLK
		cli

			;tabX
			ldy #80
			ldx #208
@			txa
			sta tabx,x		;od 208 do 79 -> (208-79)
			sta tabX,y		;od 80 do 207 -> (208-79)
			iny
			inx
			cpx #80
			bne @-

		ldx #$fa
@		lda sprites1+$700-1,x
		sta enemyTab1-1,x
		lda #$ff
		sta sprites1+$700-1,x
		dex
		bne @-
			
		;adresy linii obraz1a
		mwa #obraz1a pom
		mwa #obraz2a pom1
		;ldx #0			;X=0
		
@		lda pom
		sta obraz1La,x
		lda pom+1
		sta obraz1Ha,x
		lda pom1
		sta obraz2La,x
		lda pom1+1
		sta obraz2Ha,x
		clc
		lda pom
		adc #48
		sta pom
		bcc @+
		inc pom+1
@		clc
		lda pom1
		adc #48
		sta pom1
		bcc @+
		inc pom1+1
@		inx
		cpx #37
		bne @-2
		
		;dlist
		mva #$d0 dlist
		mva #$74 dlist+1
		mwa #obraz2 dlist+2
		ldy #26
		lda #$34
@		sta dlist+4,y
		dey
		bpl @-
		mva #$14 dlist+31
		mva #$41 dlist+32
		
		mva #<dlist dlist+33
		sta DLPTR			;program antica
		mva #>dlist dlist+34
		sta DLPTR+1
		;mwa #dlist dlist+33
		

		
		;-----
		jsr gwiazdyInit
		
		mva #10 punkty
		sta antyairOpoznienie
		jsr czyscObraz2
		mva #10 movX
		;mva #0 movY
		
		
		;mwa #obraz2 dlist+2
		
		;lda #<dlist    
		;sta DLPTR
		;lda #>dlist
		;sta DLPTR+1
		mva #>znaki1 CHBASE
			
		//jsr spriteOn	
		
		mvy #0 COLBAK
		sty flagHscore
		sty movy
		jsr setCondition
	
		

		
		;ldy #0
		;jsr setCondition

		jmp title_s0
			
			
			
			//wlasciwy program
			icl 'przerwania.asm'
			
			
			
			icl 'bszczaly.asm'
			icl 'duszki4.asm'
			icl 'bliczby.asm'
			
			icl 'bmove.asm'
			
			icl 'bantyair.asm'
			
			icl 'wybuch.asm'
			icl 'time.asm'
			icl 'rakiety.asm'
			
			icl 'spy.asm'
			icl 'enemy.asm'
			icl 'formation.asm'
			
			
			icl 'kolizje.asm'
			icl 'blevele.asm'
			icl 'sfx.asm'
			
			;GLOWNY PROGRAM

czarp1	equ *
		:4 dta b(%10110101)
		:2 dta b(255)
		dta b(%10100101)
		dta b(255)
		:2 dta b(%10110101)
		
livesRed	equ *
			ldx #9
@			lda czarp1,x
			sta sprites+startWyniki+$7c6,x
			dex
			bpl @-
			rts
			
livesRedOff	equ *
			ldx #9
			lda #255
@			sta sprites+startWyniki+$7c6,x
			dex
			bpl @-
			rts
		
czarnyPanel	equ	*
			lda #255  
			ldx #0
@			sta sprites+$700,x  ;wypelniamy 4 duszka
			dex
			bne @-
			
			ldx #242
@			sta sprites1+$700,x
			dex
			cpx #11
			bne @-
			
			lda #0
@			sta sprites1+$700-2,x
			sta sprites1+$700+230,x
			inx
			inx
			cpx #17
			bne @-
			sta sprites1+$700+247
			
			;sta sprites1+$700+12
			;sta sprites1+$700+242
			lda #126
			sta sprites1+$700+10
			sta sprites1+$700+244
			lda #60
			sta sprites1+$700+8
			sta sprites1+$700+246
			
			;lda #0
			;sta sprites1+$700+13
			;sta sprites1+$700+11
			;sta sprites1+$700+9
			;sta sprites1+$700+241
			;sta sprites1+$700+243
			;sta sprites1+$700+245
			;sta sprites1+$700+247			
			
			rts
			
spriteOn	equ *
			jsr czysc_duszki
			jsr piszCondition
			jsr pisz_zycia
			jsr pisz_panel
			
			jsr czarnyPanel
			
			lda #3
			sta PMCTL   ;wlaczenie spritow
			lda #>sprites
			sta PMBASE ;adres obrazu duszkow
			lda #1
			
			sta GTIACTL	
			
			lda #3
			sta SIZEP+3
			lda #0
			sta COLPM+3
			sta SIZEP
			
			ldx #4
@			sta GRAFP0,x
			dex
			bne @-
			
			sta enemyColor-1
			
			rts


tabora		dta b(%01,%00,%11,%00)		;ora1
			dta b(%10,%00,%11,%00)		;ora2
			dta b(%11,%01,%10,%00)		;ora3
			
			
tabBomb1	equ $1500	
tabBomb2	equ $1600		;FREE

bombRodzaj	equ $1180
bombX		equ $1200
bombY		equ $1280


;oraTab3		equ $1a00

sprites 	equ $1800		;+$300 = od $1B00 do $2000-1 efektywnie
sprites1	equ $f800		;duszki podczas sampla
	
obraz1La	equ $1700
obraz1Ha	equ obraz1La+37
obraz2La	equ obraz1Ha+37
obraz2Ha	equ obraz2La+37
dlist		equ obraz2Ha+37 ;35 bajtów, zajete 183 bajty na tej stronie

enemy		equ dlist+35
enemyX		equ enemy+6
enemyX0		equ enemy+12
enemyY		equ enemy+18
enemyY0		equ enemy+24
enemyDX		equ enemy+30
enemyDY		equ enemy+36
enemyFaza	equ enemy+42
enemyBank	equ enemy+48
enemyShapeH	equ enemy+54
enemyDX0	equ enemy+60
enemyDY0	equ enemy+66


changePanelColor
		stx cpc
		lda kolorPanel			;zmieniaj odcien panelu
		and #%11110000
		sta pom0
		lda kolorPanel
		sec
cpc		equ *+1		
		sbc #4
		and #%1111
		ora pom0
		sta kolorPanel
		sta COLPM+2
		rts

title_s0	
		jsr spriteOn
		mva #1 poziom		
		jsr piszPoziom
title_s1		
		jsr piszHscore1
		
Title_s	jsr waitvbl
		mva #0 DMACTL
		jsr init_fx
		jsr livesRedOff
		
		mva #0 sfxlicznik1
		sta pauza
		sta formacja_stan
		sta formacja_radar
		jsr piszCondition
		ldy kondycja_stan		;poprzednia kondycja
		jsr setCondition
		mva #0 stan_gry
		
		ldx #<MODUL					;low byte of RMT module to X reg
		ldy #>MODUL					;hi byte of RMT module to Y reg
		lda #$06						;starting song line 0-255 to A reg 	
		jsr RASTERMUSICTRACKER
		
		mva #1 stan_gry

		jsr Title
title1	equ *	

		mva #0 DMACTL
		sta score
		sta score+1
		sta score+2

		mwa #dlist	DLPTR
		mva #>SPRITES PMBASE
		
		mva #0 stan_gry

		
		jsr init_fx		
		
		jsr czarnyPanel
		jsr pisz_zycia

		
		mwa #obraz1 dlist+2
		jsr czyscObraz1
		
		lda JOY
		lsr
		bcc @+
		mva #1 poziom	
		
@		jsr wczytajLevel
		
		jsr pokazBazyRadar
		
		ldy #0
		jsr setCondition
		jsr czyscScore
		jsr piszScore1
			
		mva #3	lives
		jsr printLives
		mva #1 scoreZmiana	;nie ma nowych punktów
					
		jsr livesRed

		
		mva #1 zegar
		
		mva #KOLOR1 COLPF1
		mva #KOLOR3 COLPF3
		
		mva #0 flagHscore
		
		
		mva #%11000000 NMIEN
		
		mva #2 stan_gry
		;mva #$80 RMTGLOBALVOLUMEFADE

		
		jmp poczatek		;nie pokazuj ekranu przed narysowaniem

	
frame	dta 0
ruch	dta 0
ruchy	dta 0
gwx		dta 0
gwy		dta 0

;glowna petla		
loop	equ *
;
;Czekamy na ramke 2
;		

		mwa #obraz1-1 dlist+2
		mva #>znaki1 CHBASE
		mva movX HSCROL 
		;sta movx1
		mva movY VSCROL
		;sta movy1	
		
		
		mva #0 zegar
		
		mva #58 DMACTL
		

//obsługa sampli
		lda nobanner
		jeq poczatek
		cmp #1
		bne @+

		mva #%01000000 NMIEN
		
		sei
		mwa #pok_s1 $fffe
		mva #1+32 gtiactl
		
		lda #15
		sta AUDF4
		mvy #0 IRQEN
		cli
		
		jsr schowaj_duszki
		
		inc nobanner
		
		mva #4 sirq
		sta IRQEN
		jmp poczatek
		
@		ldx #4
		jsr changePanelColor

		lda sirq
		bne poczatek		;jeszcze sie nie skonczyl		
		
		jsr pokaz_duszki
		
		mva #0 AUDF4
		sta nobanner
		;mva #>SPRITES PMBASE
		
		mva #%11000000 NMIEN

		
		
poczatek	equ *
		jsr playFX
		
		mwa #obraz2L screenL
		mwa #obraz2H screenH
		
		jsr printShip
		jsr copyShip
		
		jsr radar

		jsr czyscObraz2
		
		jsr timeEvents
		
;rysujemy na obrazie 2
		mva #1 ramka
		sta vblFlaga
		mva #4 ramka4		;ramka*4	
		
		lda #2
		ldy sJoy
		ldx skos,y
		beq @+
		inc frame
		ldx frame
		cpx #6
		bcc @+
		mva #0 frame
		lda #1
@				
		jsr moveShip			;przesun i narysuj statek			
			
		jsr gwiazdyRysuj2
		jsr animacjaJadraA
		jsr animacjaJadraB
			
		jsr coreWaveA
		jsr coreWaveB
		
		lda trafienie
		ora startMapy
		bne @+
		lda czyRakiety
		beq @+
		jsr moveRakiety		;rakiety
		jsr rakiety
@		equ *
		
		jsr printEkran	

		jsr rysujWybuchy		;animuj wybuchy
		jsr rysujmWybuchy
							
		lda trafienie
		ora startMapy
		bne @+
		
		jsr kolStatekWybuch	
		jsr movePociski1	
		
		
		jsr kolStatekObiekty
		jsr kolStatekBazy
		
		
		jsr kolRakietyStatek		
		jsr kolRakietyObiekty

@		equ *
		
		jsr spy
		jsr formacja
		
		
		lda trafienie
		ora startMapy
		bne @+
		jsr printSpyScore
		
@		equ *		
		jsr moveEnemy
		
		lda trafienie		
		ora startMapy
		bne @+
		jsr dodaj_przeciwnika

@		equ *		
		jsr rysujEnemy

		lda trafienie		
		ora startMapy
		bne @+
		
		jsr obliczEnemyXY
		jsr kolStatekEnemy
		
		jsr printPociski
		jsr kolPociskiEnemy
		jsr kolObiektyEnemy
		
		
		jsr kolPociskiStatek
		jsr kolPociskiObiekty
		
@		equ *	
	
		jsr poprawlives2
		
		lda #0
@		cmp zegar
		beq @-
		
		lda trafienie
		ora startMapy
		bne @+	
		
		
		jsr moveStrzal
		
		jsr pushFire			;czy wcisnieto fire?

		jsr obliczStrzalXY2		;kolizje strzlow statku
		jsr printStrzal
  
		
		jsr kolStrzalyEnemy
		jsr kolStrzalyRakiety
		jsr kolStrzalyObiekty
		jsr kolStrzalyBazy
				
		jsr moveStrzal
				
		jsr obliczStrzalXY2
		
		
		;jsr locateStrzal2
		jsr kolStrzalyEnemy
		jsr kolStrzalyObiekty		;do poprawki
		jsr kolStrzalyBazy
		
					
@		jsr sumaPunkty		;sumuj punkty
		
		jsr playFX

		jsr sounds			;dodaj wszystkie efekty
		jsr czyNowyLevel	;sprawdz czy ukonczono poziom
		
;
;Czekamy na ramke		1
;		
@		lda zegar
@		cmp zegar
		beq @-	
					
loop2	equ *	
			
		lda consol
		and #2
		cmp consol1
		beq con0
		sta consol1
		cmp #0
		bne con0
		lda czy_music
		eor #$18
		sta czy_music
		ora #2
		ldx #<MODUL
		ldy >MODUL
		jsr rmt_init
		
con0		
				
		mwa #obraz2-1 dlist+2
		mva #>znaki2 CHBASE
		mva movX HSCROL
		;sta movx1		
		mva movY VSCROL
		;sta movy1
		
				
		mva #0 zegar
		mva #58 DMACTL		
		
				
		lda formacja_stan
		beq @+
		cmp #5
		beq @+
		
		lda conditionColor
		eor #$34
		sta conditionColor
@		equ *
	
poczatek2	
		jsr playFX
		
		mwa #obraz1L screenL
		mwa #obraz1H screenH
		
		jsr printShip
		jsr copyShip	
		
		
		jsr radar

		jsr czyscObraz1	

;rysujemy na obrazie1
		mva #0 ramka
		sta ramka4
		mva #1 vblFlaga
		
		lda #2
		ldy sJoy
		ldx skos,y
		beq *+3
		lsr
		jsr moveShip			;przesun i narysuj statek

		jsr gwiazdyRysuj1
		jsr animacjaJadraA
		jsr animacjaJadraB
			
		jsr coreWaveA
		jsr coreWaveB

		
		lda trafienie
		ora startMapy
		bne @+
		ora czyRakiety
		beq @+
		jsr moveRakiety		;rakiety
		jsr rakiety
@		equ *
		
		jsr printEkran
		
		jsr rysujWybuchy
		jsr rysujmWybuchy
		
		
		lda trafienie		
		ora startMapy
		bne @+
		
		
		jsr kolStatekWybuch
		jsr movePociski1
		jsr antyair1
		
		jsr kolStatekObiekty
		jsr kolStatekBazy
		jsr kolRakietyStatek

		
		jsr kolRakietyObiekty
				
		jsr losuj		;losuj spy,formacja
		
@		equ *		
		jsr spy
		jsr formacja
		
		lda trafienie
		ora startMapy
		bne @+
		
		jsr printSpyScore
@		equ *
		jsr moveEnemy
		jsr rysujEnemy
		
		lda trafienie		
		ora startMapy
		bne @+
		
		jsr obliczEnemyXY
		jsr kolStatekEnemy	
		jsr kolObiektyEnemy	

		jsr printPociski
		jsr kolPociskiEnemy	
		jsr kolPociskiStatek
		jsr kolPociskiObiekty		;kolizje Pociskow z Bomami i meteorami
		
		
@		equ *		
				
		jsr poprawlives1
		
		lda #0
@		cmp zegar
		beq @-
		
		lda trafienie
		ora startMapy
		bne @+
		
		
				
		jsr moveStrzal
		
		jsr pushFire
		jsr obliczStrzalXY2
		jsr printStrzal
		
		jsr kolStrzalyEnemy
		jsr kolStrzalyRakiety
		jsr kolStrzalyObiekty
		jsr kolStrzalyBazy

		jsr moveStrzal
		
		jsr obliczStrzalXY2		
		
		;jsr locateStrzal1
		jsr kolStrzalyEnemy
		jsr kolStrzalyObiekty		;do poprawki
		jsr kolStrzalyBazy

			
@		lda nobanner		;nie zatrzymuj w czasie sampla
		beq @+
		jmp loop1		

@		lda CONSOL
		and #START
		bne @+3
		mva #1 pauza
		mva #0 AUDC1
		sta AUDC2
		sta AUDC3
@		lda CONSOL
		and #START+OPTION
		cmp #START+OPTION
		bne @-
		
@		lda CONSOL
		sta pom0
		and #OPTION+START
		cmp #OPTION+START
		beq @-
		
		lda pom0
		and #START
		beq @+		;wznów gre
		mva #50 startMapy
		
		jsr zmaz_radar
		
		jmp title_s1		;resetuj + nie zaliczaj hscore , wypisz stare
	
@		lda CONSOL
		and #START
		cmp #START
		bne @-
		mva #0 pauza
@		equ *	
		
		lda scoreZmiana
		bne @+
		jsr piszScore1		;wyswietlaj zmienione hscore tylko jesli nie ma sampla
		jsr czyHscore
@		equ *		

loop1	equ *
		jsr playFX
		jsr sounds		;dodaj efekty
		
@		lda zegar
@		cmp zegar
		beq @-	


		jmp loop

czy_music	dta $18
consol1	dta 2

skos	dta 0,0,0,0,0,1,1,0,0,1,1		
		
graj_sampla	equ *
		lda #0
		jsr set_sample
		
		jsr waitvbl
		jsr init_fx

		;sei
		;mva #0 irqen
		mva #%01000000 NMIEN
		mva #>SPRITES1 PMBASE
		
		lda #$3a
		sta COLPM
		lda #$8a
		sta COLPM+1
		lda #pozWyniki-1
		sta HPOSP
		lda #pozWyniki-1+24
		sta HPOSP+1
		
		mva #$02 COLPM+3
		
		mva #0 HPOSP+2
		sta HPOSM
		sta HPOSM+1
		sta HPOSM+2
		sta nobanner
	
		;lda #0
		ldx #14
@		sta sprites1+$476+1,x		;wyczysc statek
		sta sprites1+$576,x
		dex
		dex
		bpl @-
		
		
;przygotuj napis
		ldy #0
		ldx #0
		
@		stx pom0
		lda t_blastoff,x
		:3 asl
		tax
		
		
@		lda znakiBosc-8,x
		sta sprites1+$430,y
		sta sprites1+$531,y
		iny
		iny
		inx
		txa
		and #7
		bne @-
		
		ldx pom0
		inx
		cpx #9
		bcc @-1

		mwa #pok_s1 $fffe		;nowy wektor przerwania
		
		mva #15 AUDF4		;jak czesto wywolujemy przerwanie, 64khz/16 = 4khz
		
		mva #0 IRQEN
		mva #4 sirq
		sta IRQEN
		;cli
		
		ldy #12
@		jsr mryg_bomb
		jsr waitvbl
		
		tya
		eor #255
		clc
		adc #pozWyniki+12
		sta HPOSP
		tya
		clc
		adc #pozWyniki+11
		sta HPOSP+1
		
		
		dey
		bpl @-
	
		
		mva #$24+10 zegar
		tay
		asl
		
		
@		cpy zegar
		beq @+
		jsr mryg_bomb
		ldy zegar
		tya
		asl
		
@		sta COLPM
		sta COLPM+1
		clc
		adc #5
		
@		ldx sirq
		bne @-2
		
		jsr waitvbl
		
		mva #%11000000 NMIEN
		mva #>SPRITES PMBASE
		
		mva #0 COLPM+3
		ldx #15
		jsr rstatek
		
		lda #0
		ldy #$90		;A=0
@		sta sprites1+$430-2,y		;wymaz napis
		sta sprites1+$531-2,y
		dey
		dey
		bne @-
		
		sta zegar		;A=0
		
		;mva #$80 RMTGLOBALVOLUMEFADE
		lda czy_music
		beq @+
		ldx #<MODUL
		ldy #>MODUL
		lda #$1a
		jsr rmt_init
@		
		
		rts 	
		
mryg_bomb
		pha
		lda zegar
		and #1
		beq mr_b1
		ldx #31
@		lda znaki1+firstBombaChar*8,x
		pha
		lda znaki2+firstBombaChar*8,x
		sta znaki1+firstBombaChar*8,x
		pla
		sta znaki2+firstBombaChar*8,x
		dex
		bpl @-
mr_b1	equ *
		pla
		rts
		
;rysuje gwiazdy
stars	equ *
		sta _gwKolor ;w A kolor gwiazdy
		sty _gwLast  ;w Y ostatniagwiazda-1, w X nr pierwszej gwiazdy
@		lda znakY,x
		clc
znakY1	equ *+1
		adc #0
		cmp #29
		bcc @+
		sbc #29
@		tay
		clc
		lda znakX,x
znakX1	equ *+1
		adc #0
		cmp #33
		bcc @+
		sbc #33
		clc
;screenL	equ *+1
@		adc (screenL),y	;$ffff,y
		sta _gwpos+1
;screenH	equ *+1
		lda (screenH),y	;$ffff,y
		adc #0
		sta _gwpos+2
_gwKolor	equ *+1
		lda #0
_gwpos	equ *		
		sta $ffff
		dex
_gwLast	equ *+1		;czy już wszystkie gwiazdy
		cpx #0
		bne @-2
		rts		
		
t_blastoff dta C'BLAST',b(0),C'OFF'		
		
blastoff_wav	equ *
	ins 'samples/blastoff0.wav'

alive_wav		equ *
	ins 'samples/alive0.wav'


spy_wav			equ *
	ins 'samples/spy0.wav'

	
formation_wav	equ *
	ins 'samples/formation0.wav'


conred_wav	equ *
	ins 'samples/conred0.wav'
	
gameover_wav	equ *
	ins 'samples/gameover0.wav'

			
			
		
STEREOMODE	equ 0
rmt_goto	equ $B700-(4*$22)		; 21 i 22 bajt pliku b.rmt;$B700-4*liczba_linii		;koniec utworu+1-(4*liczba_linii)
;rmt_goto=$b628
			icl "rmtplayr.asm"

MODUL=$a942	; $A6F4	;$A690	;$A6F4	
			opt h-
			ins "b12a.rmt"
			opt h+ 
			
				

		run run
		