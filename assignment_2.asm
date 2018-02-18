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

.macro print_str(%str)
 	 # :param %str addr: Address of .asciiz 
  	li $v0, 4 					
  	la $a0, %str 			
  	syscall
.end_macro

.macro print_int(%int)
  	# :param %int addr: Register/Address of word
  	li $v0, 1						
  	la $a0, (%int)
  	syscall 
.end_macro

.macro get_int_from_user()
  	# :side_effect: input stored in $v0
  	li $v0, 5					 
  	syscall
.end_macro
	
.macro end_program()
  	li $v0, 10						
  	syscall
.end_macro

.macro increase_by(%x, %amount)
  	# :param %x reg: Register with numeric value
 	# :param %amount: Amount to increase %x by
  	addi %x, %x, %amount
.end_macro 

.text 

main: 
	
	print_str(prompt_input_x)
	get_int_from_user()
	move $s1, $v0
	
	print_str(prompt_input_y)
	get_int_from_user()
	move $s2, $v0
	
	#
	# Addition
	#
	add $t0, $s1, $s2
	print_str(add_result_str)
	print_int($t0)
	
	#
	# Subtraction 
	#
	sub $t0, $s1, $s2
	print_str(sub_result_str)
	print_int($t0)
	
	#
	# Multiplication 
	#
	mul $t0, $s1, $s2
	print_str(mul_result_str)
	print_int($t0)
	
	#
	# Division
	#
	div $t0, $s1, $s2 
	print_str(div_result_str)
	print_int($t0)
	
	end_program()
	

	