########################### Areas ###################################

# Image
.eqv IM_SIZE_UNITS		131072		# size of image in units (each unit is a word in memory)
.eqv IM_SIZE_BYTES		524288		# size of image in bytes
.eqv IM_WIDTH_UNITS		512			# width of image in units
.eqv IM_WIDTH_BYTES		2048		# width of image in bytes
.eqv IM_HEIGHT_UNITS	256			# height of image in units

# Player's hitbox
.eqv PL_SIZE_UNITS		25
.eqv PL_SIZE_BYTES		100
.eqv PL_WIDTH_UNITS		5		
.eqv PL_WIDTH_BYTES		20		
.eqv PL_HEIGHT_UNITS	5		
.eqv PL_HEIGHT_SHIFT	10240

# Message
.eqv MSG_SIZE_UNITS		18072
.eqv MSG_SIZE_BYTES		72288
.eqv MSG_WIDTH_UNITS	502
.eqv MSG_WIDTH_BYTES	2008
.eqv MSG_HEIGHT_UNITS	36

# Level
.eqv LVL_SIZE_UNITS		26896
.eqv LVL_SIZE_BYTES		107584
.eqv LVL_WIDTH_UNITS	164
.eqv LVL_WIDTH_BYTES	656
.eqv LVL_HEIGHT_UNITS	164

######################## Addresses ####################################

.eqv BASE_ADDRESS 		0x10010000	# use constant to declare base adress of image

.eqv KEY_PRESS	0xFFFF0000	# place to check for keyboard input
.eqv KEY_INPUT	0xFFFF0004	# place to get the ascii value of keyboard input

# positions of messages
.eqv UPPER_MSG_POS	10260
.eqv LOWER_MSG_POS	440340

######################## Colours ######################################

.eqv WHITE		0xFFFFFF		# colour of wall
.eqv ORANGE		0xE88212		# colour of player

.eqv LGT_GREY	0x8F8C8C
.eqv MID_GREY	0x666A6C
.eqv DRK_GREY	0x292C2D

######################### Codes #######################################

# values used for movement of player
.eqv BLOCK_UP		0xFF000000		
.eqv BLOCK_DOWN		0x00FF0000
.eqv BLOCK_LEFT		0x0000FF00
.eqv BLOCK_RIGHT	0x000000FF

.eqv MOVE_UP		-2048
.eqv MOVE_DOWN		2048
.eqv MOVE_LEFT		-4
.eqv MOVE_RIGHT		4

# used for detection of objects by player
.eqv DCT_CODE	0xFF000000	# used to extract code info from pixel
.eqv DCT_DOOR	0x01000000	# door
.eqv DCT_R_CRST	0x02000000	# red crystal
.eqv DCT_G_CRST	0x03000000	# green crystal
.eqv DCT_B_CRST	0x04000000	# blue crystal
.eqv DCT_ATTACK 0x05000000	# guard attack

################# Indices to access Constant rrays ######################

# colour arrays
.eqv COLOUR			0		# gives the primary colour refered by the array				(const)
.eqv CRYSTAL_CODE 	4		# gives the crystal detection code of the colour			(const)
.eqv CRYSTAL_POS	8		# gives position of crystal									(var)
.eqv CRYSTAL_LEFT	12		# gives left-most position guard can move to				(var)
.eqv CRYSTAL_RIGHT	16		# gives right-most position guard can move to				(var)
.eqv CRYSTAL_DIR	20		# gives direction guard is currently moveing in				(var)
.eqv DASHBOARD_POS	24		# gives position of crystal to be displayed in dashboard	(const)
.eqv LEVEL_POS		28		# position of the colour of level 							(const)
.eqv CUR_LEVEL_POS	32		# gives current position of colour component of level		(var)

# Player Array

.eqv PLAYER_POS		0
.eqv PL_CUR_LEVEL	4

# level arrays (defines positions of door and crystals, and their properties)
# ofr initial position of player, use PLAYER_POS, same as player array
.eqv DOOR_POS		4
.eqv R_CRST_POS		8
.eqv R_CRST_LEFT	12
.eqv R_CRST_RIGHT	16
.eqv R_CRST_DIR		20
.eqv G_CRST_POS		24
.eqv G_CRST_LEFT	28
.eqv G_CRST_RIGHT	32
.eqv G_CRST_DIR		36
.eqv B_CRST_POS		40
.eqv B_CRST_LEFT	44
.eqv B_CRST_RIGHT	48
.eqv B_CRST_DIR		52

##################### Other Constants ###################################

# values used for jump logic
.eqv DOWN		0
.eqv UP			10
.eqv JUMP_VAL	25
.eqv NUM_JUMPS	1		# number of consecutive jumps - 1 (so 1 would mean double jump)
						# can be chenged to get required amount of consequtive jumps
.eqv SLEEP_TIME	15		# time to sleep after one iteration of the game loop
.eqv WIN_LEVEL_DISPLAY_WAIT		1500	# time to wait after the win message is displayed

.eqv GUARD_SLOWNESS	4	# how many frames does it take for the guard to move 1 pixel

########################### Variables ###################################
.data

image:		.space 	IM_SIZE_BYTES	# space for bitmap image for screen

# allocating space to load assets

lvl_buffer:	.space	LVL_SIZE_BYTES	# space to load level
msg_buffer:	.space	MSG_SIZE_BYTES	# space to load message

# file names for assets

main_menu_level:	.asciiz	"main_menu_level.dat"
main_menu_message:	.asciiz	"main_menu_message.dat"

win_level_msg:	.asciiz	"win_level.dat"
win_message:	.asciiz	"win_message.dat"

lose_level_msg:	.asciiz	"lose_level.dat"
lose_message:	.asciiz	"lose_message.dat"

level_1_level:			.asciiz	"level_1_level.dat"
level_1_message:		.asciiz	"level_1_message.dat"
level_1_dashboard:		.asciiz	"level_1_dashboard.dat"

level_2_level:			.asciiz	"level_2_level.dat"
level_2_message:		.asciiz	"level_2_message.dat"
level_2_dashboard:		.asciiz	"level_2_dashboard.dat"

level_3_level:			.asciiz	"level_3_level.dat"
level_3_message:		.asciiz	"lose_message.dat"
level_3_dashboard:		.asciiz	"level_3_dashboard.dat"

# variables used in the game

level_address:	.word	0	# used to store the address of the level for restarting levels
next_level:		.word	0	# used to store the address of next level

movement_block:	.word	0	# used to check if player is free to move in a certain direction

# colour arrays: (also hold crystal values)

red:	.word	0xFF0000, 0x02000000, 0, 0, 0, 0, 42876, 94228, 0
green:	.word	0x00FF00, 0x03000000, 0, 0, 0, 0, 42900, 94904, 0
blue:	.word	0x0000FF, 0x04000000, 0, 0, 0, 0, 42924, 95580, 0

# array to keep track of player

player_arr:	.word	0, 0

# level-specific constants

level_1_const:	.word	192576, 156220, 209104, 0, 0, 0, 209176, 0, 0, 0, 209240, 0, 0, 0
level_2_const:	.word	219188, 34880, 78156, 0, 0, 0, 182604, 0, 0, 0, 278884, 278804, 278968, -4
level_3_const:	.word	47136, 176708, 47320, 47256, 47444, -4, 119280, 119196, 119400, 4, 184720, 184640, 184816, -4

.text

# CONVENTIONS

# background is black

# t registers are free to use, it is the caller's responsibility
# to save them onto the stack and get them back after function call

.globl main

####################### loop to reset screen #########################

reset_screen:
	li $t0, BASE_ADDRESS
	add $t1, $t0, IM_WIDTH_BYTES
	
	li $t2, WHITE
	li $t4, 0
	
white_line_begin_loop:
	sw $t2, 0($t0)
	add $t0, $t0, 4
	blt $t0, $t1, white_line_begin_loop
	
	li $t3, BASE_ADDRESS
	add $t1, $t3, IM_SIZE_BYTES
	
white_line_follow_through:
	sw $t2, 0($t0)
	sw $t4, 0($t3)
	add $t0, $t0, 4
	add $t3, $t3, 4
	blt $t0, $t1, white_line_follow_through
	
	jr $ra

####################### loop to make boundary around screen ##########

make_boundary:
	li $t2, IM_WIDTH_BYTES
	mul $t2, $t2, IM_HEIGHT_UNITS
	add $t2, $t2, BASE_ADDRESS	# set $t2 to ending of the image
	
	li $t3, WHITE

h_boundary:
	li $t0, BASE_ADDRESS		# use $t0 to fill left wall
	li $t1, IM_WIDTH_BYTES
	add $t1, $t1, -4
	add $t1, $t1, $t0		# use $t1 to fill right wall
	
h_b_loop:	sw $t3, ($t0)
	sw $t3, ($t1)
	
	add $t0, $t0, IM_WIDTH_BYTES
	add $t1, $t1, IM_WIDTH_BYTES
	
	blt $t1, $t2, h_b_loop
	
v_boundary:
	li $t0, BASE_ADDRESS
	add $t2, $t0, IM_WIDTH_BYTES

v_b_loop:	sw $t3, ($t0)
	add $t0, $t0, 4
	blt $t0, $t2, v_b_loop
	
	jr $ra	
	
####################### Check Bounds #################################

# check a single pixel for movement, pixel data in $a0, movement block in $a1
# goes to special functions if objects are detected, else updates movement_block

check_pixel:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	andi $t9, $a0, DCT_CODE
	
	# <TODO> branch to all the object functions
	beq $t9, DCT_DOOR, win_level
	beq $t9, DCT_ATTACK, lose_level
	beq $t9, DCT_R_CRST, call_pickup_r_cryst
	beq $t9, DCT_G_CRST, call_pickup_g_cryst
	beq $t9, DCT_B_CRST, call_pickup_b_cryst
		j after_object_functions
		
	# calling crystal pickup functions
	call_pickup_r_cryst:
		la $a0, red
		jal pickup_crystal
		j after_object_functions
	
	call_pickup_g_cryst:
		la $a0, green
		jal pickup_crystal
		j after_object_functions
		
	call_pickup_b_cryst:
		la $a0, blue
		jal pickup_crystal
		j after_object_functions
	
	after_object_functions:
	
	beqz $a0, transparent		# check if pixel is transparent

	opaque:						# if it is opaque, update movement_block
		lw $t9, movement_block
		or $t9, $t9, $a1
		sw $t9, movement_block
		
	transparent:		# if it is transparent, do nothing

	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra			# return to caller
		
# check bounds function, goes though the whole boundary of the player and tells
# which directions the player can move in, also calls interaction functions of
# objects if the player touches them

check_bounds:
	add $sp, $sp, -4
	sw $ra, ($sp)		# save return address
	
	sw $zero, movement_block
	
	lw $t4, player_arr + PLAYER_POS
	lw $t5, player_arr + PL_CUR_LEVEL
	add $t4, $t4, $t5
	addi $t4, $t4, BASE_ADDRESS
	
check_top:
	
	sub $t0, $t4, IM_WIDTH_BYTES	# move to pixel above top-left pixel of player
	add $t1, $t0, PL_WIDTH_BYTES	# use $t1 to stop the loop
	
	check_top_loop:
		lw $a0, ($t0)
		li $a1, BLOCK_UP
		
		addi $sp, $sp, -4
		sw $t0, ($sp)
		
		jal check_pixel
	
		lw $t0, ($sp)
		addi $sp, $sp, 4
		
		add $t0, $t0, 4
	blt $t0, $t1, check_top_loop
	
check_bottom:
	
	add $t0, $t4, PL_HEIGHT_SHIFT	# move to pixel below bottom-left pixel of player
	add $t1, $t0, PL_WIDTH_BYTES	# use $t1 to stop the loop
	
	check_bottom_loop:
		lw $a0, ($t0)
		li $a1, BLOCK_DOWN
		
		addi $sp, $sp, -4
		sw $t0, ($sp)
		
		jal check_pixel
	
		lw $t0, ($sp)
		addi $sp, $sp, 4
		
		add $t0, $t0, 4
	blt $t0, $t1, check_bottom_loop
	
check_left:
	
	add $t0, $t4, -4				# move to pixel left of top-left pixel of player
	add $t1, $t0, PL_HEIGHT_SHIFT	# use $t1 to stop the loop
	
	check_left_loop:
		lw $a0, ($t0)
		li $a1, BLOCK_LEFT
		
		addi $sp, $sp, -4
		sw $t0, ($sp)
		
		jal check_pixel
	
		lw $t0, ($sp)
		addi $sp, $sp, 4
		
		add $t0, $t0, IM_WIDTH_BYTES
	blt $t0, $t1, check_left_loop
	
check_right:
	
	addi $t0, $t4, PL_WIDTH_BYTES	# move to pixel right of top-right pixel of player
	addi $t1, $t0, PL_HEIGHT_SHIFT	# use $t1 to stop the loop
	
	check_right_loop:
		lw $a0, ($t0)
		li $a1, BLOCK_RIGHT
		
		addi $sp, $sp, -4
		sw $t0, ($sp)
		
		jal check_pixel
	
		lw $t0, ($sp)
		addi $sp, $sp, 4
		
		add $t0, $t0, IM_WIDTH_BYTES
	blt $t0, $t1, check_right_loop
	
	lw $ra, ($sp)
	add $sp, $sp, -4
	jr $ra

####################### Render Player ################################

# $a2 = address of top-left pixel of 5x5 area to be cleared

clear_5x5_area:
	move $t0, $a2					# $t0, used to keep track of rows of player cleared
	add $t1, $t0, PL_HEIGHT_SHIFT	# $t1 used to stop $t0 loop
	
	clear_player_rows:
	
		move $t2, $t0					# $t2 used to colour individual pixels of player black
		add $t3, $t2, PL_WIDTH_BYTES	# $t3 used to stop $t2 loop
		
		clear_player_row:
			sw $zero, ($t2)				# load black to the current pixel
		
			add $t2, $t2, 4
		blt $t2, $t3, clear_player_row
	
		add $t0, $t0, IM_WIDTH_BYTES
	blt $t0, $t1, clear_player_rows
	
	jr $ra
	
render_player_sprite:		# <TODO> render an actual 4x4 player sprite
	lw $t0, player_arr + PLAYER_POS
	lw $t5, player_arr + PL_CUR_LEVEL
	add $t0, $t0, $t5
	addi $t0, $t0, BASE_ADDRESS			# $t0 stores the address of top-left pixel of player

	li $t4, ORANGE			# load player colour
	
	add $t1, $t0, PL_HEIGHT_SHIFT	# $t1 used to stop $t0 loop
	
	render_player_rows:
	
		move $t2, $t0					# $t2 used to colour individual pixels of player black
		add $t3, $t2, PL_WIDTH_BYTES	# $t3 used to stop $t2 loop
		
		render_player_row:
			sw $t4, ($t2)				# load player colour to the current pixel
		
			add $t2, $t2, 4
		blt $t2, $t3, render_player_row
	
		add $t0, $t0, IM_WIDTH_BYTES
	blt $t0, $t1, render_player_rows
	
	jr $ra

####################### Move Player ##################################

# $a0 = direction to move in, $a1 = movement block code
move_player:

	lw $t0, movement_block		# load movement_block to $t0
	and $t0, $t0, $a1		# get the block value for moving in given direction
	
	bnez $t0, after_move_player	# if path is blocked, exit the function
	
	add $sp, $sp, -4	# store return address to stack
	sw $ra, ($sp)
	
	lw $a2, player_arr + PLAYER_POS
	lw $t0, player_arr + PL_CUR_LEVEL
	add $a2, $a2, $t0
	addi $a2, $a2, BASE_ADDRESS		# get player's current position
	jal clear_5x5_area				# clear the player's current sprite
	lw $t0, player_arr + PLAYER_POS
	add $t0, $t0, $a0
	sw $t0, player_arr + PLAYER_POS		# update player's position
	jal render_player_sprite		# render player's sprite in new position
	
	lw $ra, ($sp)		# get return address from stack
	add $sp, $sp, 4
	
	after_move_player:
	jr $ra
	
####################### Load Asset file to given buffer ##############

# address of file name in $a0, address of buffer in $a1, number of characters in $a2

load_file:
	move $t1, $a1	# save buffer position in $t1
	move $t2, $a2	# save buffer size in $t2
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall		# opens file with name in $a0
	
	
	move $a0, $v0	# load file descriptor
	move $a1, $t1	# load buffer position
	move $a2, $t2	# load buffer size
	li $v0, 14
	syscall		# read from file, store pixel data in buffer
	
	li $v0, 16
	syscall			# close the file
	
#	move $a0, $v0
#	li $v0, 1
#	syscall		# check how many characters are read

	jr $ra 
	
####################### Render Message ###############################

# address of file name in $a0, starting position of message in $a1

render_message:
	add $sp, $sp, -4
	sw $ra, ($sp)	# store return address to stack
	
	move $t0, $a1
	la $a1, msg_buffer
	li $a2, MSG_SIZE_BYTES
	
	jal load_file
	
	li $t1, 0	# use $t1 to keep track of how many rows are rendered
	render_message_rows:
		
		move $t2, $t0	# use $t0 as starting position of row
		li $t3, 0	# use $t3 to keep track of pixels rendered in the row
		render_message_row:
			
			lw $t4, ($a1)	# load pixel from msg_buffer
			sw $t4, ($t2)	# store pixel to the screen
			
			add $t2, $t2, 4	# move to next pixel location
			add $a1, $a1, 4	# move to next pixel data in msg_buffer
			
			add $t3, $t3, 1
		
		blt $t3, MSG_WIDTH_UNITS, render_message_row
		
		add $t0, $t0, IM_WIDTH_BYTES	# move to next row
		add $t1, $t1, 1
			
	blt $t1, MSG_HEIGHT_UNITS, render_message_rows
	
	lw $ra, ($sp)	# get return address from stack
	add $sp, $sp, 4
	
	jr $ra
	
####################### Render Level #################################

# colour filter in $a0, starting position of level in $a1
# assuming level is already loaded to lvl_buffer

render_level:
	la $t9, lvl_buffer	# load address of lvl_buffer to $t9, used to get the pixels
	li $t0, 0			# use $t0 to keep track of how many rows are rendered
	render_level_rows:
	
		move $t1, $a1	# $a1 used for starting pixel of corrent row
		li $t2, 0		# use $t2 to keep track of pixels rendered in the row
		
		render_level_row:
		
			lw $t3, ($t9)		# load pixel from lvl_buffer
			and $t3, $t3, $a0	#apply colour filter to current pixel
			sw $t3, ($t1)		# store pixel to current position $t1
			
			add $t9, $t9, 4	# go to next pixel value in lvl_buffer
			add $t1, $t1, 4	# go to next pixel position in image
			
			add $t2, $t2, 1
		
		blt $t2, LVL_WIDTH_UNITS, render_level_row
		
		add $a1, $a1, IM_WIDTH_BYTES
		add $t0, $t0, 1
	
	blt $t0, LVL_HEIGHT_UNITS, render_level_rows
	
	jr $ra
	
####################### Render Door ##################################

# $a0 = address of top_left pixel of door

render_door:
	li $t0, LGT_GREY		# store required colours and codes for door in registers
	ori $t0, DCT_DOOR
	li $t1, MID_GREY
	ori $t1, DCT_DOOR
	li $t2, DRK_GREY
	ori $t2, DCT_DOOR
	
	# row 1
	sw $t0, ($a0)
	sw $t0, 8($a0)
	sw $t0, 16($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 2
	sw $t1, 4($a0)
	sw $t2, 8($a0)
	sw $t2, 16($a0)
	sw $t1, 20($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 3
	sw $t0, ($a0)
	sw $t1, 12($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 4
	sw $t0, ($a0)
	sw $t1, 4($a0)
	sw $t2, 8($a0)
	sw $t2, 16($a0)
	sw $t1, 20($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 5
	sw $t0, ($a0)
	sw $t1, 8($a0)
	sw $t1, 16($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 6
	sw $t0, ($a0)
	sw $t2, 4($a0)
	sw $t2, 12($a0)
	sw $t2, 20($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 7
	sw $t0, ($a0)
	sw $t1, 8($a0)
	sw $t1, 16($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 8
	sw $t0, ($a0)
	sw $t2, 4($a0)
	sw $t2, 12($a0)
	sw $t2, 20($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	# row 9
	sw $t0, ($a0)
	sw $t1, 4($a0)
	sw $t2, 8($a0)
	sw $t1, 12($a0)
	sw $t2, 16($a0)
	sw $t1, 20($a0)
	sw $t0, 24($a0)
	add $a0, $a0, IM_WIDTH_BYTES
	
	jr $ra
	
###################### Crystal Mechanics #############################

# $a2 = address of top-left pixel of the 3x3 area we should clear
clear_3x3_area:
	sw $zero, ($a2)
	sw $zero, 4($a2)
	sw $zero, 8($a2)
	addi $a2, $a2, IM_WIDTH_BYTES
	
	sw $zero, ($a2)
	sw $zero, 4($a2)
	sw $zero, 8($a2)
	addi $a2, $a2, IM_WIDTH_BYTES

	sw $zero, ($a2)
	sw $zero, 4($a2)
	sw $zero, 8($a2)
	jr $ra
	
# $a0 = address of colour array of crystal
render_crystal:
	lw $t0, COLOUR($a0)			# load colour to $t1
	lw $t1, CRYSTAL_CODE($a0)	# load detection code to $t1
	or $t0, $t0, $t1			# or $t0 and $t1 to $t0, now $t0 has both colour and code

	lw $t1, CRYSTAL_POS($a0)	# load position of crystal
	lw $t2, CUR_LEVEL_POS($a0)	# load current position of colour component
	add $t1, $t1, $t2
	addi $t1, $t1, BASE_ADDRESS
	sw $t0, 4($t1)
	addi $t1, $t1, IM_WIDTH_BYTES
	sw $t0, ($t1)
	sw $t0, 8($t1)
	addi $t1, $t1, IM_WIDTH_BYTES
	sw $t0, 4($t1)
	
	jr $ra

# $a0 = address of colour array of guard	
render_guard:
	lw $t0, COLOUR($a0)			# load colour to $t1
	lw $t1, CRYSTAL_CODE($a0)	# load detection code to $t1
	or $t0, $t0, $t1			# or $t0 and $t1 to $t0, now $t0 has both colour and code
	
	ori $t1, $t1, LGT_GREY		# used for top of guard, to detect when player jumps on top
	
	li $t2, LGT_GREY
	ori $t2, $t2, DCT_ATTACK	# use $t1 for the parst of the guard that can attack

	lw $t3, CRYSTAL_POS($a0)	# load position of guard
	lw $t4, CUR_LEVEL_POS($a0)	# load current position of colour component
	add $t3, $t3, $t4
	addi $t3, $t3, BASE_ADDRESS	# get absolute address of guard
	
	sw $t1, 4($t3)
	sw $t1, 8($t3)
	sw $t1, 12($t3)
	addi $t3, $t3, IM_WIDTH_BYTES
	sw $t2, ($t3)
	sw $t0, 8($t3)
	sw $t2, 16($t3)
	addi $t3, $t3, IM_WIDTH_BYTES
	sw $t2, ($t3)
	sw $t0, 4($t3)
	sw $t0, 12($t3)
	sw $t2, 16($t3)
	addi $t3, $t3, IM_WIDTH_BYTES
	sw $t2, ($t3)
	sw $t0, 8($t3)
	sw $t2, 16($t3)
	addi $t3, $t3, IM_WIDTH_BYTES
	sw $t2, 4($t3)
	sw $t2, 8($t3)
	sw $t2, 12($t3)
	
	jr $ra
	
# checks if crystal is stationary or a guard, prints accordingly
# $a0 = address of corresponding colour array
print_crystal:
	addi $sp, $sp, -4
	sw $ra, ($sp)		# store $ra to stack

	lw $t0, CRYSTAL_DIR($a0)
	beqz $t0, call_render_crystal	# check if crystal is moving, print accordingly
	
	call_render_guard:
		jal render_guard
		j end_print_crystal
		
	call_render_crystal:
		jal render_crystal
		
	end_print_crystal:
	
	lw $ra, ($sp)		# get $ra from stack
	addi $sp, $sp, 4
	jr $ra
	

# $a0 is colour array of guard
move_guard:
	lw $t0, CRYSTAL_DIR($a0)
	beqz $t0, move_guard_return

	addi $sp, $sp, -4
	sw $ra, ($sp)

	lw $t0, CRYSTAL_POS($a0)
	lw $t1, CRYSTAL_LEFT($a0)
	lw $t2, CRYSTAL_RIGHT($a0)
	
	ble $t0, $t1, set_direction_move_right
	ble $t2, $t0, set_direction_move_left
	j guard_motion
	
	set_direction_move_right:
		li $t0, MOVE_RIGHT
		sw $t0, CRYSTAL_DIR($a0)
		j guard_motion
	
	set_direction_move_left:
		li $t0, MOVE_LEFT
		sw $t0, CRYSTAL_DIR($a0)
	
	guard_motion:
		lw $a2, CRYSTAL_POS($a0)
		lw $t0, CUR_LEVEL_POS($a0)
		add $a2, $a2, $t0
		addi $a2, $a2, BASE_ADDRESS
		jal clear_5x5_area
		
		lw $t0, CRYSTAL_POS($a0)
		lw $t1, CRYSTAL_DIR($a0)
		add $t0, $t0, $t1
		sw $t0, CRYSTAL_POS($a0)
		jal render_guard
		
	lw $ra, ($sp)
	addi $sp, $sp, 4
	
	move_guard_return:
	jr $ra
		
	
# $a0 = address of colour array of crystal
pickup_crystal:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	lw $t9, CRYSTAL_DIR($a0)	# check crystal_dir, if it is moving,
								# it is a guard, else it is a crystal
	lw $a2, CRYSTAL_POS($a0)	# get position of crystal to clear its area
	lw $t0, CUR_LEVEL_POS($a0)
	add $a2, $a2, $t0
	addi $a2, $a2, BASE_ADDRESS

	beqz $t9, clear_crystal_area	# check if it is a guard and clear appropriate area
	
	clear_guard_area:
		jal clear_5x5_area
		j crystal_clear_complete
		
	clear_crystal_area:
		jal clear_3x3_area
		
	crystal_clear_complete:		# after clearing, display it on the dashboard
	
	lw $t9, DASHBOARD_POS($a0)
	sw $t9, CRYSTAL_POS($a0)	# store position of dashboard to cyrstal_pos
	sw $zero, CUR_LEVEL_POS($a0)
	sw $zero, CRYSTAL_DIR($a0)
	jal render_crystal			# display it on the dashboard
	
	lw $ra, ($sp)
	addi $sp, $sp, 4
	
	jr $ra
		
	
####################### Polling Loop #################################

polling_loop:
	lw $t0, KEY_PRESS
	beqz $t0, polling_loop
	jr $ra

####################### Main Function ################################

main:
	jal reset_screen

	# load main menu display file to lvl_buffer
	la $a0, main_menu_level
	la $a1, lvl_buffer
	li $a2, LVL_SIZE_BYTES
	jal load_file
	
	# print full display to middle level position (green[LEVEL_POS])
	li $a0, WHITE
	lw $a1, green + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level
	
	# print main menu message
	la $a0, main_menu_message
	li $a1, BASE_ADDRESS
	addi $a1, $a1, LOWER_MSG_POS
	jal render_message
	
	main_menu_polling_loop:
		lw $s2, KEY_PRESS
		beqz $s2, after_main_menu_key_press
		
		main_menu_key_press:
			lw $s3, KEY_INPUT
			
			main_menu_handle_input_space:
				bne $s3, 0x20, main_menu_handle_input_q
				j level_1
				
			main_menu_handle_input_q:
				bne $s3, 0x71, after_main_menu_key_press
				j quit
		
		after_main_menu_key_press:
		j main_menu_polling_loop

	
###################### Common level loader ###########################

# $a0 = address of level asset filename, $a1 = address of message asset filename
# $a2 = address of dashboard asset filename, $a3 = address of level array
generic_level_load:
	addi $sp, $sp, -4
	sw $ra, ($sp)		# store $ra in the stack

	# save function arguments to $s0, $s1, $s2 and $s3
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3

	# clear the screen
	jal reset_screen
	
	# get position of player
	lw $t0, PLAYER_POS($s3)
	sw $t0, player_arr + PLAYER_POS
	lw $t0, green + LEVEL_POS
	sw $t0, player_arr + PL_CUR_LEVEL
	
	# print the dashboard
	move $a0, $s2
	li $a1, BASE_ADDRESS
	addi $a1, $a1, UPPER_MSG_POS
	jal render_message
	
	# load level file to lvl_buffer
	move $a0, $s0
	la $a1, lvl_buffer
	li $a2, LVL_SIZE_BYTES
	jal load_file
	
	# print full level to middle level position (green[LEVEL_POS])
	li $a0, WHITE
	lw $a1, green + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level
	
	# print message
	move $a0, $s1
	li $a1, BASE_ADDRESS
	addi $a1, $a1, LOWER_MSG_POS
	jal render_message
	
	# print player
	jal render_player_sprite
	
	# print door
	lw $a0, DOOR_POS($s3)
	lw $t0, green + LEVEL_POS
	add $a0, $a0, $t0
	addi $a0, $a0, BASE_ADDRESS
	jal render_door
	
	# load crystal values and print crystals:
	# red:
	lw $t0, R_CRST_POS($s3)
	sw $t0, red + CRYSTAL_POS
	lw $t0, R_CRST_LEFT($s3)
	sw $t0, red + CRYSTAL_LEFT
	lw $t0, R_CRST_RIGHT($s3)
	sw $t0, red + CRYSTAL_RIGHT
	lw $t0, R_CRST_DIR($s3)
	sw $t0, red + CRYSTAL_DIR
	lw $t0, green + LEVEL_POS
	sw $t0, red + CUR_LEVEL_POS
	la $a0, red
	jal print_crystal
	
	# green:
	lw $t0, G_CRST_POS($s3)
	sw $t0, green + CRYSTAL_POS
	lw $t0, G_CRST_LEFT($s3)
	sw $t0, green + CRYSTAL_LEFT
	lw $t0, G_CRST_RIGHT($s3)
	sw $t0, green + CRYSTAL_RIGHT
	lw $t0, G_CRST_DIR($s3)
	sw $t0, green + CRYSTAL_DIR
	lw $t0, green + LEVEL_POS
	sw $t0, green + CUR_LEVEL_POS
	la $a0, green
	jal print_crystal
	
	# blue:
	lw $t0, B_CRST_POS($s3)
	sw $t0, blue + CRYSTAL_POS
	lw $t0, B_CRST_LEFT($s3)
	sw $t0, blue + CRYSTAL_LEFT
	lw $t0, B_CRST_RIGHT($s3)
	sw $t0, blue + CRYSTAL_RIGHT
	lw $t0, B_CRST_DIR($s3)
	sw $t0, blue + CRYSTAL_DIR
	lw $t0, green + LEVEL_POS
	sw $t0, blue + CUR_LEVEL_POS
	la $a0, blue
	jal print_crystal
	
	# set the frame counter for guard motion
	li $s0, 0
	
	lw $ra, ($sp)
	addi $sp, $sp, 4		# get $ra from the stack
	
	jr $ra		# return
	
	
####################### Level 1 ######################################

level_1:
	li $a0, 1
	li $v0, 1
	syscall
		
	la $t0, level_1		# get address of level_1 to use when pressing p to reset level
	sw $t0, level_address	# store address of level 1 to level_address
	
	la $t0, level_2
	sw $t0, next_level		# store address of level_2 in next_level
	
	la $a0, level_1_level
	la $a1, level_1_message
	la $a2, level_1_dashboard
	la $a3, level_1_const
	jal generic_level_load
	
	j game_loop
	
#################### Level 2 #########################################

level_2:
	li $a0, 1
	li $v0, 1
	syscall
		
	la $t0, level_2		# get address of level_2 to use when pressing p to reset level
	sw $t0, level_address	# store address of level 2 to level_address
	
	la $t0, level_3
	sw $t0, next_level		# store address of level_3 in next_level
	
	la $a0, level_2_level
	la $a1, level_2_message
	la $a2, level_2_dashboard
	la $a3, level_2_const
	jal generic_level_load
	
	j game_loop
	
#################### Level 3 #########################################

level_3:
	li $a0, 1
	li $v0, 1
	syscall
		
	la $t0, level_3		# get address of level_3 to use when pressing p to reset level
	sw $t0, level_address	# store address of level 3 to level_address
	
	la $t0, quit
	sw $t0, next_level		# store address of next level in next_level
	
	la $a0, level_3_level
	la $a1, level_3_message
	la $a2, level_3_dashboard
	la $a3, level_3_const
	jal generic_level_load
	
	j game_loop
	
#######################	Game Loop ####################################

# use $s0 to handle guard delay

# store value in address KEY_PRESS in $s2
# store ascii value of pressed key in $s3

# store address of top left unit of player in $s4

# store player's gravity in $s5
# when $s5 < DOWN, move down. when $s5 > UP, move up
# use $s6 for double jump logic, can only jump when $s6 > 0

game_loop:
	
	# frame counter to apply guard slowness
	addi $s0, $s0, 1
	li $t0, GUARD_SLOWNESS
	div $s0, $t0
	mfhi $s0
	
	# move the guards:
	bnez $s0, after_move_guard
	
	la $a0, red
	jal move_guard
	la $a0, blue
	jal move_guard
	la $a0, green
	jal move_guard
	
	after_move_guard:
	
	# call check_bounds()
	jal check_bounds
		
	lw $s2, KEY_PRESS	          # check if the player has pressed a key
	bnez $s2, handle_key_press        # if player has pressed a key, go to handle_key_press
	
	j after_key_press
	
	####################### Handle Keyboard Input ########################
	handle_key_press:
		lw $s3, KEY_INPUT
	
	handle_input_space:
		bne $s3, 0x20, handle_input_a
		blez $s6, handle_input_a
		li $s5, JUMP_VAL
		add $s6, $s6, -1
		j after_key_press
	
	handle_input_a:
		bne $s3, 0x61, handle_input_d
		li $a0, MOVE_LEFT
		li $a1, BLOCK_LEFT
		jal move_player
		j after_key_press
	
	handle_input_d:
		bne $s3, 0x64, handle_input_q
		li $a0, MOVE_RIGHT
		li $a1, BLOCK_RIGHT
		jal move_player
		j after_key_press
	
	handle_input_q:
		bne $s3, 0x71, handle_input_p
		j quit

	handle_input_p:
		bne $s3, 0x70, handle_input_m
		lw $t0, level_address	# jump to start of whatever level called the game loop
		jr $t0
		
	handle_input_m:
		bne $s3, 0x6D, after_key_press
		j main	# jump to start of game
	after_key_press:

	####################### Jump Logic ######################################
	jump_logic:
		
		check_if_on_ground:		# update double jump register $s6 if player is on the ground
			lw $t0, movement_block
			andi $t0, BLOCK_DOWN
			beqz $t0, after_check_if_on_ground
			li $s6, NUM_JUMPS
			
		after_check_if_on_ground:
	
		blt $s5, DOWN, after_calc
		add $s5, $s5, -1
	after_calc:
		li $t9, 0
#	sleep_loop:
#		addi $t9, $t9, 1
#		blt $t9, SLEEP_ITER, sleep_loop

		li $a0, SLEEP_TIME
		li $v0, 32
		syscall
	
		bgt $s5, UP, call_move_player_up
		blt $s5, DOWN, call_move_player_down
		j end_jump_logic
		
	call_move_player_up:
		li $a0, MOVE_UP
		li $a1, BLOCK_UP
		jal move_player
		j end_jump_logic
	
	call_move_player_down:
		li $a0, MOVE_DOWN
		li $a1, BLOCK_DOWN
		jal move_player
	
	end_jump_logic:

		j game_loop
		

######################## Winning Message ##################################

win_level:
	move $a0, $zero
	lw $a1, red + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level				# clear red component of level
	
	move $a0, $zero
	lw $a1, green + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level				# clear green component of level
	
	move $a0, $zero
	lw $a1, blue + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level				# clear blue component of level
	
	la $a0, win_level_msg		# load the win level display to lvl_buffer
	la $a1, lvl_buffer
	li $a2, LVL_SIZE_BYTES
	jal load_file
	
	li $a0, WHITE			# display the win level display to the screen
	lw $a1, green + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level
	
	# print win message
	la $a0, win_message
	li $a1, BASE_ADDRESS
	addi $a1, $a1, LOWER_MSG_POS
	jal render_message
	
	li $a0, WIN_LEVEL_DISPLAY_WAIT
	li $v0, 32
	syscall
	
	win_level_polling_loop:
		lw $s2, KEY_PRESS
		beqz $s2, after_win_level_key_press
		
		win_level_key_press:
			lw $s3, KEY_INPUT
			
			win_level_handle_input_space:
				bne $s3, 0x20, win_level_handle_input_q
				lw $s0, next_level
				jr $s0
				
			win_level_handle_input_q:
				bne $s3, 0x71, after_win_level_key_press
				j quit
		
		after_win_level_key_press:
		j win_level_polling_loop

	
######################## Losing Message ###################################

lose_level:
	move $a0, $zero
	lw $a1, red + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level				# clear red component of level
	
	move $a0, $zero
	lw $a1, green + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level				# clear green component of level
	
	move $a0, $zero
	lw $a1, blue + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level				# clear blue component of level
	
	la $a0, lose_level_msg		# load the lose level display to lvl_buffer
	la $a1, lvl_buffer
	li $a2, LVL_SIZE_BYTES
	jal load_file
	
	li $a0, WHITE			# display the win level display to the screen
	lw $a1, green + LEVEL_POS
	addi $a1, $a1, BASE_ADDRESS
	jal render_level
	
	# print lose message
	la $a0, lose_message
	li $a1, BASE_ADDRESS
	addi $a1, $a1, LOWER_MSG_POS
	jal render_message
	
	li $a0, WIN_LEVEL_DISPLAY_WAIT
	li $v0, 32
	syscall
	
	lose_level_polling_loop:
		lw $s2, KEY_PRESS
		beqz $s2, after_lose_level_key_press
		
		lose_level_key_press:
			lw $s3, KEY_INPUT
			
			lose_level_handle_input_p:
				bne $s3, 0x70, lose_level_handle_input_m
				lw $s0, level_address
				jr $s0
			
			lose_level_handle_input_m:
				bne $s3, 0x6D, lose_level_handle_input_q
				j main
				
			lose_level_handle_input_q:
				bne $s3, 0x71, after_lose_level_key_press
				j quit
		
		after_lose_level_key_press:
		j lose_level_polling_loop
	
		
######################## Quit the Game ####################################

quit:	jal reset_screen

	li $v0, 10
	syscall
