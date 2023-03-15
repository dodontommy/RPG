extends KinematicBody2D
var velocity = Vector2()
var anim
var camera

var motion = Vector2.ZERO
var moved = false
onready var stats = ResourceLoader.load("res://PartyMembers/" + get_name() + "/Stats.tres")
onready var animation_player = $AnimatedSprite

# Store the last input command's direction.
var direction: Vector2 = Vector2.ZERO

func _ready():
	var name = get_name()
	set_stats()
	camera = get_node("/root/MainGame/Camera2D")
	var format_string = "res://PartyMembers/%s/SpriteFrames.tres"
	animation_player.frames = load(format_string % name)
	animation_player.play("IdleDown")

func set_stats():
	var stats = GameLogic.get_character_stats()[get_name()]
	print(stats)

	

