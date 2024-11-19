////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 43
//Calculadora simple (Suma, Resta, Multiplicación, División)	
//Aritmética y flujo de control	
//Herramientas matemática
///////////////////////////////////////////////

//C#
/*

*/

//C
//codigo en c main.c

/*
#include <stdio.h>

// Declaración de las funciones en ensamblador
extern int Sumar(int a, int b);
extern int Restar(int a, int b);
extern int Multiplicar(int a, int b);
extern int Dividir(int a, int b);

int main() {
    int num1, num2, opcion, resultado;

    // Solicitar al usuario los dos números
    printf("Introduce el primer número: ");
    scanf("%d", &num1);
    
    printf("Introduce el segundo número: ");
    scanf("%d", &num2);

    // Mostrar las opciones para seleccionar la operación
    printf("Selecciona la operación:\n");
    printf("1 - Suma\n");
    printf("2 - Resta\n");
    printf("3 - Multiplicación\n");
    printf("4 - División\n");
    printf("Ingrese su opción: ");
    scanf("%d", &opcion);

    // Realizar la operación correspondiente según la opción seleccionada
    switch (opcion) {
        case 1:
            resultado = Sumar(num1, num2); // Suma
            printf("Resultado: %d + %d = %d\n", num1, num2, resultado);
            break;
        case 2:
            resultado = Restar(num1, num2); // Resta
            printf("Resultado: %d - %d = %d\n", num1, num2, resultado);
            break;
        case 3:
            resultado = Multiplicar(num1, num2); // Multiplicación
            printf("Resultado: %d * %d = %d\n", num1, num2, resultado);
            break;
        case 4:
            if (num2 != 0) { // Verificar división por cero
                resultado = Dividir(num1, num2); // División
                printf("Resultado: %d / %d = %d\n", num1, num2, resultado);
            } else {
                printf("Error: División por cero.\n");
            }
            break;
        default:
            printf("Opción inválida.\n");
            break;
    }

    return 0;
}

*/

//ARM64
//codigo en ARm64 main.s

.global Sumar
.global Restar
.global Multiplicar
.global Dividir

// Suma: retorna a + b
Sumar:
    add w0, w0, w1       // Sumar el primer y segundo argumento en w0
    ret

// Resta: retorna a - b
Restar:
    sub w0, w0, w1       // Restar el segundo argumento de w0
    ret

// Multiplicación: retorna a * b
Multiplicar:
    mul w0, w0, w1       // Multiplicar w0 * w1 y almacenar en w0
    ret

// División: retorna a / b (b debe ser distinto de 0)
Dividir:
    cbz w1, div_by_zero  // Comprobar si el divisor es 0
    sdiv w0, w0, w1      // Dividir w0 / w1 y almacenar en w0
    ret
div_by_zero:
    mov w0, 0            // Si el divisor es 0, retornar 0
    ret

//*********************************

aarch64-linux-gnu-as -o main.o main.s
aarch64-linux-gnu-gcc -c -o main_c.o main.c
aarch64-linux-gnu-gcc -o my_program main_c.o main.o
./my_program
