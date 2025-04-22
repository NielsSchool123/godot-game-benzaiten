extends Node

# secret counter
var secrets_found: int = 0
var total_secrets: int = 1

# tooltip list refill function
var tooltip_queue: Array = []

func refill_tooltip_queue(tooltips: Array):
	tooltip_queue = tooltips.duplicate()
	tooltip_queue.shuffle()
