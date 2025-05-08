extends Node3D

@export var move_distance := 2.0
@export var move_speed := 5.0

var target_position: Vector3


func _ready():
	target_position = global_transform.origin

func _on_area_3d_body_entered(body):
	if body.name == "Player": # or check with body is Player if you use a script
		target_position = global_transform.origin - Vector3(0, move_distance, 0)
