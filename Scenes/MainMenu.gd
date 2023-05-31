extends Control

signal start_game

func _ready():
	var start_game_button = $StartGame  # Get the button node
	start_game_button.connect("pressed", self, "_on_start_game_button_pressed")

func _on_start_game_button_pressed():
	emit_signal("start_game")
