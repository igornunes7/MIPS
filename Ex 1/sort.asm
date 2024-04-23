addi $v0, $zero, 5
syscall
add $s0, $v0 , $zero #lendo a

addi $v0, $zero, 5
syscall
add $s1, $v0 , $zero #lendo b

addi $v0, $zero, 5
syscall
add $s2, $v0 , $zero #lendo c

addi $v0, $zero, 5
syscall
add $s3, $v0 , $zero #lendo d



############
slt $t0, $s1, $s0 #t0 = b < a


beq $t0, $zero, IF #se b < a
	add $t9, $zero, $s0 #temp = a
	add $s0 , $zero, $s1 #a = b
	add $s1 , $zero, $t9 #b = temp
	
	
IF:
	
############	
slt $t1, $s2, $s0 #t1 = c < a


beq $t1, $zero, IF1 #se c < a
	add $t9, $zero, $s0 #temp = a
	add $s0 , $zero, $s2 #a = c
	add $s2 , $zero, $t9 #c = temp


IF1:

############
slt $t2, $s3, $s0 #t2 = d < a


beq $t2, $zero, IF2 #se d < a
	add $t9, $zero, $s0 #temp = a
	add $s0 , $zero, $s3 #a = d
	add $s3 , $zero, $t9 #d = temp

IF2:

############
slt $t3, $s2, $s1 #t3 = c < b


beq $t3, $zero, IF3 #se c < b
	add $t9, $zero, $s1 #temp = b
	add $s1 , $zero, $s2 # b = c
	add $s2 , $zero, $t9 #c = temp

IF3:

############
slt $t4, $s3, $s1 #t4 = d < b


beq $t4, $zero, IF4 #se d < b
	add $t9, $zero, $s1 #temp = b
	add $s1 , $zero, $s3 #b = d
	add $s3 , $zero, $t9 #d = temp


IF4: 

############
slt $t5, $s3, $s2 #t5 = d < c


beq $t5, $zero, IF5 #se d < c
	add $t9, $zero, $s2 #temp = c
	add $s2 , $zero, $s3 # c = d
	add $s3 , $zero, $t9 #d = temp

IF5:

############
addi $v0, $zero, 1
add $a0, $s0, $zero #imprimindo a
syscall

addi $v0, $zero, 11
addi $a0, $zero, 32 #separando os numeros na impressao
syscall

addi $v0, $zero, 1
add $a0, $s1, $zero #imprimindo b
syscall

addi $v0, $zero, 11
addi $a0, $zero, 32 #separando os numeros na impressao
syscall

addi $v0, $zero, 1
add $a0, $s2, $zero #imprimindo c
syscall

addi $v0, $zero, 11
addi $a0, $zero, 32 #separando os numeros na impressao
syscall

addi $v0, $zero, 1
add $a0, $s3, $zero #imprimindo d
syscall

addi $v0, $zero, 11
addi $a0, $zero, 32 #separando os numeros na impressao
syscall
