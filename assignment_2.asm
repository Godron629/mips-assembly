# Gideon Richter 001181085
# Assignment 2 Computer Architecture 3615
# Input two numbers, output their addition, subtraction, multiplication, and division results

.data
	prompt_input_x: .asciiz "\nEnter the first number: " 
  	prompt_input_y: .asciiz "\nEnter the second number: "
  
 	add_result_str: .asciiz "\nThe addition result is: "
 	sub_result_str: .asciiz "\nThe subtraction result is: "
  	mul_result_str: .asciiz "\nThe multiplication result is: " 
  	div_result_str: .asciiz "\nThe division result is: "
	
.text 

main: 
	
	li $v0, 4 # Print string
	la $a0, prompt_input_x
	syscall
	
	li $v0, 5 # Get int x from user
	syscall
	
	move $s1, $v0
	
	li $v0, 4 # Print string
	la $a0, prompt_input_y
	syscall
	
	li $v0, 5 # Get int y from user
	syscall
	
	move $s2, $v0
	
	#
	# Addition
	#
	add $t0, $s1, $s2
	
	li $v0, 4 # Print string
	la $a0, add_result_str
	syscall
	
	li $v0, 1 # Print integer result of x + y
	move $a0, $t0
	syscall
	
	#
	# Subtraction 
	#
	sub $t0, $s1, $s2
	
	li $v0, 4 # Print string
	la $a0, sub_result_str
	syscall
	
	li $v0, 1 # Print integer result of x - y
	move $a0, $t0
	syscall
	
	#
	# Multiplication 
	#
	mul $t0, $s1, $s2
	
	li $v0, 4 # Print string
	la $a0, mul_result_str
	syscall
	
	li $v0, 1 # Print integer result of x * y
	move $a0, $t0
	syscall
	
	#
	# Division
	#
	div $t0, $s1, $s2 
	
	li $v0, 4 # Print string
	la $a0, div_result_str
	syscall
	
	li $v0, 1 # Print integer result of x / y
	move $a0, $t0
	syscall
	
	li $v0, 10 # End program 
	syscall
	

	
