%include 'in_out.asm'

SECTION .data
    msg db 'Введите x: ', 0
    result db '2*(3x-1)+7=', 0

SECTION .bss
    x resb 80 ; Буфер для ввода x
    res resb 80 ; Буфер для результата

SECTION .text
global _start

_start:
    ; ------------------------------------------
    ; Основная программа
    ; ------------------------------------------
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
    mov eax, result
    call sprint
    mov eax, [res]
    call iprintLF

    ; Завершение программы
    call quit

; ------------------------------------------
; Подпрограмма вычисления f(g(x)) = 2*(3x-1)+7
; Вход: EAX = x
; Выход: [res] = результат
; ------------------------------------------
_calcul:
    ; Сохраняем x в стеке
    push eax

    ; Вызов подпрограммы _subcalcul для вычисления g(x) = 3x - 1
    call _subcalcul

    ; Вычисляем f(g(x)) = 2 * g(x) + 7
    mov ebx, 2
    imul eax, ebx ; EAX = 2 * g(x)
    add eax, 7 ; EAX = 2 * g(x) + 7

    ; Сохраняем результат в [res]
    mov [res], eax

    ; Восстанавливаем x из стека
    pop eax

    ; Возврат из подпрограммы
    ret

; ------------------------------------------
; Подпрограмма вычисления g(x) = 3x - 1
; Вход: EAX = x
; Выход: EAX = g(x)
; ------------------------------------------
_subcalcul:
    ; Вычисляем g(x) = 3x - 1
    mov ebx, 3
    imul eax, ebx ; EAX = 3 * x
    sub eax, 1 ; EAX = 3x - 1

    ; Возврат из подпрограммы
    ret
