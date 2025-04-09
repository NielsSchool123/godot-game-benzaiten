extends StaticBody3D

@export var move_distance: float = 7.5  # Distance forward/backward
@export var move_speed: float = 15.0  # Speed of movement

var direction: int = 1  # 1 = forward, -1 = backward
var start_position: Vector3

func _ready():
	start_position = global_transform.origin  # Store starting position

func _process(delta):
	global_transform.origin.z += direction * move_speed * delta  # Move along Z-axis

	# Reverse direction when reaching limits
	if global_transform.origin.z >= start_position.z + move_distance:
		direction = -1  # Move backward
	elif global_transform.origin.z <= start_position.z - move_distance:
		direction = 1  # Move forward
