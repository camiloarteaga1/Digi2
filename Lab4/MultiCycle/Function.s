.global _start
_start:
	//3*X-5*Y+2*Z
	SUB	R0, R15, R15 //Inicializar R0 en 0.
	SUB	R10, R15, R15 //Inicializar R10 en 0.
	LDR	R7, [PC, #0]//Cargar direccion inicial = C000_0000.
	B	GetPuls
	.DC.L	0xC0000000
GetPuls:
	LDR	R1, [R7, #8] // R1 leer switches: X, Y, Z.
	STR	R1, [R7, #0] // Mostrar R1 en los displays.
	LDR	R2, [R7, #4] //Leer el botón.
	SUBS R2, R2, #0 // Flags.
	BEQ	GetPuls //En el caso de que el pulsador no sea 1, saltar a linea 6.
release:
	LDR	R2, [R7, #4] //Leer el botón.
	SUBS R2, R2, #0 //Flags.
	BNE	release //En el caso de que el pulsador siga siendo 1, devolverse a la linea 12.
	//En el caso de que el botón haya sido soltado, continuar:
	
	SUBS R10,R10,#0 //Contador para verificar la operación que se está realizando. R10=0 -> X
	BEQ	DoAX //Realizar A*X
	
	SUBS R10,R10,#1 //Contador para verificar la operación que se está realizando. R10=1 -> Y
	BEQ DoBY //Realizar operacion B*Y
	B DoCZ //En caso contrario realizar C*Z
	
DoAX: // Calcular A*X = 3*X
	ADD R0, R0, #3 //A=3
	SUB	R11, R15, R15 //Inicializar R11 en 0 como variable auxiliar para guardar multiplicacion.
mult1:
	ADD R11, R11, R1 // 3*X = X+X+X
	SUB R0, R0, #1 // i=i-1 resta para descontar el ciclo hasta que i=0.
	SUBS R12, R0, #0 //Comparar i con cero
	BNE mult1 //En caso de que i sea diferente de cero, seguir multiplicando.
	
	ADD R10, R10, #1 //R10 será 1, por lo que ahora realizará B*Y
	B GetPuls
	
DoBY:// Calcular B*Y = 5*Y
	SUB	R0, R15, R15 //Inicializar R0 en 0.
	ADD R0, R0, #5
	
	SUB	R9, R15, R15 //Inicializar R9 en 0 como variable auxiliar para guardar multiplicacion.
mult2:
	ADD R9, R9, R1 // 5*Y = Y+Y+Y+Y+Y
	SUB R0, R0, #1 // i=i-1 resta para descontar el ciclo hasta que i=0.
	SUBS R12, R0, #0 //Comparar i con cero
	BNE mult2 //En caso de que i sea diferente de cero, seguir multiplicando.
	
	ADD R10, R10, #2 //R10 será 2, por lo que ahora realizará C*Z
	B GetPuls
	
DoCZ: //Calcular C*Z = 2*Z y resultado final
	ADD R8, R1, R1 //2*Z = Z+Z
	SUB R6, R8, R9 //V=-5*Y+2*Z
	ADD R11, R11, R6//3X-V
	STR	R11, [R7, #0] // Mostrar Resultado en los displays.
	
Finish:
	B Finish