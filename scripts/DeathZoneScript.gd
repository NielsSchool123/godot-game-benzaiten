extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)  # Detecteer of iets de grens raakt

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()  # Reset de game
