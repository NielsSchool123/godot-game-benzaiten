extends Area3D

@onready var ui = $CanvasLayer/Label  # Adjust this path to your textbox node
var activated = false
@onready var main_menu_scene = "res://IntroScreen.tscn"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if activated or not body.is_in_group("player"):  # Add your player to a "player" group
		return
	activated = true

	ui.visible = true
	ui.text = "LOOK UP"
	
	await get_tree().create_timer(1.5).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameData.secrets_found += 1 
	get_tree().change_scene_to_file(main_menu_scene)
