# Gideon Richter 001181085
# Assignment 1 Computer Architecture 3615
# Input an array, find min and max values, then output 

.data
  prompt_input_size: .asciiz "Please enter the size of the list: " 
  prompt_input_value: .asciiz "Please enter the element\n"
	
  the_list_is_string: .asciiz "\nThe list is "
  the_max_is_string: .asciiz "\nThe Max is "
  the_min_is_string: .asciiz "\nThe Min is "
  space: .asciiz " "
	
  list_length: .word 0 
  list: .space 100 

.text

main: 
  #
  # Get user to input list
  # 
  li $v0, 4 # Print string
  la $a0, prompt_input_size
  syscall
  
  li $v0, 5 # Get int list size from user
  syscall

		
  sw $v0, list_length # Store list length in memory
  lw $a1, list_length # Load list length into $a1
	
  li $s1, 0 # Initialize loop counter to 0
  li $t2, 0 # Initialize offset to 0
  la $t0, list # Load address of list to $t0
	
  #
  # Fill list and find min and max at same time 
  #
  li $s5, 1 # Boolean flag, first iteration
	
  input_loop: 
    add $s1, $s1, 1 # Increment index
    bgt  $s1, $a1, end_input_loop # If index > size: Break
	
    li $v0, 4 # Print string
    la $a0, prompt_input_value
    syscall
    
    li $v0, 5 # Get int list value from user
    syscall
		
    beqz $s5, continue_first_time # If not first time, skip
		move $s3, $v0 # Min = Input 
		move $s4, $v0 # Max = Input
		li   $s5, 0	# Skip next time
		continue_first_time:
		
		bgt $v0, $s3, continue_min # If input > min: Skip next line
		move $s3, $v0 # Min = Input			
		continue_min:  
		
		blt $v0, $s4, continue_max # If input < max: Skip next line			
		move $s4, $v0 # Max = Input 
		continue_max:

		add  $t3, $t0, $t2 # Calculate address to store value in list
		sw   $v0, 0($t3) # Store value in list address 
		addi $t2, $t2, 4
			
		j input_loop						
	end_input_loop: 	

	#
	# Output Sorted List to Screen 
	#
	li $s1, 0 # Init index to 0 
	li $t2, 0 # Init offset to 0
	lw $a1, list_length # Load list length to $a1
	la $t0, list # Load list address to $t0
	
	li $v0, 4 # Print string
	la $a0, the_list_is_string
	syscall
		
	output_loop: 
		addi $s1, $s1, 1 # Index = Index + 1
		bgt  $s1, $a1, end_output_loop # If index > size: Break
			
		add $t3, $t0, $t2 # Current element = List address + Offset
		lw  $a0, 0($t3) # Load value of current element to $a0
			
		li $v0, 1 # Print integer
		syscall	
		
		li $v0, 4 # Print string
		la $a0, space
		syscall					
			
		addi $t2, $t2, 4 # Offset = Next element 
				
		j output_loop		
	end_output_loop: 
	
	li $v0, 4 # Print string
	la $a0, the_min_is_string
	syscall
	
	li $v0, 1 # Print integer (min)
	move $a0, $s3
	syscall
	
	li $v0, 4 # Print string 
	la $a0, the_max_is_string
	syscall
	
	li $v0, 1 # Print integer (max)
	move $a0, $s4
	syscall
			
	li $v0, 10 # End program
	syscall 
