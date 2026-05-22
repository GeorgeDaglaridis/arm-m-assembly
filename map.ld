MEMORY
{
    MEM : ORIGIN = 0x0, LENGTH = 0x4000
}

SECTIONS
{
    .banana : {
        *(.vectors*)
        *(.text*)
    } > MEM
}