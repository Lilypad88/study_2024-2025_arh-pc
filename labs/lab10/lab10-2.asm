section .data
    prompt db 'Как Вас зовут? ', 0
    msg db 'Меня зовут ', 0
    filename db 'name.txt', 0

section .bss
    name resb 100 ; Буфер для ввода имени (максимум 100 символов)

section .text
global _start

_start:
    ; ---- Вывод приглашения "Как Вас зовут?"
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, prompt ; Адрес сообщения
    mov edx, 16 ; Длина сообщения
    int 0x80 ; Вызов ядра

    ; ---- Ввод имени с клавиатуры
    mov eax, 3 ; sys_read
    mov ebx, 0 ; stdin
    mov ecx, name ; Адрес буфера для ввода
    mov edx, 100 ; Максимальная длина ввода
    int 0x80 ; Вызов ядра

    ; ---- Создание файла name.txt
    mov eax, 8 ; sys_creat
    mov ebx, filename ; Имя файла
    mov ecx, 0o644 ; Права доступа (rw-r--r--)
    int 0x80 ; Вызов ядра

    ; ---- Проверка успешности создания файла
    cmp eax, -1 ; Проверяем, вернулся ли дескриптор файла
    je exit ; Если ошибка, завершаем программу

    ; ---- Сохранение дескриптора файла
    mov ebx, eax ; Дескриптор файла теперь в EBX

    ; ---- Запись в файл строки "Меня зовут "
    mov eax, 4 ; sys_write
    mov ecx, msg ; Адрес сообщения
    mov edx, 11 ; Длина сообщения
    int 0x80 ; Вызов ядра

    ; ---- Запись в файл введённого имени
    mov eax, 4 ; sys_write
    mov ecx, name ; Адрес введённого имени
    mov edx, 100 ; Длина буфера
    int 0x80 ; Вызов ядра

    ; ---- Закрытие файла
    mov eax, 6 ; sys_close
    int 0x80 ; Вызов ядра

exit:
    ; ---- Завершение программы
    mov eax, 1 ; sys_exit
    xor ebx, ebx ; Код возврата 0
    int 0x80 ; Вызов ядра
