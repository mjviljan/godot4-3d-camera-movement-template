extends Camera3D

@export var target : Node3D;

func _process(delta):
	if Input.is_action_pressed("ui_camera_rotate_cw"):
		position = position.rotated(Vector3.UP, -delta);
	if Input.is_action_pressed("ui_camera_rotate_ccw"):
		position = position.rotated(Vector3.UP, delta);

	look_at(target.position)
