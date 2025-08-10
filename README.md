# 🖥️ YOKAI Bootloader

Um bootloader simples em Assembly x86. 🚀

---

![YOKAI OS Bootloader Demo](yokai_bootloader/docs/yokaiimg.png)

---

🔧 Como compilar e testar

🛠️ Instalações necessárias
Antes de começar, você precisa ter o NASM (Netwide Assembler) e o QEMU (Quick Emulator) instalados na sua máquina.

Para sistemas baseados em Debian/Ubuntu:

```Bash

sudo apt update
sudo apt install nasm qemu-system-x86
```

Para sistemas baseados em Arch Linux:

```Bash

sudo pacman -S nasm qemu

```

1️⃣ Compilar o bootloader
```Bash

nasm -f bin bootloader.asm -o bootloader.bin

```
2️⃣ Testar no QEMU
```Bash

qemu-system-x86_64 -drive format=raw,file=bootloader.bin

```

---

## Chamadas BIOS e registradores usados

Esta tabela ajuda a entender as principais chamadas BIOS usadas no bootloader, os registradores que precisam ser preparados e o que cada função faz.

| Interrupção | Função (AH) | Registradores principais para chamada                                  | Descrição                             |
|-------------|-------------|------------------------------------------------------------------------|------------------------------------|
| **int 0x10** (Vídeo) | 0x00            | AL = caractere<br>BH = página de vídeo<br>BL = atributo (cor)<br>AH = função (0x00) | Escreve caractere na tela (modo texto) |
|             | 0x02            | BH = página de vídeo<br>DH = linha (Y)<br>DL = coluna (X)<br>AH = função (0x02)       | Posiciona o cursor na tela          |
|             | 0x06            | BH = atributo (cor)<br>CX = posição inicial (linha e coluna)<br>DX = posição final (linha e coluna)<br>AH = função (0x06) | Rola ou limpa a área da tela        |
|             | 0x0E            | AL = caractere<br>AH = função (0x0E)<br>BL = atributo (cor)                       | Imprime caractere (modo teletipo)   |
|             | 0x01            | CX = modo de vídeo<br>AH = função (0x01)                                         | Define modo de vídeo                |
| **int 0x13** (Disco)  | 0x00            | AH = função (0x00)<br>DL = drive                                              | Resetar drive de disco              |
|             | 0x02            | AH = função (0x02)<br>AL = número de setores<br>CH = cilindro<br>CL = setor<br>DH = cabeça<br>DL = drive<br>ES:BX = buffer destino | Lê setores do disco                 |
|             | 0x03            | AH = função (0x03)<br>AL = número de setores<br>CH = cilindro<br>CL = setor<br>DH = cabeça<br>DL = drive<br>ES:BX = buffer origem | Escreve setores no disco            |
| **int 0x16** (Teclado) | 0x00            | AH = função (0x00)                                                            | Lê tecla (bloqueante)              |
|             | 0x01            | AH = função (0x01)                                                            | Verifica se tecla foi pressionada (não bloqueante) |
|             | 0x10            | AH = função (0x10)<br>AL = subfunção                                        | Controla teclado estendido         |

---


✨ Autor
Desenvolvido por Matheus S. Rosa 
