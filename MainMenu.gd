extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var start_game_button = $StartGame  # Get the button node
	start_game_button.connect("pressed", self, "_on_start_game_button_pressed")

func _on_start_game_button_pressed():
	print("Start Game")
	get_tree().change_scene("res://MainGame.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
