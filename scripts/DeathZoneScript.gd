extends Area3D
@onready var death: AudioStreamPlayer = $Death


func _ready():
	body_entered.connect(_on_body_entered)  # dectecteer of iets de hitbox raakt 

func _on_body_entered(body):
	death.play()
	if body.is_in_group("player"):
		await get_tree().create_timer(0.16).timeout
		get_tree().reload_current_scene()  # reset de game (mischien veranderen in de toekomst)
