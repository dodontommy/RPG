extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy_type

func start_battle():
    var enemy_scene = load("res://Enemies/" + enemy_type + ".tscn")
    var enemy = enemy_scene.instance()
    add_child(enemy)
    enemy.position = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	start_battle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
