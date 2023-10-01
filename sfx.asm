//efekty dzwiekowe
fx_antyair=0*2
fx_asteroid=1*2
fx_bomba=2*2
fx_dzialko=3*2
fx_wybuch=4*2
fx_strzal=5*2
fx_enemy=6*2
fx_spy=7*2
fx_dead=8*2
fx_extra=9*2
fx_rakieta=10*2
fx_alarm=11*2

kanal			org *+1
petla			org *+1
kanal1			org *+1
petla1			org *+1

kanals			org *+1		;2 bajty , uzywamy tylko 1	
prio			org *+1
kanals1			org *+1
prio1			org *+1
;audctl0			org *+1

.local sfx

init
		mva #0 kanal
		rts
		
add_fx1
		sty _af1+1
		ldy kanal1
		beq @+
		cmp prio1
		bcs @+
		rts
@		
_af1	ldy #0
		sta prio1
		lda audf_table,y
		sta _kanal_audf1+1
		lda audf_table+1,y
		sta _kanal_audf1+2
		
		lda audc_table,y
		sta _kanal_audc1+1
		lda audc_table+1,y
		sta _kanal_audc1+2
		
		lda len_table,y
		sta kanal1				;dlugosc
		sta kanals1
		lda len_table+1,y
		sta petla1			
		
		rts

add_fx
		sty _af0+1
		ldy kanal
		beq @+
		cmp prio
		bcs @+
		rts
@		
_af0	ldy #0
		sta prio
		lda audf_table,y
		sta _kanal_audf+1
		lda audf_table+1,y
		sta _kanal_audf+2
		
		lda audc_table,y
		sta _kanal_audc+1
		lda audc_table+1,y
		sta _kanal_audc+2
		
		lda len_table,y
		sta kanal				;dlugosc
		sta kanals
		lda len_table+1,y
		sta petla			;petla
	
		;lda ctl_table,y
		;sta audctl0

		rts
		

play_fx
		sty pfx4+1
		ldy kanal
		beq pfx3
_kanal_audf		
		lda $ffff,y
		sta _vbsnd3
_kanal_audc		
		lda $ffff,y
		sta _vbsnd4
		dey
		bne @+					;jeszcze nie koniec
		lda petla			;czy zapetlony 0=nie
		beq @+
		ldy kanals
@		sty kanal	

pfx3	
		ldy kanal1
		beq pfx4
_kanal_audf1		
		lda $ffff,y
		sta _vbsnd1
_kanal_audc1		
		lda $ffff,y
		sta _vbsnd2
		dey
		bne @+					;jeszcze nie koniec
		lda petla1			;czy zapetlony 0=nie
		beq @+
		ldy kanals1
@		sty kanal1	

pfx4	
		ldy #0
		rts


audf_table
		dta a(antyair_audf),a(asteroid_audf),a(bomba_audf),a(dzialko_audf),a(wybuch_audf),a(strzal_audf),a(enemy_audf),a(spy_audf)
		dta a(dead_audf),a(extra_audf),a(rakieta_audf),a(alarm_audf)
		
audc_table
		dta a(antyair_audc),a(asteroid_audc),a(bomba_audc),a(dzialko_audc),a(wybuch_audc),a(strzal_audc),a(enemy_audc),a(spy_audc)
		dta a(dead_audc),a(extra_audc),a(rakieta_audc),a(alarm_audc)
/*		
ctl_table
		dta a(1)
		dta a(1+32)
		dta a(1)
		dta a(1)
		dta a(1)
		dta a(1)
		dta a(1)
		dta a(1)  */
		
len_table
		dta b(13),b(0)	;antyair
		dta b(9),b(0)	;asteroida
		dta b(25),b(0)	;bomba
		;dta b(20),b(0)	;dzialko
		dta 29,0		;dzialko
		dta b(62),b(0)	;wybuch
		dta b(19),b(0)	;strzal
		dta b(27),b(0)	;enemy
		dta b(34),b(0)	;spy
		dta 70,0			;dead
		dta 49,0			;extra life
		dta 46,0			;rakieta
		dta 60,1			;alarm formation
		

antyair_audf .he 00 F5 E5 D5 C5 B5 A5 95 85 75 65 55 45 2D
antyair_audc .he 00 A1 A1 A1 A2 A2 A2 A2 A3 A3 A3 A4 A4 A4

asteroid_audc .he 00 A3 A3 A3 A3 A0 A3 A3 A3 A3
asteroid_audf .he 00 2F 32 35 39 3C 32 35 39 3C

bomba_audf	.he 00,00,18,18,18,18,18,18,18,18,18,18,18,18,18,18
			.he 18,18,18,18,18,18,18,18,18,18
bomba_audc	.he 00,00,01,02,03,04,05,06,06,06,06,08,08,08,08,08
			.he 0A,0A,0A,0A,0A,0C,0C,0E,0E,0F


dzialko_audf	.he 00,00
				:28 .he 30
dzialko_audc	.he 00,00,01,02,03,04,05,06,06,06,06,08,08,08,08,08,09,09,09,09,0A,0A,0A,0B,0B,0B,0B,0D,0D,0E


wybuch_audf	.he 00 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
wybuch_audc	.he 00 82 82 82 82 82 82 82 82 82 82 84 84 84 84 84 84 84 84 84 84 86 86 86 86 86 86 86 86 86 88 88 88 88 88 88 88 88 88 88 8A 8A 8A 8A 8A 8A 8A 8A 8C 8C 8C 8E 8E 8E 8F 8F 8F 8F 8F 8F 8F 8F 8F

strzal_audf	.he 00,00,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b,0b
strzal_audc	.he 00 83 83 83 83 83 83 84 84 84 84 84 84 84 84 84 84 85 86 87

enemy_audf	.he 00 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 25 25 25 25 25 25 25 25 25
enemy_audc	.he 00 02 02 02 02 04 02 04 04 04 04 06 04 06 06 08 06 08 08 08 0A 0A 0C 0C 0C 0C 0C 0E

spy_audf	.he 00 31 30 2F 2E 2D 2C 2B 2A 29 28 27 26 25 24 23 22 21 20 1F 1E 1D 1C 1B 1A 19 18 17 16 15 14 13 12 11 10
spy_audc	.he 00 C1 C1 C2 C2 C1 C1 C1 C1 C1 C1 C2 C2 C4 C4 C1 C1 C1 C1 C2 C2 C3 C3 C6 C7 C2 C2 C2 C2 C3 C3 C4 C4 C6 C7

dead_audf	.he 00 C5 C4 C3 C2 C1 C0 BF BE BD BC BB BA B9 B8 B7 B6 B5 B4 B3 B2 B1 B0 AF AE AD AC AB AA A9 A8 A7 A6 A5 A4 A3 A2 A1 A0 9F 9E 9D 9C 9B 9A 99 98 97 96 95 94 93 92 91 90 8F 8E 8D 8C 8B 8A 89 88 87 86 7F 84 83 82 7B 10
dead_audc	.he 00 C1 C1 C1 C1 C1 C1 C1 C1 C2 C2 C2 C2 C2 C2 C2 C2 C3 C3 C3 C3 C3 C3 C3 C3 C4 C4 C4 C4 C4 C4 C4 C4 C5 C5 C5 C5 C5 C5 C5 C5 C6 C6 C6 C6 C6 C6 C6 C6 C7 C7 C7 C7 C7 C7 C7 C7 C8 C8 C8 C9 C9 CA CA CB AB CC CC CC 8B C8

extra_audf	.he 00 6F 8F AF CF EF 0F 2F 4F 6F 8F AF CF EF 0F 2F 4F 6F 8F AF CF EF 0F 2F 4F 6F 8F AF CF EF 0F 2F 4F 6F 8F AF CF EF 0F 2F 4F 6F 8F AF CF EF 0F 2F 4F 6F
extra_audc	.he 00 C1 C1 C1 C1 C1 C1 C2 C2 C2 C2 C2 C2 C3 C3 C3 C3 C3 C3 C4 C4 C4 C4 C4 C4 C5 C5 C5 C5 C5 C5 C5 C5 C5 C5 C5 C5 C5 C5 C5 C5 C6 C6 C6 C6 C7 C7 C8 C8 C8

rakieta_audf	.he 00 71 71 72 72 73 73 75 75 76 76 77 77 78 78 79 79 6A 6A 6B 6B 6C 6C 6D 6D 6E 6E 6F 6F 70 70 71 71 72 72 73 73 75 75 76 76 77 77 78 78 79 79
rakieta_audc	.he 00 A3 A3 A3 A3 A3 A3 A3 A3 A3 A4 A3 A4 A4 A4 A4 A4 A4 A4 A5 A4 A5 A5 A4 A5 A6 A4 A5 A6 A5 A6 A6 A5 A6 A7 A5 A6 A7 A5 A6 A8 A6 A7 A8 A6 A7 A8

alarm_audf	.he 00 3C 3C 3C 2A 35 35 2F 25 2F 2A 2A 21 2D 2D 2D 25 2F 2F 32 28 32 35 35 2A 39 39 39 2F 3C 3C 3C 2F 3C 35 35 2A 2F 2F 2F 21 2A 2A 2D 23 2D 2F 2F 25 32 32 32 2A 35 35 39 2D 39 3C 3C 2F
alarm_audc	.he 00 
			:15 .he A5 A5 A6 A8

.endl
		
