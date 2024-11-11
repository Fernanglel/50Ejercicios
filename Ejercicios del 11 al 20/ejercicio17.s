////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 17
//Ordenamiento por selección	
//Algoritmos de ordenamiento	
//Optimización y organización de datos
//video - https://asciinema.org/a/8VxML2CQMtIAMhem4HAcgHU1E
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    // Función para implementar el ordenamiento por selección
    static void SelectionSort(int[] array)
    {
        int n = array.Length;

        // Recorremos todo el arreglo
        for (int i = 0; i < n - 1; i++)
        {
            // Encontramos el índice del menor elemento en el subarreglo no ordenado
            int minIndex = i;

            for (int j = i + 1; j < n; j++)
            {
                if (array[j] < array[minIndex])
                {
                    minIndex = j; // Actualizamos el índice del mínimo
                }
            }

            // Intercambiamos el elemento encontrado con el primer elemento no ordenado
            if (minIndex != i)
            {
                int temp = array[i];
                array[i] = array[minIndex];
                array[minIndex] = temp;
            }
        }
    }

    // Función para imprimir el arreglo
    static void PrintArray(int[] array)
    {
        foreach (int value in array)
        {
            Console.Write(value + " ");
        }
        Console.WriteLine();
    }

    static void Main(string[] args)
    {
        // Creamos un arreglo de ejemplo
        int[] arr = { 64, 25, 12, 22, 11 };

        Console.WriteLine("Arreglo original:");
        PrintArray(arr);

        // Aplicamos el algoritmo de ordenamiento por selección
        SelectionSort(arr);

        Console.WriteLine("Arreglo ordenado:");
        PrintArray(arr);
    }
}

    
*/


//ARM64
.data
    prompt:       .asciz "Ordenando el array usando el método de selección...\n"
    sortedMsg:    .asciz "Array ordenado:\n"
    array:        .word 5, 3, 8, 1, 2   // Array a ordenar
    length:       .word 5               // Longitud del array
    newline:      .asciz "\n"           // Nueva línea

.text
    .global _start

_start:
    // Mostrar el mensaje de inicio
    mov x0, #1                      // Descriptor de archivo para STDOUT
    ldr x1, =prompt                 // Dirección del mensaje de inicio
    mov x2, #45                     // Longitud del mensaje
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    // Cargar la longitud del array en w1
    ldr x1, =length                 // Dirección de la longitud
    ldr w1, [x1]                    // Cargar la longitud en w1

selection_sort:
    // Bucle exterior
    mov w2, #0                      // Índice inicial del bucle externo

outer_loop:
    cmp w2, w1                      // Si el índice es igual a la longitud, terminamos
    bge end_sort

    // Suponemos que el elemento en w2 es el mínimo
    mov w3, w2                      // w3 = índice mínimo inicial

    // Bucle interior: buscar el índice del mínimo en la sublista no ordenada
    mov w4, w2                      // Índice de inicio para la búsqueda
inner_loop:
    add w4, w4, #1                  // w4 = índice actual (w2 + 1)

    cmp w4, w1                      // Si w4 es mayor o igual a la longitud, salimos del bucle interior
    bge inner_done

    // Calcular direcciones de array[w3] y array[w4]
    ldr x5, =array
    lsl w6, w3, #2                  // w6 = w3 * 4
    lsl w7, w4, #2                  // w7 = w4 * 4
    add x8, x5, x6                  // Dirección de array[w3]
    add x9, x5, x7                  // Dirección de array[w4]

    // Cargar los valores de array[w3] y array[w4]
    ldr w10, [x8]                   // w10 = array[w3]
    ldr w11, [x9]                   // w11 = array[w4]

    // Comparar los dos valores
    cmp w11, w10
    bge inner_loop                  // Si array[w4] >= array[w3], continuamos buscando

    // Actualizar el índice mínimo a w4
    mov w3, w4

    b inner_loop                    // Repetir el bucle interior

inner_done:
    // Intercambiar array[w2] con array[w3] si es necesario
    cmp w3, w2
    beq no_swap_outer               // Si el mínimo está en la posición correcta, no intercambiar

    // Calcular direcciones de array[w2] y array[w3] para el intercambio
    ldr x5, =array
    lsl w6, w2, #2                  // w6 = w2 * 4
    lsl w7, w3, #2                  // w7 = w3 * 4
    add x8, x5, x6                  // Dirección de array[w2]
    add x9, x5, x7                  // Dirección de array[w3]

    // Intercambiar los valores
    ldr w10, [x8]                   // w10 = array[w2]
    ldr w11, [x9]                   // w11 = array[w3]
    str w11, [x8]                   // array[w2] = array[w3]
    str w10, [x9]                   // array[w3] = array[w2]

no_swap_outer:
    add w2, w2, #1                  // Incrementar el índice del bucle externo
    b outer_loop                    // Repetir el bucle externo

end_sort:
    // Mostrar el mensaje de array ordenado
    mov x0, #1                      // Descriptor de archivo para STDOUT
    ldr x1, =sortedMsg              // Dirección del mensaje "Array ordenado:\n"
    mov x2, #16                     // Longitud del mensaje
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    // Imprimir los elementos del array ordenado
    mov w12, #0                     // Inicializar índice en 0

print_array:
    ldr x3, =array                  // Dirección base del array
    lsl w13, w12, #2                // Desplazamiento de w12 (w13 = w12 * 4 bytes por palabra)
    add x3, x3, x13                 // Dirección de array[w12]
    ldr w0, [x3]                    // Cargar el valor en w0

    // Convertir el número a texto (para impresión) llamando a la función print_num
    bl print_num

    // Imprimir una nueva línea
    mov x0, #1                      // Descriptor de archivo para STDOUT
    ldr x1, =newline                // Dirección de la nueva línea
    mov x2, #1                      // Longitud de la nueva línea
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    add w12, w12, #1                // Incrementar índice
    ldr x1, =length                 // Dirección de la longitud
    ldr w1, [x1]                    // Leer la longitud original del array
    cmp w12, w1                     // Comparar índice con la longitud del array
    blt print_array                 // Repetir si aún hay elementos

    // Terminar el programa
    mov x8, #93                     // Syscall para 'exit' (93)
    svc #0                          // Ejecutar syscall

// Función print_num: convierte un número en w0 a una cadena y lo imprime
print_num:
    // Aquí puedes implementar un procedimiento simple para convertir el número en w0 a ASCII.
    // Por simplicidad, asume que w0 contiene un solo dígito para este ejemplo.

    add w0, w0, '0'                 // Convertir el número a su equivalente ASCII
    mov x1, sp                      // Usar la pila para el buffer temporal
    strb w0, [x1, #-1]!             // Guardar el carácter en la pila

    mov x0, #1                      // Descriptor de archivo para STDOUT
    mov x2, #1                      // Longitud del número convertido
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    ret                             // Retornar de la función

