////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 25
//Contar vocales y consonantes	
//Análisis de cadenas	
//Análisis de textos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        string texto = "Hola Mundo!";

        (int vocales, int consonantes) = ContarVocalesYConsonantes(texto);

        Console.WriteLine($"Vocales: {vocales}");
        Console.WriteLine($"Consonantes: {consonantes}");
    }

    static (int, int) ContarVocalesYConsonantes(string texto)
    {
        int contadorVocales = 0;
        int contadorConsonantes = 0;

        foreach (char c in texto.ToLower()) // Convertimos a minúsculas para simplificar la comparación
        {
            if (char.IsLetter(c)) // Solo consideramos letras (ignoramos números, espacios, etc.)
            {
                if ("aeiouáéíóú".Contains(c)) // Comprobamos si es una vocal (incluyendo acentuadas)
                {
                    contadorVocales++;
                }
                else // Si es una letra pero no una vocal, entonces es consonante
                {
                    contadorConsonantes++;
                }
            }
        }

        return (contadorVocales, contadorConsonantes);
    }
}

*/

//C
#include <stdio.h>
/*
// Declaración de la función ensambladora
extern void count_vowels_consonants(const char *str, int *vowels, int *consonants);

int main() {
    const char *text = "Hello, World!";
    int vowels = 0;
    int consonants = 0;

    // Llamar a la función ensambladora para contar vocales y consonantes
    count_vowels_consonants(text, &vowels, &consonants);

    // Imprimir los resultados
    printf("Vocales: %d\n", vowels);
    printf("Consonantes: %d\n", consonants);

    return 0;
}
*/
//ARM64
.global count_vowels_consonants  // Hacer la función accesible desde C

.text
count_vowels_consonants:
    // Entradas: 
    //   x0 = dirección de la cadena (const char *str)
    //   x1 = dirección de la variable de vocales (int *vowels)
    //   x2 = dirección de la variable de consonantes (int *consonants)

    mov x3, #0  // Inicializar contador de vocales en 0
    mov x4, #0  // Inicializar contador de consonantes en 0

loop:
    ldrb w5, [x0], #1  // Cargar un byte de la cadena (carácter)
    cbz w5, end_loop    // Si el carácter es null terminator (0), salir del bucle

    // Verificar si el carácter es una vocal (en minúscula o mayúscula)
    cmp w5, #'a'  // Comparar con 'a'
    beq count_vowel
    cmp w5, #'e'  // Comparar con 'e'
    beq count_vowel
    cmp w5, #'i'  // Comparar con 'i'
    beq count_vowel
    cmp w5, #'o'  // Comparar con 'o'
    beq count_vowel
    cmp w5, #'u'  // Comparar con 'u'
    beq count_vowel
    cmp w5, #'A'  // Comparar con 'A'
    beq count_vowel
    cmp w5, #'E'  // Comparar con 'E'
    beq count_vowel
    cmp w5, #'I'  // Comparar con 'I'
    beq count_vowel
    cmp w5, #'O'  // Comparar con 'O'
    beq count_vowel
    cmp w5, #'U'  // Comparar con 'U'
    beq count_vowel

    // Si no es vocal, verificar si es consonante (letras del alfabeto)
    cmp w5, #'a'  // Si es una letra minúscula
    blt skip_consonant
    cmp w5, #'z'
    bgt skip_consonant
    add x4, x4, #1  // Incrementar contador de consonantes
    b loop

count_vowel:
    add x3, x3, #1  // Incrementar contador de vocales
    b loop

skip_consonant:
    b loop

end_loop:
    // Guardar los resultados en las direcciones de memoria pasadas
    str w3, [x1]   // Guardar el número de vocales
    str w4, [x2]   // Guardar el número de consonantes
    ret
    
//***************************************

Compilar el ensamblador:
as -o 25.o 25.s

Compilar el código en C:

gcc -c -o 25_c.o 25.c

Enlazar ambos archivos (C y ensamblador):

gcc -o 25_program 25_c.o 25.o

Ejecutar el programa:

./25_program

en gdb 
gdb -q ./25_program


