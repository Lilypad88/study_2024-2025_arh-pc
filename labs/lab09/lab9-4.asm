%include 'in_out.asm'

SECTION .data
    msg db 'Введите x: ', 0h ; Сообщение для ввода x
    func_msg db 'Функция: f(x)=8x-3', 0h
    result_msg db 'Результат: ', 0h

SECTION .bss
    x resb 80 ; Буфер для ввода x
    res resb 80 ; Буфер для результата

SECTION .text
global _start

_start:
    ; Вывод сообщения о функции
    mov eax, func_msg
    call sprintLF

    ; Запрос ввода x
    mov eax, msg
    call sprint
    mov ecx, x
    mov edx, 80
    call sread

    ; Преобразование x в число
    mov eax, x
    call atoi

    ; Вызов подпрограммы _calcul
    call _calcul

    ; Вывод результата
    mov eax, result_msg
    call sprint
    mov eax, [res]
    call iprintLF

    ; Завершение программы
    call quit

; Подпрограмма вычисления f(x) = 8x - 3
_f:
    mov ebx, 8
    imul eax, ebx ; EAX = 8 * x
    sub eax, 3 ; EAX = 8x - 3
    ret

; Подпрограмма _calcul
_calcul:
    call _f ; Вызов подпрограммы _f
    mov [res], eax ; Сохраняем результат в [res]
    ret
