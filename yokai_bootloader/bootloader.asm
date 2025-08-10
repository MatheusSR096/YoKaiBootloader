; ================================
; YOKAI OS BOOTLOADER
; ================================
[org 0x7c00]

; --- Inicialização ---
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

; --- Limpar tela ---
mov ax, 0x0600
mov bh, 0x07
mov cx, 0x0000
mov dx, 0x184f
int 0x10

; --- Mostrar arte ---
mov si, art1
call print_at_3_15
mov si, art2
call print_next
mov si, art3
call print_next
mov si, art4
call print_next

; --- Mensagens ---
mov si, dev_msg
call print_at_9_25
mov si, author_msg
call print_at_10_25
mov si, press_msg
call print_at_15_20

; --- Espera tecla ---
mov ah, 0
int 0x16

; --- Tela carregando ---
mov ax, 0x0600
mov bh, 0x07
mov cx, 0
mov dx, 0x184f
int 0x10
mov si, loading_msg
call print_at_12_25

; --- Ler kernel ---
mov ah, 0x02
mov al, 1
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, 0x80
mov bx, 0x1000
mov es, bx
mov bx, 0
int 0x13
jc disk_error

; --- Sucesso ---
mov si, success_msg
call print_at_13_20
mov ah, 0
int 0x16

; --- Ir para kernel ---
jmp 0x1000:0x0000

; --- Erro de disco ---
disk_error:
mov si, error_msg
call print_at_13_30
hang: jmp hang

; --- Funções utilitárias ---
print_at_3_15:
    mov dh, 3
    mov dl, 15
    jmp set_and_print
print_at_9_25:
    mov dh, 9
    mov dl, 25
    jmp set_and_print
print_at_10_25:
    mov dh, 10
    mov dl, 25
    jmp set_and_print
print_at_15_20:
    mov dh, 15
    mov dl, 20
    jmp set_and_print
print_at_12_25:
    mov dh, 12
    mov dl, 25
    jmp set_and_print
print_at_13_20:
    mov dh, 13
    mov dl, 20
    jmp set_and_print
print_at_13_30:
    mov dh, 13
    mov dl, 30
    jmp set_and_print
print_next:
    inc dh
set_and_print:
    mov bh, 0
    mov ah, 2
    int 0x10
    call print_string
    ret

print_string:
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    mov bx, 0x0007
    int 0x10
    jmp .loop
.done:
    ret

; --- Dados ---
art1 db '_   _ _____ _    _ ______ _____ ', 0
art2 db ' \_/  |   | |___/  |____|   |   ', 0
art3 db '  |   |___| |   \  |    | __|__ ', 0
art4 db '+------- OPERATING SYSTEM -------+', 0

dev_msg db 'Developed by:', 0
author_msg db 'Matheus S. Rosa', 0
press_msg db 'Press any key...', 0
loading_msg db 'Loading kernel...', 0
success_msg db 'Kernel loaded! Press any key...', 0
error_msg db 'HELLO YOKAI!', 0

times 510 - ($ - $$) db 0
dw 0xaa55
