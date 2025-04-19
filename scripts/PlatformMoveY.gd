extends AnimatableBody3D

@export var move_distance: float = 15
@export var move_speed: float = 15

var direction: int = 1
var start_position: Vector3

func _ready():
	start_position = global_transform.origin

func _process(delta):
	global_transform.origin += Vector3(0, direction * move_speed * delta, 0)

	if global_transform.origin.y >= start_position.y + move_distance:
		direction = -1
	elif global_transform.origin.y <= start_position.y:
		direction = 1
