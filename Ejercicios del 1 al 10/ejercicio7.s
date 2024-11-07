//ejercicio7  
////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 7
//Factorial de un número	
//Recursión/bucles	
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        // Pedir al usuario que ingrese un número
        Console.Write("Ingrese un número para calcular su factorial: ");
        int n = Convert.ToInt32(Console.ReadLine());

        // Verificar si el número es negativo
        if (n < 0)
        {
            Console.WriteLine("El factorial no está definido para números negativos.");
        }
        else
        {
            // Calcular el factorial usando un bucle
            long factorial = 1;
            for (int i = 1; i <= n; i++)
            {
                factorial *= i;
            }

            // Mostrar el resultado
            Console.WriteLine($"El factorial de {n} es: {factorial}");
        }
    }
}
*/

//ARM64
.section .data
prompt: .asciz "Introduce un número para calcular su factorial: "
result_msg: .asciz "El factorial de %ld es %ld.\n"
scanf_format: .asciz "%ld"

number: .quad 0
factorial: .quad 1

.section .text
.global main

main:
    // Pedir al usuario un número
    ldr x0, =prompt
    bl printf

    // Leer el número
    ldr x0, =scanf_format
    ldr x1, =number
    bl scanf

    // Cargar el número en x1
    ldr x1, =number
    ldr x1, [x1]

    // Inicializar factorial en 1
    mov x2, #1

    // Calcular el factorial
    mov x3, #1        // Inicializar contador en 1
factorial_loop:
    cmp x3, x1        // Comparar contador con el número
    bgt end_factorial // Si contador > número, salir del bucle

    mul x2, x2, x3    // factorial *= contador
    add x3, x3, #1    // Incrementar contador
    b factorial_loop   // Volver al inicio del bucle

end_factorial:
    // Guardar el resultado del factorial
    ldr x4, =factorial
    str x2, [x4]

    // Imprimir el resultado
    ldr x0, =result_msg
    mov x1, x1        // cargar el número
    ldr x2, =factorial
    ldr x2, [x2]      // cargar el resultado
    bl printf

    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0