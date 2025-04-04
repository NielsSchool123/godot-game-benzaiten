extends CharacterBody3D

@export var speed: float = 15.0
@export var jump_velocity: float = 10
@export var gravity: float = 12.0
@export var mouse_sensitivity: float = 0.002

@onready var camera: Camera3D = $Camera3D
var mouse_captured: bool = false

# Handles mouse input for looking around
func _input(event):
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * mouse_sensitivity)  # Rotate player horizontally
		camera.rotate_x(event.relative.y * mouse_sensitivity)  # Rotate camera vertically
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))  # Limit vertical look
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			mouse_captured = event.pressed
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)

# Handles player movement and physics
func _physics_process(delta: float) -> void:
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Get movement input
	var input := Vector3.ZERO
	input.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	input.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	input = input.normalized()
	
	# Calculate movement direction
	var direction = (global_transform.basis * input).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Move the character
	move_and_slide()
