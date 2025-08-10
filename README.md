# 🖥️ YOKAI Bootloader

Um bootloader simples e estilizado em Assembly x86, feito para carregar o kernel do **YOKAI OS** com direito a arte ASCII na tela de inicialização. 🚀

---

![YOKAI OS Bootloader Demo](docs/bootloader-demo.png)

> A imagem acima mostra o bootloader carregando o kernel com sucesso.

---

## 🔧 Como compilar e testar

### 1️⃣ Compilar o bootloader
```bash
nasm -f bin bootloader.asm -o bootloader.bin
```

3️⃣ Testar no QEMU
```bash
Copiar código
qemu-system-x86_64 -drive format=raw,file=bootloader.bin
```

✨ Autor
Desenvolvido por Matheus S. Rosa 🐉
