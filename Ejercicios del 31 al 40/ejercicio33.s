////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 33
//Suma de elementos en un arreglo	
//Recorrido de arreglos	
//Estadísticas simples
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main(string[] args)
    {
        // Ejemplo de un arreglo de enteros
        int[] numeros = { 2, 4, 6, 8, 10 };
        int suma = 0;

        // Sumar todos los elementos usando un bucle 'for'
        for (int i = 0; i < numeros.Length; i++)
        {
            suma += numeros[i];
        }

        Console.WriteLine($"La suma de los elementos es: {suma}");
    }
}

*/


//ARM64
.section .data
arr:    .word 5, 10, 15, 20, 25    // Elementos del arreglo (5, 10, 15, 20, 25)
length: .word 5                    // Longitud del arreglo
buffer: .space 20                  // Espacio para almacenar el texto del número

.section .text
.global _start

_start:
    // Inicialización de los registros
    ldr x1, =arr            // Cargar la dirección del arreglo en x1
    ldr w2, =5              // Cargar la longitud del arreglo en w2 (5 elementos)
    mov x3, 0               // Registro para almacenar la suma (inicializado en 0)

loop:
    // Comprobar si hemos terminado de recorrer el arreglo
    cmp w2, 0               // Comparar w2 (contador) con 0
    beq end_sum             // Si w2 es 0, salir del bucle

    // Sumar el elemento actual al total
    ldr w4, [x1], #4        // Cargar el siguiente elemento del arreglo en w4 y avanzar x1
    add x3, x3, x4          // Sumar w4 a x3

    // Decrementar el contador y repetir
    sub w2, w2, 1           // Decrementar el contador
    b loop                  // Repetir el bucle

end_sum:
    // Convertir la suma en x3 a texto en buffer
    mov x0, x3              // Pasar la suma al primer argumento para la conversión
    ldr x1, =buffer         // Dirección del buffer para almacenar el texto
    bl int_to_str           // Llamada a la función de conversión

    // Imprimir el resultado
    mov x0, 1               // File descriptor 1 (stdout)
    ldr x1, =buffer         // Dirección del buffer con el texto de la suma
    mov x2, 20              // Longitud máxima a imprimir
    mov x8, 64              // Número de syscall para escribir (write)
    svc 0                   // Llamada al sistema

    // Salida del programa
    mov x8, 93              // Código de salida para salir del programa
    svc 0

// Función para convertir un número entero en texto
int_to_str:
    mov x2, x1              // Guardar la posición de inicio del buffer en x2
    add x1, x1, 20          // Apuntar al final del buffer
    mov w3, 10              // Divisor para obtener dígitos decimales

convert_loop:
    udiv x4, x0, x3         // Dividir x0 entre 10 (quedando el cociente en x4)
    msub x5, x4, x3, x0     // Obtener el residuo de la división en x5
    add x5, x5, '0'         // Convertir el dígito en carácter
    sub x1, x1, 1           // Retroceder en el buffer
    strb w5, [x1]           // Almacenar el carácter en el buffer
    mov x0, x4              // Actualizar x0 con el cociente
    cbz x0, end_convert     // Si x0 es 0, terminamos la conversión
    b convert_loop          // Repetir el bucle

end_convert:
    mov x0, x2              // Restaurar la posición inicial del buffer
    ret                     // Regresar al llamador
