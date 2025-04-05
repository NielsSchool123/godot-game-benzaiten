extends StaticBody3D

@export var move_distance: float = 10.0  # hoe ver
@export var move_speed: float = 15.0  # hoe snel

var direction: int = -1  # 1 = rechts, 1- is links
var start_position: Vector3

func _ready():
	start_position = global_transform.origin  # start positie bewaren

func _process(delta):
	global_transform.origin.x += direction * move_speed * delta

	# veranderd waar die naar toe gaat wanneer het limiet is gehaald
	if global_transform.origin.x >= start_position.x + move_distance:
		direction = -1  # links
	elif global_transform.origin.x <= start_position.x - move_distance:
		direction = 1  # rechts
