extends StaticBody3D

@export var move_distance: float = 10.0  # How far it moves left/right
@export var move_speed: float = 15.0  # Movement speed

var direction: int = -1  # 1 = right, -1 = leftho
var start_position: Vector3

func _ready():
	start_position = global_transform.origin  # Store starting position

func _process(delta):
	global_transform.origin.x += direction * move_speed * delta

	# Reverse direction when reaching limits
	if global_transform.origin.x >= start_position.x + move_distance:
		direction = -1  # Move left
	elif global_transform.origin.x <= start_position.x - move_distance:
		direction = 1  # Move right
