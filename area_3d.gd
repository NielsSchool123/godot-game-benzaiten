extends Area3D

func _on_area_body_entered(body: Node3D):
	if body.name != "player":
		print("aap")
		return

	var current_zone = self.get_parent()
	var closest_zone: Node3D = null
	var closest_distance := INF

	for zone in get_tree().get_nodes_in_group("teleport_zone"):
		if zone == current_zone:
			continue  # skip self

		var distance = body.global_transform.origin.distance_to(zone.global_transform.origin)
		if distance < closest_distance:
			closest_distance = distance
			closest_zone = zone

	if closest_zone:
		body.global_transform.origin = closest_zone.global_transform.origin
