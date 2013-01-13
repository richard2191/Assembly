# RICHARD THE
# CS264 - LAB 3 PART 1

.data

opts:		.asciiz "\n\nWhat would you like to do?\n"
opt1:    .asciiz "1. Calculate Area of Circle\n"
opt2:    .asciiz "2. Calculate Circumference of Circle\n"
opt3:    .asciiz "3. Calculate Area of Rectangle\n"
opt4:    .asciiz "4. Calculate Perimeter of Rectangle\n"
opt5:    .asciiz "5. Exit Program\n"
prompt:  .asciiz "\nEnter the corresponding number: "
promptR: .asciiz "Enter the radius: "
promptW: .asciiz "Enter the width: "
promptL: .asciiz "Enter the length: "
endprg:	.asciiz " \nGood bye!\n"
areaC:   .asciiz "\nArea of Circle = "
circC:   .asciiz "\nCircumference of Circle = "
areaR:   .asciiz "\nArea of Rectangle = "
periR:   .asciiz "\nPerimeter of Rectangle = "

pi:      .float 3.14159265
zero:    .float 0.0
two:     .float 2.0
zeroD:   .double 0.0
twoD:    .double 2.0

.globl   main

.text

main:
      li	$v0, 4
		la $a0, opts
		syscall			   	# print options

      li	$v0, 4
		la $a0, opt1
		syscall			   	# print opt1
      
      li	$v0, 4
		la $a0, opt2
		syscall			   	# print opt2
      
      li	$v0, 4
		la $a0, opt3
		syscall			   	# print opt3
      
      li	$v0, 4
		la $a0, opt4
		syscall				   # print opt4
      
      li $v0, 4
		la $a0, opt5
		syscall				   # print opt5
      
      li	$v0, 4
		la $a0, prompt
		syscall              # print prompt

		li $v0, 5
		syscall				   # read input
      
      li $t0, 1
		beq $v0, $t0, next1
      
      li $t0, 2
		beq $v0, $t0, next2
      
      li $t0, 3
		beq $v0, $t0, next3
      
      li $t0, 4
		beq $v0, $t0, next4
      
      li $t0, 5
		beq $v0, $t0, next5
      
      li	$v0, 4
		la $a0, wrong
		syscall					# print wrong
		b main					# loop the program
      
# OPTION 1
next1:
      li	$v0, 4
		la	$a0, opt1
		syscall					# print opt1

		li	$v0, 4
		la	$a0, promptR
		syscall					# print promptR
      
		li $v0, 6
		syscall					# read input in float
		l.s $f12, zero
      add.s $f12, $f12, $f0
      
      jal proc1            # call function
      l.s $f4, zero
      add.s $f4, $f4, $f0  # store return value in $f4
      
      li	$v0, 4
		la	$a0, areaC
		syscall					# print area of circle
      
      li	$v0, 2
      l.s $f12, zero
		add.s $f12, $f12, $f4
		syscall					# print the area
		
		b main   				# loop the program

# OPTION 2
next2:
      li	$v0, 4
		la	$a0, opt2
		syscall					# print opt2

		li	$v0, 4
		la	$a0, promptR
		syscall					# print promptR
      
		li $v0, 6
		syscall					# read input in float
		l.s $f12, zero
      add.s $f12, $f12, $f0
      
      jal proc2            # call function
      l.s $f4, zero
      add.s $f4, $f4, $f0  # store return value in $f4
      
      li	$v0, 4
		la	$a0, circC
		syscall					# print circumference of circle
      
      li	$v0, 2
      l.s $f12, zero
		add.s $f12, $f12, $f4
		syscall					# print the circumference
		
		b main   				# loop the program

# OPTION 3
next3:
      li	$v0, 4
		la	$a0, opt3
		syscall					# print opt3

		li	$v0, 4
		la	$a0, promptW
		syscall					# print promptW
      
      li $v0, 7
		syscall					# read width in double
		l.d $f12, zeroD
      add.d $f12, $f12, $f0
      
      li	$v0, 4
		la	$a0, promptL
		syscall					# print promptL
      
		li $v0, 7
		syscall					# read length in double
		l.d $f14, zeroD
      add.d $f14, $f14, $f0
      
      jal proc3
      l.d $f4, zeroD
      add.d $f4, $f4, $f0  # store return value in $f4
      
      li	$v0, 4
		la	$a0, areaR
		syscall					# print area of rectangle
      
      li	$v0, 3
      l.d $f12, zeroD
		add.d $f12, $f12, $f4
		syscall					# print the area
		
		b main   				# loop the program

# OPTION 4
next4:
      li	$v0, 4
		la	$a0, opt4
		syscall					# print opt4

		li	$v0, 4
		la	$a0, promptW
		syscall					# print promptW
      
      li $v0, 7
		syscall					# read width in double
		l.d $f12, zeroD
      add.d $f12, $f12, $f0
      
      li	$v0, 4
		la	$a0, promptL
		syscall					# print promptL
      
		li $v0, 7
		syscall					# read length in double
		l.d $f14, zeroD
      add.d $f14, $f14, $f0
      
      jal proc4
      l.d $f4, zeroD
      add.d $f4, $f4, $f0  # store return value in $f4
      
      li	$v0, 4
		la	$a0, periR
		syscall					# print perimeter of rectangle
      
      li	$v0, 3
      l.d $f12, zeroD
		add.d $f12, $f12, $f4
		syscall					# print the perimeter
		
		b main   				# loop the program

# OPTION 5
next5:
      jal proc5

#########################
# procedure definitions #
#########################

proc1:
      l.s $f14, pi            # load pi
      
      mul.s $f0, $f12, $f12   # A = r * r
      mul.s $f0, $f0, $f14    # A *= pi
      
      jr $ra

proc2:
      l.s $f14, pi            # load pi
      l.s $f0, two            # load a constant (2.0)
      
      mul.s $f0, $f0, $f12    # A = 2 * r
      mul.s $f0, $f0, $f14    # A *= pi

      jr $ra

proc3:
      mul.d $f0, $f12, $f14   # A = W * L
      jr $ra

proc4:
      l.d $f4, twoD           # load a constant (2.0)
      add.d $f12, $f12, $f14  # X = W + L
      mul.d $f0, $f4, $f12    # A = 2 * X
      jr $ra

proc5:
      li	$v0, 4
		la	$a0, endprg
		syscall					# print endprg

		li $v0, 10
		syscall					# end program