extends Label
var start_time = OS.get_ticks_msec()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var elapsed_time = OS.get_ticks_msec() - start_time
	var seconds = int(elapsed_time / 1000)
	var minutes = int(seconds / 60)
	var hours = int(minutes / 60)

	var formatted_time = String(hours % 24).pad_zeros(2) + ":" + String(minutes % 60).pad_zeros(2) + ":" + String(seconds % 60).pad_zeros(2)

	text = "Time: " + formatted_time
