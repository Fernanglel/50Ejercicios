//ejercicio 10 
////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 10
//Invertir una cadena	
//Manipulación de cadenas	
//video de los ejercicios del 1 al 10 ejercicios
//https://asciinema.org/a/BqdmUa6hpbRcnqepBZE38ycTK
///////////////////////////////////////////////

//C#
/*
using System;
using System.Linq;

class Program
{
    static void Main()
    {
        // Pedir al usuario que ingrese una cadena
        Console.Write("Ingrese una cadena: ");
        string input = Console.ReadLine();

        // Usar LINQ para invertir la cadena
        string reversed = new string(input.Reverse().ToArray());

        // Mostrar la cadena invertida
        Console.WriteLine($"La cadena invertida es: {reversed}");
    }
}

*/
//ARM64
.section .data
    mensaje: .asciz "Ingresa una cadena para invertir: "
    resultado: .asciz "\nCadena invertida: "

.section .bss
    .lcomm buffer, 100       // Buffer para la cadena de entrada, tamaño 100 bytes

.section .text
.global _start

_start:
    // Imprimir mensaje para ingresar cadena
    mov x0, 1                 // file descriptor 1 (stdout)
    ldr x1, =mensaje          // Dirección del mensaje
    mov x2, 32                // Longitud del mensaje
    mov x8, 64                // syscall write
    svc 0

    // Leer cadena del usuario
    mov x0, 0                 // file descriptor 0 (stdin)
    ldr x1, =buffer           // Dirección del buffer
    mov x2, 100               // Tamaño máximo de la entrada
    mov x8, 63                // syscall read
    svc 0

    // Calcular la longitud de la cadena ingresada
    ldr x3, =buffer           // Dirección del buffer
    mov x4, #0                // Inicializamos el contador de longitud
contar_longitud:
    ldrb w5, [x3, x4]         // Leer byte
    cmp w5, #0                // Verificar si es fin de cadena ('\0')
    beq fin_contar
    add x4, x4, #1            // Incrementar longitud
    b contar_longitud

fin_contar:

    // Remover el salto de línea al final de la entrada
    cmp x4, #0                // Si la longitud es 0, saltar
    beq invertir
    sub x4, x4, #1            // Ajustar la longitud
    ldrb w5, [x3, x4]
    cmp w5, #10               // Si es '\n', reemplazar con '\0'
    bne invertir
    strb w0, [x3, x4]         // Reemplazar '\n' por '\0'

invertir:
    // Punteros para inicio y fin de la cadena
    ldr x1, =buffer           // x1 apunta al inicio de la cadena
    add x2, x1, x4            // x2 apunta al final de la cadena
    sub x2, x2, #1            // Ajustar para no incluir '\0'

invertir_loop:
    cmp x1, x2                // Comparar punteros de inicio y fin
    bge imprimir_resultado    // Si se cruzan, terminar inversión

    // Intercambiar caracteres en x1 y x2
    ldrb w3, [x1]             // Cargar carácter en inicio (x1)
    ldrb w4, [x2]             // Cargar carácter en fin (x2)
    strb w4, [x1]             // Escribir carácter de fin en inicio
    strb w3, [x2]             // Escribir carácter de inicio en fin

    // Mover punteros hacia el centro
    add x1, x1, #1            // Avanzar puntero de inicio
    sub x2, x2, #1            // Retroceder puntero de fin
    b invertir_loop

imprimir_resultado:
    // Imprimir mensaje de resultado
    mov x0, 1                 // file descriptor 1 (stdout)
    ldr x1, =resultado        // Dirección del mensaje de resultado
    mov x2, 18                // Longitud del mensaje
    mov x8, 64                // syscall write
    svc 0

    // Imprimir cadena invertida
    mov x0, 1                 // file descriptor 1 (stdout)
    ldr x1, =buffer           // Dirección del buffer (cadena invertida)
    mov x2, x4                // Longitud de la cadena invertida
    mov x8, 64                // syscall write
    svc 0

    // Terminar programa
    mov x8, 93                // syscall exit
    mov x0, 0                 // Código de salida
    svc 0
