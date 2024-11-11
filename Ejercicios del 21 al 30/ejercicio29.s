////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 29
//Contar los bits activados en un número
//Operaciones bit a bit	
//Procesamiento de datos, compresión
//video - 
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        int num = 29;  // 29 en binario es 11101

        // Contar los bits activados utilizando la conversión a binario
        int cantidadBitsActivados = ContarBitsActivadosBinario(num);

        // Mostrar el resultado
        Console.WriteLine($"El número {num} tiene {cantidadBitsActivados} bits activados (en 1).");
    }

    // Método para contar los bits activados en un número utilizando la representación binaria
    static int ContarBitsActivadosBinario(int num)
    {
        string binario = Convert.ToString(num, 2);  // Convertir el número a binario
        int cuenta = 0;

        // Contar los '1' en la representación binaria
        foreach (char bit in binario)
        {
            if (bit == '1') cuenta++;
        }

        return cuenta;
    }
}

*/

//C
#include <stdio.h>

extern unsigned long count_set_bits(unsigned long num);

int main() {
    unsigned long num;
    
    // Solicitar al usuario que ingrese un número
    printf("Introduce un número: ");
    scanf("%lu", &num);  // Leer el número desde la entrada

    // Llamar a la función ensamblada para contar los bits activados
    printf("Número de bits activados en %lu es: %lu\n", num, count_set_bits(num));

    return 0;
}


//ARM64
.global count_set_bits
.type count_set_bits, %function

count_set_bits:
    mov     x1, x0          // Copiar el número a x1
    mov     x0, #0          // Inicializar el contador de bits activados a 0

count_loop:
    cmp     x1, #0          // Comprobar si el número es 0
    beq     end             // Si es 0, hemos terminado

    // Eliminar el bit más bajo activado (x1 = x1 & (x1 - 1))
    subs    x1, x1, #1      // x1 = x1 - 1
    and     x1, x1, x0      // x1 = x1 & x0

    // Incrementar el contador de bits activados
    add     x0, x0, #1      // Incrementar el contador de bits activados

    b       count_loop      // Repetir el bucle

end:
    ret
