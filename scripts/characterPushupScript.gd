extends Node3D 

@onready var anim_player = $AnimationPlayer 

func _ready(): #speelt de animatie idk
	anim_player.play("Armature|mixamo_com|Layer0")
