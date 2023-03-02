extends Node2D

# Variables to keep track of the battle trigger timer
var battle_timer = 0.0
const BATTLE_INTERVAL = 5.0 # Time in seconds between battle checks
const BATTLE_CHANCE = 30 # 100% chance of triggering a battle

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
var current_enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	start_new_game()

# Load a new instance of Aisha, load the first map, and start the game
func start_new_game():
	player = load("res://Aisha.tscn").instance()
	var player_position = Vector2(0, 0)
	player.position = player_position
	player.z_index = player.Z_INDEX
	add_child(player)

	var map = load("res://SpaceDungeon.tscn").instance()
	add_child(map)

func _physics_process(delta):
	handle_battle_logic(delta)
	handle_camera_movement()
	handle_escape_key()

# The camera should follow the player around
func handle_camera_movement():
	var camera = get_node("Camera2D")
	camera.position = player.position

# If the escape key is pressed, lets head back out to the menu
func handle_escape_key():
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://MainMenu.tscn")
	
		
func handle_battle_logic(delta):
	# Update the battle timer and check if a battle should be triggered
	battle_timer -= delta

	# The player shouldn't be able to get into a battle unless they moved
	if player.moved:
		check_for_battle()
	
func check_for_battle():
	if battle_timer <= 0:
		# Reset the timer and check if a battle should be triggered
		battle_timer = BATTLE_INTERVAL
		print("checking for battle")
		if should_trigger_battle():
			# Load the BattleScene and pass in the necessary information	
			var battle = "res://BattleScene.tscn"
			current_enemies = [get_random_enemy_type()]
			GlobalData.set_current_enemies(current_enemies)
			get_tree().change_scene(battle)
		
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
