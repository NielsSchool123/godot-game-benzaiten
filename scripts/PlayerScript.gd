extends CharacterBody3D

@export var speed: float = 15.0
@export var jump_velocity: float = 10
@export var gravity: float = 12.0
@export var mouse_sensitivity: float = 0.002

@onready var camera: Camera3D = $Camera3D
@onready var anim_player: AnimationPlayer = $Animation/AnimationPlayer


var mouse_captured: bool = false

# muis input om om je heen te kijken
func _input(event):
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
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# movement via input map
	var input := Vector3.ZERO
	input.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	input.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	input = input.normalized()
	
	# move calculatie
	var direction = (global_transform.basis * input).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	# jumpen enzo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# beweeg het chacter
	move_and_slide()
	
	# speel animatie als je beweegt
	var horizontal_speed = Vector2(velocity.x, velocity.z).length()
	if horizontal_speed > 0.1:
		if !anim_player.is_playing():
			anim_player.play("Armature|mixamo_com|Layer0") 
	else:
		anim_player.stop()
