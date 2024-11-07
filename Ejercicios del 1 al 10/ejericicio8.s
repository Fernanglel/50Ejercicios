//ejercicio 8 
////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 8
//Serie de Fibonacci	
//Bucles y manejo de memoria	
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        // Pedir al usuario que ingrese el valor de N
        Console.Write("Ingrese la cantidad de términos de la serie Fibonacci: ");
        int N = Convert.ToInt32(Console.ReadLine());

        // Mostrar la serie de Fibonacci usando recursión
        Console.WriteLine("Serie de Fibonacci:");
        for (int i = 0; i < N; i++)
        {
            Console.Write(FibonacciRecursivo(i) + " ");
        }
        Console.WriteLine(); // Salto de línea al final
    }

    // Método recursivo para calcular el n-ésimo término de Fibonacci
    static long FibonacciRecursivo(int n)
    {
        if (n == 0) return 0; // Caso base
        if (n == 1) return 1; // Caso base
        return FibonacciRecursivo(n - 1) + FibonacciRecursivo(n - 2); // Llamada recursiva
    }
}
*/

//ARM64
.section .data
prompt: .asciz "Introduce el número de términos de la serie de Fibonacci: "
result_msg: .asciz "Fibonacci[%ld] = %ld\n"
scanf_format: .asciz "%ld"

n_terms: .quad 0
fib1: .quad 0
fib2: .quad 1

.section .text
.global main

main:
    // Pedir el número de términos
    ldr x0, =prompt
    bl printf

    // Leer el número de términos
    ldr x0, =scanf_format
    ldr x1, =n_terms
    bl scanf

    // Cargar el número de términos en x1
    ldr x1, =n_terms
    ldr x1, [x1]

    // Verificar si n es menor o igual a 0
    cmp x1, #0
    ble end_program      // Si n <= 0, salir

    // Inicializar los primeros dos términos de Fibonacci
    ldr x4, =fib1
    ldr x5, =fib2
    mov x0, #0           // Primer término (0)
    str x0, [x4]         // fib1 = 0

    mov x0, #1           // Segundo término (1)
    str x0, [x5]         // fib2 = 1

    // Imprimir el primer término
    ldr x0, =result_msg
    mov x1, #0           // Índice 0
    ldr x2, [x4]         // Cargar fib1 (0)
    bl printf

    // Si solo se quiere imprimir el primer término, salir
    cmp x1, #1
    beq end_program

    // Imprimir el segundo término
    mov x1, #1           // Índice 1
    ldr x0, =result_msg
    ldr x2, [x5]         // Cargar fib2 (1)
    bl printf

    // Calcular y mostrar el resto de los términos
    mov x7, #2           // Contador de términos ya impresos

fibonacci_loop:
    // Cargar los dos últimos términos
    ldr x10, [x4]        // fib1
    ldr x11, [x5]        // fib2
    add x12, x10, x11    // x12 = fib1 + fib2

    // Imprimir el término actual
    ldr x0, =result_msg
    mov x1, x7           // Índice actual
    mov x2, x12          // Valor a imprimir
    bl printf

    // Actualizar los términos
    str x11, [x4]        // fib1 = fib2
    str x12, [x5]        // fib2 = nuevo término (x12)

    // Incrementar el contador
    add x7, x7, #1
    cmp x7, x1
    blt fibonacci_loop

end_program:
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
