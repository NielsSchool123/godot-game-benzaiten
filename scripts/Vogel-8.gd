extends CharacterBody3D

@export var speed: float = 40.0  # Vliegsnelheid
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var detection_zone: Area3D = $DetectionZone  # Om speler te detecteren
@onready var hitbox: Area3D = $Hitbox  # Voor botsing
@onready var death: AudioStreamPlayer = $Death

var active: bool = false  # Wordt true als speler gedetecteerd

func _ready():
	detection_zone.body_entered.connect(_on_body_entered)
	detection_zone.body_exited.connect(_on_body_exited)
	hitbox.body_entered.connect(_on_hitbox_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		active = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		active = false

func _on_hitbox_entered(body):
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
		death.play()
		await get_tree().create_timer(3.0).timeout
		get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	if active and player:
		# Bereken richting naar de speler (ook in Y-richting → dus echt vliegen)
		var direction = (player.global_transform.origin - global_transform.origin).normalized()

		# Laat de vogel richting speler kijken
		if direction.length() > 0:
			look_at(global_transform.origin + direction, Vector3.UP)

		# Zet velocity direct (zonder zwaartekracht)
		velocity = direction * speed
	else:
		velocity = Vector3.ZERO

	move_and_slide()
