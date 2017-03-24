.syntax unified

.section .data
  by: .int

.section .text

  .global setby
  .global increment
  .global decrement
  .global zeroit

  setby:
    ldr r1, =by
    str r0, [r1]  
    bx lr

  increment:
    ldr r1, =by
    ldr r1, [r1]
    add r0, r1
    bx lr
  
  decrement:
    ldr r1, =by
    ldr r1, [r1]
    mvn r1, r1
    add r1, 1
    add r0, r1    
    bx lr

  zeroit:
    eor r0, r0
    bx lr
