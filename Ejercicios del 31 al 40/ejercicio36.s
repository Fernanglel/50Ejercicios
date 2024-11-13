////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 36
//Encontrar el segundo elemento más grande	
//Comparación en arreglos	
//Análisis de datos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main(string[] args)
    {
        int[] numeros = { 5, 12, 3, 9, 21, 19 };

        if (numeros.Length < 2)
        {
            Console.WriteLine("El arreglo no tiene suficientes elementos.");
            return;
        }

        int max1 = int.MinValue, max2 = int.MinValue;

        foreach (int num in numeros)
        {
            if (num > max1)
            {
                max2 = max1;  // Actualizar el segundo mayor
                max1 = num;   // Actualizar el mayor
            }
            else if (num > max2 && num != max1)
            {
                max2 = num;  // Actualizar el segundo mayor si es menor que max1
            }
        }

        if (max2 == int.MinValue)
        {
            Console.WriteLine("No hay un segundo elemento más grande.");
        }
        else
        {
            Console.WriteLine($"El segundo elemento más grande es: {max2}");
        }
    }
}

*/

/*
//C
//nano 36.c

#include <stdio.h>

// Declaración de la función ensambladora
extern void find_second_max();

// Declaración de la variable second_max que se encuentra en el ensamblador
extern int second_max;

int main() {
    // Llamar a la función en ensamblador que calcula el segundo máximo
    find_second_max();

    // Leer el segundo máximo desde la memoria y mostrarlo
    printf("El segundo máximo es: %d\n", second_max);

    return 0;
}
*/
//ARM64
//nano 36.s

.global find_second_max
.global second_max

.section .data
nums: 
    .word 4, 9, 2, 7, 5, 10, 3  // Lista de números
nums_len: 
    .word 7  // Longitud de la lista
second_max: 
    .word 0  // Inicializamos second_max a 0

.section .text
find_second_max:
    ldr x0, =nums      // Cargar la dirección de la lista de números
    ldr x1, =nums_len  // Cargar la dirección de la longitud de la lista
    ldr w1, [x1]       // Obtener la longitud de la lista (número de elementos)
    
    // Inicializamos los valores del máximo y segundo máximo
    mov x2, #0         // max = 0
    mov x3, #0         // second_max = 0
    
loop:
    cmp w1, #0
    beq end_loop

    ldr w4, [x0], #4  // Cargar el siguiente número en w4 y mover x0 al siguiente número

    cmp w4, w2
    ble not_new_max
    
    mov x3, x2         // El segundo máximo es el antiguo máximo
    mov x2, x4         // El nuevo máximo es el número actual
    b continue_loop

not_new_max:
    cmp w4, w3
    ble continue_loop

    mov x3, x4

continue_loop:
    sub w1, w1, #1
    b loop

end_loop:
    // Guardar el segundo máximo en la memoria
    ldr x0, =second_max // Cargar la dirección de second_max
    str w3, [x0]        // Guardamos el segundo máximo en la dirección de second_max
    
    ret
