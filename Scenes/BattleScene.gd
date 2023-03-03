extends Node2D

func _ready():
	start_battle()

func start_battle():
	spawn_enemies()
	spawn_background()

func spawn_background():
	var background_node = get_node("Background")
	var background_number = get_background_number()
	var background_type = GlobalData.get_current_environment()
	background_node.texture = load("res://BattleBackgrounds/" + background_type + "/" + background_type + str(background_number) + ".png")
	
func spawn_enemies():
	var enemy_type = GlobalData.get_current_enemies()[0]
	var enemy_scene = load("res://Enemies/" + enemy_type + "/" + enemy_type + ".tscn")
	var enemy = enemy_scene.instance()
	add_child(enemy)
	enemy.position = Vector2(0, 0)

func get_background_number():
	var environment = GlobalData.get_current_environment()
	var max_number = GlobalData.battle_background_count_map[environment]
	return randi() % max_number + 1
