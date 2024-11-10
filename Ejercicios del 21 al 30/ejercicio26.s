////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 26
//Operaciones AND, OR, XOR a nivel de bits	
//Operaciones a nivel de bits	
//Criptografía, manipulación de datos
///////////////////////////////////////////////

//C#
/*

*/


//ARM64

.data
    // Valores de entrada
    value1:      .quad   0x1234567812345678
    value2:      .quad   0x8765432187654321

    // Mensajes de salida
    msgAnd:      .string "AND: %016lX\n"
    msgOr:       .string "OR: %016lX\n"
    msgXor:      .string "XOR: %016lX\n"

.text
.global main
.align 2

main:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Realizar operaciones bitwise
    ldr     x2, =value1
    ldr     x3, =value2
    ldr     x2, [x2]
    ldr     x3, [x3]

    and     x4, x2, x3
    orr     x5, x2, x3
    eor     x6, x2, x3

    // Imprimir resultados
    adrp    x0, msgAnd
    add     x0, x0, :lo12:msgAnd
    mov     x1, x4
    bl      printf

    adrp    x0, msgOr
    add     x0, x0, :lo12:msgOr
    mov     x1, x5
    bl      printf

    adrp    x0, msgXor
    add     x0, x0, :lo12:msgXor
    mov     x1, x6
    bl      printf

    ldp     x29, x30, [sp], #16
    mov     x0, #0
    ret

