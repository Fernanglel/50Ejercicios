////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 20
//Multiplicación de matrices	
//Bucles anidados, operaciones en memoria	
//Modelado matemático, gráficos por computadora
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    // Función para multiplicar dos matrices
    static int[,] MultiplicarMatrices(int[,] A, int[,] B)
    {
        // Obtener el número de filas de A y el número de columnas de B
        int filasA = A.GetLength(0);
        int columnasA = A.GetLength(1);
        int filasB = B.GetLength(0);
        int columnasB = B.GetLength(1);

        // Verificar si la multiplicación es posible: columnas de A == filas de B
        if (columnasA != filasB)
        {
            throw new InvalidOperationException("El número de columnas de A debe ser igual al número de filas de B para poder multiplicarlas.");
        }

        // Crear la matriz resultado C de tamaño filasA x columnasB
        int[,] C = new int[filasA, columnasB];

        // Multiplicar A por B y almacenar el resultado en C
        for (int i = 0; i < filasA; i++)
        {
            for (int j = 0; j < columnasB; j++)
            {
                for (int k = 0; k < columnasA; k++)
                {
                    C[i, j] += A[i, k] * B[k, j];
                }
            }
        }

        return C;
    }

    // Función para imprimir una matriz
    static void ImprimirMatriz(int[,] matriz)
    {
        int filas = matriz.GetLength(0);
        int columnas = matriz.GetLength(1);

        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
            {
                Console.Write(matriz[i, j] + " ");
            }
            Console.WriteLine();
        }
    }

    static void Main(string[] args)
    {
        // Definir las matrices A y B
        int[,] A = {
            { 1, 2 },
            { 3, 4 }
        };

        int[,] B = {
            { 5, 6 },
            { 7, 8 }
        };

        Console.WriteLine("Matriz A:");
        ImprimirMatriz(A);

        Console.WriteLine("Matriz B:");
        ImprimirMatriz(B);

        try
        {
            // Multiplicar las matrices A y B
            int[,] C = MultiplicarMatrices(A, B);

            Console.WriteLine("Matriz C (A * B):");
            ImprimirMatriz(C);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }
}
    
*/


//ARM64
.data
    // Primera matriz 3x3
    matrixA:     .quad   1, 2, 3
                 .quad   4, 5, 6
                 .quad   7, 8, 9

    // Segunda matriz 3x3
    matrixB:     .quad   9, 8, 7
                 .quad   6, 5, 4
                 .quad   3, 2, 1

    // Matriz resultado 3x3
    result:      .zero   72            // 9 elementos * 8 bytes

    // Mensajes para imprimir
    msgA:        .string "Matriz A:\n"
    msgB:        .string "Matriz B:\n"
    msgR:        .string "Matriz Resultado:\n"
    format:      .string "%ld "         // Formato para imprimir números de 64 bits
    newline:     .string "\n"

.text
.global main
.align 2

main:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Imprimir mensaje para matriz A
    adrp    x0, msgA
    add     x0, x0, :lo12:msgA
    bl      printf

    // Imprimir matriz A
    adrp    x0, matrixA
    add     x0, x0, :lo12:matrixA
    bl      print_matrix

    // Imprimir mensaje para matriz B
    adrp    x0, msgB
    add     x0, x0, :lo12:msgB
    bl      printf

    // Imprimir matriz B
    adrp    x0, matrixB
    add     x0, x0, :lo12:matrixB
    bl      print_matrix

    // Realizar multiplicación
    adrp    x0, matrixA
    add     x0, x0, :lo12:matrixA
    adrp    x1, matrixB
    add     x1, x1, :lo12:matrixB
    adrp    x2, result
    add     x2, x2, :lo12:result
    bl      matrix_multiply

    // Imprimir mensaje para matriz resultado
    adrp    x0, msgR
    add     x0, x0, :lo12:msgR
    bl      printf

    // Imprimir matriz resultado
    adrp    x0, result
    add     x0, x0, :lo12:result
    bl      print_matrix

    ldp     x29, x30, [sp], #16
    mov     x0, #0
    ret

// Función para multiplicar matrices
matrix_multiply:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    mov     x3, #0                    // i = 0 (fila)

outer_loop:
    cmp     x3, #3                    // Comparar i con tamaño
    b.ge    end_outer
    mov     x4, #0                    // j = 0 (columna)

middle_loop:
    cmp     x4, #3                    // Comparar j con tamaño
    b.ge    end_middle
    mov     x5, #0                    // k = 0 (suma)
    mov     x6, #0                    // sum = 0

inner_loop:
    cmp     x5, #3                    // Comparar k con tamaño
    b.ge    end_inner

    // Calcular índices
    mov     x7, x3                    // i
    lsl     x7, x7, #4                // i * 16 (i * 8 * 2)
    add     x7, x7, x5, lsl #3        // + k * 8
    ldr     x8, [x0, x7]              // Cargar A[i][k]

    mov     x7, x5                    // k
    lsl     x7, x7, #4                // k * 16
    add     x7, x7, x4, lsl #3        // + j * 8
    ldr     x9, [x1, x7]              // Cargar B[k][j]

    // Multiplicar y sumar
    mul     x8, x8, x9                // A[i][k] * B[k][j]
    add     x6, x6, x8                // sum += multiplicación

    add     x5, x5, #1                // k++
    b       inner_loop

end_inner:
    // Guardar resultado
    mov     x7, x3                    // i
    lsl     x7, x7, #4                // i * 16
    add     x7, x7, x4, lsl #3        // + j * 8
    str     x6, [x2, x7]              // Guardar en result[i][j]

    add     x4, x4, #1                // j++
    b       middle_loop

end_middle:
    add     x3, x3, #1                // i++
    b       outer_loop

end_outer:
    ldp     x29, x30, [sp], #16
    ret

// Función para imprimir matriz
print_matrix:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    mov     x19, x0                    // Guardar dirección de la matriz

    mov     x20, #0                    // i = 0
print_outer:
    cmp     x20, #3
    b.ge    print_end
    mov     x21, #0                    // j = 0

print_inner:
    cmp     x21, #3
    b.ge    print_inner_end

    // Calcular índice y cargar valor
    mov     x22, x20                   // i
    lsl     x22, x22, #4               // i * 16
    add     x22, x22, x21, lsl #3      // + j * 8
    ldr     x1, [x19, x22]             // Cargar elemento

    // Imprimir valor
    adrp    x0, format
    add     x0, x0, :lo12:format
    bl      printf

    add     x21, x21, #1              // j++
    b       print_inner

print_inner_end:
    // Imprimir nueva línea
    adrp    x0, newline
    add     x0, x0, :lo12:newline
    bl      printf

    add     x20, x20, #1              // i++
    b       print_outer

print_end:
    ldp     x29, x30, [sp], #16
    ret

********************************************************
# Compilar y enlazar 
gcc -o mt mt.s
 # Ejecutar
 ./mt
