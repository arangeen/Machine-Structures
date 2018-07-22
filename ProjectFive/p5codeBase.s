.data
  expVal23:    .asciiz  "Expected Value : 23  Your Value : "
  expVal21:    .asciiz  "Expected Value : 21  Your Value : "
  endl:        .asciiz  "\n"

.text

# #
# int getDigit(int number);
# List Used Registers Here:
#
# #
getDigit:

  add $t0, $a0, 0  # t0 = number
  li $v0 , 0   # int sum = 0
  li $t4 , 10   # t4 = 10
  
  bge $t0 , $t4, Else  # if ( number < 10)
  add $v0, $t0, 0
  j returnFunction

Else: 

  rem $t1, $t0, $t4     # t1 = number % 10
  div $t2, $t0, $t4     # t2 = number /10
  add $v0, $t1, $t2     # sum = sum + number 

returnFunction:

  jr $ra 




##
# int sumOfDoubleEvenPlace(int number);
# List Used Registers Here:
# sum --> $s0
# digit --> $s1
# 
##
sumOfDoubleEvenPlace:

addi $sp, $sp, -4
sw   $ra, 0($sp)            
add $t6, $a0, 0

li $t7, 100
li $t8, 0 
li $t9, 10
li $t3, 0

div $t6, $t6 , $t9

wLoop:

  div $t6, $t9
  mfhi $t8
  mul  $t8, $t8, 2
  move $a0, $t8
  jal getDigit

  add $t3, $t3, $v0
  div $t6, $t6, $t7

  bgtz $t6, wLoop
  move $v0, $t3

  lw $ra, 0($sp)
  addi $sp, $sp, 4

  jr $ra




main:
  li $s0, 89744563  # int test1 = 89744563;
  li $s1, 98756421  # int test2 = 98756421;
  li $s2, 0         # int result1 = 0;
  li $s3, 0         # int result2 = 0;


  # code for first function call

  add $a0, $0, $s0
  jal sumOfDoubleEvenPlace
  add $s2, $0, $v0 

  la   $a0, expVal23     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s2       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

   # code for first function call

  add $a0, $0, $s1
  jal sumOfDoubleEvenPlace
  add $s3, $0, $v0 

  la   $a0, expVal21     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s3       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

  li $v0, 10
  syscall
