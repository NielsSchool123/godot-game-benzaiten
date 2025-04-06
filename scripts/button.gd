extends Button

@export var press_sound: AudioStream
@export var audio_player: AudioStreamPlayer

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if press_sound and audio_player:
		audio_player.stream = press_sound
		audio_player.play()
	
	get_tree().change_scene_to_file("res://MainMenu.tscn")
