%include 'in_out.asm'

section .data
    msg1 db 'Введите B: ', 0h
    msg2 db 'Наибольшее число: ', 0h
    A dd 46 ; Значение A
    C dd 74 ; Значение C

section .bss
    max resb 10 ; Переменная для хранения наибольшего числа
    B resb 10   ; Переменная для ввода B

section .text
global _start

_start:
    ; ---------- Вывод сообщения 'Введите B: '
    mov eax, msg1
    call sprint

    ; ---------- Ввод 'B'
    mov ecx, B
    mov edx, 10
    call sread

    ; ---------- Преобразование 'B' из строки в число
    mov eax, B
    call atoi ; Преобразуем строку в число (результат в EAX)
    mov [B], eax ; Сохраняем число в B

    ; ---------- Записываем 'A' в переменную 'max'
    mov ecx, [A] ; ECX = A
    mov [max], ecx ; max = A

    ; ---------- Сравниваем 'A' и 'C'
    cmp ecx, [C] ; Сравниваем A и C
    jg check_B ; Если A > C, переходим к сравнению с B
    mov ecx, [C] ; Иначе ECX = C
    mov [max], ecx ; max = C

    ; ---------- Сравниваем 'max(A,C)' и 'B'
check_B:
    mov ecx, [max]
    cmp ecx, [B] ; Сравниваем max(A,C) и B
    jg fin ; Если max(A,C) > B, переходим к выводу
    mov ecx, [B] ; Иначе ECX = B
    mov [max], ecx ; max = B

    ; ---------- Вывод результата
fin:
    mov eax, msg2
    call sprint ; Вывод сообщения 'Наибольшее число: '
    mov eax, [max]
    call iprintLF ; Вывод наибольшего числа
    call quit ; Завершение программы
