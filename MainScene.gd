extends Node

var exploration_scene
var Party

func _ready():
	load_main_menu()

func load_main_menu():
	var main_menu = preload("res://scenes/MainMenu.tscn").instance()
	main_menu.connect("start_game", self, "start_game")
	add_child(main_menu)
	get_tree().set_current_scene(main_menu)

func start_game():
	load_party()
	load_exploration_scene()

# TODO: Move the spawning logic to the Party class
func load_party():
	print("GOT HERE")
	Party = preload("res://Scripts/Party.gd").new()
	Party.spawn_party()
	print(Party.members)

func load_exploration_scene():
	exploration_scene = preload("res://scenes/ExplorationScene.tscn").instance()
	setup_exploration_scene_signals(exploration_scene)
	add_child(exploration_scene)
	get_tree().set_current_scene(exploration_scene)

func setup_exploration_scene_signals(exploration_scene):
	exploration_scene.connect("game_over", self, "load_main_menu")
	exploration_scene.connect("initiate_battle", self, "initiate_battle")
	exploration_scene.connect("battle_over", self, "load_exploration_scene")

# TODO: Most of this logic should be moved to the BattleScene
func initiate_battle():
	exploration_scene.queue_free()
	# Load the BattleScene and pass in the necessary information	
	var battle = "res://Scenes/BattleScene.tscn"
	var battle_scene = load(battle).instance()
	var current_enemies = [get_random_enemy_type()]
	exploration_scene.set_visible(false)
	GameLogic.set_current_enemies(current_enemies)
	get_tree().get_root().add_child(battle_scene)
	get_tree().set_current_scene(battle_scene)

func get_random_enemy_type() -> String:
	# Return a random enemy type to spawn in the battle
	var enemy_types = ["Druid"]
	return enemy_types[rand_range(0, enemy_types.size() - 1)]
