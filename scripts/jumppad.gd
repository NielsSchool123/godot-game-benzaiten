extends Area3D

@export var jump_force: Vector3 = Vector3.UP * 5

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.has_method("apply_jump_pad_force"):
			body.apply_jump_pad_force(jump_force)
