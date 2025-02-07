extends Camera3D

@export var target : Node3D

const CAMERA_MOVEMENT_SPEED = 50
var distanceFromCamera: Vector3

func _ready():
	distanceFromCamera = position

func _process(delta):
	var movement = Vector3.ZERO

	if Input.is_action_pressed("ui_camera_rotate_cw"):
		distanceFromCamera = distanceFromCamera.rotated(Vector3.UP, -delta)
	if Input.is_action_pressed("ui_camera_rotate_ccw"):
		distanceFromCamera = distanceFromCamera.rotated(Vector3.UP, delta)
	if Input.is_action_pressed("ui_camera_move_forward"):
		movement += position.direction_to(target.position)
	if Input.is_action_pressed("ui_camera_move_backward"):
		movement += position.direction_to(target.position) * -1
	if Input.is_action_pressed("ui_camera_move_left"):
		movement += position.direction_to(target.position).rotated(Vector3.UP, PI / 2)
	if Input.is_action_pressed("ui_camera_move_right"):
		movement += position.direction_to(target.position).rotated(Vector3.UP, -PI / 2)

	movement = movement * delta * CAMERA_MOVEMENT_SPEED
	movement.y = 0
	target.position += movement
	position = target.position + distanceFromCamera
	look_at(target.position)
