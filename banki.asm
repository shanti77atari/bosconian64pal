ROM_on	equ %11111111
BANK0	equ %11111110


bom0	equ 203
bom0a	equ 204
bom		equ 205
bom1	equ 207
bom2	equ 203

ad_Jadra		equ $fb10
ksztaltJadroA0	equ ad_Jadra+8 
ksztaltJadroA1	equ ksztaltJadroA0+16
ksztaltJadroA2	equ ksztaltJadroA1+16
ksztaltJadroA3	equ ksztaltJadroA2+16
ksztaltJadroA4	equ ksztaltJadroA3+16	
ksztaltJadroA5	equ ksztaltJadroA4+16
ksztaltJadroA6	equ ksztaltJadroA5+16
ksztaltJadroB0	equ ksztaltJadroA6+16
ksztaltJadroB1	equ ksztaltJadroB0+16
ksztaltJadroB2	equ ksztaltJadroB1+16
ksztaltJadroB3	equ ksztaltJadroB2+16
ksztaltJadroB4	equ ksztaltJadroB3+16
ksztaltJadroB5	equ ksztaltJadroB4+16
ksztaltJadroB6	equ ksztaltJadroB5+16
statek		equ $f500	;$2000
tabX		equ $1a00
	
adresZnakL	equ $f600
adresZnakH	equ $f700	

enemy1adr	equ $E000	;, ksztalty
enemy3adr	equ enemy1adr+$200	; ksztalty	+512
enemy5adr	equ enemy3adr+$200	; SPY
explo_adr	equ enemy5adr+$200


tLShif		equ explo_adr+96
tHShif		equ tLShif+4

mask			equ shpBuf+$100		;$e800
scolor0		equ mask+$100			;enemy1	;e900
scolor1		equ scolor0+$100		;enemy2
scolor2		equ scolor1+$100		;spy
scolor3		equ scolor2+$100		;explo	;ec00
ShifRight2H	equ scolor3+$100		;ed00
ShifRight2L	equ ShifRight2H+$100
ShifRight4H	equ ShifRight2L+$100
ShifRight4L	equ ShifRight4H+$100	;f000
ShifRight6H	equ ShifRight4L+$100
ShifRight6L	equ ShifRight6H+$100	;f200

znakiBosc	equ $F808		;38*8=304 bajty
cyfryBosc	equ znakiBosc+28*8


enemyTab1	equ $1800
fazaTab1	equ enemyTab1+48
tab5		equ fazaTab1+4
tablives	equ tab5+3
SpyScoreTab	equ tablives+6
conditionC	equ SpyScoreTab+3
fazaTab		equ conditionC+3

obraz1L		equ $1880			;4*29=116 		
obraz1H		equ obraz1L+29
obraz2L		equ obraz1H+29
obraz2H		equ obraz2L+29
zmazTab		equ obraz2H+29		;8b	(4b wolne), reszta w b.asm


strzalY		equ $1900
strzalX		equ strzalY+4
strzalX1	equ strzalY+8
strzalX2	equ strzalY+12
strzalX3	equ strzalY+16

strzalY1	equ strzalY+20
strzalY2	equ strzalY+24
strzalY3	equ strzalY+28
strzalYbit	equ strzalY+32
strzalKierunek	equ strzalY+36
strzalTlo	equ strzalY+40
strzalTlo1	equ strzalY+44
strzalXbit	equ strzalY+48		;(52b zajete), reszta w b.asm

;enemyTab2	equ $1600	;$fe00		;można przenieść do $1600, zwolni się 2 duszek.

enemyTabX=$ce00
enemyTabY=$cf00

			org $2600	;$7600
			
znaki_ad	equ *	
	dta b(0,0,0,0,0,0,0,0)
	
	dta b(0,0,0,0,0,0,0,0)	;znak #1 gwiazda
	dta b(0,0,0,0,0,0,0,0)	;2 gwiazda
	
;bazy
	dta b(%00000011)		;1 znak  stacji
	dta b(%00001111)
	dta b(%00111111)
	dta b(%00111111)
	dta b(%00001100)
	dta b(%11111111)
	dta b(%11111101)
	dta b(%11110110)
	
	dta b(%01010110)		;znak3
	dta b(%11111101)
	dta b(%11111111)
	dta b(%00001100)
	dta b(%00111111)
	dta b(%00111111)
	dta b(%00001111)
	dta b(%00000011)
	
	dta b(%11000000)		;znak4
	dta b(%00110000)
	dta b(%11001100)
	dta b(%11111100)
	dta b(%00110000)
	dta b(%11111111)
	dta b(%01111111)
	dta b(%10010101)
	
	dta b(%10011111)		;znak5
	dta b(%01111111)
	dta b(%11111111)
	dta b(%00110000)
	dta b(%11111100)
	dta b(%11001100)
	dta b(%00110000)
	dta b(%11000000)
	
	dta b(%00000000)		;znak6
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00111111)
	dta b(0)
	
	dta b(%00111111)		;znak7
	dta b(%00111111)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	
	dta b(%00000011)		;znak8
	dta b(%00001111)
	dta b(%00001100)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	
	dta b(%00000000)		;znak9
	dta b(%11000000)
	dta b(%11000000)
	dta b(%11110000)
	dta b(%00110000)
	dta b(%11111100)
	dta b(%11001100)
	dta b(%00110000)
	
	dta b(%11000000)		;znak10
	dta b(%11110000)
	dta b(%00110000)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	
	dta b(%00000000)		;znak11
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00001111)
	dta b(%00001100)
	dta b(%00111111)
	dta b(%00110011)
	dta b(%00001100)
	
	dta b(%00110000)		;znak12
	dta b(%11110000)
	dta b(%11110000)
	dta b(%11110000)
	dta b(%00111100)
	dta b(%00111100)
	dta b(%00111100)
	dta b(%00110000)
	
	dta b(%00001100)		;znak13
	dta b(%00001111)
	dta b(%00001111)
	dta b(%00001111)
	dta b(%00111100)
	dta b(%00111100)
	dta b(%00111100)
	dta b(%00001100)
	
	dta b(%00000000)		;znak 14 I
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00000000)
	
	dta b(%00000000)		;znak 15 I
	dta b(%11000000)
	dta b(%10000000)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%10000000)
	dta b(%11000000)
	dta b(%00000000)
	
	dta b(0)				;znak 16  schoda wdol
	dta b(%00110000)
	dta b(%00001100)
	dta b(%00110000)
	dta b(%00111100)
	dta b(%00001100)
	dta b(0,0)
	
	dta b(0)				;znak 17 schoda w gore
	dta b(%00001100)
	dta b(%00110000)
	dta b(%00001100)
	dta b(%00111100)
	dta b(%00110000)
	dta b(0,0)
	
	dta b(%00000000)		;znak 18 jadro gwiazda A
	dta b(%00110000)
	dta b(%00110000)
	dta b(%00111100)
	dta b(%00111100)
	dta b(%11111111)
	dta b(%11111011)
	dta b(%11101011)
	
	dta b(%11101011)		;znak 19 jadro gwiazda A
	dta b(%11101111)
	dta b(%11111111)
	dta b(%00111100)
	dta b(%00111100)
	dta b(%00001100)
	dta b(%00001100)
	dta b(%00000000)
	
	dta b(%00000000)		;znak 20 jadro gwiazda B
	dta b(%00000011)
	dta b(%00001111)
	dta b(%11111010)
	dta b(%00111110)
	dta b(%00001111)
	dta b(%00000011)
	dta b(%00000000)
	
	dta b(%00000000)		;znak 21 jadro gwiazda B
	dta b(%11000000)
	dta b(%11110000)
	dta b(%10111100)
	dta b(%10101111)
	dta b(%11110000)
	dta b(%11000000)
	dta b(%00000000)
	
	dta b(%00000011)		;trafione dzialko (b+20)
	dta b(%00001111)
	dta b(%00111110)
	dta b(%00110010)
	dta b(%11101000)
	dta b(%11101000)
	dta b(%10101010)
	dta b(%00100010)
	
	dta b(%00101000)		;b+21
	dta b(%11101000)
	dta b(%11100000)
	dta b(%11100000)
	dta b(%00110000)
	dta b(%00110000)
	dta b(%00001111)
	dta b(%00000011)
	
	dta b(%11000000)		;b+22
	dta b(%00110000)
	dta b(%00111100)
	dta b(%10111100)
	dta b(%00110011)
	dta b(%10101111)
	dta b(%10101011)
	dta b(%00101000)
	
	dta b(%10001000)		;b+23
	dta b(%10101011)
	dta b(%00101011)
	dta b(%00101011)
	dta b(%10101100)
	dta b(%10101100)
	dta b(%00110000)
	dta b(%11000000)
	
	dta b(%00111100)		;/ baza B
	dta b(%11001100)
	dta b(%11111100)
	dta b(%00110000)
	dta b(0,0,0,0)
	
	dta b(0,0,0,0)
	dta b(%00001100)
	dta b(%00001111)
	dta b(%00110011)
	dta b(%00111111)
	
	dta b(%00111100)		;\ baza B
	dta b(%00110011)
	dta b(%00111111)
	dta b(%00001100)
	dta b(0,0,0,0)
	
	dta b(0,0,0,0)
	dta b(%00110000)
	dta b(%11110000)
	dta b(%11001100)
	dta b(%11111100)
	
	
	dta b(%00000000)		;bomba
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00100000)
	dta b(%00001000)
	dta b(%00000001)
	dta b(%00000001)
	dta b(%00100001)
	
	dta b(%00000001)
	dta b(%00000001)
	dta b(%00001000)
	dta b(%00100000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	
	dta b(%10000000)
	dta b(%10000000)
	dta b(%00000000)
	dta b(%00000010)
	dta b(%01001000)
	dta b(%01010000)
	dta b(%01010000)
	dta b(%01010010)
	
	dta b(%01000000)
	dta b(%00010000)
	dta b(%01001000)
	dta b(%00000010)
	dta b(%00000000)
	dta b(%10000000)
	dta b(%10000000)
	dta b(%00000000)
	
;meteor	
	
	dta b(%00000010)		
	dta b(%00001010)
	dta b(%00101010)
	dta b(%00101010)
	dta b(%00101010)
	dta b(%00101010)
	dta b(%10101010)
	dta b(%10101010)
	
	dta b(%10101011)
	dta b(%10101110)
	dta b(%10101110)
	dta b(%10101111)
	dta b(%11111111)
	dta b(%00111111)
	dta b(%00111111)
	dta b(%00001111)
	
	dta b(%10000000)
	dta b(%10111010)
	dta b(%10111010)
	dta b(%10101011)
	dta b(%10101010)
	dta b(%10101010)
	dta b(%10101011)
	dta b(%10101011)
	
	dta b(%10101100)
	dta b(%10101100)
	dta b(%10101100)
	dta b(%11111100)
	dta b(%11111100)
	dta b(%00110000)
	dta b(%00000000)
	dta b(%00000000)    
	
;rakiety
	dta b(%00100000)
	dta b(%00100000)		;w gore
	dta b(%11111100)
	dta b(%01111100)
	dta b(%11111100)
	dta b(%00100000)
	dta b(%10101000)
	dta b(%11111100)
	
	dta b(%01110100)		;pasek pionowy
	dta b(%01110100)
	dta b(%01110100)
	dta b(%01110100)
	dta b(%01110100)
	dta b(%11111100)
	dta b(%10101000)
	dta b(%00100000)
	
	dta b(%00100000)		;|  pasek pionowy odwrotny
	dta b(%10101000)
	dta b(%11111100)
	dta b(%01110100)
	dta b(%01110100)
	dta b(%01110100)
	dta b(%01110100)
	dta b(%01110100)
	
	dta b(%11111100)		;w dol
	dta b(%10101000)
	dta b(%00100000)
	dta b(%11111100)
	dta b(%01111100)
	dta b(%11111100)
	dta b(%00100000)
	dta b(%00100000)
					
	dta b(%00001100)		;w lewo
	dta b(%00110100)
	dta b(%10111110)
	dta b(%10111110)
	dta b(%00111100)
	dta b(%00001100)
	dta b(0,0)
				
	dta b(%11010100)		;tyl rakiety -
	dta b(%10010111)
	dta b(%10111110)
	dta b(%10111110)
	dta b(%10010111)
	dta b(%11010100)
	dta b(0,0)
			
	dta b(%00010111)		;tyl rakiety w prawo
	dta b(%11010110)
	dta b(%10111110)
	dta b(%10111110)
	dta b(%11010110)
	dta b(%00010111)
	dta b(0,0)
			
	dta b(%00110000)		;w prawo
	dta b(%00011100)
	dta b(%10111110)
	dta b(%10111110)
	dta b(%00111100)
	dta b(%00110000)
	dta b(0,0)	
	
	;wybuchy
	dta b(0,0,0,0)
	dta b(%00000010)
	dta b(%00001001)
	dta b(%00111001)
	dta b(%00100101)
	dta b(%00100101)
	
	dta b(%00100101)
	dta b(%00111001)
	dta b(%00001001)
	dta b(%00000010)
	dta b(0,0,0)
	
	dta b(0,0,0,0)
	dta b(%10000000)
	dta b(%01100000)
	dta b(%01101100)
	dta b(%01011000)
	dta b(%01011000)
	
	dta b(%01011000)
	dta b(%01101100)
	dta b(%01100000)
	dta b(%10000000)
	dta b(0,0,0)
	
	;2
	dta b(0),b(%00000010)
	dta b(%00001001)
	dta b(%00100101)
	dta b(%00100101)
	dta b(%11100101)
	dta b(%10010101)
	dta b(%10010110)
	dta b(%10010110)
	
	dta b(%10010110)
	dta b(%10010101)
	dta b(%11100101)
	dta b(%00100101)
	dta b(%00100101)
	dta b(%00001001)
	dta b(%00000010)
	
	dta b(0),b(%10000000)
	dta b(%01100000)
	dta b(%01011000)
	dta b(%01011000)
	dta b(%01011011)
	dta b(%01010110)
	dta b(%10010110)
	dta b(%10010110)
	
	dta b(%10010110)
	dta b(%01010110)
	dta b(%01011011)
	dta b(%01011000)
	dta b(%01011000)
	dta b(%01100000)
	dta b(%10000000)	
	;3
	dta b(0),b(%00000010)
	dta b(%00001010)
	dta b(%00101011)
	dta b(%00101000)
	dta b(%11101000)
	dta b(%10101100)
	dta b(%10100000)
	dta b(%10100000)
	
	dta b(%10100000)
	dta b(%10101100)
	dta b(%11101000)
	dta b(%00101000)
	dta b(%00101011)
	dta b(%00001010)
	dta b(%00000010)
	
	dta b(0),b(%10000000)
	dta b(%10100000)
	dta b(%11101000)
	dta b(%00101000)
	dta b(%00101011)
	dta b(%00111010)
	dta b(%00001010)
	dta b(%00001010)
	
	dta b(%00001010)
	dta b(%00111010)
	dta b(%00101011)
	dta b(%00101000)
	dta b(%11101000)
	dta b(%10100000)
	dta b(%10000000)
	
	;4
	dta b(0),b(%00000010)
	dta b(%00001011)
	dta b(%00101100)
	dta b(%00100000)
	dta b(%00100000)
	dta b(%10110000)
	dta b(%10000000)
	dta b(%10000000)
	
	dta b(%10000000)
	dta b(%10110000)
	dta b(%00100000)
	dta b(%00100000)
	dta b(%00101100)
	dta b(%00001011)
	dta b(%00000010)
	
	dta b(0),b(%10000000)
	dta b(%11100000)
	dta b(%00111000)
	dta b(%00001000)
	dta b(%00001000)
	dta b(%00001110)
	dta b(%00000010)
	dta b(%00000010)
	
	dta b(%00000010)
	dta b(%00001110)
	dta b(%00001000)
	dta b(%00001000)
	dta b(%00111000)
	dta b(%11100000)
	dta b(%10000000)
	
	;maly wybuch
	dta b(%00100000)
	dta b(%00100000)
	dta b(%10001000)
	dta b(%10001000)
	dta b(%00100000)
	dta b(%00100000)
	dta b(%10001000)
	dta b(%10001000)
	
	dta b(%00100010)
	dta b(%00100010)
	dta b(%10001000)
	dta b(%10001000)
	dta b(%00100010)
	dta b(%00100010)
	dta b(%10001000)
	dta b(%10001000)
	
mwybuch2	equ *
	dta b(%10001000)
	dta b(%10001000)
	dta b(%00100000)
	dta b(%00100000)
	dta b(%10001000)
	dta b(%10001000)
	dta b(%00100000)
	dta b(%00100000)
	
	dta b(%10001000)
	dta b(%10001000)
	dta b(%00100010)
	dta b(%00100010)
	dta b(%10001000)
	dta b(%10001000)
	dta b(%00100010)
	dta b(%00100010)
	
;ksztalt wroga ^ kolor1
enemy1kszt	equ *
;faza 0
	dta b(%00001101)
	dta b(%00110101)
	dta b(%00110110)
	dta b(%11010110)
	dta b(%11010101)
	dta b(%11010110)
	dta b(%01011011)
	dta b(%01011100)
	dta b(%01101100)
	:4 dta b(%01110000)
	dta b(%11000000)
	dta b(0,0)
	
	dta b(%11000000)
	dta b(%10110000)
	dta b(%01110000)
	dta b(%01101100)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%01011011)
	dta b(%11010111)
	dta b(%11010111)
	:4 dta b(%00110111)
	dta b(%00001100)
	dta b(0,0)
			
;faza1
	dta b(0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%11010110)
	dta b(%11011011)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0,0,0)
	:2 dta b(%00000011)
	dta b(0)
	
	dta b(%11110000)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%01100111)
	dta b(%01100111)
	dta b(%01010111)
	dta b(%10010111)
	:3 dta b(%11010111)
	dta b(%11011011)
	dta b(%11011100)
	dta b(%11011100)
	dta b(%01101100)
	dta b(%01110000)
	dta b(%11000000)
			
;faza2	
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%01101010)
	dta b(%10111111)
	dta b(%11000011)
	dta b(0,0,0,0,0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00001110)
	dta b(%00000011)
	
	dta b(%11111100)
	dta b(%01010111)
	dta b(%01010111)
	dta b(%01100111)
	dta b(%01100111)
	dta b(%01010111)
	dta b(%10010111)
	dta b(%11010111)
	dta b(%11010111)
	dta b(%11011011)
	dta b(%11011100)
	dta b(%01101100)
	dta b(%01110000)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0)
			
;faza3
	dta b(0)
	dta b(%00001111)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%00111110)
	dta b(%00000011)
	dta b(0,0,0,0,0,0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110110)
	dta b(%00001111)
	
	dta b(0)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%01010101)
	dta b(%10011001)
	dta b(%11011001)
	dta b(%11010110)
	dta b(%11010111)
	dta b(%11011011)
	dta b(%01011100)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0)

;faza4
	dta b(%00111100)
	dta b(%11010111)
	dta b(%00111001)
	dta b(%00001110)
	dta b(%00000011)
	dta b(%00000011)
	dta b(0,0,0,0)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%11011011)
	dta b(%00111100)
	
	dta b(0)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01010000)
	dta b(%01010111)
	dta b(%10010111)
	dta b(%11010101)
	dta b(%11011001)
	dta b(%11011001)
	dta b(%11010110)
	dta b(%01010111)
	dta b(%01011011)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0)
			
;faza5		
	dta b(%00001111)
	dta b(%00110101)
	dta b(%00001101)
	dta b(%00001110)
	dta b(%00000011)
	dta b(%00000011)
	dta b(0,0,0)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%11010101)
	dta b(%00111001)
	dta b(%00001111)
	dta b(0)
	
	dta b(0)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%10010111)
	dta b(%11010111)
	dta b(%11010101)
	dta b(%11011001)
	dta b(%01011001)
	dta b(%01010110)
	dta b(%01011000)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0)
			
;faza6		
	dta b(%00001101)
	dta b(%00001101)
	dta b(%00001110)
	dta b(%00000011)
	dta b(%00000011)
	dta b(0,0,0)
	dta b(%11000000)
	dta b(%01111111)
	dta b(%10010101)
	dta b(%11100101)
	dta b(%00111001)
	dta b(%00001110)
	dta b(%00000011)
	dta b(0)
	
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%10011100)
	dta b(%11010111)
	dta b(%11100111)
	dta b(%11010111)
	dta b(%11010111)
	dta b(%01010111)
	dta b(%01100111)
	dta b(%01100111)
	dta b(%01010111)
	dta b(%01010111)
	dta b(%11111100)
	dta b(0)
			
;faza7
	dta b(0)
	dta b(%00000011)
	dta b(%00000011)
	dta b(0,0,0)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%10011100)
	dta b(%11010111)
	dta b(%11100101)
	dta b(%00110101)
	dta b(%00111001)
	dta b(%00001110)
	dta b(%00000011)
	dta b(0)
	
	dta b(%11000000)
	dta b(%01110000)
	dta b(%10011100)
	dta b(%11011100)
	dta b(%11011100)
	dta b(%11010111)
	dta b(%11100111)
	dta b(%11010111)
	dta b(%11010111)
	dta b(%01010111)
	dta b(%01010111)
	dta b(%01100111)
	dta b(%01100111)
	dta b(%01010111)
	dta b(%10011100)
	dta b(%11110000)
			
;faza8
	dta b(0,0)
	dta b(%11000000)
	:4 dta b(%01110000)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%10010111)
	dta b(%11010110)
	dta b(%11010101)
	dta b(%11100110)
	dta b(%00110110)
	dta b(%00111001)
	dta b(%00001101)
	
	dta b(0,0)
	dta b(%00001100)
	:4 dta b(%00110111)
	dta b(%11100111)
	dta b(%11010111)
	dta b(%10010111)
	:3 dta b(%01011100)
	dta b(%01110000)
	dta b(%01110000)
	dta b(%11000000)
			
;faza9
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%00110110)
	dta b(%00110111)
	dta b(%11010111)
	dta b(%11010111)
	dta b(%11011011)
	dta b(%11010111)
	dta b(%11010101)
	dta b(%11010101)
	dta b(%11011001)
	dta b(%11011001)
	dta b(%11010101)
	dta b(%00110110)
	dta b(%00001111)
	
	dta b(0)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%11000000)
	dta b(0,0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110110)
	dta b(%11010111)
	dta b(%01011011)
	dta b(%01011100)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0)
			
;faza10
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00001101)
	dta b(%00110110)
	dta b(%00110111)
	dta b(%11011011)
	:3 dta b(%11010111)
	dta b(%11010101)
	dta b(%11011001)
	dta b(%11011001)
	dta b(%11010101)
	dta b(%11010101)
	dta b(%00111111)
	dta b(0)
	
	dta b(%01110000)
	dta b(%10110000)
	dta b(%11000000)
	dta b(%11000000)
	dta b(0,0,0,0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%01010110)
	dta b(%01011011)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0)
			
;faza11
	dta b(0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%00110110)
	dta b(%11010111)
	dta b(%11011011)
	dta b(%01010111)
	dta b(%01100111)
	dta b(%01100101)
	dta b(%01010101)
	dta b(%11010101)
	dta b(%00110101)
	dta b(%00001110)
	dta b(%00000011)
	dta b(0)
	
	dta b(%11110000)
	dta b(%01011100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(%11000000)
	dta b(0,0,0,0)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%01111100)
	dta b(%01010111)
	dta b(%01101100)
	dta b(%11110000)
	dta b(0)
			
;faza12
	dta b(0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%11010110)
	dta b(%01010111)
	dta b(%01100111)
	dta b(%01100111)
	dta b(%01010111)
	dta b(%11010101)
	dta b(%11100101)
	dta b(%00111001)
	dta b(%00001110)
	dta b(%00000011)
	dta b(0)
	
	dta b(%00111100)
	dta b(%11010111)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(%11000000)
	dta b(0,0,0,0)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%11010111)
	dta b(%00111100)
			
;faza13
	dta b(0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%01010101)
	dta b(%01100110)
	dta b(%01100111)
	dta b(%01010111)
	dta b(%11010111)
	dta b(%11100111)
	dta b(%00110101)
	dta b(%00111001)
	dta b(%00001110)
	dta b(%00000011)
	dta b(0)
	
	dta b(0)
	dta b(%11110000)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%10111100)
	dta b(%11000000)
	dta b(%11000000)
	dta b(0,0,0,0)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%11110000)
			
;faza14
	dta b(0)
	dta b(%00111111)
	dta b(%11010101)
	dta b(%11010101)
	dta b(%11011001)
	dta b(%11011001)
	dta b(%11010110)
	:3 dta b(%11010111)
	dta b(%11100111)
	dta b(%00110111)
	dta b(%00111001)
	dta b(%00001101)
	dta b(%00001110)
	dta b(%00000011)
	
	dta b(0)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%10100101)
	dta b(%11111111)
	dta b(0,0,0,0,0)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01110000)
			
;faza15
	dta b(%00001111)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%11011001)
	dta b(%11011001)
	dta b(%11010101)
	dta b(%11010110)
	:3 dta b(%11010111)
	dta b(%11100111)
	dta b(%00110111)
	dta b(%00110111)
	dta b(%00111001)
	dta b(%00001110)
	dta b(%00000011)
	
	dta b(0)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%10010111)
	dta b(%11100111)
	dta b(%00111001)
	dta b(%00001111)
	dta b(0,0,0,0)
	dta b(%11000000)
	dta b(%11000000)
	dta b(0)
		
enemy3kszt	equ *
;faza0
	:4 dta b(%00001101)
	dta b(%00110101)
	:3 dta b(%00110110)
	dta b(%11010101)
	dta b(%11010101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%11010101)
	dta b(%00110101)
	dta b(%00110111)
	dta b(%00110111)
	
	:4 dta b(%11000000)
	:4 dta b(%01110000)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%01011011)
	dta b(%01101100)
	dta b(%01110000)
	dta b(%01110000)
	dta b(%10110000)
			
;faza1
	dta b(0,0)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%11011001)
	dta b(%11101101)
	dta b(%00111101)
	dta b(%00001110)
	dta b(%00000011)
	
	dta b(%11011100)
	dta b(%11011100)
	:3 dta b(%01011100)
	:3 dta b(%10011100)
	:3 dta b(%01011100)
	dta b(%01010111)
	dta b(%10101011)
	dta b(%11111100)
	dta b(%11000000)
	dta b(0)
			
;faza2
	dta b(0,0,0)
	dta b(%11110011)
	dta b(%01011101)
	dta b(%01010101)
	dta b(%11010110)
	dta b(%11010110)
	dta b(%11010101)
	dta b(%01100101)
	dta b(%10110101)
	dta b(%11110101)
	dta b(%00001101)
	dta b(%00110111)
	dta b(%00111011)
	dta b(%00001100)
	
	dta b(%00001100)
	dta b(%00110111)
	dta b(%11010111)
	dta b(%01010111)
	dta b(%01011011)
	dta b(%10011100)
	dta b(%10011100)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%01101100)
	dta b(%01110000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%10101100)
	dta b(%11110000)
	dta b(0)
			
;faza3
	dta b(0)
	dta b(%00110000)
	dta b(%11011100)
	dta b(%11010111)
	dta b(%11010101)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%01010110)
	dta b(%10010110)
	dta b(%11010101)
	dta b(%11100101)
	dta b(%00110101)
	dta b(%00110110)
	dta b(%11011011)
	dta b(%11101111)
	dta b(%00110000)
	
	dta b(0,0,0)
	dta b(%11111111)
	dta b(%01010101)
	dta b(%01010110)
	dta b(%10010111)
	dta b(%10011011)
	dta b(%01011100)
	dta b(%01101100)
	:5 dta b(%01110000)
	dta b(%11000000)
			
;faza4
	dta b(%00001100)
	dta b(%00110111)
	dta b(%11010111)
	dta b(%11010111)
	dta b(%11010101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%11010110)
	dta b(%11010110)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%11010110)
	dta b(%11010111)
	dta b(%11100111)
	dta b(%00110111)
	dta b(%00001100)
	
	dta b(0,0,0,0)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%10010101)
	dta b(%10011010)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(0,0,0,0)
			
;faza5
	dta b(%00110000)
	dta b(%11011111)
	dta b(%11010111)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%11010101)
	dta b(%01010110)
	dta b(%01010110)
	dta b(%11110101)
	dta b(%00110101)
	dta b(%11010110)
	dta b(%11011011)
	dta b(%11101100)
	dta b(%00110000)
	dta b(0)
	
	dta b(%11000000)
	:5 dta b(%01110000)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%10010111)
	dta b(%10010111)
	dta b(%01010101)
	dta b(%10101010)
	dta b(%11111111)
	dta b(0,0,0)
			
;faza6
	dta b(%00001100)
	dta b(%00110111)
	dta b(%00110111)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%01110101)
	dta b(%01010101)
	dta b(%11010110)
	dta b(%11010110)
	dta b(%11010101)
	dta b(%01010101)
	dta b(%01011110)
	dta b(%11110011)
	dta b(0,0,0)
	
	dta b(0)
	dta b(%11110000)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%01110000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%10011100)
	dta b(%10011100)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%11010111)
	dta b(%00110111)
	dta b(%00111011)
	dta b(%00001100)
			
;faza7
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00001101)
	dta b(%11011101)
	dta b(%11010101)
	dta b(%11010101)
	dta b(%00110101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%11100101)
	dta b(%00111101)
	dta b(%00001110)
	:2 dta b(%00000011)
	dta b(0,0)
	
	dta b(0)
	dta b(%11000000)
	dta b(%11111100)
	dta b(%01010111)
	dta b(%01010111)
	:3 dta b(%01011100)
	:3 dta b(%10011100)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%10011100)
	dta b(%11011100)
	dta b(%11101100)
			
;faza8		
	:3 dta b(%00001101)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%11100101)
	dta b(%00110101)
	dta b(%00111001)
	:3 dta b(%00001101)
	dta b(%00001110)
	:4 dta b(%00000011)
	
	dta b(%11011100)
	dta b(%11011100)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%01010111)
	dta b(%01010111)
	:3 dta b(%10011100)
	dta b(%01011100)
	:4 dta b(%01110000)
			
;faza9
	dta b(0)
	dta b(%00000011)
	dta b(%00111111)
	dta b(%11010101)
	dta b(%11010101)
	:3 dta b(%00110101)
	:3 dta b(%00110110)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%00110110)
	dta b(%00110111)
	dta b(%00111011)
	
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01111100)
	dta b(%01110111)
	dta b(%01010111)
	dta b(%01010111)
	dta b(%01011100)
	dta b(%01010101)
	dta b(%01010110)
	dta b(%01011011)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11000000)
	dta b(%11000000)
	dta b(0,0)
			
;faza10
	dta b(0)
	dta b(%00001111)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%00001101)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%00110110)
	dta b(%00110110)
	dta b(%00110101)
	dta b(%11010101)
	dta b(%11010110)
	dta b(%11011011)
	dta b(%11101100)
	dta b(%00110000)
	
	dta b(%00110000)
	dta b(%11011100)
	dta b(%11011100)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%01011101)
	dta b(%01010110)
	dta b(%10010111)
	dta b(%10010111)
	dta b(%01010111)
	dta b(%01100101)
	dta b(%10110110)
	dta b(%11001111)
	dta b(0,0,0)
			
;faza11
	dta b(%00000011)
	:5 dta b(%00001101)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%11010110)
	dta b(%11010110)
	dta b(%01010101)
	dta b(%01100110)
	dta b(%11111111)
	dta b(0,0,0)
	
	dta b(%00001100)
	dta b(%11110111)
	dta b(%11011011)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%01010111)
	dta b(%10010101)
	dta b(%10011010)
	dta b(%01011111)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%11010111)
	dta b(%00111011)
	dta b(%00001100)
	dta b(0)
			
;faza12
	dta b(0,0,0,0)
	dta b(%00000011)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%01010110)
	dta b(%01010110)
	dta b(%00110101)
	dta b(%00001101)
	dta b(%00000011)
	dta b(0,0,0,0)
	
	dta b(%00110000)
	dta b(%11011100)
	dta b(%11010111)
	dta b(%11010111)
	dta b(%01010111)
	dta b(%01010101)
	dta b(%01010110)
	dta b(%10010111)
	dta b(%10010111)
	dta b(%01010101)
	dta b(%01010110)
	dta b(%01010111)
	dta b(%11010111)
	dta b(%11011011)
	dta b(%11101100)
	dta b(%00110000)
			
;faza13
	dta b(0,0,0)
	dta b(%11111111)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%11010110)
	dta b(%11010110)
	dta b(%00110101)
	dta b(%00110101)
	:5 dta b(%00001101)
	dta b(%00000011)
	
	dta b(0)
	dta b(%00001100)
	dta b(%00110111)
	dta b(%11010111)
	dta b(%01010111)
	dta b(%01011100)
	dta b(%01011100)
	dta b(%10010101)
	dta b(%10010110)
	dta b(%01010111)
	dta b(%01011011)
	dta b(%01011100)
	dta b(%10011100)
	dta b(%11010111)
	dta b(%11111011)
	dta b(%00001100)
			
;faza14
	dta b(%00110000)
	dta b(%11011100)
	dta b(%11010111)
	dta b(%11010101)
	dta b(%11010101)
	dta b(%00110110)
	dta b(%00110110)
	:3 dta b(%00110101)
	dta b(%00001101)
	dta b(%00001101)
	dta b(%00110101)
	dta b(%00110101)
	dta b(%00001111)
	dta b(0)
	
	dta b(0,0,0)
	dta b(%11001111)
	dta b(%01110101)
	dta b(%01010110)
	dta b(%10010111)
	dta b(%10010111)
	dta b(%01010111)
	dta b(%01010101)
	dta b(%01011110)
	dta b(%01101100)
	dta b(%10110000)
	dta b(%11011100)
	dta b(%11101100)
	dta b(%00110000)
			
;faza15
	dta b(%00110111)
	dta b(%00110111)
	:3 dta b(%00110101)
	:3 dta b(%00110110)
	:3 dta b(%00110101)
	dta b(%11010101)
	dta b(%11011010)
	dta b(%00111111)
	dta b(%00000011)
	dta b(0)
	
	dta b(0,0)
	dta b(%11000000)
	dta b(%11000000)
	dta b(%01110000)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%01010101)
	dta b(%01011010)
	dta b(%01011100)
	dta b(%01010111)
	dta b(%01100111)
	dta b(%01001011)
	dta b(%01110000)
	dta b(%10110000)
	dta b(%11000000)		
			
enemy5kszt	equ *
;faza0
			dta b(0)
			:2 dta b(%00000011)
			:2 dta b(%00001111)
			dta b(%00101101)
			dta b(%00111101)
			dta b(%00101111)
			dta b(%00111111)
			dta b(%00101011)
			dta b(%00100010)
			:4 dta b(%00100000)
			dta b(0)
			
			dta b(%10000000)
			:2 dta b(%11110000)
			:2 dta b(%11111100)
			dta b(%11011110)
			dta b(%11011111)
			dta b(%11111110)
			dta b(%11111111)
			dta b(%11111010)
			dta b(%11100010)
			:4 dta b(%10000010)
			dta b(%10000000)
			
;faza1
			dta b(0,0)
			dta b(%00000011)
			dta b(%00001111)
			dta b(%00001101)
			dta b(%00101101)
			dta b(%00111111)
			dta b(%00111011)
			dta b(%00100010)
			dta b(%11100011)
			dta b(%10000010)
			dta b(%10000010)
			dta b(%00001110)
			:2 dta b(%00001000)
			dta b(0)
			
			dta b(%00100000)
			dta b(%11110000)
			:3 dta b(%11111100)
			:2 dta b(%11011100)
			dta b(%11111100)
			dta b(%11111000)
			dta b(%10111100)
			:2 dta b(%00111000)
			:3 dta b(%00100000)
			dta b(%10000000)
			
;faza2
			dta b(0,0,0)
			dta b(%00001011)
			dta b(%00101111)
			dta b(%00101011)
			dta b(%10100011)
			dta b(%10000010)
			dta b(%00000011)
			dta b(%00000010)
			dta b(%00001010)
			dta b(%00001000)
			dta b(%00101000)
			dta b(%00100000)
			dta b(0,0)
			
			dta b(0,0)
			dta b(%11111110)
			dta b(%11111111)
			:2 dta b(%01111111)
			:2 dta b(%11110111)
			:2 dta b(%11111111)
			dta b(%10111000)
			dta b(%00111100)
			dta b(%00101000)
			dta b(%00100000)
			dta b(%10100000)
			dta b(%10000000)
			
;faza3
			dta b(0,0)
			dta b(%00000010)
			dta b(%00101011)
			dta b(%10101111)
			:2 dta b(%00000011)
			dta b(%00001011)
			dta b(%00001110)
			dta b(%00101011)
			dta b(%10100010)
			dta b(0,0)
			:2 dta b(%00000010)
			dta b(%00001000)
			
			dta b(0,0)
			dta b(%11000000)
			dta b(%11110000)
			dta b(%11111110)
			:2 dta b(%01111111)
			dta b(%11111111)
			dta b(%11011111)
			dta b(%11011100)
			dta b(%11111100)
			dta b(%10110000)
			dta b(%11110000)
			dta b(%10000000)
			dta b(0,0)
			
;faza4
			dta b(0)
			dta b(%10101000)
			dta b(%00001010)
			dta b(%00001110)
			dta b(%00000011)
			dta b(%00001111)
			dta b(%00001011)
			:2 dta b(%10101011)
			dta b(%00001011)
			dta b(%00001111)
			dta b(%00000011)
			dta b(%00001110)
			dta b(%00001010)
			dta b(%10101000)
			dta b(0)
			
			dta b(0,0,0)
			:2 dta b(%11110000)
			dta b(%01111100)
			dta b(%01111111)
			:2 dta b(%11111110)
			dta b(%01111111)
			dta b(%01111100)
			:2 dta b(%11110000)
			dta b(0,0,0)
			
;faza5
			dta b(%00001000)
			:2 dta b(%00000010)
			dta b(0,0)
			dta b(%10100010)
			dta b(%00101011)
			dta b(%00001110)
			dta b(%00001011)
			dta b(%00000011)
			dta b(%00001011)
			dta b(%10101111)
			dta b(%00101011)
			dta b(%00000010)
			dta b(0,0)
			
			dta b(0,0)
			dta b(%10000000)
			dta b(%11110000)
			dta b(%10110000)
			dta b(%11111100)
			dta b(%11011100)
			dta b(%11011111)
			dta b(%11111111)
			dta b(%01111111)
			dta b(%01111110)
			dta b(%11111100)
			dta b(%11110000)
			dta b(%11000000)
			dta b(0,0)
			
;faza6
			dta b(0,0)
			dta b(%00100000)
			dta b(%00101000)
			dta b(%00001000)
			dta b(%00001010)
			dta b(%00000010)
			dta b(%00000011)
			dta b(%10000010)
			dta b(%10100011)
			dta b(%00101011)
			dta b(%00101111)
			dta b(%00001011)
			dta b(0,0,0)
			
			dta b(%10000000)
			dta b(%10100000)
			dta b(%00100000)
			dta b(%00101000)
			dta b(%00111100)
			dta b(%10111000)
			:2 dta b(%11111111)
			:2 dta b(%11110111)
			:2 dta b(%01111111)
			dta b(%11111111)
			dta b(%11111110)
			dta b(0,0)
			
;faza7
			dta b(0)
			:2 dta b(%00001000)
			dta b(%00001110)
			:2 dta b(%10000010)
			dta b(%11100011)
			dta b(%00100010)
			dta b(%00111011)
			dta b(%00111111)
			dta b(%00101101)
			dta b(%00001101)
			dta b(%00001111)
			dta b(%00000011)
			dta b(0,0)
			
			dta b(%10000000)
			:3 dta b(%00100000)
			:2 dta b(%00111000)
			dta b(%10111100)
			:2 dta b(%11111100)
			:2 dta b(%11011100)
			:3 dta b(%11111100)
			dta b(%11110000)
			dta b(%00100000)
			
			
;faza8
			dta b(%00000010)
			:4 dta b(%10000010)
			dta b(%10001011)
			dta b(%10101111)
			dta b(%11111111)
			dta b(%10111111)
			dta b(%11110111)
			dta b(%10110111)
			:2 dta b(%00111111)
			:2 dta b(%00001111)
			dta b(%00000010)
			
			dta b(0)
			:4 dta b(%00001000)
			dta b(%10001000)
			dta b(%11101000)
			dta b(%11111100)
			dta b(%11111000)
			dta b(%01111100)
			dta b(%01111000)
			:2 dta b(%11110000)
			:2 dta b(%11000000)
			dta b(0)
			
;faza9
			dta b(%00000010)
			:3 dta b(%00001000)
			:2 dta b(%00101100)
			dta b(%00111110)
			:2 dta b(%00111111)
			:2 dta b(%00110111)
			:3 dta b(%00111111)
			dta b(%00001111)
			dta b(%00001000)
			
			dta b(0)
			:2 dta b(%00100000)
			dta b(%10110000)
			:2 dta b(%10000010)
			dta b(%11001011)
			dta b(%10001000)
			dta b(%11101100)
			dta b(%11111100)
			dta b(%01111000)
			dta b(%01110000)
			dta b(%11110000)
			dta b(%11000000)
			dta b(0,0)
			
;faza10
			dta b(%00000010)
			dta b(%00001010)
			dta b(%00001000)
			dta b(%00101000)
			dta b(%00111100)
			dta b(%00101110)
			:2 dta b(%11111111)
			:2 dta b(%11011111)
			:2 dta b(%11111101)
			dta b(%11111111)
			dta b(%10111111)
			dta b(0,0)
			
			dta b(0,0)
			dta b(%001000)
			dta b(%00101000)
			dta b(%00100000)
			dta b(%10100000)
			dta b(%10000000)
			dta b(%11000000)
			dta b(%10000010)
			dta b(%11001010)
			dta b(%11101000)
			dta b(%11111000)
			dta b(%11100000)
			dta b(0,0,0)
			
;faza11
			dta b(0,0)
			dta b(%00000010)
			dta b(%00001111)
			dta b(%00001110)
			dta b(%00111111)
			dta b(%00110111)
			dta b(%11110111)
			dta b(%11111111)
			dta b(%11111101)
			dta b(%10111101)
			dta b(%00111111)
			dta b(%00001111)
			dta b(%00000011)
			dta b(0,0)
			
			dta b(%00100000)
			:2 dta b(%10000000)
			dta b(0,0)
			dta b(%10001010)
			dta b(%11101000)
			dta b(%10110000)
			dta b(%11100000)
			dta b(%11000000)
			dta b(%11100000)
			dta b(%11111010)
			dta b(%11101000)
			dta b(%10000000)
			dta b(0,0)
			
;faza12
			dta b(0,0)
			dta b(%00000011)
			:2 dta b(%00001111)
			dta b(%00111101)
			dta b(%11111101)
			:2 dta b(%10111111)
			dta b(%11111101)
			dta b(%00111101)
			:2 dta b(%00001111)
			dta b(%00000011)
			dta b(0,0)
			
			dta b(0)
			dta b(%00101010)
			dta b(%10100000)
			dta b(%10110000)
			dta b(%11000000)
			dta b(%11110000)
			dta b(%11100000)
			:2 dta b(%11101010)
			dta b(%11100000)
			dta b(%11110000)
			dta b(%11000000)
			dta b(%10110000)
			dta b(%10100000)
			dta b(%00101010)
			dta b(0)
			
;faza13
			dta b(0,0)
			dta b(%00000011)
			dta b(%00001111)
			dta b(%00111111)
			dta b(%10111101)
			dta b(%11111101)
			dta b(%11111111)
			dta b(%11110111)
			dta b(%00110111)
			dta b(%00111111)
			dta b(%00001110)
			dta b(%00001111)
			dta b(%00000010)
			dta b(0,0)
			
			dta b(0,0)
			dta b(%10000000)
			dta b(%11101000)
			dta b(%11111010)
			dta b(%11100000)
			dta b(%11000000)
			dta b(%11100000)
			dta b(%10110000)
			dta b(%11101000)
			dta b(%10001010)
			dta b(0,0)
			:2 dta b(%10000000)
			dta b(%00100000)
			
;faza14
			dta b(0,0)
			dta b(%10111111)
			dta b(%11111111)
			:2 dta b(%11111101)
			:2 dta b(%11011111)
			:2 dta b(%11111111)
			dta b(%00101110)
			dta b(%00111100)
			dta b(%00101000)
			dta b(%00001000)
			dta b(%00001010)
			dta b(%00000010)
			
			dta b(0,0,0)
			dta b(%11100000)
			dta b(%11111000)
			dta b(%11101000)
			dta b(%11001010)
			dta b(%10000010)
			dta b(%11000000)
			dta b(%10000000)
			dta b(%10100000)
			dta b(%00100000)
			dta b(%00101000)
			dta b(%00001000)
			dta b(0,0)
			
;faza15
			dta b(%00001000)
			dta b(%00001111)
			:3 dta b(%00111111)
			:2 dta b(%00110111)
			:2 dta b(%00111111)
			dta b(%00111110)
			:2 dta b(%00101100)
			:3 dta b(%00001000)
			dta b(%00000010)
			
			dta b(0,0)
			dta b(%11000000)
			dta b(%11110000)
			dta b(%01110000)
			dta b(%01111000)
			dta b(%11111100)
			dta b(%11101100)
			dta b(%10001000)
			dta b(%11001011)
			:2 dta b(%10000010)
			dta b(%10110000)
			:2 dta b(%00100000)
			dta b(0)
			
;wybuch
explo_kszt	equ *

	dta b(%10000000)		;3faza
	dta b(%00101100)
	dta b(%00101110)		
	dta b(%00001011)
	dta b(%00110100)		
	dta b(%00100101)
	dta b(%00101100)		
	dta b(%00110111)
	
	dta b(%10100100)		
	dta b(%00010101)
	dta b(%00000100)		
	dta b(%00001000)
	dta b(%00101101)		
	dta b(%00101111)
	dta b(%10000000)		
	dta b(%10000000)
	
	dta b(%10000010)		
	dta b(%10001011)
	dta b(%11001000)		
	dta b(%00101100)
	dta b(%01111100)		
	dta b(%00010100)
	dta b(%11001011)		
	dta b(%01011010)
	
	dta b(%00010000)		
	dta b(%00010100)
	dta b(%00110101)		
	dta b(%01101010)
	dta b(%10111000)		
	dta b(%10001000)
	dta b(%10001110)		
	dta b(%10000010)
	
	dta b(%00000000)		;2faza
	dta b(%11000000)
	dta b(%01110000)
	dta b(%00011111)
	dta b(%00010100)
	dta b(%00000110)
	dta b(%00001010)
	dta b(%01011000)
	
	dta b(%00001000)
	dta b(%00000001)
	dta b(%00001110)
	dta b(%00001001)
	dta b(%00010110)
	dta b(%00010000)
	dta b(%01110000)
	dta b(%00000000)
	
	dta b(%00000000)
	dta b(%00000000)
	dta b(%01110001)
	dta b(%01110101)
	dta b(%10010100)
	dta b(%10100100)
	dta b(%00101011)
	dta b(%00011000)
	
	dta b(%10100000)
	dta b(%00101000)
	dta b(%10011100)
	dta b(%11011100)
	dta b(%00110100)
	dta b(%00110100)
	dta b(%01110001)
	dta b(%00000000)

	dta b(%00000000)		;1faza
	dta b(%00110000)
	dta b(%00011100)
	dta b(%00110111)
	dta b(%00000100)
	dta b(%00001101)
	dta b(%00000110)
	dta b(%00000110)
	
	dta b(%00111100)
	dta b(%00000010)
	dta b(%00000011)
	dta b(%00000111)
	dta b(%00110100)
	dta b(%00011100)
	dta b(%00000000)
	dta b(%00000000)
	
	dta b(%00000000)
	dta b(%00001100)
	dta b(%00110000)
	dta b(%01110000)
	dta b(%01010000)
	dta b(%11010000)
	dta b(%00101100)
	dta b(%00110000)
	
	dta b(%00100000)
	dta b(%10000000)
	dta b(%01110000)
	dta b(%01111100)
	dta b(%01000100)
	dta b(%11000011)
	dta b(%00000000)
	dta b(%00000000)

;migajaca bomba i rakieta	
bomba1	equ *
	dta b(%00000000)		;bomba
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00100000)
	dta b(%00001000)
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00100011)
	
	dta b(%00000011)
	dta b(%00000011)
	dta b(%00001000)
	dta b(%00100000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	dta b(%00000000)
	
	dta b(%10000000)
	dta b(%10000000)
	dta b(%00000000)
	dta b(%00000010)
	dta b(%11001000)
	dta b(%11110000)
	dta b(%11110000)
	dta b(%11110010)
	
	dta b(%11000000)
	dta b(%00110000)
	dta b(%11001000)
	dta b(%00000010)
	dta b(%00000000)
	dta b(%10000000)
	dta b(%10000000)
	dta b(%00000000)
	
rakieta1	equ *
	dta b(%00100000)
	dta b(%00100000)		;w gore
	dta b(%11111100)
	dta b(%11110100)
	dta b(%11111100)
	dta b(%00100000)
	dta b(%10101000)
	dta b(%11111100)
	
	dta b(%11111100)		;w dol
	dta b(%10101000)
	dta b(%00100000)
	dta b(%11111100)
	dta b(%11110100)
	dta b(%11111100)
	dta b(%00100000)
	dta b(%00100000)
;pozioma rakieta
	dta b(%00001100)		;w lewo
	dta b(%00111100)
	dta b(%10111110)
	dta b(%10111110)
	dta b(%00110100)
	dta b(%00001100)
	dta b(0,0)
			
	dta b(%00110000)		;w prawo
	dta b(%00111100)
	dta b(%10111110)
	dta b(%10111110)
	dta b(%00011100)
	dta b(%00110000)
	dta b(0,0)
	
ksztaltJadro	dta b(%00000000)
				dta b(%00000000)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%01111101)
				dta b(%00000000)
				dta b(%00000000)
		
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00001101)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)

				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000001)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)		
				dta b(%00110000)
				dta b(%00110000)
				dta b(%00111100)
				dta b(%00111100)
				dta b(%11111111)
				dta b(%11111011)
				dta b(%11101011)
	
				dta b(%11101011)		
				dta b(%11101111)
				dta b(%11111111)
				dta b(%00111100)
				dta b(%00111100)
				dta b(%00001100)
				dta b(%00001100)
				dta b(%00000000)	

				dta b(%00000000)
				dta b(%00000000)
				dta b(%00101101)
				dta b(%00101101)
				dta b(%00101101)
				dta b(%10101101)
				dta b(%10101101)
				dta b(%10101101)
				
				dta b(%10101101)
				dta b(%10101101)
				dta b(%10101101)
				dta b(%00101101)
				dta b(%00101101)
				dta b(%00101101)
				dta b(%00000000)
				dta b(%00000000)

				dta b(%00000000)
				dta b(%00000000)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%10111101)
				dta b(%10111101)
				dta b(%10111101)
				
				dta b(%10111101)
				dta b(%10111101)
				dta b(%10111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00111101)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%00000000)
			
				dta b(%00000000)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%00111111)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%11011100)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				dta b(%00000000)
				
				dta b(%00000000)		
				dta b(%00000011)
				dta b(%00001111)
				dta b(%11111010)
				dta b(%00111110)
				dta b(%00001111)
				dta b(%00000011)
				dta b(%00000000)
	
				dta b(%00000000)			
				dta b(%11000000)
				dta b(%11110000)
				dta b(%10111100)
				dta b(%10101111)
				dta b(%11110000)
				dta b(%11000000)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00001010)
				dta b(%00001010)
				dta b(%00000010)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%10100000)
				dta b(%10100000)
				dta b(%10000000)
				dta b(%00000000)

				dta b(%00000000)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00111111)
				dta b(%00001010)
				dta b(%00001010)
				dta b(%00000000)
				
				dta b(%00000000)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%11011100)
				dta b(%10100000)
				dta b(%10100000)
				dta b(%00000000)	
				
statek_ksztalt	equ	*			;gora
SPR_1_FRM_0
  .he 10 10 10 10 38 28 28 aa a8 fa 7c d2 90 28 28 00
SPR_0_FRM_0
  .he 10 00 10 00 10 38 30 30 b2 a4 d2 e4 12 30 10 00

SPR_1_FRM_4
  .he 00 28 28 90 d2 7c fa a8 aa 28 28 38 10 10 10 10 			
SPR_0_FRM_4
  .he 00 10 30 12 e4 d2 a4 ba 30 30 38 10 00 10 00 00
 
SPR_1_FRM_6
  .he 00 0a 0e 04 0c 39 3d ee ce 3d 19 04 04 0a 04 00
SPR_0_FRM_6
  .he 00 0e 04 04 04 1d 3d 5f 3b 15 24 08 00 04 0a 00

SPR_1_FRM_2
  .he 00 50 70 20 30 9c bc 77 73 bc 98 20 20 50 20 00 
SPR_0_FRM_2
  .he 00 70 20 20 20 b8 bc fa dc a8 24 10 00 20 50 00

SPR_1_FRM_7
  .he 00 00 80 44 64 52 5e 2c 28 18 28 3c 16 46 24 00
SPR_0_FRM_7
  .he 00 80 00 40 66 26 3e 5c 3c 28 14 0e 3a 22 46 24

SPR_1_FRM_1
  .he 00 00 02 44 4c 94 f4 68 28 30 28 78 d0 c4 48 00
SPR_0_FRM_1
  .he 00 02 00 04 cc c8 f8 74 78 28 50 e0 b8 88 c4 48

SPR_1_FRM_3
  .he 00 00 48 c4 d0 78 28 30 28 68 f4 94 4c 44 02 00
SPR_0_FRM_3
  .he 00 48 c4 88 b8 e0 50 28 78 74 f8 c8 cc 04 00 02

SPR_1_FRM_5
  .he 00 00 24 46 16 3c 28 18 28 2c 5e 52 64 44 80 00
SPR_0_FRM_5
  .he 00 24 46 22 3a 0e 14 28 3c 5c 3e 26 66 40 00 80

  
/*			dta b(%00000000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00111000)
			dta b(%00101000)
			dta b(%00101000)
			dta b(%10101010)
			dta b(%10101010)
			dta b(%11111110)
			dta b(%11111110)
			dta b(%11010110)
			dta b(%10010010)
			dta b(%00101000)
			dta b(%00101000)
			
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00101000)
			dta b(%00000000)
			dta b(%10010010)
			dta b(%10010010)
			
			dta b(%00101000)		;dol
			dta b(%00101000)
			dta b(%10010010)
			dta b(%11010110)
			dta b(%11111110)
			dta b(%11111110)
			dta b(%10101010)
			dta b(%10101010)
			dta b(%00101000)
			dta b(%00101000)
			dta b(%00111000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00000000)
			
			dta b(%10010010)
			dta b(%10010010)
			dta b(%00000000)
			dta b(%00101000)
			dta b(%00000000)
			dta b(%01000100)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00101000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00010000)
			dta b(%00000000)
			
			dta b(%00000000)		;lewo
			dta b(%00011100)
			dta b(%00011100)
			dta b(%00001000)
			dta b(%00001000)
			dta b(%00111001)
			dta b(%00111101)
			dta b(%11001110)
			dta b(%11001110)
			dta b(%00111101)
			dta b(%00111001)
			dta b(%00001000)
			dta b(%00001000)
			dta b(%00011100)
			dta b(%00011100)
			dta b(%00000000)
			
			dta b(%00000000)
			dta b(%00000010)
			dta b(%00000010)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000100)
			dta b(%00000000)
			dta b(%00110001)
			dta b(%00110001)
			dta b(%00000000)
			dta b(%00000100)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000010)
			dta b(%00000010)
			dta b(%00000000)
			
			dta b(%00000000)	;prawo
			dta b(%00111000)
			dta b(%00111000)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%10011100)
			dta b(%10111100)
			dta b(%01110011)
			dta b(%01110011)
			dta b(%10111100)
			dta b(%10011100)
			dta b(%00010000)
			dta b(%00010000)
			dta b(%00111000)
			dta b(%00111000)
			dta b(%00000000)
			
			 dta b(%00000000)	
			dta b(%01000000)
			dta b(%01000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00100000)
			dta b(%00000000)
			dta b(%10001100)
			dta b(%10001100)
			dta b(%00000000)
			dta b(%00100000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%01000000)
			dta b(%01000000)
			dta b(%00000000)
			
			dta b(%10000100)		;lewo-gora
			dta b(%10000100)
			dta b(%01100010)
			dta b(%01100010)
			dta b(%01010111)
			dta b(%01011100)
			dta b(%00101100)
			dta b(%00101000)
			dta b(%00111000)
			dta b(%10111100)
			dta b(%11101100)
			dta b(%01101000)
			dta b(%01001000)
			dta b(%01000000)
			dta b(%01000000)
			dta b(%00000000)
			
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00100000)
			dta b(%00100001)
			dta b(%00010001)
			dta b(%00010100)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00010000)
			dta b(%00000100)
			dta b(%00000100)
			dta b(%00000000)
			dta b(%00100000)
			dta b(%00100000)
			
			dta b(%00100001)		;prawo-gora
			dta b(%00100001)
			dta b(%01000110)
			dta b(%01000110)
			dta b(%11101010)
			dta b(%00111010)
			dta b(%00110100)
			dta b(%00010100)
			dta b(%00011100)
			dta b(%00111101)
			dta b(%00110111)
			dta b(%00010110)
			dta b(%00010010)
			dta b(%00000010)
			dta b(%00000010)
			dta b(%00000000)
			
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000100)
			dta b(%10000100)
			dta b(%10001000)
			dta b(%00101000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00001000)
			dta b(%00100000)
			dta b(%00100000)
			dta b(%00000000)
			dta b(%00000100)
			dta b(%00000100)
			
			dta b(%00000000)		
			dta b(%00000010)		;prawo-dol
			dta b(%00000010)
			dta b(%00010010)
			dta b(%00010110)
			dta b(%00110111)
			dta b(%00111101)
			dta b(%00011100)
			dta b(%00010100)
			dta b(%00110100)
			dta b(%00111010)
			dta b(%11101010)
			dta b(%01000110)
			dta b(%01000110)
			dta b(%00100001)
			dta b(%00100001)
			
			
			dta b(%00000100)
			dta b(%00000100)
			dta b(%00000000)
			dta b(%00100000)
			dta b(%00100000)
			dta b(%00001000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00101000)
			dta b(%10001000)
			dta b(%10000100)
			dta b(%00000100)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			
			dta b(%00000000)		;lewo-dol
			dta b(%01000000)
			dta b(%01000000)
			dta b(%01001000)
			dta b(%11101000)
			dta b(%10101100)
			dta b(%00111100)
			dta b(%00111000)
			dta b(%00101000)
			dta b(%00101100)
			dta b(%01011100)
			dta b(%01010111)
			dta b(%01100010)
			dta b(%01100010)
			dta b(%10000100)
			dta b(%10000100)
			
			dta b(%00100000)
			dta b(%00100000)
			dta b(%00000000)
			dta b(%00000100)
			dta b(%00000100)
			dta b(%00010000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00010100)
			dta b(%00010001)
			dta b(%00100001)
			dta b(%00100000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)
			dta b(%00000000)  */


			
			
			
znakiBosc1	equ *
		:8 dta b(0)

	
		dta b(0)
		dta b(%00111000)
		dta b(%01101100)		;a
		dta b(%11000110)
		dta b(%11000110)
		dta b(%11111110)
		dta b(%11000110)
		dta b(%11000110)
		
		dta b(0)
		dta b(%11111100)		;b
		:2 dta b(%11000110)
		dta b(%11111100)
		:2 dta b(%11000110)
		dta b(%11111110)
		
		dta b(0)
		dta b(%00111100)		;c
		dta b(%01100110)
		:3 dta b(%11000000)
		dta b(%01100110)
		dta b(%00111100)
		
		dta b(0)
		dta b(%11111000)
		dta b(%11001100)
		dta b(%11000110)		;d
		dta b(%11000110)
		dta b(%11000110)
		dta b(%11001100)
		dta b(%11111000)
		
		dta b(0)
		dta b(%01111110)
		dta b(%01100000)		;e
		dta b(%01100000)
		dta b(%01111100)
		dta b(%01100000)
		dta b(%01100000)
		dta b(%01111110)
		
		dta b(0)
		dta b(%11111110)		;f
		:2 dta b(%11000000)
		dta b(%11111100)
		:3 dta b(%11000000)
		dta b(0)
		
		dta b(%00111110)		;g
		dta b(%01100000)
		dta b(%11000000)
		dta b(%11001110)
		dta b(%11000110)
		dta b(%01100110)
		dta b(%00111110)
		
		dta b(0)
		:3 dta b(%11000110)	;h
		dta b(%11111110)
		:3 dta b(%11000110)
		
		dta b(0)
		dta b(%01111110)		;i
		:5 dta b(%00011000)
		dta b(%01111110)
		dta b(0)
		
		:5 dta b(%00000110)	;j
		dta b(%11000110)
		dta b(%01111100)
		
		dta b(0)
		dta b(%11000110)		;k
		dta b(%11001100)
		dta b(%11011000)
		dta b(%11110000)
		dta b(%11111000)
		dta b(%11011100)
		dta b(%11001110)
		
		dta b(0)
		:6 dta b(%11000000)	;l
		dta b(%11111100)
		
		dta b(0)
		dta b(%11000110)		;m
		dta b(%11101110)
		:2 dta b(%11111110)
		dta b(%11010110)
		:2 dta b(%11000110)
		
		dta b(0)
		dta b(%11000110)
		dta b(%11100110)		;n
		dta b(%11110110)
		dta b(%11111110)
		dta b(%11011110)
		dta b(%11001110)
		dta b(%11000110)
		
		dta b(0)	
		dta b(%01111100)
		:5 dta b(%11000110)		;o
		dta b(%01111100)
		
		dta b(0)
		dta b(%11111100)		;p
		:3 dta b(%11000110)
		dta b(%11111100)
		:2 dta b(%11000000)
		
		dta b(0)
		dta b(%01111100)		;q
		:3 dta b(%11000110)
		dta b(%11011110)
		dta b(%11001100)
		dta b(%01111010)
		
		dta b(0)
		dta b(%11111100)
		dta b(%11000110)
		dta b(%11000110)		;r
		dta b(%11001110)
		dta b(%11111000)
		dta b(%11001100)
		dta b(%11000110)
		
		dta b(0)
		dta b(%01111000)
		dta b(%11001100)
		dta b(%11000000)		;s
		dta b(%01111100)
		dta b(%00000110)
		dta b(%11000110)
		dta b(%01111100)
		
		dta b(0)
		dta b(%01111110)
		:6 dta b(%00011000)	;t
		
		dta b(0)
		:6 dta b(%11000110)	;u
		dta b(%01111100)
		
		dta b(0)
		dta b(%11000110)
		dta b(%11000110)		;v
		dta b(%11000110)
		dta b(%11101110)
		dta b(%01111100)
		dta b(%00111000)
		dta b(%00010000)
		
		dta b(0)
		:2 dta b(%11000110)		;w
		dta b(%11010110)
		:2 dta b(%11111110)
		dta b(%11101110)
		dta b(%11000110)
		
		dta b(0)
		dta b(%11000110)		;x
		dta b(%11101110)
		dta b(%01111100)
		dta b(%00111000)
		dta b(%01111100)
		dta b(%11101110)
		dta b(%11000110)
		
		dta b(0)
		dta b(%01100110)			;y
		dta b(%01100110)
		dta b(%01100110)
		dta b(%00111100)
		dta b(%00011000)
		dta b(%00011000)
		dta b(%00011000)
		
		dta b(0)
		dta b(%11111110)		;z
		dta b(%00001110)
		dta b(%00011100)
		dta b(%00111000)
		dta b(%01110000)
		dta b(%11100000)
		dta b(%11111110)
		
		dta b(0)
		:5 dta b(0)			;.65+26=91
		:2 dta b(%00110000)
		
		dta b(0)
		dta b(%00001000)		;!	92
		:2 dta b(%00111000)
		dta b(%00110000)
		dta b(0)
		:2 dta b(%00110000)

cyfryBosc1	equ *		
		dta b(0)
		dta b(%00111000)		;0	93
		dta b(%01001100)
		:3 dta b(%11000110)
		dta b(%01100100)
		dta b(%00111000)
		
		dta b(0)
		dta b(%00011000)		;1
		dta b(%00111000)
		:4 dta b(%00011000)
		dta b(%01111110)
		
		dta b(0)
		dta b(%01111100)		;2
		dta b(%11000110)
		dta b(%00001110)
		dta b(%00111100)
		dta b(%01111000)
		dta b(%11100000)
		dta b(%11111110)
		
		dta b(0)
		dta b(%01111110)		;3
		dta b(%00001100)
		dta b(%00011000)
		dta b(%00111100)
		dta b(%00000110)
		dta b(%11000110)
		dta b(%01111100)
		
		dta b(0)
		dta b(%00011100)		;4
		dta b(%00111100)
		dta b(%01101100)
		dta b(%11001100)
		dta b(%11111110)
		:2 dta b(%00001100)
		
		dta b(0)
		dta b(%11111100)		;5
		dta b(%11000000)
		dta b(%11111100)
		:2 dta b(%00000110)
		dta b(%11000110)
		dta b(%01111100)
		
		dta b(0)
		dta b(%00111100)		;6
		dta b(%01100000)
		dta b(%11000000)
		dta b(%11111100)
		:2 dta b(%11000110)
		dta b(%01111100)
		
		dta b(0)
		dta b(%11111110)		;7
		dta b(%11000110)
		dta b(%00001100)
		dta b(%00011000)
		:3 dta b(%00110000)
		
		dta b(0)
		dta b(%01111000)		;8
		dta b(%11000100)
		dta b(%11100100)
		dta b(%01111000)
		dta b(%10011110)
		dta b(%10000110)
		dta b(%01111100)
		
		dta b(0)
		dta b(%01111100)		;9		;102
		:2 dta b(%11000110)
		dta b(%01111110)
		dta b(%00000110)
		dta b(%00001100)
		dta b(%01111000)			
			
.macro	@shif
		:+256 dta :1([#<<8]>>:2)
.endm

_Shif			@shif h 2
				@shif l 2

				@shif h 4
				@shif l 4
	
				@shif h 6
				@shif l 6			
			
			
tLShif1		dta h(ShifRight2L, ShifRight2L, ShifRight4L, ShifRight6L)
				dta h(ShifRight2H, ShifRight2H, ShifRight4H, ShifRight6H)			


;1 paczka 			124b
enemyTab1_	dta b(-2,4,27,33,33,27,4,-2)		;48b
			dta b(13,18,33,33,18,13,-2,-2)
			
			dta b(4,-2,-2,4,24,30,30,24)
			dta b(-2,-2,12,17,30,30,12,17)
			
			dta b(5,7,9,11,13,14,2,1)
			dta b(8,8,12,12,0,0,4,4)	
				
fazaTab1_	dta b(14,2,10,6)				;4b
tab5_		dta b(10,5,0)					;3b
tablives_	dta b(179,189,199)				;6b
			dta b(170,191,201)
			
spyScoreTab_ dta b($20,$30,$40)				;4b
conditionC_	equ *
			dta b(kolorGreen,kolorYellow,kolorRed)	;3b
fazaTab_	dta b(6,8,8,8,8,8,8,8)			;56b
			dta b(4,6,7,7,7,7,8,7)
			dta b(4,6,6,7,7,7,8,7)
			dta b(4,6,6,6,7,7,8,7)
			dta b(4,5,5,6,6,7,7,7)
			dta b(4,5,5,5,5,5,6,7)
			dta b(4,6,5,5,5,5,5,6)

pos_gwiazd	equ *			
			dta b(31),b(20),b(18),b(1),b(12),b(10),b(7),b(21),b(23),b(3),b(14),b(25),b(15,0,13,28,4,27)
			dta b(10),b(20),b(5),b(25),b(27),b(12),b(7),b(14),b(24),b(19),b(22),b(2),b(10,13,17,18,3,7)
			
			.align
scolorTab		dta b(%00,%01,%11,%00)	;scolor0
				dta b(%00,%10,%11,%00)	;scolor1
				dta b(%00,%01,%10,%11)	;scolor2
				dta b(%00,%01,%11,%00)	;scolor3


_enemyTabX
.local speed0
d0=126
d1=132
d2=140
d3=148
d4=154
d5=160
d6=166
d7=178

?w2=d0*382/1000
?w1=d0*707/1000
?w3=d0*923/1000
			dta a(0,?w2,?w1,?w3,d0,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d0,-?w3,-?w1,-?w2)
?w2=d1*382/1000
?w1=d1*707/1000
?w3=d1*923/1000
			dta a(0,?w2,?w1,?w3,d1,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d1,-?w3,-?w1,-?w2)			
?w2=d2*382/1000
?w1=d2*707/1000
?w3=d2*923/1000
			dta a(0,?w2,?w1,?w3,d2,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d2,-?w3,-?w1,-?w2)
?w2=d3*382/1000
?w1=d3*707/1000
?w3=d3*923/1000
			dta a(0,?w2,?w1,?w3,d3,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d3,-?w3,-?w1,-?w2)
?w2=d4*382/1000
?w1=d4*707/1000
?w3=d4*923/1000
			dta a(0,?w2,?w1,?w3,d4,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d4,-?w3,-?w1,-?w2)			
?w2=d5*382/1000
?w1=d5*707/1000
?w3=d5*923/1000
			dta a(0,?w2,?w1,?w3,d5,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d5,-?w3,-?w1,-?w2)		
?w2=d6*382/1000
?w1=d6*707/1000
?w3=d6*923/1000
			dta a(0,?w2,?w1,?w3,d6,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d6,-?w3,-?w1,-?w2)	
?w2=d7*382/1000
?w1=d7*707/1000
?w3=d7*923/1000
			dta a(0,?w2,?w1,?w3,d7,?w3,?w1,?w2,0,-?w2,-?w1,-?w3,-d7,-?w3,-?w1,-?w2)	
			
?w2=d0*382/1000
?w1=d0*707/1000
?w3=d0*923/1000
			dta a(-d0,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d0,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)
?w2=d1*382/1000
?w1=d1*707/1000
?w3=d1*923/1000
			dta a(-d1,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d1,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)
?w2=d2*382/1000
?w1=d2*707/1000
?w3=d2*923/1000
			dta a(-d2,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d2,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)
?w2=d3*382/1000
?w1=d3*707/1000
?w3=d3*923/1000
			dta a(-d3,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d3,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)
?w2=d4*382/1000
?w1=d4*707/1000
?w3=d4*923/1000
			dta a(-d4,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d4,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)
?w2=d5*382/1000
?w1=d5*707/1000
?w3=d5*923/1000
			dta a(-d5,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d5,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)
?w2=d6*382/1000
?w1=d6*707/1000
?w3=d6*923/1000
			dta a(-d6,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d6,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)
?w2=d7*382/1000
?w1=d7*707/1000
?w3=d7*923/1000
			dta a(-d7,-?w3,-?w1,-?w2,0,?w2,?w1,?w3,d7,?w3,?w1,?w2,0,-?w2,-?w1,-?w3)			
.endl


			

			

//tworzy tabele maski 00->11, reszta 00
mmask		equ *	
.local			
			txa
			and #%11
			bne @+
			lda #%11
			bne @+1
@			lda #0
@			sta bom0

			txa
			and #%1100
			bne @+
			lda #%1100
			bne @+1
@			lda #0
@			ora bom0
			sta bom0
			
			txa
			and #%110000
			bne @+
			lda #%110000
			bne @+1
@			lda #0
@			ora bom0
			sta bom0
			
			txa
			and #%11000000
			bne @+
			lda #%11000000
			bne @+1
@			lda #0
@			ora bom0
			
			rts
.endl
	
//tworzy tabelę kolorów, w Y nr tabeli*4	
mcolor	equ *	
.local
			lda #>scolorTab
			sta bom+1
			sty bom
			
			txa
			and #%11
			tay
			lda (bom),y
			sta bom0
			
			txa
.if .def UC
			alr	#%1100
.else			
			and #%1100
			lsr
.endif			
			lsr
			tay
			lda (bom),y
			:2 asl
			ora bom0
			sta bom0
			
			txa
.if .def UC
			alr	#%110000
.else			
			and #%110000
			lsr
.endif			
			:3 lsr
			tay
			lda (bom),y
			:4 asl
			ora bom0
			sta bom0
			
			txa
.if .def UC
			alr	#%11000000
.else			
			and #%11000000
			lsr
.endif			
			:5 lsr
			tay
			lda (bom),y
			:6 asl
			ora bom0
			
			rts
.endl
			
;kopiowanie danych do bankow pamieci
init_banki	equ *
			sei
			mva #0 NMIEN
			mva #BANK0 PORTB
			
;przepisuje ksztalty duszkow pod ROM
			mva #BANK0 PORTB		;wyłączamy ROM
				
			ldy #0						;ksztalt0
@			lda enemy1kszt,y
			sta enemy1adr,y
			lda enemy1kszt+$100,y
			sta enemy1adr+$100,y
			
			lda enemy3kszt,y			;ksztalt2
			sta enemy3adr,y
			lda enemy3kszt+$100,y
			sta enemy3adr+$100,y
			
			lda enemy5kszt,y			;spy
			sta enemy5adr,y
			lda enemy5kszt+$100,y
			sta enemy5adr+$100,y
			
			dey
			bne @-	
			
			ldy #95					;wybuch	(3 fazy 1x2)
@			lda explo_kszt,y
			sta explo_adr,y
			dey
			bpl @-
				
;maski , kolory
			ldx #0
@			equ *
			jsr mmask
			sta mask,x
			
			ldy #0
			jsr mcolor
			sta scolor0,x
			
			ldy #4
			jsr mcolor
			sta scolor1,x
			
			ldy #8
			jsr mcolor
			sta scolor2,x
			
			ldy #12
			jsr mcolor
			sta scolor3,x
			
			dex
			bne @-

//przepisz tabelę przesunięć			
			ldx #7
@			lda tLShif1,x
			sta tLShif,x
			dex
			bpl @-
			
			ldx #0
@			lda _shif,x
			sta ShifRight2H,x
			lda _shif+$100,x
			sta ShifRight2H+$100,x
			lda _shif+$200,x
			sta ShifRight2H+$200,x
			lda _shif+$300,x
			sta ShifRight2H+$300,x
			lda _shif+$400,x
			sta ShifRight2H+$400,x
			lda _shif+$500,x
			sta ShifRight2H+$500,x
			dex
			bne @-
				
;znaki	
			
			ldx #0
@			lda znaki_ad,x
			sta znaki1,x
			sta znaki2,x
			lda znaki_ad+$100,x
			sta znaki1+$100,x
			sta znaki2+$100,x
			lda znaki_ad+$200,x
			dex
			bne @-
			
			ldx #31
@			lda bomba1,x
			sta znaki2+firstBombaChar*8,x
			dex
			bpl @-
		
			ldx #7
@			lda rakieta1,x
			sta znaki2+firstRakietaChar*8,x
			lda rakieta1+8,x
			sta znaki2+(firstRakietaChar+3)*8,x
			lda rakieta1+16,x
			sta znaki2+(firstRakietaChar+4)*8,x
			lda rakieta1+24,x
			sta znaki2+(firstRakietaChar+7)*8,x
			lda mwybuch2,x
			sta znaki2+firstMalyWybuchChar*8,x
			lda mwybuch2+8,x
			sta znaki2+firstMalyWybuchChar*8+8,x
			lda mwybuch2-8,x
			sta znaki1+firstMalyWybuchChar*8+8,x
			dex
			bpl @-


;animacja jadra			
			ldx #14*16
@			lda ksztaltJadro-1,x
			sta ksztaltJadroA0-1,x
			dex
			bne @-
			
			ldx #6
			lda #96
			sec
			
@			sta ad_jadra,x
			sbc #16
			dex
			bpl @-
			
;ksztalt statku
			ldx #0
@			lda statek_ksztalt,x
			sta statek,x
			dex
			bne @-
			
			
;przepisywanie tabel			
			ldx #123
@			lda enemyTab1_,x
			sta sprites1+$700,x
			dex
			bpl @-
			
;adresy linii obraz1LH
			mwa #obraz1 bom
			mwa #obraz2 bom1
			ldy #0
@			lda bom
			sta sprites1+$780,y
			lda bom+1
			sta sprites1+$79d,y
			lda bom1
			sta sprites1+$7ba,y
			lda bom1+1
			sta sprites1+$7d7,y
			clc
			lda bom
			adc #48
			sta bom
			bcc @+
			inc bom+1
@			clc
			lda bom1
			adc #48
			sta bom1
			bcc @+
			inc bom1+1
@			iny
			cpy #29
			bne @-2
		

			
;adresy znaków
			mwa #znaki1	bom
			ldy #0
@			lda bom
			sta adresZnakL,y
			sta adresZnakL+128,y
			lda bom+1
			sta adresZnakH,y
			sta adresZnakH+128,y
			clc
			lda bom
			adc #8
			sta bom
			bcc @+
			inc bom+1
@			iny
			cpy #128
			bne @-1			
			
			ldx #35
@			lda pos_gwiazd,x
			sta znakXa,x
			dex
			bpl @-
		
			
			
			ldx #0
@			lda $3E00,x
			sta $f300,x
			lda $3F00,x
			sta $f400,x
			lda znakiBosc1,x
			sta znakiBosc-8,x
			;lda _enemyTab2,x
			;sta enemyTab2,x
			dex
			bne @-
			
			mwa #enemyTabX pom
			mwa #(enemyTabX+16) pom1
			
			mva #16 pom0
			ldx #0
@			ldy #0
_des0			
@			lda _enemyTabX,x
			sta (pom),y
			inx
_des1			
			lda _enemyTabX,x
			sta (pom1),y
			inx
			bne *+8
			inc _des0+2
			inc _des1+2
			iny
			cpy #16
			bcc @-
			clc
			lda pom
			adc #$20
			sta pom
			bcc *+4
			inc pom+1
			clc
			lda pom1
			adc #$20
			sta pom1
			bcc *+4
			inc pom1+1
			dec pom0
			bne @-1
			
			
			ldx #79
@			lda cyfra1,x
			:4 asl
			sta cyfra2,x
			dex
			bpl @- 
			
			ldx #$37
@			lda znakiBosc1+$100,x
			sta znakiBosc-8+$100,x
			dex
			bpl @-
			
			ldy #25-2
			ldx #0
_ad			
@			lda $4000,x
			sta $b700,x
			dex
			bne @-
			inc _ad+2
			inc _ad+2+3
			dey
			bne @-
			

			
			
			ldx #0
			txa
@			sta sprites1+$400,x
			sta sprites1+$500,x
			inx
			cpx #$fa
			bcc @-
			
;konczymy przygotowania	
			mva #ROM_on PORTB
			mva #%01000000 NMIEN ;wlacz VBLK
			cli
			
			rts
			
			
			org $F300,$3e00	;$8E00
;poczatek strony
cyfra1	dta b(%0010)
		:5 dta b(%0101)
		dta b(%0010)
		dta b(0)
		
		dta b(%0010)
		dta b(%0110)
		:4 dta b(%0010)
		dta b(%0111)
		dta b(0)
		
		dta b(%0010)
		dta b(%0101)
		dta b(%0001)
		dta b(%0010)
		:2 dta b(%0100)
		dta b(%0111)
		dta b(0)
		
		dta b(%0010)
		dta b(%0101)
		dta b(%0001)
		dta b(%0010)
		dta b(%0001)
		dta b(%0101)
		dta b(%0010)
		dta b(0)
		
		dta b(%0100)
		:2 dta b(%0101)
		dta b(%0011)
		:3 dta b(%0001)
		dta b(0)
		
		dta b(%0111)
		dta b(%0100)
		dta b(%0110)
		:2 dta b(%0001)
		dta b(%0101)
		dta b(%0010)
		dta b(0)
		
		dta b(%0010)
		dta b(%0101)
		dta b(%0100)
		dta b(%0110)
		:2 dta b(%0101)
		dta b(%0010)
		dta b(0)
		
		dta b(%0111)
		:2 dta b(%0001)
		:4 dta b(%0010)
		dta b(0)
		
		dta b(%0010)
		:2 dta b(%0101)
		dta b(%0010)
		:2 dta b(%0101)
		dta b(%0010)
		dta b(0)
		
		dta b(%0010)
		:2 dta b(%0101)
		dta b(%0011)
		dta b(%0001)
		dta b(%0101)
		dta b(%0010)
		dta b(0)
		
		dta b(0,0,0,0,0,0,0,0)

;1 duszek
condition1	equ * ;24b
		dta b(%11110010)		;green
		:3 dta b(%11101110)
		:2 dta b(%11101010)
		dta b(%11100010)
		dta b(0)

		   dta b(%10101000)		;yellow
		:2 dta b(%10101011)
		   dta b(%10001001)
		:2 dta b(%11011011)
		   dta b(%11011000)
		dta b(0)
		
		dta b(%11001100)		;red
		:2 dta b(%11010101)
		dta b(%11001100)
		:2 dta b(%11010101)
		dta b(%11010100)
		dta b(0)

;2 duszek
condition2	equ *
		dta b(%01100010)	;green
		:2 dta b(%10101110)
		dta b(%01100110)
		:2 dta b(%10101110)
		dta b(%10100010)
		dta b(0)
		
		:6 dta b(%10111011)	;yellow
		   dta b(%10001000)
		dta b(0)
	
		dta b(%01001111)		;red
		:5 dta b(%11010111)
		dta b(%01001111)
		dta b(0)
		
;3duszek
condition3	equ *
		dta b(%00100111)		;green
		:2 dta b(%11101011)
		dta b(%01101011)
		:2 dta b(%11101011)
		dta b(%00101011)
		dta b(0)
		
		   dta b(%11001010)		;yellow
		:3 dta b(%10101010)
		:2 dta b(%10101000)
		   dta b(%10011010)
		dta b(0)
		
		:3 dta b(%11001100)			;red
		dta b(%11011101)
		dta b(255)
		:2 dta b(%11011101)
		dta b(0)
		
nap_form2	equ *
	:3 dta b(0)		; strzala w gore
	:2 dta b(%00010000)
	:2 dta b(0)
	:2 dta b(%00101000)
	:2 dta b(0)
	:2 dta b(%01000100)
	:3 dta b(0)

	dta b(0)				;linia
	:2 dta b(%00010000)
	dta b(0)
	:2 dta b(%00010000)
	dta b(0)
	:2 dta b(%00010000)
	dta b(0)
	:2 dta b(%00010000)
	dta b(0)
	:2 dta b(%00010000)
	dta b(0)

	:3 dta b(0)
	dta b(%01000100)		;celownik ,kostka 5
	dta b(%01000100)
	:2 dta b(0)
	dta b(%00010000)
	dta b(%00010000)
	:2 dta b(0)
	dta b(%01000100)
	dta b(%01000100)
	:3 dta b(0)
	
	:3 dta b(0)		;krzyzyk
	dta b(%00010000)
	dta b(%00010000)
	:2 dta b(0)
	dta b(%10010010)
	dta b(%10010010)
	:2 dta b(0)
	dta b(%00010000)
	dta b(%00010000)
	:3 dta b(0)
	
statek_zapas	equ *	
	dta b(%00000000)
	dta b(%00010000)
	dta b(%00010000)
	dta b(%00010000)
	dta b(%00010000)
	dta b(%00111000)
	dta b(%00101000)
	dta b(%00101000)
	dta b(%10101010)
	dta b(%10101010)
	dta b(%11111110)
	dta b(%11111110)
	dta b(%11010110)
	dta b(%10010010)
	dta b(%00101000)
	dta b(%00101000)	
	
nap_1up	equ *
	dta b(%00100101)  ;player1
	dta b(%01100101)
	dta b(%00100101)
	dta b(%00100101)
	dta b(%00100101)
	dta b(%00100101)
	dta b(%01110110)
	
	dta b(%01110000)    ;player 2
	dta b(%01010000)
	dta b(%01010000)
	dta b(%01110000)
	dta b(%01000000)
	dta b(%01000000)
	dta b(%01000000)	

	dta b(0,0)		;wyrównanie do strony
;poczatek strony
cyfra2	dta b(%01110000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01110000)
		dta b(0)
		
		dta b(%00100000)
		dta b(%01100000)
		dta b(%00100000)
		dta b(%00100000)
		dta b(%00100000)
		dta b(%00100000)
		dta b(%01110000)
		dta b(0)
		
		dta b(%01110000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%01110000)
		dta b(%01000000)
		dta b(%01000000)
		dta b(%01110000)
		dta b(0)
		
		dta b(%01110000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%00110000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%01110000)
		dta b(0)
		
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01110000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(0)
		
		dta b(%01110000)
		dta b(%01000000)
		dta b(%01000000)
		dta b(%01110000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%01110000)
		dta b(0)
		
		dta b(%01110000)
		dta b(%01000000)
		dta b(%01000000)
		dta b(%01110000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01110000)
		dta b(0)
		
		dta b(%01110000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(0)
		
		dta b(%01110000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01110000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01110000)
		dta b(0)
		
		dta b(%01110000)
		dta b(%01010000)
		dta b(%01010000)
		dta b(%01110000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(%00010000)
		dta b(0)
		
		dta b(0,0,0,0,0,0,0,0)
	
	
	
nap_form1	equ *
	dta b(%00110110)	;pociski
	dta b(%00100101)
	dta b(%00110101)
	:2 dta b(%00100101)
	dta b(0,0)
	:2 dta b(%00000101)
	dta b(%00000110)
	:2 dta b(%00000101)
	
	dta b(%01001100)	;1duszek
	dta b(%10101010)
	dta b(%10101100)
	dta b(%10101010)
	dta b(%01001010)
	dta b(0,0,0,0,0,0,0)
	
	dta b(%10100100)	;2duszek
	dta b(%11101010)
	dta b(%10101110)
	:2 dta b(%10101010)
	dta b(0,0)
	dta b(%01001101)
	dta b(%10100100)
	dta b(%11100100)
	:2 dta b(%10100100)
	
	dta b(%11010010)	;3duszek
	:3 dta b(%01010101)
	dta b(%01010010)
	dta b(0,0)
	dta b(%10010011)
	dta b(%10101010)
	dta b(%10111010)
	dta b(%10101010)
	dta b(%10101011)
		
nap_condition	equ *
	   dta b(%00110110)	;pociski
	:5 dta b(%00100101)
	   dta b(%00110101)
	
	   dta b(%00110110)	;1duszek
	:5 dta b(%01010101)
	   dta b(%01100101)
	
	   dta b(%01100101)	;3duszek
	:5 dta b(%01010100)
	   dta b(%01100100)	
	
	   dta b(%11010011)	;3duszek
	:5 dta b(%10010101)
	   dta b(%10010110)
	   
nap_hiscore	equ *
	dta b(%11100111)    ;pociski
	dta b(%11010100)
	dta b(%11010100)
	dta b(%11100110)
	dta b(%11010100)
	dta b(%11010100)
	dta b(%11010111)
	
	dta b(%01010111)   ;player1
	dta b(%01010010)
	dta b(%01010010)
	dta b(%01110010)
	dta b(%01010010)
	dta b(%01010010)
	dta b(%01010111)
	
	dta b(%00001100)   ;player2
	dta b(%00010001)
	dta b(%00010001)
	dta b(%11011101)
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00011000)
	
	dta b(%11001101)   ;player3
	dta b(%00010101)
	dta b(%00010101)
	dta b(%00010101)
	dta b(%00010101)
	dta b(%00010101)
	dta b(%11011001)


statekm_zapas	equ *
	:4 dta b(%00101010)
	:2 dta b(0)
	dta b(%00111111)
	dta b(0)
	:2 dta b(%00101010)
	
nap_round	equ *
	dta b(%00000110)	;pociski
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000110)	
	
	dta b(%01100011)   ;1 duszek
	dta b(%01010101)
	dta b(%01010101)
	dta b(%01100101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%01010110)
	
	dta b(%01010110)  ;2 duszek
	dta b(%01010101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%01010101)
	dta b(%01100101)
	

nap_0	equ *
	dta b(%00000010)   ;0 w pociskach
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000101)
	dta b(%00000010)	
	
radarBazy1	dta b(128,64,32,16,8,4,2,1,0,0,0,0)   ;pozycja X bazy na radarze sprit3
radarBazy2	dta b(0,0,0,0,0,0,0,0,32,16,8,4)		;pociski 3 i 2		
				
			
			
			org $B700,$4000	;$9000
			icl 'title.asm'
			icl 'hscore.asm'			
					
		
			
			
			ini (init_banki)
			