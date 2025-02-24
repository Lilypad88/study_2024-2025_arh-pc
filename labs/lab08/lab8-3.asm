%include 'in_out.asm'

SECTION .data
    msg db "Результат: ", 0

SECTION .text
global _start

_start:
    ; Извлекаем количество аргументов
    pop ecx ; ECX = количество аргументов
    pop edx ; EDX = имя программы (первый аргумент)
    sub ecx, 1 ; Уменьшаем ECX на 1 (исключаем имя программы)

    ; Проверяем, есть ли аргументы
    cmp ecx, 0
    jz _no_args ; Если аргументов нет, переходим к _no_args

    ; Инициализируем ESI (результат) первым аргументом
    pop eax ; Извлекаем первый аргумент
    call atoi ; Преобразуем в число
    mov esi, eax ; ESI = первый аргумент

    ; Перемножаем оставшиеся аргументы
next:
    cmp ecx, 1 ; Проверяем, остались ли аргументы
    jz _end ; Если аргументов больше нет, переходим к _end

    pop eax ; Извлекаем следующий аргумент
    call atoi ; Преобразуем в число
    imul esi, eax ; Умножаем ESI на EAX (ESI = ESI * EAX)

    loop next ; Переход к следующему аргументу

_end:
    mov eax, msg ; Вывод сообщения "Результат: "
    call sprint
    mov eax, esi ; Записываем результат в EAX
    call iprintLF ; Печать результата
    call quit ; Завершение программы

_no_args:
    mov eax, msg ; Вывод сообщения "Результат: "
    call sprint
    mov eax, 0 ; Если аргументов нет, результат = 0
    call iprintLF
    call quit
