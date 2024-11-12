////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 37
//Implementar una pila usando un arreglo	
//Estructuras de datos	
//Manejo de datos y memoria
///////////////////////////////////////////////

//C#
/*

*/


//Codigo en C
#include <stdio.h>

// Declaraciones externas para las funciones en ensamblador
extern void init_pila();
extern long push(long value);
extern long pop();
extern int is_empty();

int main() {
    int option;
    long value, result;

    // Inicializar la pila
    init_pila();

    do {
        printf("\nMenu:\n");
        printf("1. Apilar\n");
        printf("2. Desapilar\n");
        printf("3. Verificar si la pila está vacía\n");
        printf("0. Salir\n");
        printf("Seleccione una opción: ");
        scanf("%d", &option);

        switch (option) {
            case 1:
                printf("Ingrese un valor a apilar: ");
                scanf("%ld", &value);
                result = push(value);
                if (result == -1) {
                    printf("Error: Desbordamiento de pila.\n");
                } else {
                    printf("%ld apilado.\n", value);
                }
                break;

            case 2:
                result = pop();
                if (result == -1) {
                    printf("Error: Pila vacía.\n");
                } else {
                    printf("Desapilado: %ld\n", result);
                }
                break;

            case 3:
                if (is_empty()) {
                    printf("La pila está vacía.\n");
                } else {
                    printf("La pila no está vacía.\n");
                }
                break;

            case 0:
                printf("Saliendo...\n");
                break;

            default:
                printf("Opción no válida.\n");
                break;
        }
    } while (option != 0);

    return 0;
}


//ARM64
.data
    .align 3
    stack_array: .skip 800      // Espacio para 100 elementos de 8 bytes
    stack_count: .word 0        // Contador de elementos
    .equ MAX_SIZE, 100         // Tamaño máximo de la pila

.text
.align 2
.global init_pila
.global push
.global pop
.global is_empty

// Función para inicializar la pila
init_pila:
    stp     x29, x30, [sp, -16]!   // Guardar el frame pointer y link register
    mov     x29, sp
    
    adrp    x0, stack_count        // Cargar dirección de stack_count
    add     x0, x0, :lo12:stack_count
    str     wzr, [x0]              // Inicializar el contador a 0
    
    ldp     x29, x30, [sp], 16
    ret

// Función para apilar (push)
push:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si hay espacio
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w2, [x1]               // Cargar contador actual
    cmp     w2, MAX_SIZE
    b.ge    push_overflow
    
    // Calcular dirección donde guardar
    adrp    x3, stack_array
    add     x3, x3, :lo12:stack_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    str     x0, [x3, x4]           // Guardar valor
    
    // Incrementar contador
    add     w2, w2, #1
    str     w2, [x1]
    
    mov     x0, #0                 // Retorno exitoso
    ldp     x29, x30, [sp], 16
    ret

push_overflow:
    mov     x0, #-1                // Código de error
    ldp     x29, x30, [sp], 16
    ret

// Función para desapilar (pop)
pop:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Verificar si hay elementos
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w2, [x1]
    cbz     w2, pop_empty
    
    // Calcular dirección del elemento a extraer
    sub     w2, w2, #1             // Decrementar contador
    str     w2, [x1]               // Guardar nuevo contador
    
    adrp    x3, stack_array
    add     x3, x3, :lo12:stack_array
    lsl     x4, x2, #3             // Multiplicar índice por 8
    ldr     x0, [x3, x4]           // Cargar valor
    
    ldp     x29, x30, [sp], 16
    ret

pop_empty:
    mov     x0, #-1                // Código de error
    ldp     x29, x30, [sp], 16
    ret

// Función para verificar si está vacía
is_empty:
    adrp    x1, stack_count
    add     x1, x1, :lo12:stack_count
    ldr     w0, [x1]
    cmp     w0, #0
    cset    w0, eq                 // Establecer 1 si está vacía, 0 si no
    ret

