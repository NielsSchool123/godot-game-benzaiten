extends CharacterBody3D

@export var speed: float = 10.0
@export var gravity: float = -9.8 
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var detection_zone: Area3D = $DetectionZone  # De aggro zone
@onready var hitbox: Area3D = $Hitbox  # De hitbox om te resetten
@onready var death: AudioStreamPlayer = $Death

var active: bool = false  # Vijand start inactief (wat doet bool)

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
		if body.has_method("die"):
			body.die()
			death.play()
			await get_tree().create_timer(3.0).timeout  # wacht 3 seconden zodat animatie afspeelt
		reset_game()



func reset_game():
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if active and player:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		
		# veranderd welke kant de slime kijky
		var adjusted_direction = Vector3(direction.x, 0, direction.z).rotated(Vector3.UP, deg_to_rad(90))
		look_at(global_transform.origin + adjusted_direction, Vector3.UP)  # Laat vijand naar de speler kijken
		
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
	move_and_slide()  # beweegt enzo
