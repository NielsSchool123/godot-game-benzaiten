extends Control

@onready var fullscreen_checkbox = $Fullscreen
@onready var fps_option = $"FPS limit"
@onready var back_button = $IntroScreen
@onready var click_sound = $Buttonselect
@onready var volume_slider = $HSlider  # Add reference to the volume slider

# Default volume value (you can change this or load it from settings)
var default_volume: float = 1

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

	# Set volume slider value
	volume_slider.value = default_volume  # Set default volume value (or load from saved settings)

	# Connect signals
	fullscreen_checkbox.toggled.connect(_on_fullscreen_toggled)
	fps_option.item_selected.connect(_on_fps_selected)
	back_button.pressed.connect(_on_back_pressed)
	volume_slider.value_changed.connect(_on_volume_changed)  # Connect slider value change to function

func _on_fullscreen_toggled(toggled_on):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)

func _on_fps_selected(index):
	var fps = fps_option.get_item_metadata(index)
	Engine.set_max_fps(fps)

func _on_back_pressed():
	click_sound.play()
	await get_tree().create_timer(0.14).timeout
	get_tree().change_scene_to_file("res://IntroScreen.tscn")

# Function to handle volume change
func _on_volume_changed(value: float):
	# Adjust the master volume for the audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	# Optionally, save the volume setting (e.g., to user settings or a config file)
	default_volume = value  # Save current volume value for next session
