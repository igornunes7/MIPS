.text 

addi $v0, $zero, 5
syscall
add $s5, $v0 , $zero #lendo n


addi $v0, $zero, 9 #em v0 temos o endereco da memoria alocada
mul $a0, $s5, 4  #alocando espaço para n * 4 bytes
syscall

add $s0, $zero, $v0 #agora s0 e o endereco inicial do array


#inicializando o ponteiro para percorrer o array
add $s1, $zero, $s0 #copiando em s1 o endereco alocado em s0


mul $s6, $s5, 4
add $t0, $s0, $s6 

FOR:
   slt $t1, $s1, $t0
   beq $t1, $zero, fim_for
   addi $v0, $zero, 5 #lendo
   syscall
   sw $v0 ,0($s1) #primeira posicao do vetor
   addi $s1, $s1, 4 #adicionando +4 no ptr
   j FOR
fim_for:



mul $s7, $s5, 4
add $t3, $s0, $s7 

add $s1, $zero, $s0 #copiando em s1 o endereco alocado em s0

lw $a0, 0($s1)
add $t6, $a0, $zero ##t6 é meu menor elemento

lw $a0, 0($s1)
add $t4, $a0, $zero ##t4 é meu maior elemento

FOR2:
   slt $t2, $s1, $t3
   beq $t2, $zero, fim_for2
   
   #imprime
   lw $a0, 0($s1)   #carrega o valor do endereço de memória em $s1 para $a0
   
   add $t5, $a0, $zero 
   
   slt $t0, $t5, $t6 ##se t5 < t6, retorna 1 se for verdade
   
   
   beq $t0, $zero, ELSE
   	add $t6, $zero, $zero
   	add $t6, $t5, $zero
    
   ELSE:
   	#nada acontece

   
   slt $t0, $t4, $t5 ## se t4 < t5, retorna 1 se for verdade
   
   
   beq $t0, $zero, ELSE2
   	add $t4, $zero, $zero
   	add $t4, $t5, $zero
   ELSE2:
     #nada acontece
	
   addi $s1, $s1, 4 #adicionando +4 no ptr
   j FOR2
 fim_for2:
 
 
mul $s7, $s5, 4
add $t3, $s0, $s7 

add $s1, $zero, $s0 #copiando em s1 o endereco alocado em s0


FOR3:
   slt $t2, $s1, $t3
   beq $t2, $zero, fim_for3
   
   #imprime
   lw $a0, 0($s1)   #carrega o valor do endereço de memória em $s1 para $a0
   add $t5, $a0, $zero 
   
   bne $t5, $t4, ELSE3
  	addi $v0, $zero, 11  ##syscall para imprimir caractere
  	addi $a0, $zero, 34  ##aspas duplas
  	syscall
  
  	addi $v0, $zero, 1
  	add $a0, $zero, $t5
  	syscall
  
  	addi $v0, $zero, 11  ##syscall para imprimir caractere
  	addi $a0, $zero, 34  ##aspas duplas
  	syscall
  	
  	addi $v0, $zero, 11
  	addi $a0, $zero, 32
  	syscall

   	addi $s1, $s1, 4 #adicionando +4 no ptr
   
   	j FOR3
   ELSE3:
     #nada acontece
   
   bne $t5, $t6, ELSE4
  	addi $v0, $zero, 11  ##syscall para imprimir caractere
  	addi $a0, $zero, 34  ##aspas duplas
  	syscall
  
  	addi $v0, $zero, 1
  	add $a0, $zero, $t5
  	syscall
  
  	addi $v0, $zero, 11  ##syscall para imprimir caractere
  	addi $a0, $zero, 34  ##aspas duplas
  	syscall
  	
  	addi $v0, $zero, 11
  	addi $a0, $zero, 32
  	syscall
  
    addi $s1, $s1, 4 #adicionando +4 no ptr
     
    j FOR3

    
   ELSE4:
     #nada acontece

   
   addi $v0, $zero, 1  
   syscall
     
   addi $v0, $zero, 11
   addi $a0, $zero, 32
   syscall
  
   addi $s1, $s1, 4 #adicionando +4 no ptr
     
   j FOR3
fim_for3:

addi $v0, $zero, 10
syscall
