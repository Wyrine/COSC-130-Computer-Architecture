.syntax unified

//Put your .equ statements here for x, y, and z
.equ IVECTOR3_x, 0
.equ IVECTOR3_y, 4
.equ IVECTOR3_z, 8

.section .text
.global cross
.global dot

dot:
	//Write your functionality for dot product here
	//Remember the first parameter is the first vector
	//the second parameter is the second vector and you
	//return the dot product.
  push {r4, lr}
	ldr r2, [r0, IVECTOR3_x]
  ldr r3, [r1, IVECTOR3_x]
  mul r4, r2, r3
  ldr r2, [r0, IVECTOR3_y]
  ldr r3, [r1, IVECTOR3_y]
  mul r2, r3
  add r4, r2
  ldr r2, [r0, IVECTOR3_z]
  ldr r3, [r1, IVECTOR3_z]
  mul r2, r3
  add r4, r2
  mov r0, r4
	//Replace bx lr with whatever you need
	pop {r4, pc}
	
cross:
	//Write your functionality for the cross product here
	//The first parameter is the RESULTANT vector
	//The second parameter is the first vector (left)
	//The third parameter is the second vector (right)
	//This is a void function, so nothing is returned
	push {r4, r5, r6, r7, lr}
  ldr r3, [r1, IVECTOR3_y]
  ldr r4, [r2, IVECTOR3_z]
  mul r3, r4
  mov r5, r3
  ldr r3, [r1, IVECTOR3_z]
  ldr r4, [r2, IVECTOR3_y]
  mul r3, r4
  sub r5, r3
  
  //x done
  ldr r3, [r1, IVECTOR3_z]
  ldr r4, [r2, IVECTOR3_x]
  mul r3, r4
  mov r6, r3
  ldr r3, [r1, IVECTOR3_x]
  ldr r4, [r2, IVECTOR3_z]
  mul r3, r4
  sub r6, r3
  
  //y done
  ldr r3, [r1, IVECTOR3_x]
  ldr r4, [r2, IVECTOR3_y]
  mul r3, r4
  mov r7, r3
  ldr r3, [r1, IVECTOR3_y]
  ldr r4, [r2, IVECTOR3_x]
  mul r3, r4
  sub r7, r3
  str r5, [r0, IVECTOR3_x]//r5 is x component
  str r6, [r0, IVECTOR3_y]//r6 is y component
  str r7, [r0, IVECTOR3_z]//r7 is z component
	//Replace bx lr with whatever you need
	pop {r4, r5, r6, r7, pc}
