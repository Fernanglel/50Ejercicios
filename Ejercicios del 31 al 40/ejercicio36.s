////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 36
//Encontrar el segundo elemento más grande	
//Comparación en arreglos	
//Análisis de datos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main(string[] args)
    {
        int[] numeros = { 5, 12, 3, 9, 21, 19 };

        if (numeros.Length < 2)
        {
            Console.WriteLine("El arreglo no tiene suficientes elementos.");
            return;
        }

        int max1 = int.MinValue, max2 = int.MinValue;

        foreach (int num in numeros)
        {
            if (num > max1)
            {
                max2 = max1;  // Actualizar el segundo mayor
                max1 = num;   // Actualizar el mayor
            }
            else if (num > max2 && num != max1)
            {
                max2 = num;  // Actualizar el segundo mayor si es menor que max1
            }
        }

        if (max2 == int.MinValue)
        {
            Console.WriteLine("No hay un segundo elemento más grande.");
        }
        else
        {
            Console.WriteLine($"El segundo elemento más grande es: {max2}");
        }
    }
}

*/


//ARM64
