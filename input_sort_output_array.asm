# Gideon Richter 001181085
# In-Class Assignment 2 Computer Architecture 3615
# Input an array, selection sort it, then output

.data
	prompt_input_size: .asciiz "Please enter the size of the list: " 
	prompt_input_element: .asciiz "Please enter the element\n"
	space: .asciiz " "
	list_length: .word 0 
	list: .space 100 
	end_of_list_offset: .word 0

.text

main: 
	## Get User to Input List ##
	li $v0, 4 # print string
	la $a0, prompt_input_size 
	syscall
	
	li $v0, 5 # get list size from user
	syscall
		
	sw $v0, list_length # keep input size in memory
	lw $a1, list_length	# move contents input_size to $a1
	
	li $s1, 0 # initialize loop counter to 0
	li $t2, 0 # initialize offset to 0
	la $t0, list # load address of list to $t0
	
	input_loop: 
		addi $s1, $s1, 1 # increment index
		bgt  $s1, $a1, end_input_loop # if index > size, break
	
		li $v0, 4 # print string
		la $a0, prompt_input_element
		syscall
		
		li $v0, 5 # get value from user
		syscall

		add  $t3, $t0, $t2	# calculate the address to store input
		sw   $v0, 0($t3) # save the input to list address 
		addi $t2, $t2, 4 # adjust the offset to next list element
			
		j input_loop						
	end_input_loop: 	

	## Selection Sort Input ##
	la 	 $a0, list # pointer to first element in unsorted part
	addi $a1, $a1, -1	
	sll  $a1, $a1, 2	
	add  $a1, $a0, $a1 # pointer to last element in unsorted part
	lw   $t0, 0($a1) # temporary place for value of last element
	
	sort: 
		beq  $a0, $a1, done_sort # if single element, already sorted
		jal  max
		lw   $t0, 0($a1) # load last element into $t0
		sw   $t0, 0($v0) # copy last element to max location
		sw   $v1, 0($a1) # copy max value to last element 
		addi $a1, $a1, -4 # decrement pointer to last element
		j    sort # repeat sort for smaller list
	
	max: 
		addi $v0, $a0, 0 # init max pointer to first element
		lw   $v1, 0($v0) # init max value to first value
		addi $t0, $a0, 0 # init next pointer to first
		
		loop: 
			beq	 $t0, $a1, ret # if next = last, return : fixed typo $a0
			addi $t0, $t0, 4 # advance to next element 
			lw 	 $t1, 0($t0) # load next element into $t1
			slt  $t2, $t1, $v1 # (next)<(max)?
			bne  $t2, $zero, loop # if (next)<(max) repeat with n/c
			addi $v0, $t0, 0 # next element is new max element 
			addi $v1, $t1, 0 # next value is new max value
			j 	 loop # change completed; now repeat
			
	ret: 
		jr $ra

	done_sort: 
	
	## Output Sorted List to Screen ##
	la $t0, list_length	# load the address of size to t0
	lw $a1 0($t0) # load the value of size to a1
	
	li $s1, 0 # initialize index to 0 
	li $t2, 0 # initialize offset to 0
	la $t0, list # load the address of list in $t0
		
	output_loop: 
		addi $s1, $s1, 1 # increment index
		bgt  $s1, $a1, end_output_loop # if index > size, break
			
		add $t3, $t0, $t2 # calculating the address of current element
		lw  $a0, 0($t3) # load the current element from address of $t3 to $a0
		
		li $v0, 1 # print integer
		syscall 
		
		li $v0, 4 # print string
		la $a0, space
		syscall
			
		addi $t2, $t2, 4		# increase offset to next space in array
			
		j output_loop		
	end_output_loop: 
		
	li $v0, 10 # end program 
	syscall	
