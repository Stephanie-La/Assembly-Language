		.data
A: .word 0,0,0
X: .word 0 #to reserve space for an integer (4 bytes for 1 int)
Y: .word 0 #to reserve space for an integer (4 bytes for 1 int)
message: .asciiz " The Sum is:"




		.text
main:
		li $v0, 5 #read 1st integer ex. int x = 0
		syscall #executes action
		sw $v0, X #saved 1st integer in X
		lw $t8, X #load value of x into $t8
		
		li $v0, 5 #read 2nd integer int 
		syscall #executes action
		sw $v0, Y #save 2nd integer in Y ex. int y = 0
		lw $t9, Y #load word of y into $t9
		
		jal sum #jump and link to sum()
		
		move $t0, $a0 #move sum value received from function into $t0 
		la $a0, message #load message above into $a0
		li $v0, 4 #print string from $a0
		syscall #executes action
		move $a0, $t0 #move sum value back into $t0
		li $v0, 1 #print sum out
		syscall #executes action
		li $v0,10 #close and end the program 
		syscall#executes action
		j exit #jump to exit
		
##################################################
#sum(): uses registers, $t8 and $t9, and $a0. Arguments 
#$t8 and $t9 have values that will be passed into 
#$a0 where it is returned to $a0 the main function.
####################################################	
		
sum: 
		add $a0, $t8, $t9 #$a0 = $t8 + $t9 returns sum back to $a0
		jr $ra #returns control to the caller in main
		
exit:
		
		
		
		
		
		
		
		
		
		
		
		
		
