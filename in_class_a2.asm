# Gideon Richter 001181085
# Assignment 2 Computer Architecture 3615
# Input an array, sort it, then output

.data
	prompt_input_size: .asciiz "Please enter the size of the list: " 
	prompt_input_element: .asciiz "Please enter the element\n"
	space: .asciiz " "
	list_length: .word 0 
	list: .space 100 
	end_of_list_offset: .word 0

.text

.macro print_string(%string)
	# Print string to output
	li $v0, 4 					
	la $a0, %string 			
	syscall
.end_macro

.macro print_integer(%integer)
	li $v0, 1						
	syscall 
.end_macro

.macro get_integer_from_user()
	li $v0, 5					 
	syscall
.end_macro
	
.macro end_program() 
	li $v0, 10						
	syscall
.end_macro

main: 
	print_string(prompt_input_size)
	get_integer_from_user()
		
	sw $v0, list_length			# keep input size in memory
	lw  $a1, list_length		# move contents input_size to $a1
	
	li $s1, 0					# initialize loop counter to 0
	li $t2, 0					# initialize offset to 0
	la $t0, list 				# load address of list to $t0
	
	input_loop: 							
		addi $s1, $s1, 1				# increment index
		bgt $s1, $a1, end_input_loop	# if index > size, break
	
		print_string(prompt_input_element)
		
		get_integer_from_user()

		add $t3, $t0, $t2				# calculate the address to store input
		sw $v0, 0($t3)					# save the input to list address 
		addi $t2, $t2, 4				# adjust the offset to next list element
			
		j input_loop						
	end_input_loop: 	

	sw $t2, end_of_list_offset
	### SORT ###
		
	jal sort_array

	### /SORT ###
		
	li $s1, 0							# initialize index to 0 
	li $t2, 0							# initialize offset to 0
	la $t0, list 						# load the address of list in $t0
		
	output_loop: 
		addi $s1, $s1, 1				# increment index
		bgt $s1, $a1, end_output_loop	# if index > size, break
			
		add $t3, $t0, $t2				# calculating the address of current element
		lw $a0, 0($t3) 					# load the current element from address of $t3 to $a0
			
		print_integer(a0)
		print_string(space)
			
		addi $t2, $t2, 4				# increase offset to next space in array
			
		j output_loop		
	end_output_loop: 
			
	end_program()
	
sort_array: 
	la $a0, list	
	la $t0, list_length
	lw $a1, list_length
	addi $a1, $a1, -1	# set offset to last element 
	
	sll $a1, $a1, 2
	add $a1, $a0, $a1
	
	jr $ra
	
	
