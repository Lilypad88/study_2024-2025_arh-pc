%include 'in_out.asm'

SECTION .data
    func_msg db 'Функция: f(x)=8x-3', 0h
    result_msg db 'Результат: ', 0h

SECTION .text
global _start

_start:
    ; Вывод сообщения о функции
    mov eax, func_msg
    call sprintLF

    ; Извлекаем количество аргументов
    pop ecx ; ECX = количество аргументов
    pop edx ; EDX = имя программы (первый аргумент)
    sub ecx, 1 ; Уменьшаем ECX на 1 (исключаем имя программы)

    ; Проверяем, есть ли аргументы
    cmp ecx, 0
    jz _no_args ; Если аргументов нет, переходим к _no_args

    ; Инициализируем ESI (результат) нулём
    mov esi, 0

    ; Обрабатываем аргументы
next:
    pop eax ; Извлекаем следующий аргумент
    call atoi ; Преобразуем в число

    ; Вычисляем f(x) = 8x - 3
    mov ebx, 8 ; EBX = 8
    imul eax, ebx ; EAX = 8 * x
    sub eax, 3 ; EAX = 8x - 3

    ; Добавляем результат к сумме
    add esi, eax ; ESI = ESI + (8x - 3)

    ; Проверяем, остались ли аргументы
    loop next ; Переход к следующему аргументу

_end:
    ; Вывод результата
    mov eax, result_msg
    call sprint
    mov eax, esi
    call iprintLF
    call quit

_no_args:
    ; Если аргументов нет, выводим 0
    mov eax, result_msg
    call sprint
    mov eax, 0
    call iprintLF
    call quit
