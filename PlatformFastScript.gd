extends StaticBody3D

@export var speed: float = 25.0
@export var move_distance: float = 10.0
@export var move_axis: Vector3 = Vector3(1, 0, 0)  # Move along X by default

var start_pos: Vector3
var moving_to_end = true

func _ready():
	start_pos = position

func _process(delta):
	var target_pos = start_pos + move_axis * move_distance if moving_to_end else start_pos
	position = position.move_toward(target_pos, speed * delta)
	
	if position == target_pos:
		moving_to_end = !moving_to_end
