extends CharacterBody3D
@export var speed: float = 15.0
@export var jump_velocity: float = 10
@export var gravity: float = 12.0
@export var mouse_sensitivity: float = 0.002
@onready var camera: Camera3D = $Camera3D
@onready var anim_player: AnimationPlayer = $Animation/AnimationPlayer
@onready var jump_sound: AudioStreamPlayer = $Jump
@onready var walk_model: Node3D = $Animation
@onready var walk_anim: AnimationPlayer = $Animation/AnimationPlayer
@onready var death_model: Node3D = $CharachterDeath
@onready var death_anim: AnimationPlayer = $CharachterDeath/AnimationPlayer

var mouse_captured: bool = false
var is_dead: bool = false

func _ready():
	death_model.visible = false

# muis input om om je heen te kijken
func _input(event):
	if is_dead:
		return
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * mouse_sensitivity)  # horizontaal
		camera.rotate_x(event.relative.y * mouse_sensitivity)  # verticaal
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))  # limiet verticaal kijken (werkt niet)
	
	if event is InputEventMouseButton: # als de muis knop is ingehouden dan kan je bewegen
		if event.button_index == MOUSE_BUTTON_RIGHT:
			mouse_captured = event.pressed
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
# doet pyshcis
func _physics_process(delta: float) -> void:
	if is_dead:
		return  # geen physics of movement als dood
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input := Vector3.ZERO
	input.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	input.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	input = input.normalized()
	
	var direction = (global_transform.basis * input).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jump_sound.play()
	
	move_and_slide()
	
	var horizontal_speed = Vector2(velocity.x, velocity.z).length()
	if horizontal_speed > 0.1:
		if !walk_anim.is_playing():
			walk_anim.play("Armature|mixamo_com|Layer0") 
	else:
		walk_anim.stop()


func die(): # function to play animation when dead
	is_dead = true
	walk_model.visible = false
	death_model.visible = true
	death_anim.play("Armature|mixamo_com|Layer0")
