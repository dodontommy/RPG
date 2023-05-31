extends Node2D

var current_enemies = []	# List of enemies in the current battle
var current_party = []	# List of party members in the current battle
var turn_order = []	# List of all characters in the current battle, sorted by speed
signal battle_started # Emitted when the battle starts

func _ready():
	start_battle()

func start_battle():
	spawn_enemies()
	spawn_background()
	determine_turn_order()
	emit_signal("battle_started")

func determine_turn_order():
	for party_member in current_party:
		turn_order.append(party_member)
		print(party_member)
	for enemy in current_enemies:
		turn_order.append(enemy)
	# turn_order.sort_custom(self, "compare_speed")
	print("Turn order: " + str(turn_order))

func spawn_background():
	var background_node = get_node("Background")
	var background_number = get_background_number()
	var background_type = GameLogic.get_current_environment()
	background_node.texture = load("res://BattleBackgrounds/" + background_type + "/" + background_type + str(background_number) + ".png")
	
func spawn_enemies():
	var enemy_type = GameLogic.get_current_enemies()[0]
	var enemy_scene = load("res://Enemies/" + enemy_type + "/" + enemy_type + ".tscn")
	var enemy = enemy_scene.instance()
	if add_child(enemy):
		current_enemies.append(enemy)
		enemy.position = Vector2(0, 0)

func get_background_number():
	var environment = GameLogic.get_current_environment()
	var max_number = GameLogic.battle_background_count_map[environment]
	return randi() % max_number + 1
