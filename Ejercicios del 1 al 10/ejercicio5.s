//Ejercicio 5
////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 5
//División de dos números	
//Aritmética (UDIV, SDIV)	
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        // Pedir al usuario que ingrese el primer número (dividendo)
        Console.Write("Ingrese el primer número (dividendo): ");
        double num1 = Convert.ToDouble(Console.ReadLine());

        // Pedir al usuario que ingrese el segundo número (divisor)
        Console.Write("Ingrese el segundo número (divisor): ");
        double num2 = Convert.ToDouble(Console.ReadLine());

        // Verificar si el divisor es 0 para evitar la división por cero
        if (num2 == 0)
        {
            Console.WriteLine("Error: No se puede dividir por cero.");
        }
        else
        {
            // Realizar la división de los dos números
            double division = num1 / num2;

            // Mostrar el resultado
            Console.WriteLine($"La división de {num1} entre {num2} es: {division}");
        }
    }
}
*/

//ARM64
.section .data
prompt1: .asciz "Introduce el primer número: "
prompt2: .asciz "Introduce el segundo número: "
result_msg: .asciz "La división es: %ld\n"
scanf_format: .asciz "%ld"  // Formato para leer long int

num1: .quad 0
num2: .quad 0
result: .quad 0

.section .text
.global main

main:
    // Pedir el primer número
    ldr x0, =prompt1
    bl printf

    // Leer el primer número
    ldr x0, =scanf_format // Cargar formato de scanf
    ldr x1, =num1        // Cargar dirección de num1
    bl scanf

    // Pedir el segundo número
    ldr x0, =prompt2
    bl printf

    // Leer el segundo número
    ldr x0, =scanf_format // Cargar formato de scanf
    ldr x1, =num2        // Cargar dirección de num2
    bl scanf

    // Dividir los números
    ldr x1, =num1
    ldr x1, [x1]         // Cargar el primer número
    ldr x2, =num2
    ldr x2, [x2]         // Cargar el segundo número

    // Comprobar si el segundo número es cero
    cmp x2, #0
    beq division_por_cero // Saltar si el segundo número es cero

    sdiv x3, x1, x2       // Dividir los números
    ldr x0, =result
    str x3, [x0]         // Almacenar el resultado

    // Mostrar el resultado
    ldr x0, =result_msg
    ldr x1, =result
    ldr x1, [x1]         // Cargar el resultado
    bl printf

    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0

division_por_cero:
    ldr x0, =prompt1
    ldr x0, =prompt2
    ldr x1, =num2
    // Mostrar un mensaje de error si se intenta dividir por cero
    ldr x0, =prompt1
    ldr x1, =prompt2
    ldr x2, =num1
    // Aquí puedes colocar un mensaje que indique que la división por cero no es permitida.
    ldr x0, =prompt1
    ldr x0, =prompt2
    ldr x0, =num2
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
