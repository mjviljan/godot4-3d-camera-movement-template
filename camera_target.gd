extends Node3D

const CAMERA_MOVEMENT_SPEED = 40

var movement_direction: Constants.Direction
var target_position: Vector3

func _ready():
	movement_direction = Constants.Direction.NONE
	target_position = Vector3(1,1,1)

func _process(delta):
	var movement = Vector3.ZERO

	if (movement_direction & Constants.Direction.FORWARD):
		movement += position.direction_to(target_position)
	if (movement_direction & Constants.Direction.BACKWARD):
		movement += position.direction_to(target_position) * -1
	if (movement_direction & Constants.Direction.LEFT):
		movement += position.direction_to(target_position).rotated(Vector3.UP, PI / 2)
	if (movement_direction & Constants.Direction.RIGHT):
		movement += position.direction_to(target_position).rotated(Vector3.UP, -PI / 2)

	if movement_direction:
		movement = movement * delta * CAMERA_MOVEMENT_SPEED
		movement.y = 0
		# not sure if lerping adds any smoothness here, but using it still...
		var lerp_factor = min(.9 + delta, 1)
		position = position.lerp(position + movement, lerp_factor)
		movement_direction = Constants.Direction.NONE
		print(position)

func _on_world_camera_move(direction):
	movement_direction |= direction
