extends Control

@onready var button_select: AudioStreamPlayer = $Buttonselect
@onready var secret_label = $Secretslabel
@onready var tooltip_label = $TooltipLabel

var tooltips = [
	"Try to find secrets!",
	"It's watching.",
	"Jumping just before falling off a ledge gives you more distance.",
	"Some platforms aren't as stable as they look...",
	"You can rotate mid-air, use it to align for tight landings.",
	"Some things might be locked away forever if you're not careful enough...",
	"Press F11 to escape fullscreen.",
	"Press Escape to open an ingame pause screen.",
	"Some platforms might not be real. Be aware of details!"
]


# logica voor de quit button, als de bubtton text quit is dan runt het de logica om het af te sluiten en aders gebruikt de de funcite daaronder
func _ready():
	secret_label.text = "Secrets found: " + str(GameData.secrets_found) + "/" + str(GameData.total_secrets)
	for button in $VBoxContainer.get_children():
		if button.name == "Quit":
			button.pressed.connect(func(): get_tree().quit())
		else:
			button.pressed.connect(func(): _on_level_selected(button.name))
	if GameData.tooltip_queue.is_empty():
		GameData.refill_tooltip_queue(tooltips)

	tooltip_label.text = GameData.tooltip_queue.pop_front()


func _on_level_selected(level_name: String): # logica voor levels laden, het kijkt hij de button heet  en laad dat level
	button_select.play()
	await get_tree().create_timer(0.14).timeout
	var scene_path = "res://" + level_name + ".tscn" 
	get_tree().change_scene_to_file(scene_path)
