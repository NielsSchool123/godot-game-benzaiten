extends Area3D
@onready var Death = $Death

func _ready():
	body_entered.connect(_on_body_entered)  # dectecteer of iets de hitbox raakt 


func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		Death.play()
		await get_tree().create_timer(0.16).timeout
		get_tree().reload_current_scene()  # reset de game (mischien veranderen in de toekomst)
