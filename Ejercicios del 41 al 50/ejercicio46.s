////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 46
//Encontrar prefijo común más largo en cadenas	
//Comparación de cadenas	
//Comparación de textos
///////////////////////////////////////////////

//C#
/*
using System;

class Program
{
    static void Main()
    {
        string[] cadenas = { "flor", "florecer", "flotante", "flota" };

        string prefijoComun = EncontrarPrefijoComun(cadenas);

        Console.WriteLine($"El prefijo común más largo es: '{prefijoComun}'");
    }

    static string EncontrarPrefijoComun(string[] cadenas)
    {
        if (cadenas == null || cadenas.Length == 0)
            return string.Empty;

        // Tomamos la primera cadena como base
        string prefijo = cadenas[0];

        // Comparar el prefijo con las demás cadenas
        for (int i = 1; i < cadenas.Length; i++)
        {
            // Mientras no coincida, acortamos el prefijo
            while (cadenas[i].IndexOf(prefijo) != 0)
            {
                prefijo = prefijo.Substring(0, prefijo.Length - 1);

                if (prefijo == string.Empty)
                    return string.Empty;
            }
        }

        return prefijo;
    }
}

*/


//ARM64
.data
    prompt1:   .asciz "Ingrese la primera cadena: "
    prompt2:   .asciz "Ingrese la segunda cadena: "
    result_msg: .asciz "El prefijo comun es: "
    no_prefix_msg: .asciz "No hay prefijo comun.\n"
    newline:   .asciz "\n"
    buffer1:   .space 100
    buffer2:   .space 100

.text
.global _start

_start:
    // Solicitar la primera cadena
    ldr x0, =1                 // STDOUT
    ldr x1, =prompt1           // Mensaje para la primera cadena
    mov x2, #24                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Leer la primera cadena
    ldr x0, =0                 // STDIN
    ldr x1, =buffer1           // Buffer
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Solicitar la segunda cadena
    ldr x0, =1                 // STDOUT
    ldr x1, =prompt2           // Mensaje para la segunda cadena
    mov x2, #24                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Leer la segunda cadena
    ldr x0, =0                 // STDIN
    ldr x1, =buffer2           // Buffer
    mov x2, #100               // Leer hasta 100 caracteres
    mov x8, #63                // Syscall 'read'
    svc #0                     // Llamar al sistema

    // Comparar las cadenas y encontrar el prefijo común
    mov x3, #0                 // Índice para recorrer las cadenas
    ldr x4, =buffer1           // Dirección de la primera cadena
    ldr x5, =buffer2           // Dirección de la segunda cadena
    ldrb w6, [x4, x3]          // Cargar el primer carácter de buffer1
    ldrb w7, [x5, x3]          // Cargar el primer carácter de buffer2
    cmp w6, w7                 // Comparar los caracteres
    beq find_prefix            // Si son iguales, continuar comparando

no_prefix:
    // Si no hay prefijo común, mostrar mensaje de error
    ldr x0, =1                 // STDOUT
    ldr x1, =no_prefix_msg     // Mensaje de error
    mov x2, #22                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema
    b end_program

find_prefix:
    // Continuar comparando los caracteres
    add x3, x3, #1             // Incrementar el índice
    ldrb w6, [x4, x3]          // Cargar siguiente carácter de buffer1
    ldrb w7, [x5, x3]          // Cargar siguiente carácter de buffer2
    cmp w6, w7                 // Comparar los caracteres
    bne display_prefix         // Si no son iguales, fin de la comparación

    // Si los caracteres siguen siendo iguales, continuar comparando
    cmp w6, #0                 // Verificar fin de cadena
    beq display_prefix         // Si fin de cadena, mostrar prefijo común
    b find_prefix

display_prefix:
    // Mostrar el prefijo común
    ldr x0, =1                 // STDOUT
    ldr x1, =result_msg        // Mensaje del prefijo común
    mov x2, #23                // Longitud del mensaje
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

    // Mostrar el prefijo común completo
    ldr x0, =1                 // STDOUT
    ldr x1, =buffer1           // Dirección de la cadena con el prefijo
    mov x2, x3                 // Longitud del prefijo
    mov x8, #64                // Syscall 'write'
    svc #0                     // Llamar al sistema

end_program:
    // Terminar el programa
    mov x8, #93                // Syscall 'exit'
    svc #0                     // Llamar al sistema

//*************************
nano hola.s
as -o hola.o hola.s
ld -o hola hola.o
./hola
