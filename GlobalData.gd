extends Node

var current_enemy_scenes = []

# For now, just return false but in the future, this GlobalFlag will be used 
# to determine if random battles should be calculated or not
var in_safe_zone = false

func set_current_enemies(enemy_scenes):
	current_enemy_scenes = enemy_scenes

func get_current_enemies():
	return current_enemy_scenes

func get_in_safe_zone():
	return in_safe_zone

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

