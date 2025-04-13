extends CanvasLayer

@onready var resume_button: Button = $Control/ResumeButton
@onready var main_menu_button: Button = $Control/MainMenuButton
@onready var settings_button: Button = $Control/SettingsButton
@onready var button_select: AudioStreamPlayer = $Buttonselect


func _ready():
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	settings_button.pressed.connect(_on_settings_pressed)


func _on_resume_pressed():
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	Engine.time_scale = 1
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_main_menu_pressed():
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://MainMenu.tscn")  # Adjust to your main menu path

func _on_settings_pressed():
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Settings.tscn")
