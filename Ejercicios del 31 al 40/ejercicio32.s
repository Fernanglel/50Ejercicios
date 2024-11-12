////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 32
//Potencia (x^n)	
//Recursión/bucles	
//Cálculos matemáticos
///////////////////////////////////////////////

//C#
/*

*/



//c
/*

#include <stdio.h>

// Declaración de la función ensambladora
extern long potencia(long x, long n);

int main() {
    long x, n;

    // Pedir los valores de x y n al usuario
    printf("Ingrese el valor de la base (x): ");
    scanf("%ld", &x);
    printf("Ingrese el valor del exponente (n): ");
    scanf("%ld", &n);

    if (n < 0) {
        printf("Error: El exponente debe ser un número entero no negativo.\n");
        return 1;
    }

    // Llamada a la función ensambladora
    long resultado = potencia(x, n);

    // Imprimir el resultado
    printf("El resultado de %ld^%ld es: %ld\n", x, n, resultado);

    return 0;
}

*/

//ARM64

.global potencia
.type potencia, %function

// Función potencia(x, n)
potencia:
    // Entrada: x en X0, n en X1
    // Salida: resultado en X0 (x^n)

    mov x2, #1          // Inicializamos el resultado en 1 (X2 = resultado acumulado)

potencia_loop:
    cbz x1, fin         // Si n (X1) es 0, salimos del bucle
    mul x2, x2, x0      // resultado *= x (X2 = X2 * X0)
    sub x1, x1, #1      // n -= 1
    b potencia_loop     // Repetimos el ciclo

fin:
    mov x0, x2          // Colocamos el resultado en X0 para retornar
    ret                 // Retornar

