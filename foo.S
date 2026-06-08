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
reset_handler: #set r8-r11 manualy set $r8=8

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

    mov r4, #0x4
    mov r6, #0x6
    mov r7, #0x7

    push {r4-r7}
 
    mov r0, r8
    mov r1, r9
    mov r2, r10
    mov r3, r11

    push {r0-r3}

#reset r8-r11 manualy set $r8=0
break_here:

    mov r0, #0
    mov r1, #0
    mov r2, #0
    mov r3, #0
    mov r4, #0
    #mov r5, #0
    mov r6, #0
    mov r7, #0

    pop {r0-r3}

    mov r8,  r0
    mov r9,  r1
    mov r10, r2
    mov r11, r3

    pop {r4-r7}

    bx lr
