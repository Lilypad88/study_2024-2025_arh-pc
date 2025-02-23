%include 'in_out.asm' ; Подключение внешнего файла с подпрограммами

SECTION .data ; Секция инициализированных данных
    msg_x db "Введите значение x: ", 0h ; Сообщение для ввода x
    msg_y db "Результат y = ", 0h ; Сообщение для вывода результата
    formula db "y = (1/3 * x + 5) * 7", 0h ; Формула для вывода

SECTION .bss ; Секция неинициализированных данных
    x resb 10 ; Буфер для ввода x
    y resb 10 ; Буфер для вывода результата

SECTION .text ; Секция кода
    GLOBAL _start ; Начало программы

_start:
    ; Вывод формулы
    mov eax, formula
    call sprintLF

    ; Запрос ввода x
    mov eax, msg_x
    call sprint
    mov ecx, x ; Адрес буфера для ввода x
    mov edx, 10 ; Максимальная длина ввода
    call sread ; Вызов подпрограммы ввода

    ; Преобразование введённого x в число
    mov eax, x
    call atoi ; Преобразуем строку в число (результат в EAX)

    ; Вычисление выражения y = (1/3 * x + 5) * 7
    mov ebx, 3 ; EBX = 3
    xor edx, edx ; Очистка EDX для деления
    div ebx ; EAX = x / 3 (целая часть)
    add eax, 5 ; EAX = (x / 3) + 5
    mov ebx, 7 ; EBX = 7
    mul ebx ; EAX = ((x / 3) + 5) * 7

    ; Преобразование результата в строку
    mov [y], eax ; Сохраняем результат в y
    mov eax, y
    call iprintLF ; Вывод результата

    ; Завершение программы
    call quit
