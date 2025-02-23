extends Camera3D

@export var target : Node3D

const CAMERA_MOVEMENT_SPEED = 40

var distance_from_target: Vector3
var rotate_angle: Constants.Rotation
var movement_direction: Constants.Direction
var desired_target_position: Vector3

func _ready():
	distance_from_target = position
	rotate_angle = Constants.Rotation.NONE
	movement_direction = Constants.Direction.NONE
	desired_target_position = target.position

func _process(delta):
	var movement = Vector3.ZERO

	if (rotate_angle != Constants.Rotation.NONE):
		distance_from_target = distance_from_target.rotated(Vector3.UP, delta * rotate_angle)
		rotate_angle = Constants.Rotation.NONE

	if movement_direction:
		if (movement_direction & Constants.Direction.FORWARD):
			movement += position.direction_to(target.position)
		if (movement_direction & Constants.Direction.BACKWARD):
			movement += position.direction_to(target.position) * -1
		if (movement_direction & Constants.Direction.LEFT):
			movement += position.direction_to(target.position).rotated(Vector3.UP, PI / 2)
		if (movement_direction & Constants.Direction.RIGHT):
			movement += position.direction_to(target.position).rotated(Vector3.UP, -PI / 2)

		movement = movement * delta * CAMERA_MOVEMENT_SPEED
		movement.y = 0
		# not sure if lerping adds any smoothness here, but using it still...
		var lerp_factor = min(.9 + delta, 1)
		target.position = target.position.lerp(target.position + movement, lerp_factor)
		desired_target_position = target.position
		movement_direction = Constants.Direction.NONE
	else:
		target.position = target.position.lerp(desired_target_position, delta)

	position = target.position + distance_from_target
	look_at(target.position)

func _on_world_camera_rotate(direction):
	rotate_angle = direction

func _on_world_camera_move(direction):
	movement_direction |= direction

func _on_player_moving_to(position):
	desired_target_position = position
