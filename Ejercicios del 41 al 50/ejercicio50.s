////////////////////////////////////////////////
//Angel Fernando Garcia Calderon
//No.control - 22210306
//Hora- 4 a 5
//Lenguajes de interfaz
//Ejercicio 50
//Escribir en un archivo	
//Manejo de archivos y llamadas al sistema	
//Registro de datos
///////////////////////////////////////////////

//C#
/*
using System;
using System.IO;

class Program
{
    static void Main()
    {
        string path = "archivo.txt";
        string contenido = "\nEsta línea se agregó al final del archivo.";

        // Agregar texto al final del archivo
        File.AppendAllText(path, contenido);

        Console.WriteLine($"El texto ha sido agregado al archivo '{path}'.");
    }
}

*/


//ARM64
.global _start

.section .data
    filename: .asciz "output.txt"  // Nombre del archivo a escribir
    message:  .asciz "Hola desde ensamblador ARM64\n"  // Mensaje que se escribirá en el archivo
    len = . - message  // Longitud del mensaje

.section .text
_start:
    // Abrir el archivo para escritura
    mov x8, 56               // syscall: openat
    mov x0, -100             // dirfd (AT_FDCWD)
    ldr x1, =filename        // filename
    mov x2, 577              // flags: O_CREAT | O_WRONLY | O_TRUNC (octal 01001)
    mov x3, 0644             // mode: permisos rw-r--r--
    svc 0

    // Guardar el descriptor del archivo en x10
    mov x10, x0

    // Escribir en el archivo
    mov x8, 64               // syscall: write
    mov x0, x10              // file descriptor
    ldr x1, =message         // buffer (mensaje a escribir)
    mov x2, len              // tamaño del mensaje
    svc 0

    // Cerrar el archivo
    mov x8, 57               // syscall: close
    mov x0, x10              // file descriptor
    svc 0

    // Salir del programa
    mov x8, 93               // syscall: exit
    mov x0, 0                // código de salida
    svc 0
