;trzecia wersja duszków
firstDuchChar	equ 74

shpBuf			equ explo_adr+$100

;tablice
duszkiZnakiL	equ *
			:6 dta b(<((firstDuchChar+9*#)*8+znaki1))
duszkiZnakiH	equ *
			:6 dta b(>((firstDuchChar+9*#)*8+znaki1))
duszkiChar		equ *
			:6 dta b(firstDuchChar+(#*9))

			
enemy1Shape	equ 0
enemy2Shape	equ 16			
spyShape1		equ 2*16	
exploShape	equ 3*16

duszkiPrint	.proc
	
nchar		equ pom0
duchX		equ pom0a	
DX			equ pom0b
DY2		equ pom0c
_bufor	equ pom0d
			
			sec
			lda enemyX,x
			sbc posX
			tay
			lda tabX,y
			sta enemyX0,x
			clc
			adc #2
			cmp #33+2
			bcc @+
			;lda enemyY,x		;obliczmy też Y0 dla duszka poza ekranem
			;sbc posY
			;sta enemyY0,x
			lda #1
			sta enemyEkran,x
			rts		;poza ekranem
			
@			adc #6
			sta duchX
			
			sec
			lda enemyY,x
			sbc posY
			sta enemyY0,x
			clc
			adc #2
			cmp #29+2
			bcc @+
			lda #1
			sta enemyEkran,x
			rts		;poza ekranem	
			
@			tay
			
			lda ramka
			bne @+					;adres pamieci obrazu pod duszkiem
			;clc
			lda obraz1La+6,y
			adc duchX
			sta pom
			lda obraz1Ha+6,y
			adc #0
			sta pom+1
			jmp @+1		;skok bezwarunkowy
@			;clc
			lda obraz2La+6,y
			adc duchX
			sta pom
			lda obraz2Ha+6,y
			adc #0
			sta pom+1
			
@			equ *
			lda enemyDY,x
			and #%11000000
			asl
			:2 rol
			sta enemyDY0,x
			asl
			sta pom0c	;DY*2

			lda enemyDX,x
			and #%11000000
			asl
			:2  rol
			sta enemyDX0,x		
			sta pom0b			;DX

			stx duchX	;zapamietaj X
			lda enemyOraTab,x
			sta enemyColor
			
//nowe znaki
			lda duszkiZnakiH,x
			ora ramka4
			tay
			lda duszkiZnakiL,x		;wskaznik do adresu pierwszego znaku duszka
			
			sta nznak0+1
			sta nznak0b+1
			sty nznak0+2
			sty nznak0b+2
			;clc
			adc #8
			sta nznak1+1
			sta nznak1b+1
			sty nznak1+2
			sty nznak1b+2
			adc #8
			
			ldx DX
			beq @+
		
			sta nznak2+1
			sta nznak2b+1
			sty nznak2+2
			sty nznak2b+2
			
@			adc #8
			sta nznak3+1
			sty nznak3+2
			adc #8
			bcc *+4
			clc
			iny
			sta nznak4+1
			sty nznak4+2
			adc #8
			
			ldx DX
			beq @+
			
			sta nznak5+1
			sty nznak5+2
			
@			ldx DY2
			beq @+
			
			adc #8
			sta nznak6+1
			sta nznak6b+1
			sty nznak6+2
			sty nznak6b+2
			adc #8
			sta nznak7+1
			sta nznak7b+1
			sty nznak7+2
			sty nznak7b+2
			
			ldx DX
			beq @+
			
			adc #8
			sta nznak8+1
			sta nznak8b+1
			sty nznak8+2
			sty nznak8b+2			
		
@			ldx DuchX

			lda duszkiChar,x			
			ora enemyNegatyw,x	
			sta nchar
			
_jmp		lda enemyFaza,x
			ora enemyShapeH,x
			cmp #51
			bne *+4
			lda #50
			:3 asl
			sta _bufor
			lda #>(enemy1adr/8)
			rol
			asl _bufor
			rol
			asl _bufor
			rol
			;ora #>enemy1adr
			tax
			lda _bufor
			
//procedura testowa kopiuje ksztalt do bufora, na podstawie adresu i DX,DY2
			ldy DX
			bne @+1

//DX=0
			sta adr0+1
			stx adr0+2
			ora #16			;zamiast adc
			sta adr1+1
			stx adr1+2

			;lda #<shpBuf
			;ora DY2
			lda DY2
			sta _shp0+1
			ora #24
			sta _shp1+1
			

			ldy #15
@			equ *
adr0		lda $ffff,y
_shp0		sta shpBuf,y

adr1		lda $ffff,y
_shp1		sta shpBuf+24,y

			dey
			bpl @-
			jmp @+2
//DX>0			
@			equ *
			sta adr0b+1
			stx adr0b+2
			ora #16
			sta adr1b+1
			stx adr1b+2
			
			lda tHShif,y
			sta tShfL0+2
			sta tShfL1+2

			lda tLShif,y
			sta tShfH0+2
			sta tShfH1+2
			
			;lda #<shpBuf
			;ora DY2
			lda DY2
			sta _shp0b+1
			ora #24				;+24
			sta _shp1b+1
			eor #%00101000		;+24
			sta _shp2b+1

			
			ldy #15
@			equ *	
adr1b		ldx $ffff,y

tShfH0		lda $ff00,x
_shp2b		sta shpBuf+48,y

tShfL0		lda $ff00,x

adr0b		ldx $ffff,y

tShfH1		ora $ff00,x
_shp1b		sta shpBuf+24,y

tShfL1		lda $ff00,x
_shp0b		sta shpBuf+0,y

			dey
			bpl @-								
			

_adres		equ *			
@			equ *	//adresy znaków pod duszkami
			ldy #0			;1znak
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif			
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo0+1
			sta tlo0b+1
			lda adresZnakH,x
			ora ramka4
			sta tlo0+2
			sta tlo0b+2
			
			iny
			inc nchar
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo1+1
			sta tlo1b+1
			lda adresZnakH,x
			ora ramka4
			sta tlo1+2
			sta tlo1b+2
			inc nchar
			
			ldx DX	
			beq @+		;pomin 3 rząd
			
			iny
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo2+1
			sta tlo2b+1
			lda adresZnakH,x
			ora ramka4
			sta tlo2+2
			sta tlo2b+2
				
@			equ *			
			ldy #48
			inc nchar
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo3+1
			lda adresZnakH,x
			ora ramka4
			sta tlo3+2
			
			iny
			inc nchar
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo4+1
			lda adresZnakH,x
			ora ramka4
			sta tlo4+2
			inc nchar
			
			ldx DX
			beq @+
			
			iny
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo5+1
			lda adresZnakH,x
			ora ramka4
			sta tlo5+2
						
@			ldx DY2
			beq @+
			
			ldy #96
			inc nchar
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo6+1
			sta tlo6b+1
			lda adresZnakH,x
			ora ramka4
			sta tlo6+2
			sta tlo6b+2
			
			iny
			inc nchar
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo7+1
			sta tlo7b+1
			lda adresZnakH,x
			ora ramka4
			sta tlo7+2
			sta tlo7b+2
			
			ldx DX
			beq @+
			
			iny
			inc nchar
.if .def UC			
			lax (pom),y
.else		
			lda (pom),y
			tax
.endif	
			and #128			
			ora nchar		;nr znaku duszka
			sta (pom),y
			lda adresZnakL,x
			sta tlo8+1
			sta tlo8b+1
			lda adresZnakH,x
			ora ramka4
			sta tlo8+2
			sta tlo8b+2		
		
@			equ *	
			ldx #7
			lda DY2
			bne @+1
			lda DX
			bne @+
			;DY=0 i DX=0
			mva #$ca tlo2-3	;dex
			mva #$10 tlo2-2	;bpl
			mva #256-31 tlo2-1	;dlugosc skoku do skok1
			sta _bpl1
			mva #$60 tlo2		;rts
			;mva #256-31 _bpl1	;zmiana dlugosci skoku do skok2
			;ldx #7
			jsr skok1
			ldx #7
			jmp skok2
			;DY=0,DX>0
@			mva #$bc tlo2-3	;ldy $ffff,x
			mva #<(shpBuf+6*8) tlo2-2
			mva #>(shpBuf+6*8) tlo2-1
			mva #$bd tlo2	;lda $ffff,x
			
			mva #$10 nznak2+4	;bpl
			mva #256-45 nznak2+5	;skok do skok1
			sta _bpl1
			mva #$60 nznak2+6		;rts
			;mva #256-45 _bpl1		;skok na proc3
			
			jsr skok1
			ldx #7
			jmp proc3
			;DY>0
@			sta nznak2+5
			lda DX
			bne @+
			;DY>0,DX=0

			mva #$4c tlo2-3	;jmp
			mwa #nznak2+3 tlo2-2	;skok do dex
			
			mva #$e0 nznak2+4 ;cpx
			mva #$b0 nznak2+6	;bcs
			mva #256-59	nznak2+7	;do tlo7
			
			mva #256-43 _bpl2	;do tlo0b
			mva #256-31 _bpl1	;do skok2
			
			jsr tlo7
			jsr tlo0b
			ldx #7
			jmp skok2
			
			;DY>0,DX>0
@			mva #$bc tlo2-3	;ldy $ffff,x
			mva #<(shpBuf+6*8) tlo2-2
			mva #>(shpBuf+6*8) tlo2-1
			mva #$bd tlo2	;lda $ffff,x
			
			mva #$e0 nznak2+4 ;cpx
			mva #$b0 nznak2+6	;bcs
			mva #256-65 nznak2+7	; petla do proc1
			
			mva #256-63 _bpl2		;petla do proc2
			
			mva #256-45 _bpl1		;petla do proc3
			
			jsr proc1
			jsr proc2
			ldx #7
			
//przepisanie 1 wiersza, zawsze niezależnie od DY			
			
proc3		equ *	
	
			ldy shpBuf+7*8,x
tlo5		lda $ffff,x		;pomin dla DX=0
			and mask,y
			ora (enemyColor-1),y
nznak5		sta $ffff,x
			

skok2		equ *	
			ldy shpBuf+4*8,x
tlo4		lda $ffff,x	
			and mask,y
			ora (enemyColor-1),y
nznak4		sta $ffff,x
			
			ldy shpBuf+1*8,x
tlo3		lda $ffff,x	
			and mask,y
			ora (enemyColor-1),y
nznak3		sta $ffff,x
			
			dex
_bpl1		equ *+1
			bpl proc3				;zmiana adresu dla DX=0, pomijamy 1 kolumne
					
			ldx DuchX
			lda #0
			sta enemyEkran,x
			rts			
			
//procedury przepisująca znaki
			
proc1			equ *
tlo8		lda $ffff,x		;tylko dla szerokosci 3, inaczej pomin
nznak8		sta $ffff,x

tlo7		lda $ffff,x		
nznak7		sta $ffff,x			
tlo6		lda $ffff,x		
nznak6		sta $ffff,x

skok1		equ *
			
			ldy shpBuf,x
tlo0		lda $ffff,x
			and mask,y
			ora (enemyColor-1),y
nznak0		sta $ffff,x

			ldy shpBuf+3*8,x
tlo1		lda $ffff,x
			and mask,y
			ora (enemyColor-1),y
nznak1		sta $ffff,x

			ldy shpBuf+6*8,x
tlo2		lda $ffff,x			;tylko dla szerokosci 3, dla 2 jmp do dex
			and mask,y
			ora (enemyColor-1),y
nznak2		sta $ffff,x
	
			dex
			cpx #$ff	;255,1,3,5
			bcs proc1
			rts
			
//jeśli DY=0 to pomijamy		
proc2		equ *

tlo2b		lda $ffff,x		;tylko dla szerokosci 3
nznak2b		sta $ffff,x	

			ldy shpBuf+8*8,x
tlo8b		lda $ffff,x		;tylko dla szerokosci 3
			and mask,y
			ora (enemyColor-1),y
nznak8b		sta $ffff,x

		
tlo0b		lda $ffff,x		;przepisz fragment tła
nznak0b		sta $ffff,x			
tlo1b		lda $ffff,x		
nznak1b		sta $ffff,x

			ldy shpBuf+2*8,x
tlo6b		lda $ffff,x
			and mask,y
			ora (enemyColor-1),y
nznak6b		sta $ffff,x

			ldy shpBuf+5*8,x
tlo7b		lda $ffff,x
			and mask,y
			ora (enemyColor-1),y
nznak7b		sta $ffff,x
	
			dex
_bpl2		equ *+1
			bpl proc2
			rts							
			
.endp