////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 13
//Encontrar el mínimo en un arreglo	
//Recorrido de arreglos	
//Análisis de datos, búsqueda de valores

///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        // Definir un arreglo de enteros
        int[] arreglo = { 3, 5, 7, 2, 8, 6, 4 };

        // Usar el método Min() para encontrar el valor mínimo
        int minimo = Array.Min(arreglo);

        // Mostrar el resultado
        Console.WriteLine("El valor mínimo en el arreglo es: " + minimo);
    }
}
*/


//ARM64
.section .data
array:      .word 12, 3, 5, 7, 1, 9, 2    // Arreglo de ejemplo
array_size: .word 7                       // Tamaño del arreglo (número de elementos)

.section .text
.global _start

_start:
    // Cargar el tamaño del arreglo y la dirección del primer elemento
    adrp x1, array_size                  // Carga la página de base de array_size en x1
    add x1, x1, :lo12:array_size         // Completa la dirección usando el offset bajo de array_size
    ldr w2, [x1]                         // Carga el tamaño del arreglo en w2

    adrp x3, array                       // Carga la página de base de array en x3
    add x3, x3, :lo12:array              // Completa la dirección usando el offset bajo de array
    ldr w4, [x3]                         // Inicializa el mínimo con el primer elemento del arreglo

    // Bucle para recorrer el arreglo
find_minimum:
    subs w2, w2, #1                      // Decrementa el contador (cantidad de elementos a recorrer)
    beq end                              // Si el contador es cero, termina el bucle
    add x3, x3, #4                       // Avanza al siguiente elemento del arreglo
    ldr w5, [x3]                         // Carga el siguiente elemento en w5

    cmp w5, w4                           // Compara el elemento actual con el mínimo actual
    csel w4, w5, w4, lt                  // Si el elemento actual es menor, actualiza el mínimo

    b find_minimum                       // Salta al inicio del bucle

end:
    // Aquí w4 contiene el valor mínimo del arreglo
    // Usar w4 como código de salida

    mov w0, w4                           // Mueve el mínimo encontrado a w0 (código de salida)
    mov x8, #93                          // Código de salida para ARM Linux (93 en lugar de 60)
    svc #0                               // Llama al sistema para salir

*****************************
as -o arreglo.o arreglo.s
ld -o arreglo arreglo.o

./arreglo

es necesario luego de escribir el ./arreglo  escribir echo $?

echo $?
