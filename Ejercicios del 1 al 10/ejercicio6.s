//Ejercicio 6
////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 6
//Suma de los N primeros números naturales	
//Bucles y contadores	
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        // Pedir al usuario que ingrese el valor de N
        Console.Write("Ingrese el valor de N: ");
        int N = Convert.ToInt32(Console.ReadLine());

        // Verificar si N es un número positivo
        if (N < 1)
        {
            Console.WriteLine("Por favor, ingrese un número natural positivo mayor que 0.");
        }
        else
        {
            // Calcular la suma de los N primeros números naturales usando la fórmula
            int suma = N * (N + 1) / 2;

            // Mostrar el resultado
            Console.WriteLine($"La suma de los primeros {N} números naturales es: {suma}");
        }
    }
}
*/

//ARM64
.section .data
prompt: .asciz "Introduce un número N para calcular la suma de los primeros N números naturales: "
result_msg: .asciz "La suma de los primeros %ld números naturales es %ld.\n"
scanf_format: .asciz "%ld"

number: .quad 0
sum: .quad 0

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

    // Inicializar la suma en 0
    mov x2, #0

    // Calcular la suma de los primeros N números naturales
    mov x3, #1        // Inicializar contador en 1
sum_loop:
    cmp x3, x1        // Comparar contador con N
    bgt end_sum       // Si contador > N, salir del bucle

    add x2, x2, x3    // suma += contador
    add x3, x3, #1    // Incrementar contador
    b sum_loop        // Volver al inicio del bucle

end_sum:
    // Guardar el resultado de la suma
    ldr x4, =sum
    str x2, [x4]

    // Imprimir el resultado
    ldr x0, =result_msg
    mov x1, x1        // cargar N
    ldr x2, =sum
    ldr x2, [x2]      // cargar el resultado
    bl printf

    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
