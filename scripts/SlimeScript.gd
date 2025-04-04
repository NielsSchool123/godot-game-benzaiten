extends CharacterBody3D

@export var speed: float = 10.0
@export var gravity: float = -9.8  # Gravity force
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var detection_zone: Area3D = $DetectionZone  # De trigger-zone
@onready var hitbox: Area3D = $Hitbox  # De hitbox om te resetten

var active: bool = false  # Vijand start inactief

func _ready():
	detection_zone.body_entered.connect(_on_body_entered)  # Detecteer speler in radius
	detection_zone.body_exited.connect(_on_body_exited)    # Deactiveer als speler wegloopt
	hitbox.body_entered.connect(_on_hitbox_entered)  # Detecteer speler bij hitbox

func _on_body_entered(body):
	if body.is_in_group("player"):
		active = true  # Activeer als speler in de zone komt

func _on_body_exited(body):
	if body.is_in_group("player"):
		active = false  # Stop met volgen als speler weg is

func _on_hitbox_entered(body):
	if body.is_in_group("player"):
		reset_game()  # Reset de game wanneer de speler de hitbox aanraakt

func reset_game():
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity * delta  # Update y velocity with gravity

	if active and player:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		
		# Adjust the direction based on how your model is oriented
		var adjusted_direction = Vector3(direction.x, 0, direction.z).rotated(Vector3.UP, deg_to_rad(90))  # Adjust by 90 degrees
		look_at(global_transform.origin + adjusted_direction, Vector3.UP)  # Laat vijand naar de speler kijken
		
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
	move_and_slide()  # This will handle collisions and gravity automatically
