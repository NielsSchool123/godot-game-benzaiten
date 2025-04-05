extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)  # dectecteer of iets de hitbox raakt 

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()  # reset de game (mischien veranderen in de toekomst)
