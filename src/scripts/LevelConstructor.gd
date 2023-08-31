extends Node2D

var instance_list
var inmov = false
var canMove = []
onready var widthVec = range(0, Globals.GAMERESOLUTION[0], Globals.GAMERESOLUTION[0] / Globals.display_div[0])
onready var heightVec = range(0, Globals.GAMERESOLUTION[1], Globals.GAMERESOLUTION[1] / Globals.display_div[1])

func _ready():
	print("Game Resolution: ", Globals.GAMERESOLUTION)
	instance_list = create_instances(Globals.LEVEL3_POS, 2)
	update_states()
	pass
		
func create_instances(level_obj_pos, scale) -> Array:
	var instances = []
	for obj in level_obj_pos:
		var currentInst = Sprite.new()
		currentInst.texture = Globals.RESOURCE_TEXTURE[obj[0]] 
		currentInst.position = Vector2(widthVec[obj[1][0]], heightVec[obj[1][1]])
		currentInst.centered = false
		currentInst.scale = Vector2(scale, scale)
		add_child(currentInst)
		instances.append([currentInst, obj[0], [obj[1][0], obj[1][1]]])
	return instances

func search_instance_by_pos(x, y, exclude=[]) -> Array:
	for instance in instance_list:
		if instance[2][0] == x and instance[2][1] == y:
			if not instance[1] in exclude:
				return instance
	return []

func update_states():
	for instance in instance_list:
		if Globals.INSTANCE_STATES.has(instance[1]):
			var inst_left1 = search_instance_by_pos(instance[2][0] - 1, instance[2][1])
			var inst_left2 = search_instance_by_pos(instance[2][0] - 2, instance[2][1])
			if !inst_left1.empty() and !inst_left2.empty():
				if Globals.OBJ_CORRELATION.has(inst_left2[1]) and inst_left1[1] == Globals.IS_C:
					Globals.INSTANCE_STATES[instance[1]] = Globals.OBJ_CORRELATION[inst_left2[1]]
				else: Globals.INSTANCE_STATES[instance[1]] = 0
			else: Globals.INSTANCE_STATES[instance[1]] = 0

#find the instances type that not have properties
func searchNonPropertyInst(): 
	var inst_vec = []
	for inst in Globals.OBJECTS:
		if not inst in Globals.INSTANCE_STATES.values():
			inst_vec.append(inst)
	return inst_vec

func can_move(instance, where):
	var instColliding
	var nonProperty = searchNonPropertyInst()
	match where:
		"up": instColliding = search_instance_by_pos(instance[2][0], instance[2][1] - 1, nonProperty)
		"down": instColliding = search_instance_by_pos(instance[2][0], instance[2][1] + 1, nonProperty)
		"left": instColliding = search_instance_by_pos(instance[2][0] - 1, instance[2][1], nonProperty)
		"right": instColliding = search_instance_by_pos(instance[2][0] + 1, instance[2][1], nonProperty)
	print(instColliding)
	if (!instColliding.empty()): # colidiu
		if (instColliding[1] == Globals.INSTANCE_STATES[Globals.STOP_C]):
			canMove = []
			return false
		if (instColliding[1] in Globals.COMMANDS):
			if(move_instance(instColliding, where)): return true
			return false
		if (instColliding[1] == Globals.INSTANCE_STATES[Globals.PUSH_C]):
			if(move_instance(instColliding, where)): return true
			return false
		if (instColliding[1] == Globals.INSTANCE_STATES[Globals.WIN_C]):
			if (instance[1] == Globals.INSTANCE_STATES[Globals.YOU_C]):
				print("you win")
				return true
			if(move_instance(instColliding, where)): return true
			return false
		canMove = []
		return true
	else:
		canMove = []
		return true

func move_all_instance(inst_num, where):
	for instance in instance_list:
		if instance[1] == inst_num:
			move_instance(instance, where)

func move_instance(instance, where):
	inmov = true
	canMove.append(can_move(instance, where))
	if not false in canMove:
		match where:
			"up":
				var dest = instance[2][1] - 1
				if (dest >= 0 and dest < Globals.display_div[1]): instance[2][1] = dest
				else: return false
			"down": 
				var dest = instance[2][1] + 1
				if (dest >= 0 and dest < Globals.display_div[1]): instance[2][1] = dest
				else: return false
			"left":
				var dest = instance[2][0] - 1
				if (dest >= 0 and dest < Globals.display_div[0]): instance[2][0] = dest
				else: return false
			"right":
				var dest = instance[2][0] + 1
				if (dest >= 0 and dest < Globals.display_div[0]): instance[2][0] = dest
				else: return false
		instance[0].position = Vector2(widthVec[instance[2][0]], heightVec[instance[2][1]])
		return true
