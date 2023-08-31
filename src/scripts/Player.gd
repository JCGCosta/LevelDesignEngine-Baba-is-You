extends Node2D

onready var c = get_parent() 

func _input(event):
	c.update_states()
	var current_player = Globals.INSTANCE_STATES[Globals.YOU_C]
	var current_push = Globals.INSTANCE_STATES[Globals.PUSH_C]
	print(Globals.INSTANCE_STATES)
	if event.is_action_pressed("ui_up"):
		c.move_all_instance(current_player, "up")
	if event.is_action_pressed("ui_down"):
		c.move_all_instance(current_player, "down")
	if event.is_action_pressed("ui_left"):
		c.move_all_instance(current_player, "left")
	if event.is_action_pressed("ui_right"):
		c.move_all_instance(current_player, "right")
	c.update_states()
