////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 34
//Invertir los elementos de un arreglo	
//Manipulación de arreglos	
//Procesamiento de datos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void InvertirRecursivo(int[] arr, int inicio, int fin)
    {
        if (inicio >= fin) return;

        // Intercambiar los elementos
        int temp = arr[inicio];
        arr[inicio] = arr[fin];
        arr[fin] = temp;

        // Llamada recursiva
        InvertirRecursivo(arr, inicio + 1, fin - 1);
    }

    static void Main(string[] args)
    {
        int[] numeros = { 21, 22, 23, 24, 25 };

        // Invertir usando recursión
        InvertirRecursivo(numeros, 0, numeros.Length - 1);

        // Imprimir el arreglo invertido
        Console.WriteLine("Arreglo invertido: " + string.Join(", ", numeros));
    }
}
*/

//C
#include <stdio.h>

// Declaración de la función ensambladora
extern void invert_array(int *arr, int length);

int main() {
    int arr[] = {5, 10, 15, 20, 25};  // Arreglo inicial
    int length = sizeof(arr) / sizeof(arr[0]);  // Calcular la longitud del arreglo

    // Llamar a la función ensambladora para invertir el arreglo
    invert_array(arr, length);

    // Imprimir el arreglo invertido
    printf("Arreglo invertido:\n");
    for (int i = 0; i < length; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    return 0;
}


//ARM64
// 34.s - Invertir un arreglo de enteros
.section .text
.global invert_array

// Función que invierte un arreglo de enteros
// Parámetros:
// x0 = dirección del arreglo
// w1 = longitud del arreglo
invert_array:
    // Calcular la dirección del último elemento
    mov w2, w1              // Copiar la longitud en w2
    sub w2, w2, 1           // Restar 1 para obtener el índice final
    lsl w2, w2, 2           // Multiplicar por 4 (tamaño de un entero en bytes)
    add x3, x0, x2          // x3 apunta al último elemento

invert_loop:
    cmp x0, x3              // Comparar las direcciones de los extremos
    bge end_invert          // Si se cruzan o se encuentran, salir del bucle

    ldr w4, [x0]            // Cargar el elemento desde el extremo izquierdo
    ldr w5, [x3]            // Cargar el elemento desde el extremo derecho
    str w5, [x0]            // Escribir el elemento derecho en el extremo izquierdo
    str w4, [x3]            // Escribir el elemento izquierdo en el extremo derecho

    add x0, x0, 4           // Avanzar al siguiente elemento desde la izquierda
    sub x3, x3, 4           // Retroceder al siguiente elemento desde la derecha
    b invert_loop           // Repetir el bucle

end_invert:
    ret                     // Retornar al código de C

//ARM64
