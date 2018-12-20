	.ORIG x3000
	
	LEA R0, xFF 		;R0 <- x3001 + xFF = x3100
	ADD R0, R0, xF		;R0 <- x3100 + xF = x310f
	ADD R0, R0, xF 		;R0 <- x310f + xF = x311e
	Add R0, R0, x2 		;R0 <- x311e + x2 = x3120

;storing 9 at x3120
	AND R3, R3, #0		;clear R3
	ADD R3, R3, #9		;R3 <- #9
	STI R3, X 			;M[x3120] <- #9

;storing -13 at x3120
	AND R3, R3, #0 		;clear R3
	ADD R3, R3, #-13 	;R3 <- #-13
	STI R3, Y 			;M[x3121] <- #-13

	LDI R1, X 			;R1 <- X 
	LDI R2, Y 			;R2 <- Y

; X - Y
	NOT R3, R2
	ADD R3, R3, #1 		;R3 <- -Y
	ADD R4, R1, R3		;R4 <- X - Y
	STI R4, X_minus_Y	;M[x3120] <- X - Y

; |X|
	ADD R3, R1, #0		;just to set CCs
	BRzp ZP1			;leave as is if zero or positive
	NOT R3, R1			;otherwise, find 2s complement
	ADD R3, R3, #1
ZP1	STI R3, absX

; |Y|
	ADD R3, R2, #0		;just to set CCs
	BRzp ZP2			;leave as is if zero or positive
	NOT R3, R2 			;otherwise, find 2s complement
	ADD R3, R3, #1
ZP2 STI R3, absY

; Z
	LDI R3, absX		;R3 <- |X|
	
	LDI R4, absY 		;R4 <- |Y|
	NOT R4, R4 			;
	ADD R4, R4, #1 		;R4 <- -|Y|

	AND R5, R5, #0
	ADD R6, R3, R4 		;R6 <- |X| - |Y|
	BRz ZER 			;if zero, Z = 0
	BRp POS 			;if positive, Z = 1
	BRn NEG 			;if negative, Z = 2

NEG	ADD R5, R5, #1 		;if negative, add 1 twice
POS ADD R5, R5, #1		;if positive, add 1 once
ZER STI R5, Z			;if zero, add nothing, skip to store

	HALT

X 			.FILL x3120
Y 			.FILL x3121
X_minus_Y 	.FILL x3122
absX 		.FILL x3123
absY 		.FILL x3124
Z			.FILL x3125

	.END