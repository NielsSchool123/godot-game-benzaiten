extends Node3D

@export var move_distance := 5
@export var move_speed := 15

var target_position: Vector3

func _ready():
	target_position = global_transform.origin

func _process(delta):
	# Move towards the target position smoothly
	var current_position = global_transform.origin
	var new_position = current_position.lerp(target_position, move_speed * delta)
	global_transform.origin = new_position

func _on_area_3d_body_entered(body):
	if body.name == "player":
		target_position = global_transform.origin - Vector3(0, move_distance, 0)
