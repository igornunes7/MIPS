##Trabalho incompleto -> Faltou implementar o Bresenham em todos os pontos

.data
display: .space 0x80000 #0x10010000 (inicio)
buffer_arquivo: .space 0x0400 #0x10090000
local_arquivo: .asciiz "/home/thx/Desktop/T1 LM/teste.txt" 


.text
main:
    # Abrir arquivo
    addi $v0, $zero, 13       
    lui $t0, 0x1009
    ori $a0, $t0, 0x0400      
    addi $a1, $zero, 0        
    syscall
    add $s0, $zero, $v0       # $s0 = descritor do arquivo
    
    #auxiliar das cores (R = 0, G = 1, B = 2)
    addi $s2, $zero, 0   
    
    #auxiliar para verificar se: cores = 0, pontos = 1
    add $s7, $zero, $zero
    #R 
    addi $s3, $zero, 0   
     
    #G
    addi $s4, $zero, 0  
    
    #B      
    addi $s5, $zero, 0        
    
    #auxiliar para armazenar o valor
    add $t1, $zero, $zero    
    
    
read_loop:
    # Ler um caractere do arquivo
    addi $v0, $zero, 14      
    add $a0, $zero, $s0       # descritor do arquivo
    lui $a1, 0x1009
    ori $a1, $a1, 0x0000      
    addi $a2, $zero, 1        
    syscall
    
    beq $v0, $zero, close_file   # Se EOF, fechar o arquivo
    
    lw $s6, 0($a1)   
                
    addi $t3, $zero, 10   # t3 = 10 (\n) (por conta do ultimo y da linha)
    beq $s6, $t3, point_y_reset
    
    # Verifica se está processando as cores (R, G, B)
    beq $s7, $zero, process_color 
    bne $s7, $zero, process_point
    
    j read_loop
    
process_color:
    addi $t3, $zero, 44           # t3 = 44 (,)
    beq $s6, $t3, VIRGULA  
        
    addi $t7, $zero, 32  #t7 = 32 ( )
    beq $s6, $t7, VIRGULA
    
    
    addi $t4, $zero, 48            # '0' = 48
    addi $t5, $zero, 57            # '9' = 57
    
    #cerifica se o caractere é um dígito entre '0' e '9'
    slt $t6, $s6, $t4             
    bne $t6, $zero, FIM_CHAR
    
    slt $t6, $t5, $s6              
    bne $t6, $zero, FIM_CHAR
    
    # Converte caractere ASCII para valor numérico
    sub $t6, $s6, $t4              # $t6 = $s6 - '0'
    

    addi $t2, $zero, 10
    mult $t1, $t2                   #multiplica $t1 por 10
    mflo $t1                        #move o resultado da multiplicação para $t1
    add $t1, $t1, $t6               #adiciona o dígito atual
    
    j read_loop  
    
    
process_point:
    addi $t3, $zero, 44   # t3 = 44 (,)
    beq $s6, $t3, point_x     
    
    addi $t7, $zero, 32  #t7 = 32 ( )
    beq $s6, $t7, point_y
    
    addi $t4, $zero, 48      # '0' = 48
    addi $t5, $zero, 57         # '9' = 57
    
   
    #cerifica se o caractere é um dígito entre '0' e '9'
    slt $t6, $s6, $t4             
    bne $t6, $zero, FIM_CHAR
    
    slt $t6, $t5, $s6              
    bne $t6, $zero, FIM_CHAR
    
    
    sub $t6, $s6, $t4              # $t6 = $s6 - '0'
    

    addi $t2, $zero, 10
    mult $t1, $t2                   
    mflo $t1                        
    add $t1, $t1, $t6               
    
    j read_loop  
    
point_x:
	beq $s2, $zero, first_x
	
	add $t8, $zero, $t1 #armazena x em t8
	add $t1, $zero, $zero 
	
	j read_loop
	
first_x:
		add $s3, $zero, $t1 #armazena o primeiro x em s3
		add $t8, $zero, $t1 #armazena x em t8
		add $t1, $zero, $zero 
		addi $s2, $zero, 1
		
		j read_loop
	
point_y:
	beq $s4, $zero, first_y
	
	lui $s6, 0x1001 
	add $t9, $zero, $t1 #armazena y em t9
	add $t1, $zero, $zero 
	
	
	addi $t3, $zero, 4
	mult $t8, $t3
	mflo $t3 #x * 4
	
	addi $t4, $zero , 2048
	mult $t9, $t4
	mflo $t4 #y * 2048
	
	add $t5, $t4, $t3 #x * 4 + y * 2048
	
	add $s6, $s6, $t5

	sw $s1, 0($s6) 
	
	
	add $t8, $zero, $zero
	add $t9, $zero, $zero 
	add $t1, $zero, $zero 
	
	j read_loop
	
first_y:

	add $s5, $zero, $t1 #armazena o primeiro y em s5
	addi $s4, $zero, 1
	lui $s6, 0x1001 
	add $t9, $zero, $t1 #armazena y em t9
	add $t1, $zero, $zero 
	
	
	#desenhar o ponto
	addi $t3, $zero, 4
	mult $t8, $t3
	mflo $t3 #x * 4
	
	addi $t4, $zero , 2048
	mult $t9, $t4
	mflo $t4 #y * 2048
	
	add $t5, $t4, $t3 #x * 4 + y * 2048
	
	add $s6, $s6, $t5

	sw $s1, 0($s6) 
	
	add $t8, $zero, $zero
	add $t9, $zero, $zero 
	add $t1, $zero, $zero 
	
	j read_loop

point_y_reset:
	lui $s6, 0x1001 
	add $t9, $zero, $t1 #armazena y em t9
	add $t1, $zero, $zero
	
	#armazenando ultimo X em s2
	add $s2, $zero, $t8
	
	#armazenando ultimo Y em s4
	add $s4, $zero, $t9
	
	
	#desenhar o ponto
	addi $t3, $zero, 4
	mult $t8, $t3
	mflo $t3 #x * 4
	
	addi $t4, $zero , 2048
	mult $t9, $t4
	mflo $t4 #y * 2048
	
	add $t5, $t4, $t3 #x * 4 + y * 2048
	
	add $s6, $s6, $t5

	sw $s1, 0($s6) 
	
	add $t8, $zero, $zero
	add $t9, $zero, $zero 
	add $t1, $zero, $zero   
	
	j bresenham

VIRGULA:
    beq $s2, $zero, RED
    
    addi $t3, $zero, 1
    beq $s2, $t3, GREEN
    
    addi $t4, $zero, 2
    beq $s2, $t4, BLUE
    j read_loop 
    
RED:
    add $s3, $zero, $t1            # Armazena R em $s3
    j reseta_acumulador
    
GREEN:
    add $s4, $zero, $t1            # Armazena G em $s4
    j reseta_acumulador
    
BLUE:
    add $s5, $zero, $t1            # Armazena B em $s5
    #auxiliar para verificar se a cor ja foi setada (0 = nao, 1 = sim)
    beq $s1, $zero, set_color
    
    
reseta_acumulador:
    add $t1, $zero, $zero          # Reseta o acumulador
    addi $s2, $s2, 1               # Incrementa o contador de cores
    
    slti $t7, $s2, 3
    bne $t7, $zero, read_loop 
    
    addi $s7, $zero, 1
    j read_loop
    

    
FIM_CHAR:
    j read_loop
    
set_color:       
    sll $t0, $s3, 16              
    sll $t1, $s4, 8                
    or  $s1, $t0, $t1              
    or  $s1, $s1, $s5   
         
    addi $s7, $zero, 1
    add $t1, $zero, $zero 
    add $s2, $zero, $zero  
    add $s3, $zero, $zero  
    add $s4, $zero, $zero
    add $s5, $zero, $zero  
    
    j read_loop  
     

bresenham: 
				

	add $t9, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t8, $zero, $zero

	
	sub $t4, $s2, $s3  #diferença horizontal t4 = x1 - x0
	
	slti $t1, $t4, 0
	bne $t1, $zero, ABS_X
	
	#abs.s $t2, $t4
	#abs.s $t3, $t5
	add $t2, $zero, $t4
	
	j cont1
	
	ABS_X:
		addi $t1, $zero, -1
		mult $t4, $t1
		mflo $t2  #t2 = dx


	cont1: 
	slt $t1, $s3, $s2
	bne $t1, $zero, calc_sx
	
	addi $t5, $zero, -1 #t5 = sx
	j calc_dy
	
	calc_sx:
		addi $t5, $zero, 1
		j calc_dy
	
	

calc_dy:
	sub $t4, $s4, $s5 #diferença horizontal t5 = y1 - y0
	
	slti $t1, $t4, 0
	bne $t1, $zero, ABS_Y
	
	#abs.s $t2, $t4
	#abs.s $t3, $t5
	add $t3, $zero, $t4
	j cont2
	ABS_Y:
		addi $t1, $zero, -1
		mult $t4, $t1
		mflo $t3  #t3 = dy

	cont2:
	addi $t1, $zero, -1
	mult $t3, $t1
	mflo $t3
	

	slt $t1, $s5, $s4
	bne $t1, $zero, calc_sy
	
	addi $t6, $zero, -1 #t6 = sy
	j calculate_error
	
	calc_sy:
		addi $t6, $zero, 1
		j calculate_error
calculate_error:

	add $t9, $t3, $t2
	
	j bres_loop

bres_loop:

	lui $s6, 0x1001
	addi $t4, $zero, 4
	mult $s3, $t4
	mflo $t4
	
	addi $t7, $zero, 2048
	mult $s5, $t7
	mflo $t7
	
	add $t1, $t4, $t7
	add $s6, $s6, $t1
	
	sw $s1, 0($s6)
	

	beq $s3, $s2, check_y
	j cont3
	
	check_y:
		beq $s5, $s4, bres_done

	cont3:
	addi $t4, $zero , 2
	mult $t4, $t9
	mflo $t8
	
	slt $t4, $t3, $t8
	beq $t4, $zero, FIM_IF1
	
	add $t9, $t9, $t3
	add $s3, $s3, $t5
	
	FIM_IF1:

	
	addi $t7, $t2, 1
	
	slt $t4, $t8, $t7
	beq $t4, $zero, FIM_IF2
	
	add $t9, $t9, $t2
	add $s5, $s5, $t6
	
	FIM_IF2:
	
	j bres_loop
	

bres_done:
    	j full_reset

	
full_reset:
	add $s1, $zero, $zero   
   	add $s2, $zero, $zero        
   	add $s3, $zero, $zero         
   	add $s4, $zero, $zero  
   	add $s5, $zero, $zero  
   	add $s7, $zero, $zero
   	
    	j read_loop
    
close_file:
    # Fechar o arquivo
    addi $v0, $zero, 16           
    add $a0, $zero, $s0            # descritor do arquivo
    syscall
    
    
    # Encerrar o programa
    addi $v0, $zero, 10           
    syscall
