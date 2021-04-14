extends Node2D


export var gun_distance := 10

var mouse_angle := 0.0

func is_aim_event(event: InputEvent) -> bool:
	return event.is_action("aim_down") \
	 || event.is_action("aim_up") \
	 || event.is_action("aim_left") \
	 || event.is_action("aim_right")

func _input(event):
	# mouse_angle = vec from player - get_viewport().get_mouse_position()
	# set x = player_x + cos(mouse_angle) + DISTANCE
	# y = player_y + sin(mouse_angle) + DISTANCE
	# rotation = angle(vec_from player to gun)
	#var mouse_angle := position.angle_to(get_viewport().get_mouse_position())
	#print(mouse_angle)
	print(event)
	if event is InputEventMouseMotion:
		var mouse_angle = get_parent().position.angle_to(get_viewport().get_mouse_position())
		var vec_player_to_mouse = get_parent().position - get_viewport().get_mouse_position()
		position = -vec_player_to_mouse.normalized() * 200
	elif is_aim_event(event):
		var x := Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
		var y := Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
		if x != 0 or y != 0:
			position = Vector2(x, y).normalized() * 200
