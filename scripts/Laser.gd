extends Area3D

@export var move_speed: float = 10
@export var move_distance: float = 5.0
@onready var death: AudioStreamPlayer = $Death


var start_position: Vector3
var direction: int = 1

func _ready():
	start_position = position
	connect("body_entered", _on_body_entered)

func _process(delta):
	position.z += move_speed * direction * delta
	if abs(position.z - start_position.z) > move_distance:
		direction *= -1

func _on_body_entered(body):
	if body.is_in_group("player") and not body.is_dead:
		if body.has_method("die"):
			body.die()
			death.play()
			await get_tree().create_timer(3.0).timeout
			get_tree().reload_current_scene()
