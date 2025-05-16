extends Node3D

@onready var platform_a = $PlatformA
@onready var platform_b = $PlatformB
@onready var collider_a = $PlatformA/CollisionShape3D
@onready var collider_b = $PlatformB/CollisionShape3D2
@onready var timer = $Timer

var showing_a = true

func _ready():
	timer.wait_time = 2.5  # seconds between switches
	timer.autostart = true
	timer.start()
	_update_platforms()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	showing_a = !showing_a
	_update_platforms()

func _update_platforms():
	platform_a.visible = showing_a
	collider_a.disabled = !showing_a

	platform_b.visible = !showing_a
	collider_b.disabled = showing_a
