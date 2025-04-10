extends AnimatableBody3D

@export var move_distance: float = 15  # hoe ver
@export var move_speed: float = 10  # hoe snel

var direction: int = 1
var start_position: Vector3

func _ready():
	start_position = global_transform.origin  # start positie bewaren

func _process(delta):
	global_transform.origin.y += direction * move_speed * delta

	# veranderd waar die naar toe gaat wanneer het limiet is gehaald
	if global_transform.origin.y >= start_position.y + move_distance:
		direction = -1  
	elif global_transform.origin.y <= start_position.y - start_position.y:
		direction = 1  
