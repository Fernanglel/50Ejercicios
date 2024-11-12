////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 38
//Implementar una cola usando un arreglo	
//Estructuras de datos	
//Manejo de datos y memoria
///////////////////////////////////////////////

//C#
/*

*/

//codigo en c —------ main.c
#include <stdio.h>

// Declaración de las funciones implementadas en assembly
extern void enqueue(int value);
extern int dequeue();
extern int is_empty();
extern int is_full();

// Definiciones de la cola
#define SIZE 5
int queue[SIZE];
int front = 0;
int rear = -1;
int count = 0;

// Función principal
int main() {
    int option, value;

    while (1) {
        printf("\nOperaciones de la Cola:\n");
        printf("1. Enqueue\n");
        printf("2. Dequeue\n");
        printf("3. Verificar si la cola está vacía\n");
        printf("4. Verificar si la cola está llena\n");
        printf("5. Salir\n");
        printf("Seleccione una opción: ");
        scanf("%d", &option);

        switch (option) {
            case 1:
                if (!is_full()) {
                    printf("Ingrese un valor para insertar: ");
                    scanf("%d", &value);
                    enqueue(value);
                } else {
                    printf("La cola está llena.\n");
                }
                break;

            case 2:
                if (!is_empty()) {
                    value = dequeue();
                    printf("Elemento eliminado: %d\n", value);
                } else {
                    printf("La cola está vacía.\n");
                }
                break;

            case 3:
                printf("¿Cola vacía? %s\n", is_empty() ? "Sí" : "No");
                break;

            case 4:
                printf("¿Cola llena? %s\n", is_full() ? "Sí" : "No");
                break;

            case 5:
                return 0;

            default:
                printf("Opción no válida.\n");
                break;
        }
    }
    return 0;
}








//codigo en ARM64

.global find_second_largest
find_second_largest:
    // Entradas: 
    // x0 = puntero al arreglo
    // x1 = tamaño del arreglo

    cmp x1, #2                // Si el tamaño es menor que 2, no hay segundo más grande
    blt end                   // Salir si el tamaño es menor que 2

    ldr w2, [x0]              // Primer elemento (maximo)
    ldr w3, [x0, #4]          // Segundo elemento (segundo máximo)
    cmp w2, w3                // Verificar si el primer elemento es mayor que el segundo
    bge init_max_second       // Si el primer elemento es mayor o igual, inicializar segundo máximo
    mov w2, w3                // Si no, el segundo máximo es el primero
    mov w3, w2                // Segundo máximo es el primero ahora

init_max_second:
    // Recorre el arreglo
    mov x4, #2                // Índice a partir de 2 (ya tenemos los dos primeros elementos)
loop:
    cmp x4, x1                // Verificar si hemos recorrido todo el arreglo
    bge end                   // Salir si hemos llegado al final

    ldr w5, [x0, x4, lsl #2]  // Cargar el siguiente elemento en el arreglo
    cmp w5, w2                // Comparar con el máximo
    bgt update_max            // Si el elemento es mayor que el máximo, actualizar el máximo

    cmp w5, w3                // Comparar con el segundo máximo
    bgt update_second         // Si es mayor que el segundo máximo, actualizar el segundo máximo
    b loop

update_max:
    mov w3, w2                // El segundo máximo ahora es el máximo actual
    mov w2, w5                // Actualizar el máximo con el nuevo valor
    b loop

update_second:
    mov w3, w5                // Actualizar el segundo máximo
    b loop

end:
    mov x0, w3                // El segundo máximo es el resultado
    ret

