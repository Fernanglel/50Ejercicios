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
using System;

class Cola
{
    private int[] elementos;
    private int frente;     // Índice del elemento en el frente de la cola
    private int fin;        // Índice donde se inserta el próximo elemento
    private int tamaño;
    private int capacidad;

    // Constructor para inicializar la cola con una capacidad dada
    public Cola(int tamaño)
    {
        capacidad = tamaño;
        elementos = new int[capacidad];
        frente = 0;
        fin = -1;
        this.tamaño = 0;
    }

    // Método para insertar un elemento en la cola (Enqueue)
    public void Enqueue(int elemento)
    {
        if (IsFull())
        {
            Console.WriteLine("Error: La cola está llena.");
            return;
        }
        fin = (fin + 1) % capacidad; // Mover el fin de forma circular
        elementos[fin] = elemento;
        tamaño++;
        Console.WriteLine($"Elemento {elemento} insertado en la cola.");
    }

    // Método para eliminar y devolver el elemento del frente de la cola (Dequeue)
    public int Dequeue()
    {
        if (IsEmpty())
        {
            Console.WriteLine("Error: La cola está vacía.");
            return -1; // Valor indicativo si la cola está vacía
        }
        int elemento = elementos[frente];
        frente = (frente + 1) % capacidad; // Mover el frente de forma circular
        tamaño--;
        return elemento;
    }

    // Método para devolver el elemento del frente de la cola sin eliminarlo (Peek)
    public int Peek()
    {
        if (IsEmpty())
        {
            Console.WriteLine("Error: La cola está vacía.");
            return -1;
        }
        return elementos[frente];
    }

    // Método para verificar si la cola está vacía
    public bool IsEmpty()
    {
        return tamaño == 0;
    }

    // Método para verificar si la cola está llena
    public bool IsFull()
    {
        return tamaño == capacidad;
    }

    // Método para obtener el número de elementos en la cola
    public int Tamaño()
    {
        return tamaño;
    }
}

class Program
{
    static void Main(string[] args)
    {
        // Crear una cola con capacidad de 5 elementos
        Cola cola = new Cola(5);

        // Probar las operaciones de la cola
        cola.Enqueue(10);
        cola.Enqueue(20);
        cola.Enqueue(30);
        cola.Enqueue(40);
        cola.Enqueue(50);
        cola.Enqueue(60); // Intentar insertar cuando la cola está llena

        Console.WriteLine($"Elemento del frente (Peek): {cola.Peek()}");

        Console.WriteLine($"Elemento removido (Dequeue): {cola.Dequeue()}");
        Console.WriteLine($"Elemento del frente (Peek): {cola.Peek()}");

        cola.Enqueue(60);
        Console.WriteLine($"Tamaño actual de la cola: {cola.Tamaño()}");

        // Vaciar la cola
        while (!cola.IsEmpty())
        {
            Console.WriteLine($"Elemento removido (Dequeue): {cola.Dequeue()}");
        }
    }
}

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

