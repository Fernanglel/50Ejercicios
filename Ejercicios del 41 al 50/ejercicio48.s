////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 48
//Medir el tiempo de ejecución de una función	
//Operaciones con temporizadores	
//Optimización de código
///////////////////////////////////////////////

//C#
/*
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        Stopwatch stopwatch = new Stopwatch();

        // Medir el tiempo de la primera función
        stopwatch.Start();
        Func1();
        stopwatch.Stop();
        Console.WriteLine($"Tiempo de Func1: {stopwatch.ElapsedMilliseconds} ms");
        stopwatch.Reset();

        // Medir el tiempo de la segunda función
        stopwatch.Start();
        Func2();
        stopwatch.Stop();
        Console.WriteLine($"Tiempo de Func2: {stopwatch.ElapsedMilliseconds} ms");
    }

    static void Func1()
    {
        System.Threading.Thread.Sleep(1500); // Simula trabajo
    }

    static void Func2()
    {
        System.Threading.Thread.Sleep(500); // Simula trabajo
    }
}

*/

//c
/*
#include <stdio.h>
#include <stdint.h>

extern void calcular_mcm();  // Declaración de la función en ensamblador
extern uint64_t obtener_tiempo();  // Declaración de la función para obtener el tiempo de ejecución

int main() {
    uint64_t tiempo_inicial, tiempo_final, tiempo_total;

    // Obtener el tiempo inicial
    tiempo_inicial = obtener_tiempo();

    // Llamada a la función de cálculo del MCM
    calcular_mcm();

    // Obtener el tiempo final
    tiempo_final = obtener_tiempo();

    // Calcular el tiempo total de ejecución
    tiempo_total = tiempo_final - tiempo_inicial;

    printf("El tiempo de ejecución en ciclos es: %lu\n", tiempo_total);

    return 0;
}

*/
//ARM64
.global calcular_mcm
.global obtener_tiempo

// Función para obtener el tiempo de ejecución (contador de ciclos)
obtener_tiempo:
    mrs x0, CNTVCT_EL0   // Leer el contador de ciclos en x0
    ret

// Función de cálculo del MCM
calcular_mcm:
    mov x0, 15            // Primer número
    mov x1, 20            // Segundo número
    // Algoritmo para calcular el MCM (este es un ejemplo sencillo)
    mov x2, 0             // Limpiar el registro
    ret
    
//******************************************
Compilación del archivo ensamblador:

as -o 48.o 48.s

Compilación del archivo C:

gcc -c 48.c -o 48c.o

Enlace de ambos archivos para crear el ejecutable:

gcc 48.o 48c.o -o 48

Ejecución del programa:

./48
