////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 38
//Establecer, borrar y alternar bits	
//Manipulación de bits	
//Control de dispositivos
//video - 
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        int num = 29;  // 29 en binario: 11101

        Console.WriteLine($"Número original: {num} (binario: {Convert.ToString(num, 2).PadLeft(8, '0')})");

        // Establecer el bit en la posición 1 (de derecha a izquierda, empezando en 0)
        int numConBitEstablecido = EstablecerBit(num, 1);
        Console.WriteLine($"Después de establecer el bit 1: {numConBitEstablecido} (binario: {Convert.ToString(numConBitEstablecido, 2).PadLeft(8, '0')})");

        // Borrar el bit en la posición 3
        int numConBitBorrado = BorrarBit(num, 3);
        Console.WriteLine($"Después de borrar el bit 3: {numConBitBorrado} (binario: {Convert.ToString(numConBitBorrado, 2).PadLeft(8, '0')})");

        // Alternar el bit en la posición 2
        int numConBitAlternado = AlternarBit(num, 2);
        Console.WriteLine($"Después de alternar el bit 2: {numConBitAlternado} (binario: {Convert.ToString(numConBitAlternado, 2).PadLeft(8, '0')})");
    }

    // Método para establecer un bit en una posición dada (ponerlo a 1)
    static int EstablecerBit(int num, int posicion)
    {
        return num | (1 << posicion);  // Desplazamos 1 a la posición deseada y hacemos OR con num
    }

    // Método para borrar un bit en una posición dada (ponerlo a 0)
    static int BorrarBit(int num, int posicion)
    {
        return num & ~(1 << posicion);  // Desplazamos 1 a la posición, negamos el valor y hacemos AND con num
    }

    // Método para alternar un bit en una posición dada (invertirlo)
    static int AlternarBit(int num, int posicion)
    {
        return num ^ (1 << posicion);  // Desplazamos 1 a la posición deseada y hacemos XOR con num
    }
}

*/


//ARM64

.data
    value:    .quad   0x0000B8D8C5750010    // Valor inicial
    mask:     .quad   0x0000B8D8C5750018    // Máscara para bits 8-11
    result:   .quad   0                     // Resultado

    // Mensajes
    msgInit:  .string "Valor inicial: 0x%016lX\n"
    msgMask:  .string "Máscara: 0x%016lX\n"
    msgSet:   .string "Bits establecidos: 0x%016lX\n"
    msgClear: .string "Bits borrados: 0x%016lX\n"
    msgToggl: .string "Bits alternados: 0x%016lX\n"

.text
.global main
.align 2

main:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Imprimir valor inicial y máscara
    adrp    x0, msgInit
    add     x0, x0, :lo12:msgInit
    adrp    x1, value
    add     x1, x1, :lo12:value
    bl      printf

    adrp    x0, msgMask
    add     x0, x0, :lo12:msgMask
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      printf

    // Establecer bits
    adrp    x0, value
    add     x0, x0, :lo12:value
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      set_bits
    str     x0, [sp, #-8]!            // Guardar resultado

    adrp    x0, msgSet
    add     x0, x0, :lo12:msgSet
    ldr     x1, [sp], #8              // Recuperar resultado
    bl      printf

    // Borrar bits
    adrp    x0, value
    add     x0, x0, :lo12:value
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      clear_bits
    str     x0, [sp, #-8]!            // Guardar resultado

    adrp    x0, msgClear
    add     x0, x0, :lo12:msgClear
    ldr     x1, [sp], #8              // Recuperar resultado
    bl      printf

    // Alternar bits
    adrp    x0, value
    add     x0, x0, :lo12:value
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      toggle_bits
    str     x0, [sp, #-8]!            // Guardar resultado

    adrp    x0, msgToggl
    add     x0, x0, :lo12:msgToggl
    ldr     x1, [sp], #8              // Recuperar resultado
    bl      printf

    ldp     x29, x30, [sp], #16
    mov     x0, #0
    ret

// Función para establecer bits
set_bits:
    orr     x0, x0, x1
    ret

// Función para borrar bits
clear_bits:
    bic     x0, x0, x1
    ret

// Función para alternar bits
toggle_bits:
    eor     x0, x0, x1
    ret

****************************************************
