extends Control

@onready var fullscreen_checkbox = $Fullscreen
@onready var fps_option = $"FPS limit"
@onready var back_button = $IntroScreen
@onready var click_sound = $Buttonselect

func _ready():
	# Set checkbox based on current state
	fullscreen_checkbox.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

	# Populate FPS options
	fps_option.add_item("30 FPS")
	fps_option.set_item_metadata(0, 30)

	fps_option.add_item("60 FPS")
	fps_option.set_item_metadata(1, 60)

	fps_option.add_item("120 FPS")
	fps_option.set_item_metadata(2, 120)

	fps_option.add_item("Unlimited")
	fps_option.set_item_metadata(3, 0)
	
	

	# Set current FPS option
	var current_fps = Engine.get_max_fps()
	var found = false
	for i in fps_option.item_count:
		if fps_option.get_item_metadata(i) == current_fps:
			fps_option.select(i)
			found = true
			break
	if not found:
		fps_option.select(fps_option.get_item_index(0))  # Default to first

	# Connect signals
	fullscreen_checkbox.toggled.connect(_on_fullscreen_toggled)
	fps_option.item_selected.connect(_on_fps_selected)
	back_button.pressed.connect(_on_back_pressed)

func _on_fullscreen_toggled(toggled_on):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)

func _on_fps_selected(index):
	var fps = fps_option.get_item_metadata(index)
	Engine.set_max_fps(fps)

func _on_back_pressed():
	click_sound.play()
	await get_tree().create_timer(0.14).timeout
	get_tree().change_scene_to_file("res://IntroScreen.tscn")
