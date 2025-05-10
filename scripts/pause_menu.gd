extends CanvasLayer

@onready var resume_button: Button = $Control/ResumeButton
@onready var main_menu_button: Button = $Control/MainMenuButton
@onready var quit_button: Button = $Control/QuitButton
@onready var button_select: AudioStreamPlayer = $Buttonselect


func _ready():
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _on_resume_pressed():
	Engine.time_scale = 1
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_main_menu_pressed():
	Engine.time_scale = 1
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	get_tree().change_scene_to_file("res://MainMenu.tscn")  # Adjust to your main menu path

func _on_quit_pressed():
	Engine.time_scale = 1
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	get_tree().quit()
