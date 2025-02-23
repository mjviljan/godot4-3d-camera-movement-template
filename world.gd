extends Node3D

signal camera_rotate(direction)
signal camera_move(direction)

signal player_rotate(direction)
signal player_move(direction)

func _ready():
	var window = get_window()
	var screen_rect = DisplayServer.screen_get_usable_rect(window.current_screen)
	var window_side_length = min(screen_rect.size.x, screen_rect.size.y) * .95
	# this is for a horizontal screen, with the window being wider than it is tall
	DisplayServer.window_set_size(Vector2(1.5 * window_side_length, window_side_length))
	var window_size = DisplayServer.window_get_size_with_decorations()
	# center window
	window.position = screen_rect.position + ((screen_rect.size - window_size) / 2)

func _process(delta):
	if Input.is_action_pressed("ui_camera_rotate_cw"):
		camera_rotate.emit(Constants.Rotation.CLOCKWISE)
	if Input.is_action_pressed("ui_camera_rotate_ccw"):
		camera_rotate.emit(Constants.Rotation.COUNTER_CLOCKWISE)

	if Input.is_action_pressed("ui_camera_move_forward"):
		camera_move.emit(Constants.Direction.FORWARD)
	if Input.is_action_pressed("ui_camera_move_backward"):
		camera_move.emit(Constants.Direction.BACKWARD)
	if Input.is_action_pressed("ui_camera_move_left"):
		camera_move.emit(Constants.Direction.LEFT)
	if Input.is_action_pressed("ui_camera_move_right"):
		camera_move.emit(Constants.Direction.RIGHT)

	if Input.is_action_just_pressed("ui_player_turn_right"):
		player_rotate.emit(Constants.Rotation.CLOCKWISE)
	if Input.is_action_just_pressed("ui_player_turn_left"):
		player_rotate.emit(Constants.Rotation.COUNTER_CLOCKWISE)

	if Input.is_action_just_pressed("ui_player_move_forward"):
		player_move.emit(Constants.Direction.FORWARD)
	if Input.is_action_just_pressed("ui_player_move_backward"):
		player_move.emit(Constants.Direction.BACKWARD)
