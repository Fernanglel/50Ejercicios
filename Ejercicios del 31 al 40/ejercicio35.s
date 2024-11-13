////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 35
//Rotación de un arreglo (izquierda/derecha)	
//Manipulación de arreglos	
//Algoritmos de criptografía
///////////////////////////////////////////////

//Python
/*
def rotar_izquierda(arr, n):
    n = n % len(arr)  # Asegurarse de que 'n' no sea mayor que la longitud del arreglo
    return arr[n:] + arr[:n]

# Ejemplo de uso
arr = [1, 2, 3, 4, 5]
n = 2
resultado = rotar_izquierda(arr, n)
print(f"Rotación a la izquierda por {n} posiciones: {resultado}")

*/


//ARM64
.data
arreglo: .word 32145435, 5345, 12345, 6789, 10234  // Arreglo de ejemplo con 5 elementos
tamano: .word 5                                    // Tamaño del arreglo
msg_elemento: .string "%d\n"                       // Formato para imprimir cada elemento

.text
.global main
.align 2

.global _start

_start:
    // Llamar a la función main
    bl main   

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!   // Guardar el frame pointer y el link register
    mov     x29, sp

    // Preparar variables
    ldr     x1, =tamano             // Cargar la dirección de 'tamano' en x1
    ldr     w1, [x1]                // Cargar el valor de 'tamano' en w1 (32 bits)
    adrp    x2, arreglo             // Dirección base del arreglo
    add     x2, x2, :lo12:arreglo   // Dirección base del arreglo

    // Inicializar el máximo y segundo máximo
    ldr     w3, [x2], #4            // Cargar el primer elemento
    mov     w4, w3                  // El primer elemento es el máximo
    mov     w5, w3                  // El segundo máximo inicialmente es el primero

    // Bucle para recorrer el arreglo y encontrar el máximo y segundo máximo
buscar_maximo:
    cbz     w1, fin_buscar_maximo   // Si w1 es 0 (tamaño = 0), terminar el bucle

    ldr     w3, [x2], #4            // Cargar el siguiente elemento

    cmp     w3, w4                  // Comparar el elemento con el máximo actual
    ble     siguiente               // Si w3 <= w4, ir a siguiente
    mov     w5, w4                  // El segundo máximo es el anterior máximo
    mov     w4, w3                  // El nuevo máximo es w3

siguiente:
    cmp     w3, w5                  // Comparar el elemento con el segundo máximo actual
    bge     fin_buscar_maximo       // Si w3 >= w5, continuar al siguiente
    mov     w5, w3                  // Actualizar el segundo máximo

    b       buscar_maximo           // Volver a comprobar el siguiente elemento

fin_buscar_maximo:
    // Imprimir el segundo máximo
    adrp    x0, msg_elemento        // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_elemento
    mov     w1, w5                  // Colocar el segundo máximo en w1 para printf
    bl      printf                  // Llamar a printf para imprimir el segundo máximo

    // Reiniciar el contador y dirección para imprimir el arreglo
    ldr     w1, [x1]                // Cargar el tamaño de nuevo
    adrp    x2, arreglo             // Dirección base del arreglo
    add     x2, x2, :lo12:arreglo   // Dirección base del arreglo

loop_imprimir:
    cbz     w1, fin_programa        // Si no quedan elementos, terminar

    ldr     w3, [x2], #4            // Cargar elemento y avanzar dirección del arreglo
    mov     w1, w3                  // Colocar el elemento en w1 para printf
    adrp    x0, msg_elemento        // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_elemento
    bl      printf                  // Llamar a printf para imprimir el elemento

    sub     w1, w1, #1              // Decrementar el contador de elementos
    b       loop_imprimir           // Repetir para el siguiente elemento

fin_programa:
    // Epílogo de la función main
    ldp     x29, x30, [sp], #16     // Restaurar el frame pointer y el link register
    mov     x0, #0                  // Código de salida 0
    ret
