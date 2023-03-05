extends Node2D

# Initialize the stats to a script for now
# TODO: change this to a dict later that is loaded from the script
var stats = Script

func _ready():
	initialize_enemy()

func initialize_enemy():
	var name = get_name()
	var script_path = "res://Enemies/" + name + "/Stats.gd"  # Replace with the path to your script
	var script = ResourceLoader.load(script_path)
	stats = script.new()

	# Load the stats
	var enemy_name = stats.name
	var enemy_hp = stats.hp

