extends Node3D

signal player_moving_to(position)

const STEP_LENGTH: float = 8
var direction = Vector3.FORWARD
var target_position = position
var target_direction = direction
var turn_direction: Constants.Rotation
var move_direction: Constants.Direction

func _process(delta):
	if (move_direction):
		if (move_direction == Constants.Direction.FORWARD):
			target_position += target_direction * STEP_LENGTH
		if (move_direction == Constants.Direction.BACKWARD):
			target_position -= target_direction * STEP_LENGTH

		move_direction = Constants.Direction.NONE
		player_moving_to.emit(target_position)

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

func _on_world_player_move(direction):
	move_direction = direction
