////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 15
//Búsqueda binaria	
//Recursión y saltos	
//Optimización en búsquedas, bases de datos
//video - https://asciinema.org/a/8VxML2CQMtIAMhem4HAcgHU1E
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    // Función para realizar la búsqueda binaria
    static int BusquedaBinaria(int[] arreglo, int valorBuscado)
    {
        int izquierda = 0;
        int derecha = arreglo.Length - 1;

        while (izquierda <= derecha)
        {
            // Calculamos el índice del medio
            int medio = (izquierda + derecha) / 2;

            // Comparamos el valor en el medio con el valor buscado
            if (arreglo[medio] == valorBuscado)
            {
                return medio; // El valor fue encontrado
            }
            else if (arreglo[medio] < valorBuscado)
            {
                // El valor buscado está en la mitad derecha
                izquierda = medio + 1;
            }
            else
            {
                // El valor buscado está en la mitad izquierda
                derecha = medio - 1;
            }
        }

        // Si no se encontró el valor, retornamos -1
        return -1;
    }

    static void Main()
    {
        // Definir un arreglo de enteros ordenado
        int[] arreglo = { 2, 3, 4, 5, 6, 7, 8 };

        // Solicitar al usuario el valor que desea buscar
        Console.Write("Introduce el valor que deseas buscar: ");
        int valor = int.Parse(Console.ReadLine());

        // Llamar a la función de búsqueda binaria
        int indice = BusquedaBinaria(arreglo, valor);

        // Mostrar el resultado
        if (indice != -1)
        {
            Console.WriteLine($"El valor {valor} se encuentra en el índice: {indice}");
        }
        else
        {
            Console.WriteLine($"El valor {valor} no se encuentra en el arreglo.");
        }
    }
}
*/

//ARM64
.section .data
array:      .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19  // Arreglo ordenado
array_size: .word 10                             // Tamaño del arreglo
target:     .word 7                              // Valor a buscar

.section .text
.global _start

_start:
    // Cargar el tamaño del arreglo y la dirección del primer elemento
    adrp x1, array_size                   // Carga la página base de array_size en x1
    add x1, x1, :lo12:array_size          // Completa la dirección con el offset bajo de array_size
    ldr w2, [x1]                          // Carga el tamaño del arreglo en w2

    adrp x3, array                        // Carga la página base de array en x3
    add x3, x3, :lo12:array               // Completa la dirección con el offset bajo de array
    adrp x4, target                       // Carga la página base de target en x4
    add x4, x4, :lo12:target              // Completa la dirección con el offset bajo de target
    ldr w5, [x4]                          // Carga el valor a buscar en w5

    mov w6, #0                            // Inicializa el índice de inicio (low)
    mov w7, w2                            // Inicializa el índice final (high) al tamaño del arreglo

binary_search_loop:
    cmp w6, w7                            // Verifica si low <= high
    bgt not_found                         // Si no, el valor no se encuentra

    add w8, w6, w7                        // w8 = low + high
    lsr w8, w8, #1                        // w8 = (low + high) / 2 (dividir entre 2)

    ldr w9, [x3, x8, lsl #2]              // Cargar el elemento en la mitad del arreglo (array[mid])
    cmp w9, w5                            // Compara el valor encontrado con el valor objetivo
    beq found                             // Si son iguales, hemos encontrado el valor

    blt search_right                      // Si el valor es menor que el objetivo, buscar en la mitad derecha
    b search_left                         // Si el valor es mayor, buscar en la mitad izquierda

search_left:
    sub w7, w8, #1                        // high = mid - 1
    b binary_search_loop                  // Repetir la búsqueda

search_right:
    add w6, w8, #1                        // low = mid + 1
    b binary_search_loop                  // Repetir la búsqueda

not_found:
    mov w0, #-1                           // Si no se encuentra el valor, retorna -1
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir

found:
    mov w0, w8                            // Retorna el índice donde se encontró el valor
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir

***************************************
as -o binario.o binario.s
ld -o binario binario.o
./binario

Verifica el código de salida con:

echo $?
