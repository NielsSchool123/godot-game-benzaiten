extends StaticBody3D 

@export var win_screen_scene: PackedScene # uhhh je selecteert het in godot zelf (note: zoek op hoe dit precies werkt)

func _ready():  # decteert of iemand in de hotbox is
	$Area3D.body_entered.connect(_on_body_entered)
	if Global.secret_level_visited:
		queue_free()


func _on_body_entered(body): # als iemand in de hitbox is doe show win script
	if body.is_in_group("player"):
		show_win_screen()

func show_win_screen(): # laat het winscreen zien
	var win_screen = win_screen_scene.instantiate()
	get_tree().current_scene.add_child(win_screen)
