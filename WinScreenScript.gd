extends Control

@export var main_menu_scene: String = "res://MainMenu.tscn"

func _ready():
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	get_tree().change_scene_to_file(main_menu_scene)
