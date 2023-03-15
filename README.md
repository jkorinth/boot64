# boot64: x86_64 assembler bootloader project
I wanted to learn how a x86_64 bootloader works, so I wrote one.
It starts in real-mode (16b), sets up protected mode (32b), then
moves to compatibility mode (64b), and finally to long mode.
During the four stages, it prints labels (press key on first).

## Prerequisites
This project uses the [Netwide Assembler (NASM)][3]. You need to
have it installed and in the path.

## Building
As another side-project, I used the [tup build system][1], which
I like a lot, at least for such small projects.
Just run
```sh
$ tup init && tup
```
to build the project.

## Running
I used [QEMU][2] for my tests:
```sh
$ qemu-system-x86_64 -fda boot64.bin
```

[1]: https://gittup.org/tup/
[2]: https://www.qemu.org/
[3]: https://www.nasm.us/
