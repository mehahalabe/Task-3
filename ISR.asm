; ISR.asm
; Name: Meha Halabe
; UTEid: mbh2622
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
        .ORIG x2600
	ST R1, REG1
	LDI R0, KBDR
	LD R1, ascA
	ADD R1,R1,R0
	BRz Val
	LD R1, ascC
	ADD R1,R1,R0
	BRz Val
	LD R1, ascG
	ADD R1,R1,R0
	BRz Val
	

Val	STI R0, buffer
	LD R1,REG1
	RTI


	
	RTI

	ascA .FILL x-41
	ascC .FILL x-43
	ascG .FILL x-47
	ascU .FILL x-55
	KBDR .FILL xFE02
	buffer .FILL x4600
	REG1 .BLKW 1	
	
	.END
