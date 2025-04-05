extends Area3D

@export var win_screen_scene: PackedScene # je selecteerd dit in godot inspector (note: zoek uit hoe dit precies werkt)

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		show_win_screen()

func show_win_screen():
	var win_screen = win_screen_scene.instantiate()
	get_tree().current_scene.add_child(win_screen)
