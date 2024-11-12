////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 40
//Convertir binario a decimal	
//Conversión, bucles	
//Conversión de datos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main(string[] args)
    {
        Console.Write("Ingrese un número binario: ");
        string binario = Console.ReadLine();

        int decimalValue = BinarioADecimal(binario);
        Console.WriteLine($"El número binario {binario} en decimal es: {decimalValue}");
    }

    static int BinarioADecimal(string binario)
    {
        int decimalValue = 0;
        int longitud = binario.Length;

        for (int i = 0; i < longitud; i++)
        {
            // Convierte el carácter binario ('0' o '1') a entero
            if (binario[i] == '1')
            {
                decimalValue += (int)Math.Pow(2, longitud - i - 1);
            }
        }

        return decimalValue;
    }
}

*/

//main.c
/************************************
#include <stdio.h>

// Declaración de la función en Assembly que convierte binario a decimal
extern int binary_to_decimal(const char *binary);

int main() {
    char bin_input[32];

    // Pedir al usuario que ingrese un número binario
    printf("Ingrese un número binario: ");
    scanf("%s", bin_input);

    // Llamar a la función en Assembly para convertir el binario a decimal
    int decimal = binary_to_decimal(bin_input);

    // Imprimir el resultado
    printf("El número decimal es: %d\n", decimal);

    return 0;
}

/*****************************************************************


//ARM64   —-------------binary_to_decimal.s
//***************************************************
.section .text
.global binary_to_decimal

binary_to_decimal:
    // x0 = dirección de la cadena (input binario)
    mov x9, #0              // Inicializar el acumulador (resultado decimal) en x9
    mov x10, #0             // Índice para recorrer la cadena

loop:
    ldrb w8, [x0, x10]      // Leer el siguiente carácter (byte) en w8
    cmp w8, #0              // Comparar con el carácter nulo ('\0')
    beq end_loop            // Si es nulo, terminamos el ciclo

    // Multiplicar el acumulador por 2 (desplazamiento a la izquierda)
    lsl x9, x9, #1

    // Convertir el carácter ('0' o '1') al valor numérico y sumarlo
    sub w8, w8, '0'         // Convertir carácter ASCII a número (0 o 1)
    add x9, x9, x8          // Sumar el bit al resultado acumulado

    // Incrementar el índice y continuar el ciclo
    add x10, x10, #1
    b loop

end_loop:
    // Devolver el resultado en x0
    mov x0, x9
    ret

