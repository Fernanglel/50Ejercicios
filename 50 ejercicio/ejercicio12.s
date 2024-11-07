////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 12
//Encontrar el máximo en un arreglo	
//Recorrido de arreglos	
//Análisis de datos, búsqueda de valores
///////////////////////////////////////////////

//C#
/*
using System;
using System.Linq;  // Necesario para usar LINQ

class Program
{
    static void Main()
    {
        // Definir un arreglo de enteros
        int[] arreglo = { 3, 5, 7, 2, 8, 6, 4 };

        // Usar LINQ para encontrar el valor máximo
        int maximo = arreglo.Max();

        // Mostrar el resultado
        Console.WriteLine("El valor máximo en el arreglo es: " + maximo);
    }
}
*/

****************************
//codigo en C		   *
codigo en C - main.c	   *
****************************
#include <stdio.h>

// Declaramos la función de ensamblador
extern void encontrar_maximo();

// Declaramos la variable resultado como externa
extern int resultado;

int main() {
    // Llamamos a la función de ensamblador
    encontrar_maximo();

    // Imprimimos el resultado
    printf("El valor máximo en el arreglo es: %d\n", resultado);
    return 0;
}

//ARM64
  .data
arreglo:
    .word 5, 10, 3, 21, 7, 15, 6    // Ejemplo de arreglo de enteros de 32 bits
longitud:
    .word 7                         // Longitud del arreglo

.global resultado
resultado:
    .word 0                         // Variable para almacenar el máximo

    .text
    .global encontrar_maximo

encontrar_maximo:
    ldr x0, =arreglo                // Cargar la dirección base del arreglo en x0
    ldr w1, =7                      // Cargar la longitud del arreglo en w1 (longitud)
    ldr w2, [x0]                    // Inicializar w2 con el primer elemento (valor máximo inicial)

    mov w3, #1                      // Índice para iterar por el arreglo

buscar_maximo:
    cmp w3, w1                      // Comprobar si llegamos al final del arreglo
    bge fin                         // Si el índice es >= longitud, termina el bucle

    ldr w4, [x0, x3, LSL #2]        // Cargar el siguiente elemento en w4
    cmp w4, w2                      // Comparar el elemento actual con el máximo actual
    ble siguiente                   // Si w4 <= w2, saltar a siguiente
    mov w2, w4                      // Actualizar w2 con el nuevo máximo

siguiente:
    add w3, w3, #1                  // Incrementar el índice
    b buscar_maximo                 // Repetir el bucle

fin:
    ldr x5, =resultado              // Cargar la dirección de 'resultado'
    str w2, [x5]                    // Guardar el valor máximo en 'resultado'
    ret
****************************************
as -o m.o m.s
gcc -c main.c -o main.o
gcc main.o m.o -o m
./m
