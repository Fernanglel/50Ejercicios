//ejercicio 9 
////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 9
//Verificar si un número es primo	
//Saltos condicionales	
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        // Pedir al usuario que ingrese un número
        Console.Write("Ingrese un número para verificar si es primo: ");
        int numero = Convert.ToInt32(Console.ReadLine());

        // Verificar si el número es primo
        if (EsPrimo(numero))
        {
            Console.WriteLine($"{numero} es un número primo.");
        }
        else
        {
            Console.WriteLine($"{numero} no es un número primo.");
        }
    }

    // Método para verificar si un número es primo
    static bool EsPrimo(int n)
    {
        // Casos base
        if (n <= 1) return false;   // No es primo si es menor o igual a 1
        if (n == 2) return true;    // El 2 es el único número primo par

        // Verificar divisibilidad desde 2 hasta la raíz cuadrada de n
        for (int i = 2; i <= Math.Sqrt(n); i++)
        {
            if (n % i == 0) // Si n es divisible por i, no es primo
            {
                return false;
            }
        }

        // Si no se encuentra ningún divisor, es primo
        return true;
    }
}
*/

//ARM64
.section .data
prompt: .asciz "Introduce un número: "
result_msg: .asciz "El número %ld es primo.\n"
not_prime_msg: .asciz "El número %ld no es primo.\n"
scanf_format: .asciz "%ld"

num: .quad 0

.section .text
.global main

main:
    // Pedir un número
    ldr x0, =prompt
    bl printf

    // Leer el número
    ldr x0, =scanf_format
    ldr x1, =num
    bl scanf

    // Cargar el número en x1
    ldr x1, =num
    ldr x1, [x1]

    // Comprobar si el número es menor que 2
    cmp x1, #2
    blt not_prime      // Si num < 2, no es primo

    // Comenzar a verificar divisores
    mov x2, #2         // x2 será el divisor
    mov x3, x1         // Guardamos el número original en x3

check_loop:
    // Calcular x2 * x2
    mul x4, x2, x2
    cmp x4, x3
    bgt is_prime       // Si x2 * x2 > num, es primo

    // Verificar si num es divisible por x2
    mov x0, x3        // Mover num a x0
    sdiv x5, x0, x2   // x5 = num / x2
    mul x6, x5, x2    // x6 = x5 * x2
    cmp x6, x3        // Comparar x6 con num
    beq not_prime      // Si son iguales, no es primo

    // Incrementar divisor
    add x2, x2, #1
    b check_loop

is_prime:
    // Imprimir que es primo
    ldr x0, =result_msg
    ldr x1, =num
    ldr x1, [x1]      // Cargar el número
    bl printf
    b end_program

not_prime:
    // Imprimir que no es primo
    ldr x0, =not_prime_msg
    ldr x1, =num
    ldr x1, [x1]      // Cargar el número
    bl printf

end_program:
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
