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
using System;

class Pila
{
    private int[] elementos;
    private int tope; // Índice del elemento en la parte superior de la pila
    private int capacidad;

    // Constructor para inicializar la pila con una capacidad dada
    public Pila(int tamaño)
    {
        capacidad = tamaño;
        elementos = new int[capacidad];
        tope = -1; // Inicialmente la pila está vacía
    }

    // Método para insertar un elemento en la pila (Push)
    public void Push(int elemento)
    {
        if (IsFull())
        {
            Console.WriteLine("Error: La pila está llena.");
            return;
        }
        elementos[++tope] = elemento;
        Console.WriteLine($"Elemento {elemento} insertado en la pila.");
    }

    // Método para eliminar y devolver el elemento superior de la pila (Pop)
    public int Pop()
    {
        if (IsEmpty())
        {
            Console.WriteLine("Error: La pila está vacía.");
            return -1; // Valor indicativo si la pila está vacía
        }
        return elementos[tope--];
    }

    // Método para devolver el elemento superior de la pila sin eliminarlo (Peek)
    public int Peek()
    {
        if (IsEmpty())
        {
            Console.WriteLine("Error: La pila está vacía.");
            return -1;
        }
        return elementos[tope];
    }

    // Método para verificar si la pila está vacía
    public bool IsEmpty()
    {
        return tope == -1;
    }

    // Método para verificar si la pila está llena
    public bool IsFull()
    {
        return tope == capacidad - 1;
    }

    // Método para obtener el número de elementos en la pila
    public int Tamaño()
    {
        return tope + 1;
    }
}

class Program
{
    static void Main(string[] args)
    {
        // Crear una pila con capacidad de 5 elementos
        Pila pila = new Pila(5);

        // Probar las operaciones de la pila
        pila.Push(10);
        pila.Push(20);
        pila.Push(30);

        Console.WriteLine($"Elemento superior (Peek): {pila.Peek()}");

        Console.WriteLine($"Elemento removido (Pop): {pila.Pop()}");
        Console.WriteLine($"Elemento superior (Peek): {pila.Peek()}");

        pila.Push(40);
        pila.Push(50);
        pila.Push(60); // Intentar insertar cuando la pila está llena

        Console.WriteLine($"Tamaño actual de la pila: {pila.Tamaño()}");

        // Vaciar la pila
        while (!pila.IsEmpty())
        {
            Console.WriteLine($"Elemento removido (Pop): {pila.Pop()}");
        }
    }
}

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

