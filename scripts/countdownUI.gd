extends CanvasLayer

@onready var label = $Label
var timer_duration := 2.5
var time_left := timer_duration

func _process(delta):
	time_left -= delta
	if time_left <= 0.0:
		time_left = timer_duration  # Reset
	label.text = str("%.2f" % time_left)  # Show 2 decimals
