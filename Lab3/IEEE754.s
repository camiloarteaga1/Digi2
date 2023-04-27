.global _start
.equ N,4
.text
_start:

	mov r11, #1
	mov r0, #0
	b For
	b End_For
For:
	cmp r11, #N
	bhi End_For
	ldr r12, =A

	ldr r4, [r12,r0]
	lsl r1, r4, #9  //Desplazamiento de mantisa de A
	lsr r1, r1, #9
	add r1, r1, #0x00800000  //Mantisa de A separada.
	ldr r12, =B
	ldr r5, [r12,r0]
	lsl r2, r5, #9  //Desplazamiento de mantisa de B.
	lsr r2, r2, #9
	add r2, r2, #0x00800000	//Mantisa de B separada.
	lsl r6, r4, #1
	lsl r7, r5, #1
	lsr r6, r6, #24  //Exponente de A extraido.
	lsr r7, r7, #24  //Exponente de B extraido.
	
	//Analisis de casos especiales.
	cmp r6,#255
	mov r5, r1
	mov r4, pc
	beq especiales
	cmp r7,#255
	mov r5, r2
	mov r4, pc
	beq especiales
	
	//Incrementar 
	cmp r6,#255
	lsreq r5, r6, #7
	movne r5, #0
	cmp r7,#255
	lsreq r4, r7, #7
	movne r4, #0
	orr r4, r4, r5
	cmp r4, #1
	beq incrementar
	
	//Verificacion de operaciones.
	ldr r12, =OP
	ldr r4, [r12, r0] //Se carga la operacion en r4.
	cmp r4, #1
	beq Mul //Si la operación es 1, se entra a la funcion de multiplicacion.
	bcc Sum //Si la operación es 0, se entra a la funcion de suma.
	b End_For //De lo contrario, terminar el programa.
	
Sum:
	cmp r6, r7 // Activa las banderas r6-r7 que compara los exponentes.
	subcc r3, r7, r6 
	subhi r3, r6, r7
	moveq r3, #0 //Cuando los exponentes son iguales
	
	//Verificacion numeros negativos
	ldr r10, =A
	ldr r10, [r10,r0]
	bic r10, r10, #2147483647 //Extraer signo de A
	cmp r10, #0
	mvnmi r1, r1 //Complemento a 1
	addmi r1, r1, #1 //Complemento a 2
	
	ldr r5, =B
	ldr r5, [r5,r0]
	bic r5,r5,#2147483647 //Extraer signo de B
	cmp r5, #0
	mvnmi r2, r2 //Complemento a 1
	addmi r2, r2, #1 //Complemento a 2 
	
	cmp r1, r2
	lsrcc r3, r1, r3 //Se corre la mantisa
	lsrhi r3, r2, r3
	addcc r3, r2, r3 //Suma las mantisas
	addhi r3, r1, r3
	
	movcc r9, r7
	movhi r9, r6
	cmp r3 , #16777216
	addhs r9, #1
	lsl r9, r9, #23
	
	cmp r6, r7 // Activa las banderas r6-r7.
	addcc r9, r9, r5 //Se agrega el signo B si A<B.
	addhi r9, r9, r10  //Se agrega el signo A si A>B.
	
	lsrhs r3, r3, #1 //Normalizando.
	lsl r3, r3, #9
	lsr r3, r3, #9 //Fraccion resultante.
	
	cmp r9,#0 //En caso de que el resultado sea negativo.
	mvnmi r3, r3 //Complemento a 1 del resultado negativo .
	addmi r3, r3, #1 //Complemento a 2 del resultado negativo.
	
	add r8, r9, r3 // Ensambla el resultado
	ldr r12, =R
	str r8, [r12,r0] // Guarda el resultado
	add r0,r0,#4
	add r11, r11, #1
	b For

	
Mul:
	sub r6, r6, #127
	sub r7, r7, #127
	add r9, r6, r7 //Exp final
	umull r3, r10, r1, r2 //Multiplica la mantisa
	
	cmp r10, #32768
	addcs r9, #1// Comparar el exponente y la mascara de overflow. 
	add r9, r9, #127
	lsr r3, r3, #16 
	lslcs r10, #17
	lsrcs r10, #1//Normalizando.
	lslcc r10, #18
	lsrcc r10, #2//Normalizando.
	
	
	ldr r6, =A
	ldr r6, [r6,r0]
	bic r6,r6,#2147483647 //Signo de A.
	ldr r7, =B
	ldr r7, [r7,r0]
	bic r7,r7,#2147483647 //Signo de B.
	eor r6,r6,r7 //XOR para obtener el signo de la multiplicación.
	
	add r3, r3, r10 //Mantisa resultante.
	lsrcs r3, #8//Desplazar Mantisa para ensamblar con exponente.
	lsrcc r3, #7
	lsl r9, r9, #23 //Exponente final.
	add r9,r6
	add r8, r3, r9 //Une el resultado.
	ldr r12, =R
	str r8, [r12,r0] // Guardado de la multiplicación.
	add r0,r0,#4
	add r11, r11, #1
	b For

especiales:
	//Para los casos especiales solo validar cuando los exponentes son 11111111.
	ldr r12, =R // Cargar direccion reservada para el resultado.
	sub r5, r5, #0x00800000 //Analizar mantisa sin normalizar.
	cmp r5,#0 //Flags para comparar la mantisa.
	
	movne r8,#0xffffffff// Caso de NaN.
	strne r8, [r12,r0] // Se guarda el resultado.
	bne incrementar
	
	moveq r8,#0x7f0// Caso de infinitos.
	addeq r8, r8,#8
	lsleq r8,#20 
	
	streq r8, [r12,r0] // Guarda el resultado de la operación.
	mov pc, r4
	
incrementar:
	add r0,r0,#4 //Aumenta de a 4 para asi recorrer la memoria.
	add r11, r11, #1
	b For
	
End_For:
	b End_For //Final del programa.

.data
R: .ds.l N
A: .dc.l 0x41CB7525, 0x9e2548fe, 0x423d6600, 0x3F800000
B: .dc.l 0x4869BC00, 0x4869bc00, 0x41b4f000, 0x3F800000
OP: .dc.l 0x00000000, 0x00000001, 0x00000001, 0x00000001
	