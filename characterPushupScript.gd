extends Node3D

@onready var anim_player = $AnimationPlayer 

func _ready():
	anim_player.play("Armature|mixamo_com|Layer0")
