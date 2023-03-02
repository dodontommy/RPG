extends Node2D

# Variables to keep track of the battle trigger timer
var battle_timer = 0.0
const BATTLE_INTERVAL = 10.0 # Time in seconds between battle checks
const BATTLE_CHANCE = 100 # 100% chance of triggering a battle

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var player = get_node("Player")
	if player.moved:
		battle_timer -= delta
		check_for_battle()

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://MainMenu.tscn")
	
func check_for_battle():
	if battle_timer <= 0:
		# Reset the timer and check if a battle should be triggered
		battle_timer = BATTLE_INTERVAL
		print("checking for battle")
		if should_trigger_battle():
			# Load the BattleScene and pass in the necessary information	
			var battle = "res://BattleScene.tscn"
			var dict = { 'enemy_type': get_random_enemy_type() }
			get_tree().change_scene(battle, dict)
		
func should_trigger_battle() -> bool:
	# Determine if a battle should be triggered based on a random chance
	var chance = rand_range(1, 100)
	return chance <= BATTLE_CHANCE # 10% chance of triggering a battle

func get_random_enemy_type() -> String:
	# Return a random enemy type to spawn in the battle
	var enemy_types = ["Druid"]
	return enemy_types[rand_range(0, enemy_types.size() - 1)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
