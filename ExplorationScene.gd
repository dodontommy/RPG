extends Node2D

# Variables to keep track of the battle trigger timer
var battle_timer = 0.0
const BATTLE_INTERVAL = 5.0 # Time in seconds between battle checks
const BATTLE_CHANCE = 100 # 100% chance of triggering a battle

var player

# Movement variables
const TILE_SIZE = 16
const Z_INDEX = 100

# Speed of movement
var _pixels_per_second: float = 2 * TILE_SIZE
var _step_size: float = 1 / _pixels_per_second 

# Accumulator of deltas, aka fractions of seconds, to time movement.
var _step: float = 0 

# Count movement progress in distinct integer steps
var _pixels_moved: int = 0
var motion = Vector2.ZERO

var current_party = load("res://GlobalLogic/Party.tres")

signal initiate_battle

# Called when the node enters the scene tree for the first time.
func _ready():
	start_new_game()
	var main_menu = get_node("/root/MainMenu")

# Load a new instance of Aisha, load the first map, and start the game
# TODO: Take this out of the overworld scene and put it in the main scene
# TODO: load party from file
func start_new_game():
	spawn_player()
	GameLogic.set_current_environment("SpaceDungeon")
	var map = load("res://Scenes/" + GameLogic.get_current_environment() + ".tscn").instance()
	add_child(map)

func spawn_player():
	print('TEST')
	# # var party_members = Party.members
	# # print(party_members[0])
	# var player_character = get_node("res:///PartyMembers/" + party_members[0].name + "/PartyMember.tscn")
	# var player_position = Vector2(0, 0)
	# player_character.position = player_position
	# player_character.z_index = Z_INDEX
	# add_child(player_character)

func _physics_process(delta):
	handle_battle_logic(delta)
	handle_escape_key()
	handle_movement(delta)
	handle_camera_movement()
	
func is_moving() -> bool:
	return player.direction.x != 0 or player.direction.y != 0
		
func handle_movement(delta):
	player.moved = false
	motion = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		player.direction.x = 1.1
		player.animation_player.play('MoveRight')
	if Input.is_action_pressed("MoveLeft"):
		player.direction.x = -1.1
		player.animation_player.play('MoveLeft')
	if Input.is_action_pressed("MoveDown"):
		player.direction.y = 1.1
		player.animation_player.play('MoveDown')
	if Input.is_action_pressed("MoveUp"):
		player.direction.y = -1.1
		player.animation_player.play('MoveUp')
	
	if not is_moving(): return false
	
	# delta is measured in fractions of seconds, so for a speed of
	# 4 pixels_per_second, we need to accumulate deltas until we
	# reach 1 / 4 = 0.25
	_step += delta
	if _step < _step_size: return

	# Move a pixel
	_step -= _step_size
	_pixels_moved += 1
	player.move_and_collide(player.direction)

	# Complete movement
	if _pixels_moved >= TILE_SIZE:
		player.direction = Vector2.ZERO
		_pixels_moved = 0
		_step = 0
		player.moved = true
	
	return true

# The camera should follow the player around
func handle_camera_movement():
	var camera = get_node("Camera2D")
	camera.position = player.position

# If the escape key is pressed, lets head back out to the menu
func handle_escape_key():
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
	
		
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
		emit_signal("initiate_battle") if should_trigger_battle() else null

func should_trigger_battle() -> bool:
	# Determine if a battle should be triggered based on a random chance
	var chance = rand_range(1, 100)
	return chance <= BATTLE_CHANCE # 10% chance of triggering a battle

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
