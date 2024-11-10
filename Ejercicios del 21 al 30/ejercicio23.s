////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 23
//Conversión de entero a ASCII	
//Conversión de tipos de datos	
//Interfaces de usuario
///////////////////////////////////////////////

//C#
/*

*/


//ARM64

.global _start

.section .data
msg:    .asciz "El valor ASCII es: "
char:   .byte 65               // El valor ASCII de 'A'

.section .text
_start:
    // Escribir el mensaje en stdout
    mov x0, #1                  // Número de archivo: 1 = stdout
    ldr x1, =msg                // Dirección del mensaje
    ldr x2, =19                  // Longitud del mensaje
    mov x8, #64                 // Número de syscall para 'write'
    svc #0                       // Hacer la llamada al sistema

    // Escribir el valor ASCII (carácter 'A') desde la sección de datos
    mov x0, #1                  // Número de archivo: 1 = stdout
    ldr x1, =char               // Dirección del valor ASCII (carácter 'A')
    mov x2, #1                  // Longitud (1 byte)
    mov x8, #64                 // Número de syscall para 'write'
    svc #0                       // Hacer la llamada al sistema

    // Finalizar el programa
    mov x0, #0                  // Código de salida
    mov x8, #93                 // Número de syscall para 'exit'
    svc #0                       // Hacer la llamada al sistema
