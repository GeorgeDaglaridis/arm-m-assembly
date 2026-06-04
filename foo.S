#systick configuration registers
.equ systick_csr,   0xE000E010
.equ systick_rvr,   0xE000E014
.equ systick_cvr,   0xE000E018
.equ systick_calib, 0xE000E01C
.equ timeout,       0x00FFFFFF

.section .vectors
vector_table:
    .word 0x20001000
    .word reset_handler   
.org 0x3C                   // systick_handler has exception number 15 and is found at an offset of 15*4 = 0x3C from the base of vector_table
    .word systick_handler
    .zero 400

.section .text
.align 1
.type reset_handler, %function
reset_handler:

    mov r5, #0x0

#configuring systick
    ldr r0, =systick_csr
    ldr r1, =systick_rvr
    ldr r2, =systick_cvr
    ldr r3, =timeout

    str r3, [r1]
    mov r3, #0x0
    str r3, [r2]
    mov r3, #0x7
    str r3, [r0] // set processor clock as source clock, trigger exception when reaches zero, enable counter

    b .          // BL in Thumb is a 32-bit (4-byte) instruction.

.section .text
.align 1
.type systick_handler, %function
systick_handler:
    add r5, r5, #0x1

break_here:
    bx lr



