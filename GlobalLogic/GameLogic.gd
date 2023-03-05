extends Node

# Other scripts

# Global variables
var current_enemy_scenes = []
var current_environment = null
var party = null

var battle_background_count_map = {
	"SpaceDungeon": 1,
}

# For now, just return false but in the future, this GlobalFlag will be used 
# to determine if random battles should be calculated or not
var in_safe_zone = false

func _ready():
	party = ResourceLoader.load("res://GlobalLogic/Party.tres")

func set_current_enemies(enemy_scenes):
	current_enemy_scenes = enemy_scenes

func get_current_enemies():
	return current_enemy_scenes

func set_current_environment(environment):
	current_environment = environment

func get_current_environment():
	return current_environment

func get_in_safe_zone():
	return in_safe_zone


