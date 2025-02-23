%include 'in_out.asm'

section .data
    msg_x db 'Введите x: ', 0h
    msg_a db 'Введите a: ', 0h
    msg_y db 'Результат y = ', 0h
    formula db 'y = a + x, если x >= a; иначе y = x', 0h

section .bss
    x resb 10 ; Переменная для ввода x
    a resb 10 ; Переменная для ввода a
    y resb 10 ; Переменная для результата y

section .text
global _start

_start:
    ; ---------- Вывод формулы
    mov eax, formula
    call sprintLF

    ; ---------- Ввод 'x'
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread

    ; ---------- Преобразование 'x' из строки в число
    mov eax, x
    call atoi
    mov [x], eax

    ; ---------- Ввод 'a'
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread

    ; ---------- Преобразование 'a' из строки в число
    mov eax, a
    call atoi
    mov [a], eax

    ; ---------- Вычисление y
    mov eax, [x]
    cmp eax, [a] ; Сравниваем x и a
    jge x_ge_a ; Если x >= a, переходим к x_ge_a
    ; Иначе y = x
    mov [y], eax
    jmp fin

x_ge_a:
    ; y = a + x
    add eax, [a]
    mov [y], eax

    ; ---------- Вывод результата
fin:
    mov eax, msg_y
    call sprint ; Вывод сообщения 'Результат y = '
    mov eax, [y]
    call iprintLF ; Вывод результата
    call quit ; Завершение программы
