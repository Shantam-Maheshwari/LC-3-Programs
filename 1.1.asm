	.ORIG x3000

	LEA R0, xFF			;R0 <- x3001 + xFF = x3100
	
;storing 9 at x3100
	AND R3, R3, #0 		;clearing R3
	ADD R3, R3, #9		;
	STR R3, R0, #0		;M[x3000] = 9

;storing -13 at x3101
	AND R3, R3, #0 		;clearing R3
	ADD R3, R3, #-13	;
	STR R3, R0, #1		;M[x3100 + 1] <- -13

	LDR R1, R0, x0 		;R1 <- M[x3100] = X
	LDR R2, R0, x1 		;R2 <- M[x3101] = Y

	ADD R3, R1, R2 		;R3 <- X + Y
	AND R4, R1, R2 		;R4 <- X AND Y
	NOT R5, R1 			;R5 <- NOT(X)
	NOT R6, R2 			;R6 <- NOT(Y)

	AND R7, R5, R6		;R7 <- NOT(X) AND NOT(Y)
	NOT R7, R7			;R7 <- X OR Y (DE MORGAN'S LAW)

	STR R3, R0, x2		;M[x3102] <- R3 = X + Y
	STR R4, R0, x3 		;M[x3103] <- R4 = X AND Y
	STR R7, R0, x4 		;M[x3104] <- R7 = X OR Y
	STR R5, R0, x5 		;M[x3105] <- R5 = NOT(X)
	STR R6, R0, x6 		;M[x3106] <- R6 = NOT(y)

	ADD R3, R1, x3 		;R3 <- X + 3
	ADD R4, R2, x-3 	;R4 <- Y - 3
	AND R5, R1, x1 		;R5 <- X AND 1 (to detect odd or even) = Z

	STR R3, R0, x7 		;M[x3107] <- R3 = X + 3
	STR R4, R0, x8 		;M[x3108] <- R4 = Y - 3
	STR R5, R0, x9 		;M[x3109] <- R5 = Z

	HALT
	
	.END
