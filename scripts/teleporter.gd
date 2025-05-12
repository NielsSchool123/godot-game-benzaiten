extends StaticBody3D

var can_teleport := true  # cooldown flag
@onready var teleport_sound = $Teleport

func _on_area_3d_body_entered(body: Node3D) -> void:
	# Check that the body is the player (by group, more reliable than name)
	if not body.is_in_group("player"):
		print("Ignored body:", body.name)
		return
	teleport_sound.play()
	print("Player entered teleport zone")

	if not can_teleport:
		print("Teleport on cooldown")
		return

	can_teleport = false  # prevent instant re-trigger

	var closest_zone: Node3D = null
	var closest_distance := INF

	for zone in get_tree().get_nodes_in_group("teleport_zone"):
		if zone == self:
			continue  # skip self

		var distance = body.global_transform.origin.distance_to(zone.global_transform.origin)
		if distance < closest_distance:
			closest_distance = distance
			closest_zone = zone

	if closest_zone:
		print("Teleporting to:", closest_zone.name)
		body.global_transform.origin = closest_zone.global_transform.origin
	else:
		print("No valid teleport destination found")

	# Optional cooldown delay to prevent bouncing
	await get_tree().create_timer(2).timeout
	can_teleport = true
