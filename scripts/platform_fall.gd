extends Node3D

# het meeste hiervan is door AI geschreven (note to self: rewrite/write comments + code)

class_name DisappearingPlatform

# Export variables to customize platform behavior in the editor
@export var disappear_time: float = 0.5
@export var respawn_time: float = 3.0
@export var warning_color: Color = Color(1.0, 0.5, 0.0)  # Orange warning color
@export var normal_color: Color = Color(0.2, 0.8, 0.2)   # Default green color
@export var fade_animation_time: float = 0.5

# Internal variables to track state
var timer: float = 0.0
var is_active: bool = true
var is_player_on_platform: bool = false
var is_respawning: bool = false
var original_scale: Vector3
var original_position: Vector3

# References to node components
var platform_body: StaticBody3D
var collision_shape: CollisionShape3D
var platform_mesh: Node  # This can be any node containing your platform model
var materials: Array[Material] = []
var original_materials: Array[Material] = []

func _ready():
	# Get references to components
	collision_shape = $DetectorArea/CollisionShape3D
	platform_mesh = $Cube  # Adjust this path to your model's node
	
	# Store original transform for respawning
	original_scale = scale
	original_position = position
	
	# Store and modify all materials in the platform mesh
	collect_materials(platform_mesh)
	
	# Set initial color
	set_platform_color(normal_color)

# Recursively collect all materials from the model
func collect_materials(node: Node) -> void:
	if node is MeshInstance3D:
		var mesh_instance := node as MeshInstance3D
		
		# Handle surface materials
		if mesh_instance.material_override:
			original_materials.append(mesh_instance.material_override)
			var new_material = mesh_instance.material_override.duplicate()
			mesh_instance.material_override = new_material
			materials.append(new_material)
		
		# Handle per-surface materials
		for i in range(mesh_instance.get_surface_override_material_count()):
			var mat = mesh_instance.get_surface_override_material(i)
			if mat:
				original_materials.append(mat)
				var new_material = mat.duplicate()
				mesh_instance.set_surface_override_material(i, new_material)
				materials.append(new_material)
	
	# Recursively check children
	for child in node.get_children():
		collect_materials(child)

# Set color for all platform materials
func set_platform_color(color: Color) -> void:
	for material in materials:
		if material is StandardMaterial3D:
			material.albedo_color = color
		elif material is BaseMaterial3D:
			material.albedo_color = color

# Set alpha for all platform materials
func set_platform_alpha(alpha: float) -> void:
	for material in materials:
		if material is StandardMaterial3D:
			material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			material.albedo_color.a = alpha
		elif material is BaseMaterial3D:
			material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			material.albedo_color.a = alpha

func _physics_process(delta):
	if is_player_on_platform and is_active:
		# Increment timer while player is on the platform
		timer += delta
		
		# Visual warning when platform is about to disappear
		if timer > disappear_time * 0.5:
			set_platform_color(warning_color)
		
		# When timer reaches disappear_time, start disappearing
		if timer >= disappear_time:
			start_disappearing()
	elif is_respawning:
		# Handle respawning logic
		timer += delta
		if timer >= respawn_time:
			respawn_platform()

func start_disappearing():
	# Mark platform as inactive and start the respawn timer
	is_active = false
	is_respawning = true
	timer = 0.0
	
	# Create a tween for smooth disappearing animation
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector3.ZERO, fade_animation_time)
	tween.parallel().tween_method(set_platform_alpha, 1.0, 0.0, fade_animation_time)
	
	# Disable collision when platform is gone
	tween.tween_callback(func(): 
		collision_shape.disabled = true
		visible = false
	)

func respawn_platform():
	# Reset state
	is_respawning = false
	is_active = true
	timer = 0.0
	
	# Enable collision and visibility
	collision_shape.disabled = false
	visible = true
	
	# Reset appearance
	set_platform_color(normal_color)
	set_platform_alpha(1.0)
	
	# Create a tween for smooth respawning animation
	var tween = create_tween()
	tween.tween_property(self, "scale", original_scale, fade_animation_time)
	
# Signal handlers for player detection





func _on_detector_area_body_entered(body: Node3D):
	if body.is_in_group("player"):
		is_player_on_platform = true


func _on_detector_area_body_exited(body: Node3D):
	if body.is_in_group("player"):
		is_player_on_platform = false
	if is_active:
		timer = 0.0
		set_platform_color(normal_color)
