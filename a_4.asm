# Gideon Richter 001181085
# 3660 Computer Architecture 
# Assignment 4 - Let the user inputs their full name, use spaces to seperate 
# the names then print out the chracters in the first and the last name reversely.
# Well TBH you can enter whatever you want not just your name. 

.data 
	prompt_input_name: .asciiz "Please enter your name: "
	input_string: .space 200
	
.text
main: 
	li $v0, 4 # Print string
	la $a0, prompt_input_name
	syscall

	li $v0, 8  # Read string 
	la $a0, input_string
	li $a1, 50
	syscall

	#la $t0 test_string	# Load test_string address
	la $t0 input_string	# Load test_string address
	
	size_loop: # Loop to find size of input
		lb 	$t1 0($t0) # Load character
		beq $t1 $zero end_size_loop # If character is null value break
		addi $t0 $t0 1	# Else increment counter
		j size_loop	# Continue
	end_size_loop:
	
	la 	$t6 input_string	# Load test_string address for base addressing
	sub $t7 $t0 $t6 # Size of input string
	li $t0 0 # While loop index
	li $t3 0 # Offset for retreiving test_string characters
	li $t4 0 # Word character counter for reverse loop
	
	while_loop: # Loop over all the characters in input
		bgt $t0, $t7, end_while_loop	# If we reached the end, GOTO end_while_loop
		
		add $t3, $t0, $t6 # Compute address of character
		lb $t3, 0($t3)	# Load character value to $t3
		
		bne $t3, 32, else	# If $t3 is not a space, GOTO else
		li $t5, 0	# Else make $t5 a loop counter
		reverse_loop: # Pop pushed characters from the stack and print them
			beq $t5 $t4 end_reverse_loop	# If we reached the end of the word, GOTO end_reverse_loop
			lw $a0 ($sp) # Pop off character stack
			addi $sp $sp 4 # Adjust stack pointer
			li $v0 11	# Load print character 
			syscall 	
			addi $t5 $t5 1 # Increment reverse_loop counter
			j reverse_loop	
		end_reverse_loop:
		li $a0 32 # Load a space to $a0
		li $v0 11 # Load print character
		syscall 

		addi $t0, $t0, 1	# Increment while_loop counter
		li $t4 0 # set word character counter back to zero
		j while_loop	
		
		else: # If character was not a space
		sub $sp $sp 4 # Adjust the stack pointer
		sb $t3 ($sp) # Push the character onto the stack

		addi $t4, $t4, 1	# Incremenet word character counter
		addi $t0, $t0, 1	# Increment while_loop counter
		j while_loop
	
	end_while_loop:
		li $t5 0	 # Make $t5 a loop counter
		last_reverse_loop: # We reverse from the last space to the last character, repeat code but oh well
			beq $t5 $t4 end_last_reverse_loop	# If we reached the end of the word, GOTO end_last_reverse_loop
			
			lw $a0 ($sp) # Pop off character stack
			addi $sp $sp 4 # Adjust stack pointer
			
			li $v0 11	# Load print character
			syscall
			
			addi $t5 $t5 1 # Incremenet loop counter
			j last_reverse_loop
			
		end_last_reverse_loop:
	
	li $v0 10
	syscall