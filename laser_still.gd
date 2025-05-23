extends Area3D

@onready var death: AudioStreamPlayer = $Death

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and not body.is_dead:
		if body.has_method("die"):
			body.die()
			death.play()
			await get_tree().create_timer(3.0).timeout
			get_tree().reload_current_scene()
