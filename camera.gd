extends Camera3D

@export var target : Node3D

const CAMERA_MOVEMENT_SPEED = 40
var distance_from_camera: Vector3

func _ready():
	distance_from_camera = position

func _process(delta):
	var movement = Vector3.ZERO

	if Input.is_action_pressed("ui_camera_rotate_cw"):
		distance_from_camera = distance_from_camera.rotated(Vector3.UP, -delta)
	if Input.is_action_pressed("ui_camera_rotate_ccw"):
		distance_from_camera = distance_from_camera.rotated(Vector3.UP, delta)

	if Input.is_action_pressed("ui_camera_move_forward"):
		movement += position.direction_to(target.position)
	if Input.is_action_pressed("ui_camera_move_backward"):
		movement += position.direction_to(target.position) * -1
	if Input.is_action_pressed("ui_camera_move_left"):
		movement += position.direction_to(target.position).rotated(Vector3.UP, PI / 2)
	if Input.is_action_pressed("ui_camera_move_right"):
		movement += position.direction_to(target.position).rotated(Vector3.UP, -PI / 2)

	if movement != Vector3.ZERO:
		movement = movement * delta * CAMERA_MOVEMENT_SPEED
		movement.y = 0
		# not sure if lerping adds any smoothness here, but using it still...
		var lerp_factor = min(.9 + delta, 1)
		target.position = target.position.lerp(target.position + movement, lerp_factor)

	position = target.position + distance_from_camera
	look_at(target.position)
