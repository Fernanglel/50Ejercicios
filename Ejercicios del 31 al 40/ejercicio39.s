////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 39
//Convertir decimal a binario	
//Conversión, bucles	
//Conversión de datos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main(string[] args)
    {
        Console.Write("Ingrese un número decimal: ");
        int numero = int.Parse(Console.ReadLine());

        Console.WriteLine($"El número {numero} en binario es: {DecimalABinario(numero)}");
    }

    static string DecimalABinario(int numero)
    {
        if (numero == 0)
            return "0";
        if (numero == 1)
            return "1";

        return DecimalABinario(numero / 2) + (numero % 2).ToString();
    }
}

*/


//ARM64
.global _start

.section .data
    num: .word 43        // Número decimal a convertir
    msg: .asciz "El número en binario es: "

.section .bss
    bin_str: .skip 32    // Reservamos 32 bytes para la cadena binaria

.section .text
_start:
    // Imprimir mensaje de inicio
    ldr x0, =msg         // Cargar la dirección del mensaje
    bl print_string

    // Cargar el número decimal a convertir
    ldr w1, =num         // Cargar el valor de 'num' en w1

    // Convertir a binario y almacenar el resultado en bin_str
    mov w2, #31          // Contador para el bit más significativo (comenzamos desde el bit 31)
    ldr x3, =bin_str     // Dirección de la cadena binaria

convert_loop:
    cmp w2, #0           // Si el contador es menor a 0, terminamos
    blt done

    // Obtener el bit en la posición w2
    lsr w4, w1, w2       // Desplazar el número hacia la derecha (w1)
    and w4, w4, #1       // Obtener el bit (0 o 1)

    // Convertir el bit a ASCII (0 o 1)
    add w4, w4, #48      // '0' tiene valor ASCII 48

    // Guardar el bit en la cadena binaria
    strb w4, [x3], #1    // Almacenar el byte y mover el puntero

    // Reducir el contador
    sub w2, w2, #1
    b convert_loop

done:
    // Imprimir la cadena binaria
    ldr x0, =bin_str     // Cargar la dirección de la cadena binaria
    bl print_string

    // Salir del programa
    mov x8, #93          // syscall number for exit
    mov x0, #0           // status 0
    svc #0

// Función para imprimir una cadena de caracteres
print_string:
    mov x2, x1           // Longitud de la cadena (en bytes)
    mov x8, #64          // syscall number for write
    mov x1, x0           // Dirección de la cadena
    mov x0, #1           // File descriptor (1 = stdout)
    svc #0
    ret
