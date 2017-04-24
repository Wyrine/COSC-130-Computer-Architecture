.syntax unified
/*
  char name[40];
  int birthday;
  int birthmonth;
  int birthyear;
  int height;
  int weight;
*/
//EQU directives go here
.equ PERSON_name, 0
.equ PERSON_birthday, 40
.equ PERSON_birthmonth, 44
.equ PERSON_birthyear, 48
.equ PERSON_height, 52
.equ PERSON_weight, 56
.equ PERSON, 60
.equ PARAM_5, 64

.section .text
.global CopyString
CopyString:
    //Put your code for CopyString here
    mov r2, 0 //r2 is the current offset
  1:
    ldrb r3, [r1, r2]
    cmp r3, 0
    it eq
    beq 1f
    strb r3, [r0, r2]
    add r2, 1
    b 1b
  1:
    strb r3, [r0, r2]
    bx  lr

.global NewPerson
//const char *name, int bday, int bmonth, int byear, int height, int weight
//r0                  r1        r2          r3          sp1         sp2
NewPerson:
    //Put your code for NewPerson here
    sub sp, PERSON
    str r1, [sp, PERSON_birthday]
    str r2, [sp, PERSON_birthmonth]
    str r3, [sp, PERSON_birthyear]
    ldr r1, [sp, PARAM_5] //r1 is weight
    ldr r2, [sp, PERSON] //r2 is height
    str r1, [sp, PERSON_weight]
    str r2, [sp, PERSON_height]
 
    mov r1, r0
    mov r0, sp
    push {r4, lr}
    bl CopyString
    pop {r4, lr}
    mov r0, sp
    push {r4, lr}
    bl AddToList
    pop {r4, lr}
    add sp, PERSON
    //Change bx lr to whatever you need below
    bx lr
