////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 31
//Mínimo Común Múltiplo (MCM)	
//Operaciones aritméticas	
//Cálculo de múltiplos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    // Función para calcular el MCD usando el Algoritmo de Euclides
    static int CalcularMCD(int a, int b)
    {
        while (b != 0)
        {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    // Función para calcular el MCM usando la relación MCM(a, b) = (a * b) / MCD(a, b)
    static int CalcularMCM(int a, int b)
    {
        return (a * b) / CalcularMCD(a, b);
    }

    static void Main(string[] args)
    {
        Console.WriteLine("Ingrese el primer número:");
        int num1 = int.Parse(Console.ReadLine());

        Console.WriteLine("Ingrese el segundo número:");
        int num2 = int.Parse(Console.ReadLine());

        int mcm = CalcularMCM(num1, num2);
        Console.WriteLine($"El MCM de {num1} y {num2} es: {mcm}");
    }
}

*/


//C

/*
#include <stdio.h>

// Declaración de la función ensambladora
extern long mcm_func(long a, long b);

int main() {
    long a, b;

    // Capturar los valores de a y b desde el usuario
    printf("Ingrese el primer número: ");
    scanf("%ld", &a);
    printf("Ingrese el segundo número: ");
    scanf("%ld", &b);

    // Validar que los números sean positivos
    if (a <= 0 || b <= 0) {
        printf("Error: Ambos números deben ser positivos y mayores que cero.\n");
        return 1;
    }

    // Llamar a la función ensambladora que ejecuta el cálculo del MCM
    long result = mcm_func(a, b);

    // Imprimir el resultado
    printf("El MCM de %ld y %ld es: %ld\n", a, b, result);

    return 0;
}


*/



//ARM64

.global mcm_func
.text

// Función que calcula el MCD
gcd:
    cmp x1, x0            // Comparar b y a
    b.eq end_gcd          // Si son iguales, termina
    b.gt greater          // Si b > a, saltar a 'greater'
    sub x0, x0, x1        // Resta b de a
    b gcd                 // Repite
greater:
    sub x1, x1, x0        // Resta a de b
    b gcd                 // Repite
end_gcd:
    mov x0, x0            // MCD almacenado en x0
    ret

// Función principal mcm_func
mcm_func:
    stp x29, x30, [sp, -16]!  // Guardar registros de marco
    mov x29, sp               // Actualizar marco de pila

    mov x2, x0                // Guardar a en x2
    mov x3, x1                // Guardar b en x3

    bl gcd                    // Llamar a gcd(a, b)
    mov x4, x0                // Guardar resultado del MCD en x4

    // Calcular MCM = (a * b) / MCD
    mul x0, x2, x3            // Multiplicar a y b
    udiv x0, x0, x4           // Dividir el producto por el MCD

    ldp x29, x30, [sp], 16    // Restaurar registros de marco
    ret

*****************************************************
