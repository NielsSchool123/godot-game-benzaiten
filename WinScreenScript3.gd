extends Control

@export var main_menu_scene: String = "res://MainMenu.tscn"

@onready var win_sound: AudioStreamPlayer = $Levelwin
@onready var button_select: AudioStreamPlayer = $Buttonselect

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	win_sound.play()
	$Button.pressed.connect(_on_button_pressed)
	$Button2.pressed.connect(_on_button2_pressed)


func _on_button_pressed():
	button_select.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(main_menu_scene)
	
func _on_button2_pressed():
	button_select.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://level_4.tscn")
