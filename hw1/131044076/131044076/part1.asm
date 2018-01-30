
	.data 
operator :
	.space 4
inputmessage:
	.asciiz "Enter input:"
enterChar:
	.asciiz "\n"
sonucmessage:
	.asciiz "\nsonuc:\n"
toplamaisareti:
	.byte  '+'
cikarmaisareti:
	.byte  '-'	
carpmaisareti:
	.byte  '*'
noktaprint: .asciiz "."	
sifirprint: .asciiz "0"

	
	.text
	.globl main




main:
 			
 	
	la $a0,inputmessage  
	li $v0,4
	syscall 
	 	
	li $v0, 5 
	syscall 
	move $s0, $v0 
	
	
	
			
	
	la $a0,inputmessage  
	li $v0,4 
	syscall 
	 	
	 	
	li $v0,5 
	syscall 
	move $s1,$v0 
	
	
	
	
	la $a0,inputmessage
	li $v0,4 
	syscall 
		
	
	
	lw      $a0, operator 
	li      $v0,12 
	syscall
	move $s5,$v0 
	
	
	li      $v0,12   
	syscall
	
	
			
 	
	la $a0,inputmessage
	li $v0,4 
	syscall 
	 	
	li $v0, 5 
	syscall 
	move $s2, $v0 
	
			
	
	la $a0,inputmessage 
	li $v0,4 
	syscall 
	 	
	li $v0,5 
	syscall  
	move $s3,$v0 
	
	move $a0,$s1
	move $a1,$s3
	jal paydaBasamakSayisi 
	move $s4,$v0
	

	jal paydaBasamakEsitle
	
	
	lb $t0,toplamaisareti
	bne $s5,$t0,operatorCarpma
	jal topla  
	j islemlerBitti
	
	operatorCarpma:
	lb $t0,carpmaisareti
	bne $s5,$t0,operatorCikarma
	jal carp
	j islemlerBitti

	operatorCikarma:
	lb $t0,cikarmaisareti
	bne $s5,$t0,islemlerBitti
	jal cikar
	
	islemlerBitti:
	move $s6,$v0
	move $s7,$v1
	
	jal print
	

	li $v0, 10 
	syscall 
	
paydaBasamakEsitle:
	
	addi $sp,$sp,-8 
	sw $ra,0($sp)
	sw $s7,4($sp)
	move $a0 ,$s1
	li $a1,0 
	jal paydaBasamakSayisi 
	move $s7, $v0
	
	
	
	move $a0 ,$s3
 	li $a1,0 
	jal paydaBasamakSayisi
	move $t2, $v0 
	move $t1,$s7
	
	slt $t4,$t2,$t1
	beqz $t4,digerkosul
	move $t3,$s3
	move $t0,$t2 
	j basamakarttir
	
	digerkosul: 
	move $t3,$s1 
	move $t0,$t1 
	
	basamakarttir:
	slt $t5,$t0, $s4 
	beqz  $t5,loopend 
	li $t6,10 
	mul $t3, $t3, $t6
	addi $t0,$t0,1
	j basamakarttir	
	loopend:
	slt $t6,$t2,$t1 
	beqz $t6 else1
	move $s3,$t3
	j bittir2
	else1:
	move $s1,$t3

	bittir2:
	lw $ra ,0($sp)
	lw $s7,4($sp)
	addi $sp,$sp,4
	
	jr $ra
	
paydaBasamakSayisi:
	li $t0,0
	move $t1,$a0 
	move $t2,$a1
	dongu: 
	slt $t3,$zero,$t1
	slt $t4,$zero,$t2 
	or $t5,$t3,$t4 
	beqz $t5,bittir 
	div $t1,$t1,10 
	div $t2,$t2,10 
	addi $t0,$t0,1 
	j dongu 
	bittir:
	move $v0,$t0 
	jr $ra 
	
topla:

	addi $sp,$sp ,-8 
	sw $s6,0($sp)
	sw $s7,4($sp)
	
	move $s6,$ra
	move $a0 ,$s0
	move $a1,$s1 
	
	jal PayPaydaBirlestir 
	move $s7,$v0 
	
	
	move $a0 ,$s2
	move $a1,$s3
	jal PayPaydaBirlestir
	move $t1,$v0 
	move $t0,$s7
	
	add $t2,$t0,$t1
	 
	
	li $t3 ,0 
	li $t4,1 
	toplaDongu:
	slt $t7,$t3,$s4 
	beqz $t7,toplaAtla 
	mul $t4,$t4,10 
	addi $t3,$t3,1 
	j toplaDongu
	toplaAtla:
	div $t6,$t2,$t4
	mfhi $t5 
	
	move $v0,$t6 
	slt $t3,$t5,$zero
	beqz $t3,toplaAtla2
	mul $t5,$t5,-1
	toplaAtla2:

	move $v1,$t5
	move $ra,$s6
 	
	lw $s6,0($sp)
	lw $s7,4($sp)
	addi $sp,$sp ,-8
	jr $ra
carp:
	
	addi $sp,$sp ,-8
	sw $s6,0($sp)
	sw $s7,4($sp)

	move $a0 ,$s0
	move $a1,$s1 
	move $s6,$ra
	jal PayPaydaBirlestir 
	move $s7,$v0 
	
	
	move $a0 ,$s2 
	move $a1,$s3
	jal PayPaydaBirlestir
	move $t1,$v0 
	move $t0,$s7
	
	mul $t2,$t0,$t1
	 
	 
	li $t3 ,0 
	li $t4,1 
	mul $t6,$s4,2 
	carpDongu:
	slt $t7,$t3,$t6 
	beqz $t7,carpAtla 
	mul $t4,$t4,10 
	addi $t3,$t3,1 
	j carpDongu
	carpAtla:
	div $t6,$t2,$t4  
	
	mfhi $t5 
	
	move $v0,$t6 
	slt $t3,$t5,$zero 
	beqz $t3,carpAtla2
	mul $t5,$t5,-1
	carpAtla2:
	move $v1,$t5
	move $ra,$s6

	lw $s6,0($sp)
	lw $s7,4($sp)
	addi $sp,$sp ,-8
	
	jr $ra
cikar:

	addi $sp,$sp ,-8 
	sw $s6,0($sp)
	sw $s7,4($sp)

	move $a0 ,$s0 
	move $a1,$s1 
	move $s6,$ra 
	jal PayPaydaBirlestir
	move $s7,$v0 
	

	move $a0 ,$s2
	move $a1,$s3
	jal PayPaydaBirlestir
	move $t1,$v0
	move $t0,$s7
	
	sub $t2,$t0,$t1 
	 
	
	li $t3 ,0
	li $t4,1 
	cikarDongu:
	slt $t7,$t3,$s4 
	beqz $t7,cikarAtla 
	mul $t4,$t4,10 
	addi $t3,$t3,1 
	j cikarDongu
	cikarAtla:
	div $t6,$t2,$t4  
	mfhi $t5 
	
	move $v0,$t6
	slt $t3,$t5,$zero
	beqz $t3,cikarAtla2
	mul $t5,$t5,-1
	cikarAtla2:
	move $v1,$t5
	move $ra,$s6
	
	lw $s6,0($sp)
	lw $s7,4($sp)
	addi $sp,$sp ,-8
	
	jr $ra

PayPaydaBirlestir:

	move $t0 , $a0 
	li $t7,0 
	dongusayibirlestir:
	slt $t1,$t7,$s4
	beqz $t1, atla 
	li $t2, 10 
	mul $t0,$t0,$t2 
	addi $t7,$t7,1  
	j dongusayibirlestir  
	atla:
	sle $t3,$zero,$a0  
	beqz $t3 , paydanegatif 
	add $t0,$t0,$a1
	j paypaydabirlestirBitti 
	paydanegatif:
	sub $t0,$t0,$a1 
	paypaydabirlestirBitti:
	move $v0,$t0
	jr $ra
	

print:
		
	addi $sp,$sp,-4 
	sw $ra ,0($sp) 
	la $a0,sonucmessage 
	li $v0,4
	syscall  
	
	move $a0,$s6 
	li $v0,1 
	syscall 
		
	la $a0,noktaprint
	li $v0,4 
	syscall  
	
	move $a0 ,$s7
	li $a1,0
	jal paydaBasamakSayisi
	move $t0,$v0 
	
	
	sifirdongu:
	slt $t1, $t0,$s4
	beqz $t1 ,paydayaz
	
	addi $t0,$t0,1
	la $a0,sifirprint
	li $v0,4
	syscall
	
	j sifirdongu	
	
	
	paydayaz:
	move $a0,$s7 
	li $v0,1 
	syscall 
		
	lw $ra ,0($sp) 
	addi $sp,$sp,4 
	jr $ra
	

