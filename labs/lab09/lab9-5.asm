SECTION .data
    result_msg db 'Result: ', 0 ; Сообщение для вывода результата
    newline db 0xA ; Символ новой строки

SECTION .bss
    result resb 10 ; Буфер для хранения результата (максимум 10 символов)

SECTION .text
global _start

_start:
    ; ---- Вычисление выражения (3+2)*4+5
    mov ebx, 3 ; EBX = 3
    mov eax, 2 ; EAX = 2
    add ebx, eax ; EBX = 3 + 2 = 5
    mov ecx, 4 ; ECX = 4
    mov eax, ebx ; EAX = 5
    mul ecx ; EAX = 5 * 4 = 20
    add eax, 5 ; EAX = 20 + 5 = 25

    ; ---- Преобразование результата в строку
    mov edi, result + 9 ; Указываем на конец буфера
    mov byte [edi], 0 ; Завершаем строку нулём
    dec edi ; Переходим к предыдущему символу

    mov ecx, 10 ; Основание системы счисления (десятичная)
convert_loop:
    xor edx, edx ; Очищаем EDX перед делением
    div ecx ; Делим EAX на 10, остаток в EDX
    add dl, '0' ; Преобразуем остаток в символ
    mov [edi], dl ; Сохраняем символ в буфере
    dec edi ; Переходим к предыдущему символу
    test eax, eax ; Проверяем, осталось ли что-то в EAX
    jnz convert_loop ; Если да, продолжаем цикл

    ; ---- Вывод сообщения "Result: "
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, result_msg ; Адрес сообщения
    mov edx, 8 ; Длина сообщения
    int 0x80 ; Вызов ядра

    ; ---- Вывод результата
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    lea ecx, [edi + 1] ; Адрес начала строки с результатом
    mov edx, result + 10 ; Конец буфера
    sub edx, ecx ; Вычисляем длину строки
    int 0x80 ; Вызов ядра

    ; ---- Вывод новой строки
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, newline ; Адрес символа новой строки
    mov edx, 1 ; Длина символа
    int 0x80 ; Вызов ядра

    ; ---- Завершение программы
    mov eax, 1 ; sys_exit
    xor ebx, ebx ; Код возврата 0
    int 0x80 ; Вызов ядра
