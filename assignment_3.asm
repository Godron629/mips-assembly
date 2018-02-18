# Gideon Richter 001181085
# Assignment 3 Computer Architecture 3615
# Compute the factorial function n!

.data
  	prompt_n_value: .asciiz "\nEnter a number (0, 12): " 
  	invalid_input_str: .asciiz "\nError - Invalid Input: Must be (0 < N < 12"
	factorial_result_str: .asciiz "\nThe factorial result is: "
	
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

main: 
	print_str(prompt_n_value)
	get_int_from_user()
	
	#
	# Check for invalid input 
	#
	blt $v0, 1, invalid_input	
	bgt $v0, 11, invalid_input
	 
	# 
	# If valid: Compute factorial
	#
	move $s0, $v0	# N = Input
	move $t0, $v0	# Decrementing loop counter
	li $t1, 1		# Product result
	
	while_loop: 
		beqz $t0, done_loop		# Loop counter at 0: Break
		mul $t1, $t0, $t1		# Factorial: result = result * (result - 1)
		increase_by($t0, -1)	# Decrement counter
		j while_loop
	
	#
	# Print factorial result 
	#
	done_loop:
		print_str(factorial_result_str)
		print_int($t1)
		end_program()
	
	#
	# User input not 0<N<12 as required by assignment
	#
	invalid_input: 
		print_str(invalid_input_str)
		end_program()
	