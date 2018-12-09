; Main.asm
; Name: Meha Halabe
; UTEid: mbh2622
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer

	AND R6,R6,#0
	LD R6, STACK


; set up the keyboard interrupt vector table entry

	LD R0, GLOVAR
	STI R0, KBSR

; enable keyboard interrupts
	LD R0, KBISR
	STI R0, KBIVE

; start of actual program
	
loop	LDI R0, GLOVAR
	BRZ loop
	TRAP X21
	AND R1,R1,#0
	STI R1, GLOVAR	

;process R0
	;check for start codon
	LD R1, ascA
	ADD R1,R1,R0
	BRz A_STATE
	BRnp loop
A_STATE AND R2,R2,#0
loop1	LDI R0, GLOVAR
	BRZ loop1
	TRAP X21		;print character
	AND R1,R1,#0
	STI R1, GLOVAR
	LD R1,ascU
	ADD R1,R1,R0
	BRZ AU_STATE
	LD R1, ascA
	ADD R1,R1,R0
	BRZ A_STATE
	LD R1,ascG
	ADD R1,R1,R0
	BRZ loop
	LD R1,ascC
	ADD R1,R1,R0
	BRZ loop

AU_STATE AND R2,R2,#0
loop2	LDI R0, GLOVAR
	BRZ loop2
	TRAP X21
	AND R1,R1,#0
	STI R1, GLOVAR
	LD R1,ascG
	ADD R1,R1,R0
	BRZ print
	LD R1, ascA 
	ADD R1,R1,R0
	BRZ A_STATE
	LD R1,ascC
	ADD R1,R1,R0
	BRZ loop
	LD R1,ascU
	ADD R1,R1,R0
	BRZ loop
print	LD R0,bar
	TRAP X21

	
;stop codons
loop3	LDI R0, GLOVAR
	BRZ loop3
	TRAP X21
	AND R1,R1,#0
	STI R1, GLOVAR
	;check for U
	LD R1, ascU
	ADD R1,R1,R0
	BRZ U_STATE
	BRNP loop3
U_STATE AND R2,R2,#0
loop4	LDI R0, GLOVAR
	BRZ loop4
	TRAP X21
	AND R1,R1,#0
	STI R1, GLOVAR
	LD R1, ascA
	ADD R1,R1,R0
	BRZ UA_STATE
	LD R1, ascG
	ADD R1,R1,R0
	BRZ UG_STATE
	LD R1, ascU
	ADD R1,R1,R0
	BRZ U_STATE
	LD R1, ascC
	ADD R1,R1,R0
	BRZ loop3


UA_STATE AND R2,R2,#0
loop5	LDI R0, GLOVAR
	BRZ loop5
	TRAP X21
	AND R1,R1,#0
	STI R1, GLOVAR
	 LD R1,ascU
	ADD R1,R1,R0
	BRZ U_STATE
	LD R1, ascA
	ADD R1,R1,R0
	BRZ end
	LD R1, ascG
	ADD R1,R1,R0
	BRZ end
	LD R1, ascC
	ADD R1,R1,R0
	BRZ loop3

UG_STATE AND R2,R2,#0
loop6	LDI R0, GLOVAR
	BRZ loop6
	TRAP X21
	AND R1,R1,#0
	STI R1, GLOVAR	
	LD R1,ascU
	ADD R1,R1,R0
	BRZ U_STATE
	LD R1,ascA
	ADD R1,R1,R0
	BRZ end
	LD R1,ascG
	ADD R1,R1,R0
	BRZ loop3
	LD R1,ascC
	ADD R1,R1,R0
	BRZ loop3
	
	
end
	TRAP X25
	STACK .FILL X4000
	GLOVAR .FILL X4600
	KBISR .FILL X2600
	ascA .FILL x-41
	ascC .FILL x-43
	ascG .FILL x-47
	ascU .FILL x-55
	bar .FILL X7C
	KBSR .FILL XFE00
	KBIVE .FILL X0180
		.END
