extends Node3D

const STEP_LENGTH: float = 8
var direction = Vector3.FORWARD

func _process(delta):
	if Input.is_action_just_pressed("ui_player_move_forward"):
		position += direction * STEP_LENGTH
	if Input.is_action_just_pressed("ui_player_move_backward"):
		position -= direction * STEP_LENGTH
	if Input.is_action_just_pressed("ui_player_turn_right"):
		direction = direction.rotated(Vector3.UP, -PI / 2)
		look_at(position + direction)
	if Input.is_action_just_pressed("ui_player_turn_left"):
		direction = direction.rotated(Vector3.UP, PI / 2)
		look_at(position + direction)
