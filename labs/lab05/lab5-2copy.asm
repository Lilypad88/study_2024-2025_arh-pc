%include 'in_out.asm' ; подключение внешнего файла

SECTION .data ; Секция инициированных данных
msg: DB 'Введите строку: ',0h ; сообщение для ввода

SECTION .bss ; Секция не инициированных данных
buf1: RESB 80 ; Буфер размером 80 байт

SECTION .text ; Код программы
GLOBAL _start ; Начало программы

_start: ; Точка входа в программу
    ; Вывод сообщения "Введите строку:"
    mov eax, msg ; запись адреса выводимого сообщения в EAX
    call sprintLF ; вызов подпрограммы печати сообщения

    ; Ввод строки от пользователя
    mov ecx, buf1 ; запись адреса буфера в ECX
    mov edx, 80 ; запись длины буфера в EDX
    call sread ; вызов подпрограммы ввода сообщения

    ; Вывод введённой строки
    mov eax, buf1 ; запись адреса буфера в EAX
    call sprintLF ; вызов подпрограммы печати сообщения

    ; Завершение программы
    call quit ; вызов подпрограммы завершения
