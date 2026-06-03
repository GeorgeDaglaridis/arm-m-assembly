.section .vectors
vector_table:
    .word 0x20001000
    .word reset_handler
    .zero 400

.section .text
.align 1
.type reset_handler, %function
reset_handler:
    mov r1, #7      
    mov r2, #3
    mov r3, #5

    push {r3, r2, r1}

    mov r1, #5      
    mov r2, #5
    mov r3, #5

    pop {r3, r2, r1}
    
    bl .              // BL in Thumb is a 32-bit (4-byte) instruction.
