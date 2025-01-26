extends Camera3D

@export var target : Node3D;

func _process(delta):
	position = position.rotated(Vector3.UP, delta)
	look_at(target.position)
