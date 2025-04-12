extends Control

@export var main_menu_scene: String = "res://secretlevel1.tscn"
@export var alt_scene: String = "res://introscreen.tscn"  # Second scene to load

@onready var win_sound: AudioStreamPlayer = $Secret
@onready var button_select: AudioStreamPlayer = $Buttonselect

func _ready():
	win_sound.play()
	$Button.pressed.connect(_on_button_pressed)
	$AltButton.pressed.connect(_on_alt_button_pressed)  # Second button

func _on_button_pressed():
	Global.secret_level_visited = true
	button_select.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(main_menu_scene)

func _on_alt_button_pressed():
	button_select.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(alt_scene)
