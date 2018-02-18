# Gideon Richter 001181085
# Assignment 3 Computer Architecture 3615
# Compute the factorial function n!

.data
  	prompt_n_value: .asciiz "\nEnter a number (0, 12): " 
  	invalid_input_str: .asciiz "\nError - Invalid Input: Must be (0 < N < 12"
	factorial_result_str: .asciiz "\nThe factorial result is: "
	
.text
main: 
	li $v0, 4 # Print string 
	la $a0, prompt_n_value
	syscall

	li $v0, 5 # Get int n value from user
	syscall
	
	#
	# Check for invalid input 
	#
	blt $v0, 1, invalid_input	
	bgt $v0, 11, invalid_input
	 
	# 
	# If valid: Compute factorial
	#
	move $s0, $v0 # N = Input
	move $t0, $v0 # Decrementing loop counter
	li $t1, 1 # Product result
	
	while_loop: 
		beqz $t0, done_loop	# Loop counter at 0: Break
		mul $t1, $t0, $t1 # Factorial: result = result * (result - 1)
		addi $t0, $t0, -1 # Decrement counter
		j while_loop
	
	#
	# Print factorial result 
	#
	done_loop:
		li $v0, 4 # Print string 
		la $a0, factorial_result_str
		syscall
		
		li $v0, 1 # Print int factorial result
		move $a0, $t1
		syscall
		
		li $v0, 10 # End program 
		syscall
	
	#
	# User input not 0<N<12 as required by assignment
	#
	invalid_input: 
		li $v0, 4 # Print string
		la $a0, invalid_input_str
		syscall
		
		li $v0, 10 # End program 
		syscall
