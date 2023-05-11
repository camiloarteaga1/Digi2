.global _start
_start:
	SUB	R0, R15, R15 //Inicializar R0 en 0.
	LDR	R7, [R0, #0] //Cargar direccion inicial = C000_0000.
	ciclo:
	LDR	R1, [R7, #8] // R1 leer switches: X, Y, Z.
	STR	R1, [R7, #0] // Mostrar R1 en los displays.
	B ciclo
	