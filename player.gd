extends Node3D

const STEP_LENGTH: float = 8
var direction = Vector3.FORWARD
var target_position = position
var target_direction = direction
var turn_direction: Constants.Rotation

func _process(delta):
	if Input.is_action_just_pressed("ui_player_move_forward"):
		target_position += target_direction * STEP_LENGTH
	if Input.is_action_just_pressed("ui_player_move_backward"):
		target_position -= target_direction * STEP_LENGTH

	if (turn_direction != Constants.Rotation.NONE):
		target_direction = target_direction.rotated(Vector3.UP, PI / 2 * turn_direction)
		turn_direction = Constants.Rotation.NONE

	var lerp_factor = min(.75 + delta, 1)
	position = position.lerp(target_position, lerp_factor)
	lerp_factor = min(.5 + delta, 1)
	direction = direction.lerp(target_direction, lerp_factor)
	look_at(position + direction)

func _on_world_player_rotate(direction):
	turn_direction = direction
