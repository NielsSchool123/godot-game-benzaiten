extends Control

func _ready(): # logica voor de quit button, als de button text quit is dan runt het de logica om het af te sluiten en aders gebruikt de de funcite daaronder
	for button in $VBoxContainer.get_children():
		if button.text == "Quit":
			button.pressed.connect(func(): get_tree().quit())
		else:
			button.pressed.connect(func(): _on_level_selected(button.text))


func _on_level_selected(level_name: String): # logica voor levels laden, het kijkt wat er op de button staat en laad dat level
	var scene_path = "res://" + level_name + ".tscn" 
	get_tree().change_scene_to_file(scene_path)
