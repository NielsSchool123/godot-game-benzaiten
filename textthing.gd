extends Area3D

@onready var ui = $CanvasLayer/Label  # Adjust this path to your textbox node
var activated = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if activated or not body.is_in_group("player"):  # Add your player to a "player" group
		return
	activated = true

	ui.visible = true
	ui.text = "HES HERE"
	
	await get_tree().create_timer(0.5).timeout

	get_tree().quit()
