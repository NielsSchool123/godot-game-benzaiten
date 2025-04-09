extends Control
@onready var button_select: AudioStreamPlayer = $Buttonselect

func _ready(): # logica voor de quit button, als de button text quit is dan runt het de logica om het af te sluiten en aders gebruikt de de funcite daaronder
	for button in $VBoxContainer.get_children():
		if button.name == "Quit":
			button.pressed.connect(func(): get_tree().quit())
		else:
			button.pressed.connect(func(): _on_level_selected(button.name))


func _on_level_selected(level_name: String): # logica voor levels laden, het kijkt hij de button heet  en laad dat level
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	var scene_path = "res://" + level_name + ".tscn" 
	get_tree().change_scene_to_file(scene_path)
