# RICHARD THE
# CS264 - LAB 2
# Date: 5/11/12
# File: lab2.asm

.data

read_str:   .space 20
pwd_str:	   .space 10

pswrd:		.asciiz "davarpanah"
opts:		   .asciiz "\n\nWhat would you like to do?\n"
opt1:		   .asciiz "1. Add 2 numbers\n"
opt2:		   .asciiz "2. Multiply 4 numbers\n"
opt3:		   .asciiz "3. String processing\n"
opt4:		   .asciiz "4. Fibonacci\n"
opt5:		   .asciiz "5. Exit program\n"
prompt:  	.asciiz "\nEnter the corresponding number: "
promptS:    .asciiz "\nInput 264? "
prompt1: 	.asciiz "\nEnter 1st number: "
prompt2: 	.asciiz "Enter 2nd number: "
prompt3: 	.asciiz "Enter 3rd number: "
prompt4: 	.asciiz "Enter 4th number: "
prompt5: 	.asciiz "Enter a string (max 20 chars): "
prompt6: 	.asciiz "Enter a number: "
sumTxt:		.asciiz "\nSum = "
prodTxt: 	.asciiz "\nProduct = "
revStr:		.asciiz "\nThe reversed string is "
wrong:	   .asciiz "\nWrong Input!\n"
endprg:	   .asciiz "\nGood bye!\n"
space:		.asciiz " "
idheap:		.asciiz "\nIdentity in HEAP\n"
bytealloc:	.asciiz "Number of bytes to allocate? "
myname:     .asciiz "richardthe"
memprint:	.asciiz "The memory was allocated at address 0x10040000\n"

.globl		main

.text

main:
		li		$v0, 4
		la		$a0, opts
		syscall					# print options

		li		$v0, 4
		la		$a0, opt1
		syscall					# print opt1

		li		$v0, 4
		la		$a0, opt2
		syscall					# print opt2

		li		$v0, 4
		la		$a0, opt3
		syscall					# print opt3

		li		$v0, 4
		la		$a0, opt4
		syscall					# print opt4

		li		$v0, 4
		la		$a0, opt5
		syscall					# print opt5
		
		li		$v0, 4
		la		$a0, prompt
		syscall					# print prompt

		li		$v0, 5
		syscall					# read input
      
		addi	$t0, $0, 264
		beq 	$v0, $t0, nextS
		
		li		$t0, 1
		beq 	$v0, $t0, next1
		
		li		$t0, 2
		beq 	$v0, $t0, next2
		
		li		$t0, 3
		beq 	$v0, $t0, next3
		
		li		$t0, 4
		beq 	$v0, $t0, next4
		
		li		$t0, 5
		beq 	$v0, $t0, next5
		
		li		$v0, 4
		la		$a0, wrong
		syscall					# print wrong
		b		main			   # loop the program
		
# SECRET OPTION #

nextS:
      li		$v0, 4
		la		$a0, promptS
		syscall					# print promptS
		
		la		$a0, pwd_str
		la		$a1, 10			# allocate 10 char space for input
		li		$v0, 8
		syscall					# read input
      
      jal procsec
		
		la		$a0, pswrd
		la		$a1, pwd_str
		jal	strcmp         # call procedure to check password
		
		li		$t0, 0         # go to pwdOK if password is correct
		beq	$v0, $t0, pwdOK
		
		li		$v0, 4         # if password is wrong,
		la		$a0, wrong
		syscall					# print wrong
		
		b     main				# loop the program
		
pwdOK:
      jal	procsec        # call 'procsec' procedure

# OPTION 1 #

next1:
      li		$v0, 4
		la		$a0, opt1
		syscall					# print opt1

		li		$v0, 4
		la		$a0, prompt1
		syscall					# print prompt1
      
		li    $v0, 5
		syscall					# read input
		sw		$v0, 0($sp)		# store 1st input

		li		$v0, 4
		la		$a0, prompt2
		syscall					# print prompt2
		li		$v0, 5
		syscall					# read input
		sw		$v0, 4($sp)		# store 2nd input

		jal	procadd			# call 'procadd' procedure
		add 	$t0, $0, $v0
		
		li		$v0, 4
		la		$a0, sumTxt
		syscall					# print sumTxt
		
		li		$v0, 1
		add 	$a0, $t0, $0
		syscall					# print the sum
		
		b     main				# loop the program

# OPTION 2 #

next2:
      li		$v0, 4
		la		$a0, opt2
		syscall					# print opt2
		
		li		$v0, 4
		la		$a0, prompt1
		syscall					# print prompt1
		li    $v0, 5
		syscall					# read input
		sw		$v0, 0($sp)		# store 1st input

		li		$v0, 4
		la		$a0, prompt2
		syscall					# print prompt2
		li		$v0, 5
		syscall					# read input
		sw		$v0, 4($sp)		# store 2nd input

		li		$v0, 4
		la		$a0, prompt3
		syscall					# print prompt1
		li		$v0, 5
		syscall					# read input
		sw		$v0, 8($sp)		# store 3rd input

		li		$v0, 4
		la		$a0, prompt4
		syscall					# print prompt2
		ori   $v0, $0, 5
		syscall					# read input
		sw		$v0, 12($sp)	# store 4th input

		jal 	procmult		   # call 'procmult' procedure
		add 	$t0, $0, $v0
		
		li		$v0, 4
		la		$a0, prodTxt
		syscall					# print prodTxt
		
		li		$v0, 1
		add 	$a0, $t0, $0
		syscall					# print the product
		
		b     main				# loop the program

# OPTION 3 #

next3:
      li		$v0, 4
		la		$a0, opt3
		syscall					# print opt3

		li		$v0, 4
		la		$a0, prompt5
		syscall					# print prompt5
		
		jal   procstr			# call 'procstr' procedure

		b     main				# loop the program

# OPTION 4 #

next4:
      li		$v0, 4
		la		$a0, opt4
		syscall					# print opt4
		
		li		$v0, 4
		la		$a0, prompt6
		syscall					# print prompt6
		li		$v0, 5
		syscall					# read input (limit)
		addi	$sp, $sp, -16	# allocate the stack
		sw		$v0, 0($sp)		# store the limit
		li		$t0, 0		
		sw		$t0, 4($sp)		# store base case (prev)
		li		$t0, 1		
		sw		$t0, 8($sp)		# store base case (current)
		sw		$ra, 12($sp)	# store register address
		
		jal 	procfib			# call 'procfib' procedure
		
		b     main				# loop the program

# OPTION 5 #

next5:
      li		$v0, 4
		la		$a0, opt5
		syscall					# print opt5
		
		jal   procend		   # call 'procend' procedure

# - - - - - - - - - - - #
# procedure definitions #
# - - - - - - - - - - - #

procadd:
		lw		$a0, 0($sp)
		lw		$a1, 4($sp)
		add	$v0, $a0, $a1	# return (a + b)
		jr		$ra

# - - - - - - - - - - - -  #
procmult:
		lw		$a0, 0($sp)
		lw		$a1, 4($sp)
		lw		$a2, 8($sp)
		lw		$a3, 12($sp)
		li		$v0, 1			# result = 1
		mult	$a0, $a1
		mflo	$v0				# result = a * b
		mult	$v0, $a2
		mflo	$v0				# result *= c
		mult	$v0, $a3
		mflo	$v0				# result *= d
		jr		$ra

# - - - - - - - - - - - -  #
procstr:
		la		$a0, read_str
		la		$a1, 20			# allocate 20 char space for input
		li		$v0, 8
		syscall					# read input
		
		la		$s0, read_str
		la		$s1, read_str
		
while1:
      lb    $t0, 0($s1)
		beq   $t0, 10, end1
		addi  $s1, $s1, 1
		b     while1
		
end1:	addi  $s1, $s1, -1

while2:
      bge   $s0, $s1, end2
		lb    $t0, 0($s0)
		lb    $t1, 0($s1)
		sb    $t0, 0($s1)
		sb    $t1, 0($s0)
		addi  $s0, $s0, 1
		addi  $s1, $s1, -1
		b while2
		
end2:	li    $v0, 4
		la    $a0, revStr
		syscall					# print revStr
		
		la    $a0, read_str
		li    $v0, 4
		syscall					# print the reversed string

		jr    $ra

# - - - - - - - - - - - -  # 
procfib:
		lw		$a1, 0($sp)
		lw		$a2, 4($sp)
		lw		$a3, 8($sp)
		lw		$ra, 12($sp)
		addi	$sp, $sp, 16	# de-allocate the stack
	
		beqz	$a2, base		# if(prev == 0) it's the base case
		
		add 	$t0, $0, $a3	# $t0 = current
		add 	$a3, $a3, $a2	# current = current + prev
		bgt 	$a3, $a1, back	# if(current > limit) recursive done
		add 	$a2, $0, $t0	# prev = $t0
		j		next
	
base:	li		$v0, 1
		li		$a0, 0
		syscall					# print base case
		
		li		$v0, 4
		la		$a0, space
		syscall					# print a space
		
		li		$v0, 1
		add 	$a0, $a3, $0
		syscall					# print base case
		
		li		$v0, 4
		la		$a0, space
		syscall					# print a space
		
		add 	$t0, $0, $a3	# $t0 = current
		add 	$a3, $a3, $a2	# current = current + prev
		add 	$a2, $0, $t0	# prev = $t0

next:	li		$v0, 1
		add 	$a0, $a3, $0
		syscall					# print current
		
		li		$v0, 4
		la		$a0, space
		syscall					# print a space
		
		addi  $sp, $sp, -16	# allocate the stack
		sw 	$a1, 0($sp)		# store limit
		sw 	$a2, 4($sp)		# store prev
		sw 	$a3, 8($sp)		# store current
		sw 	$ra, 12($sp)	# store register address
		jal 	procfib			# recursive call
	
back:	jr 	$ra				# return to register address

# - - - - - - - - - - - -  #
procend:
		li		$v0, 4
		la		$a0, endprg
		syscall					# print endprg

		li     $v0, 10
		syscall					# end program

# - - - - - - - - - - - -  #   
procsec:		
		li		$v0, 4
		la		$a0, bytealloc
		syscall					# print bytealloc
      
      li    $v0, 5
		syscall					# read input
      
      add   $s0, $0, $v0   # $s0 = memory size
      add   $a0, $0, $s0
      li    $v0, 9
		syscall					# read bytealloc
      move  $s1, $v0       # $s1 = memory starting address
		
		li		$v0, 4
		la		$a0, memprint
		syscall					# print memprint
      
      la		$s2, myname    # $s2 = name starting address
      
      li    $t0, 0         # int i = 0
      li    $t1, 0         # count = 0
rpt:  lb    $t2, 0($s2)    # load char from name to $t2
      sb    $t2, 0($s1)    # store char from $t2 to name
      add   $s1, $s1, 1    # increment memory address
      add   $s2, $s2, 1    # increment name address
      add   $t1, $t1, 1    # count++
      add   $t0, $t0, 1    # i++
      beq   $t1, 9, rst    # if(count==9) go to rst
here: blt   $t0, $s0, rpt  # while(i < memory size)
      
      li		$v0, 4
		la		$a0, idheap
		syscall					# print idHeap

		jal   procend        # the program should terminate
      
rst:  li    $t1, 0         # count = 0
      add   $s2, $s2, -9   # reset name from 1st char
      j     here

# - - - - - - - - - - - -  #
strcmp:
		li		$t0, 0
		add	$t1, $0, $a0
		add	$t2, $0, $a1
		
loop:	lb		$t3($t1)  		# load a byte from each string
		lb		$t4($t2)
		beqz	$t3, chk2 		# str1 end
		beqz	$t4, nope
		slt   $t5, $t3, $t4	# compare two bytes
		bnez	$t5, nope
		addi	$t1, $t1, 1  	# $t1 points to the next byte of str1
		addi	$t2, $t2, 1
		j		loop

nope:	li    $v0, 1
		jr    $ra

chk2:	bnez  $t4, nope
		li    $v0, 0
		jr    $ra