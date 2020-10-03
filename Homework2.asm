#Stephanie La

		.data
inBuf:	.space 80	#input line, space of 80 character max 
outBuf: .space 80	#char lines for the input line	
#prompt: .asciiz		"Enter a new string .\n"

		.text
main:
		jal 	getline			#getline
		lb 	$t0, inBuf 		#loads byte into inBuf[i]
		beq 	$t0, '#', exit 		#if $t0 == # then break
		
		li 	$t0, 0 			#i = 0
rept:
		
		bge 	$t0, 80, dump 		# i >= 80 goto dump
		lb 	$s1, inBuf($t0) 	#key = inBuf[i]
		
		jal 	lin_search 		
		addi 	$s2, $s2, 0x30 		#ascii code
		sb	$s2, outBuf($t0)	#outBuf[i] = char(type)
		
		beq 	$s1, '#', dump		#key == #, goto to dump s
		addi	$t0, $t0, 1		# i++
		b	rept			#loop
		
dump:
		jal	printInBuf
		jal	printOutBuf
		jal	clearInBuf
		jal	clearOutBuf
		
		b	main			#back to main loop

exit:
		li $v0, 10			#to end program
		syscall

		
		
######################
#
# getline()
#
#
#######################
		.data
prompt:		.asciiz		"Enter a new string: \n"

		.text
		
		.data
newline: .asciiz		"\n"
		
		.text
		
getline:
		la	$a0, prompt		#enter a new line
		li	$v0, 4
		syscall

		la	$a0, inBuf		#read a new line
		li	$a1, 80	
		li	$v0, 8
		syscall

		jr	$ra


######################
#
# lin_search()
#
#
#######################
		.text
lin_search:	
		li	$t1, 0 			#i = 0
		
loop:
		lw 	$t2, Tabchar($t1) 	#t2= tabchar[i]
		
		beq 	$t2, $s1, found		#if tabchar[i]==key goto found
		beq 	$t2, 0x5c, found	#if Tabchar[i] == end of Tabchar, goto found 
		addi 	$t1, $t1, 8		# increment i by 8, char = 8 bytes
		b 	loop			
		
found:
		addi 	$t1, $t1, 4 		
		lw 	$s2, Tabchar($t1)	#char(type) = tabchar[i]
		jr 	$ra
		
############
#
# printInBuf()
#
#
###########
		.text
printInBuf:
		la 	$a0, inBuf		#load inBuf in $a0
		li 	$v0, 4			#and print to screen inBuf
		syscall

		la 	$a0, newline		#enter a new line
		li	$v0, 4
		syscall
		
		jr	$ra			#back to main
		
############
#
# printOutBuf()
#
#
###########
		.text
printOutBuf:
		la 	$a0, outBuf		#load outBuf into $a0
		li 	$v0, 4			#and print to screen outBuf
		syscall
		
		la 	$a0, newline		#enter a new line
		li 	$v0, 4
		syscall
		
		jr 	$ra			#back to main
			
############
#
# clearInBuf()
#
#
###########
		.text
clearInBuf:

for:
		li 	$t3, 0			
		blt 	$t3, 80, done		#exit if counter is at 80th element 
		sb 	$0, inBuf($t3)	
		#lb	$t4, inBuf($t3)		 
		addi 	$t3, $t3, 1		# i++
		b  	for
done: 		
		jr $ra
		
############
#
# clearOutBuf()
#
#
###########
		.text
clearOutBuf:
looping:	
		li	$t4, 0 			
		blt	$t4, 80, finish		#exit loop if counter is at last element
		sb	$0, outBuf($t4)		#set outBuf[i] to null
		#lb	$t5, outBuf($t4)
		addi 	$t4, $t4, 1		# i++
		b 	looping
		
finish: 		
		jr 	$ra

############
#
# Tabchar()
#
#
###########
		.data
Tabchar: 	
	.word 	0x0a, 6		# LF
	.word 	' ', 5
 	.word 	'#', 6
	.word 	'$',4
	.word 	'(', 4 
	.word 	')', 4 
	.word 	'*', 3 
	.word 	'+', 3 
	.word 	',', 4 
	.word 	'-', 3 
	.word 	'.', 4 
	.word 	'/', 3 

	.word 	'0', 1
	.word 	'1', 1 
	.word 	'2', 1 
	.word 	'3', 1 
	.word 	'4', 1 
	.word 	'5', 1 
	.word 	'6', 1 
	.word 	'7', 1 
	.word 	'8', 1 
	.word 	'9', 1 

	.word 	':', 4 

	.word 	'A', 2
	.word 	'B', 2 
	.word 	'C', 2 
	.word 	'D', 2 
	.word 	'E', 2 
	.word 	'F', 2 
	.word 	'G', 2 
	.word 	'H', 2 
	.word 	'I', 2 
	.word 	'J', 2 
	.word 	'K', 2
	.word 	'L', 2 
	.word 	'M', 2 
	.word 	'N', 2 
	.word 	'O', 2 
	.word 	'P', 2 
	.word 	'Q', 2 
	.word 	'R', 2 
	.word 	'S', 2 
	.word 	'T', 2 
	.word 	'U', 2
	.word 	'V', 2 
	.word 	'W', 2 
	.word 	'X', 2 
	.word 	'Y', 2
	.word 	'Z', 2

	.word 	'a', 2 
	.word 	'b', 2 
	.word 	'c', 2 
	.word 	'd', 2 
	.word 	'e', 2 
	.word 	'f', 2 
	.word 	'g', 2 
	.word 	'h', 2 
	.word 	'i', 2 
	.word 	'j', 2 
	.word 	'k', 2
	.word 	'l', 2 
	.word 	'm', 2 
	.word 	'n', 2 
	.word 	'o', 2 
	.word 	'p', 2 
	.word 	'q', 2 
	.word 	'r', 2 
	.word 	's', 2 
	.word 	't', 2 
	.word 	'u', 2
	.word 	'v', 2 
	.word 	'w', 2 
	.word 	'x', 2 
	.word 	'y', 2
	.word 	'z', 2

	.word	0x5c, -1	# if you ‘\’ as the end-of-table symbol

