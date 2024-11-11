////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 27
//Desplazamientos a la izquierda y derecha	
//Operaciones de desplazamiento	
//Procesamiento de señales
//video - 
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        int num = 8;  // En binario: 1000

        // Desplazamiento a la izquierda (<<)
        int desplazamientoIzquierda = num << 2; // 8 << 2 -> 1000 << 2 = 100000 (32 en decimal)
        Console.WriteLine($"Desplazamiento a la izquierda de {num} << 2: {desplazamientoIzquierda}");

        // Desplazamiento a la derecha (>>)
        int desplazamientoDerecha = num >> 2; // 8 >> 2 -> 1000 >> 2 = 10 (2 en decimal)
        Console.WriteLine($"Desplazamiento a la derecha de {num} >> 2: {desplazamientoDerecha}");
        
        // Desplazamiento a la derecha en número negativo
        int numNegativo = -8; // En binario de complemento a dos: 11111111111111111111111111111000
        int desplazamientoDerechaNegativo = numNegativo >> 2; // -8 >> 2
        Console.WriteLine($"Desplazamiento a la derecha de {numNegativo} >> 2: {desplazamientoDerechaNegativo}");
    }
}

*/


//ARM64

.data
    x:      .quad   0x1234567812345678    // Número de 64 bits
    y:      .quad   0x0000000000000005    // Número de 64 bits
    
    msgX:    .string "Valor de x: %016lX\n"
    msgY:    .string "Valor de y: %016lX\n"
    msgLeft: .string "Desplazamiento a la izquierda: %016lX\n"
    msgRight:.string "Desplazamiento a la derecha: %016lX\n"
    newline: .string "\n"

.text
.global main
.align 2

main:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    // Imprimir valor de x
    adrp    x0, msgX
    add     x0, x0, :lo12:msgX
    mov     x1, x
    bl      printf
    
    // Imprimir valor de y
    adrp    x0, msgY
    add     x0, x0, :lo12:msgY
    mov     x1, y
    bl      printf
    
    // Desplazamiento a la izquierda
    mov     x0, x                      // Cargar el valor de x
    mov     x1, y                      // Cargar el valor de y
    bl      shift_left
    
    // Desplazamiento a la derecha
    mov     x0, x                      // Cargar el valor de x
    mov     x1, y                      // Cargar el valor de y
    bl      shift_right
    
    ldp     x29, x30, [sp], #16
    mov     x0, #0
    ret

// Función para desplazamiento a la izquierda
shift_left:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    lsl     x0, x0, x1                 // Desplazar x a la izquierda por y bits
    
    // Imprimir resultado
    adrp    x0, msgLeft
    add     x0, x0, :lo12:msgLeft
    bl      printf
    
    ldp     x29, x30, [sp], #16
    ret

// Función para desplazamiento a la derecha
shift_right:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    lsr     x0, x0, x1                 // Desplazar x a la derecha por y bits
    
    // Imprimir resultado
    adrp    x0, msgRight
    add     x0, x0, :lo12:msgRight
    bl      printf
    
    ldp     x29, x30, [sp], #16
    ret

************************************************************************************************
    
