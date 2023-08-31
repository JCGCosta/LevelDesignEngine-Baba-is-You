extends Node2D

enum {
	EMPTY,		# 0 - Empty Cell
	BOB,		# 1 - Bob Cell
	FLAG,		# 2 - Flag Cell
	ROCK,		# 3 - Rock Cell
	WALL,		# 4 - Wall Cell
	BOB_C,		# 5 - Bob Command Cell
	IS_C,		# 6 - Is Command Cell
	YOU_C,		# 7 - You Command Cell
	WALL_C,		# 8 - Wall Command Cell
	STOP_C,		# 9 - Stop Command Cell
	ROCK_C,		# 10 - Rock Command Cell
	PUSH_C,		# 11 - Push Command Cell
	FLAG_C,		# 12 - Flag Command Cell
	WIN_C		# 13 - Win Command Cell
}

var COMMANDS = [
	BOB_C,
	WALL_C,
	FLAG_C,
	ROCK_C,
	IS_C,
	YOU_C,
	STOP_C,
	PUSH_C,
	WIN_C 
]

var OBJECTS = [
	BOB,
	FLAG,
	ROCK,
	WALL
]

var RESOURCE_TEXTURE = {
	BOB: preload("res://sprites/1.png"),
	FLAG: preload("res://sprites/2.png"),
	ROCK: preload("res://sprites/3.png"),
	WALL: preload("res://sprites/4.png"),
	BOB_C: preload("res://sprites/5.png"),
	IS_C: preload("res://sprites/6.png"),
	YOU_C: preload("res://sprites/7.png"),
	WALL_C: preload("res://sprites/8.png"),
	STOP_C: preload("res://sprites/9.png"),
	ROCK_C: preload("res://sprites/10.png"),
	PUSH_C: preload("res://sprites/11.png"),
	FLAG_C: preload("res://sprites/12.png"),
	WIN_C: preload("res://sprites/13.png"),
}

var OBJ_CORRELATION = {
	BOB_C: BOB,
	FLAG_C: FLAG,
	ROCK_C: ROCK,
	WALL_C: WALL
}

# you, push, stop, win
var INSTANCE_STATES = {
	YOU_C: EMPTY,
	PUSH_C: EMPTY,
	STOP_C: EMPTY,
	WIN_C: EMPTY
}

var LEVEL1_POS = [
	
	[WALL, [12, 5]],
	[WALL, [13, 5]],
	[WALL, [14, 5]],
	[WALL, [15, 5]],
	[WALL, [16, 5]],
	[WALL, [17, 5]],
	[WALL, [18, 5]],
	[WALL, [19, 5]],
	[WALL, [20, 5]],
	
	[WALL, [12, 11]],
	[WALL, [13, 11]],
	[WALL, [14, 11]],
	[WALL, [15, 11]],
	[WALL, [16, 11]],
	[WALL, [17, 11]],
	[WALL, [18, 11]],
	[WALL, [19, 11]],
	[WALL, [20, 11]],
	
	[ROCK, [16, 6]],
	[ROCK, [16, 7]],
	[ROCK, [16, 8]],
	[ROCK, [16, 9]],
	[ROCK, [16, 10]],
	
	[BOB, [8, 8]],
	[FLAG, [24, 8]],
	
	[BOB_C, [12, 3]],
	[IS_C, [13, 3]],
	[YOU_C, [14, 3]],
	
	[WALL_C, [18, 3]],
	[IS_C, [19, 3]],
	[STOP_C, [20, 3]],
	
	[ROCK_C, [12, 13]],
	[IS_C, [13, 13]],
	[PUSH_C, [14, 13]],
	
	[FLAG_C, [18, 13]],
	[IS_C, [19, 13]],
	[WIN_C, [20, 13]],
]

var LEVEL2_POS = [
	
	[WALL, [20, 2]],
	[WALL, [20, 3]],
	[WALL, [20, 4]],
	[WALL, [20, 5]],
	[WALL, [20, 6]],
	[WALL, [20, 7]],
	[WALL, [20, 8]],
	
	[WALL, [14, 1]],
	[WALL, [15, 1]],
	[WALL, [16, 1]],
	[WALL, [17, 1]],
	[WALL, [18, 1]],
	[WALL, [19, 1]],
	[WALL, [20, 1]],
	
	[WALL, [14, 2]],
	[WALL, [14, 3]],
	[WALL, [14, 4]],
	[WALL, [14, 5]],
	
	[WALL, [13, 5]],
	[WALL, [12, 5]],
	[WALL, [11, 5]],
	[WALL, [10, 5]],
	
	[WALL, [10, 6]],
	[WALL, [10, 7]],
	[WALL, [10, 8]],
	[WALL, [10, 9]],
	
	[WALL, [11, 9]],
	[WALL, [12, 9]],
	[WALL, [13, 9]],
	[WALL, [14, 9]],
	[WALL, [15, 9]],
	[WALL, [16, 9]],
	[WALL, [17, 9]],
	[WALL, [18, 9]],
	[WALL, [19, 9]],
	[WALL, [20, 9]],
	
	[WALL, [20, 10]],
	[WALL, [20, 11]],
	[WALL, [20, 12]],
	[WALL, [20, 13]],
	[WALL, [20, 14]],
	[WALL, [20, 15]],
	
	[WALL, [19, 15]],
	[WALL, [18, 15]],
	[WALL, [17, 15]],
	[WALL, [16, 15]],
	[WALL, [15, 15]],
	[WALL, [14, 15]],
	
	[WALL, [14, 14]],
	[WALL, [14, 13]],
	[WALL, [14, 12]],
	[WALL, [14, 11]],
	[WALL, [14, 10]],
	
	[BOB, [17, 13]],
	[FLAG, [16, 7]],
	
	[BOB_C, [0, 0]],
	[IS_C, [1, 0]],
	[YOU_C, [2, 0]],
	
	[WALL_C, [16, 11]],
	[IS_C, [17, 11]],
	[STOP_C, [18, 11]],
	
	[FLAG_C, [12, 7]],
	[IS_C, [16, 3]],
	[WIN_C, [18, 5]],
]

var LEVEL3_POS = [
	
	[FLAG, [20, 2]],
	[FLAG, [20, 3]],
	[FLAG, [20, 4]],
	[FLAG, [20, 5]],
	[FLAG, [20, 6]],
	[FLAG, [20, 7]],
	[FLAG, [20, 8]],
	
	[FLAG, [14, 1]],
	[FLAG, [15, 1]],
	[FLAG, [16, 1]],
	[FLAG, [17, 1]],
	[FLAG, [18, 1]],
	[FLAG, [19, 1]],
	[FLAG, [20, 1]],
	
	[FLAG, [14, 2]],
	[FLAG, [14, 3]],
	[FLAG, [14, 4]],
	[FLAG, [14, 5]],
	
	[FLAG, [13, 5]],
	[FLAG, [12, 5]],
	[FLAG, [11, 5]],
	[FLAG, [10, 5]],
	
	[FLAG, [10, 6]],
	[FLAG, [10, 7]],
	[FLAG, [10, 8]],
	[FLAG, [10, 9]],
	
	[FLAG, [11, 9]],
	[FLAG, [12, 9]],
	[FLAG, [13, 9]],
	[FLAG, [14, 9]],
	[FLAG, [15, 9]],
	[FLAG, [16, 9]],
	[FLAG, [17, 9]],
	[FLAG, [18, 9]],
	[FLAG, [19, 9]],
	[FLAG, [20, 9]],
	
	[FLAG, [20, 10]],
	[FLAG, [20, 11]],
	[FLAG, [20, 12]],
	[FLAG, [20, 13]],
	[FLAG, [20, 14]],
	[FLAG, [20, 15]],
	
	[FLAG, [19, 15]],
	[FLAG, [18, 15]],
	[FLAG, [17, 15]],
	[FLAG, [16, 15]],
	[FLAG, [15, 15]],
	[FLAG, [14, 15]],
	
	[FLAG, [14, 14]],
	[FLAG, [14, 13]],
	[FLAG, [14, 12]],
	[FLAG, [14, 11]],
	[FLAG, [14, 10]],
	
	[ROCK, [17, 13]],
	[WALL, [16, 7]],
	
	[ROCK_C, [0, 0]],
	[IS_C, [1, 0]],
	[YOU_C, [2, 0]],
	
	[FLAG_C, [16, 11]],
	[IS_C, [17, 11]],
	[STOP_C, [18, 11]],
	
	[WALL_C, [12, 7]],
	[IS_C, [16, 3]],
	[WIN_C, [18, 5]],
]

var CURRENT_LEVEL = 1

onready var GAMERESOLUTION = [get_viewport().size.x, get_viewport().size.y]

var display_div = [32, 16]
