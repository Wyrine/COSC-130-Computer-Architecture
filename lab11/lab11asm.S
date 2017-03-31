.syntax unified
.section .text

.global compare
compare:
 subs r0, r1
 it eq
  moveq r0, 0
 it lt
  movlt r0, -1
 it gt
  movgt r0, 1
 bx lr


.global strlength
strlength:
  ldrb r1, [r0]
  mov r2, 0  
1:
  cmp r1, 0
  it eq    
    beq 1f
  add r2, 1
  ldrb r1, [r0, r2]
  b 1b
1:
  mov r0, r2
  bx lr


.global minimum
minimum:
  push {r0, r1, r2, lr}
  bl compare
  movs r3, r0
  pop {r0, r1, r2, lr}
  ite le
    movle r1, r2
    movgt r0, r2
  push {r0, r1, r2, lr}
  bl compare
  movs r2, r0
  pop {r0, r1, r2, lr}
  it ge
   movge r0, r1
  bx lr

.global maximum
maximum:
  push {r0, r1, r2, lr}
  bl compare
  movs r3, r0
  pop {r0, r1, r2, lr}
  ite ge
    movge r1, r2
    movlt r0, r2
  push {r0, r1, r2, lr}
  bl compare
  movs r2, r0
  pop {r0, r1, r2, lr}
  it le
   movle r0, r1
  bx lr
