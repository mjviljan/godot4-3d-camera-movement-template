extends Node3D

const STEP_LENGTH: float = 8
var direction = Vector3.FORWARD
var target_position = position
var target_direction = direction

func _process(delta):
	if Input.is_action_just_pressed("ui_player_move_forward"):
		target_position += target_direction * STEP_LENGTH
	if Input.is_action_just_pressed("ui_player_move_backward"):
		target_position -= target_direction * STEP_LENGTH
	if Input.is_action_just_pressed("ui_player_turn_right"):
		target_direction = target_direction.rotated(Vector3.UP, -PI / 2)
		#look_at(position + target_direction)
	if Input.is_action_just_pressed("ui_player_turn_left"):
		target_direction = target_direction.rotated(Vector3.UP, PI / 2)
		#direction = direction.lerp(target_direction, .5 - delta)
		#look_at(position + direction)

	position = position.lerp(target_position, .75 - delta)
	direction = direction.lerp(target_direction, .5 - delta)
	look_at(position + direction)
