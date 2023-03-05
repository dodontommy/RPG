extends KinematicBody2D
var velocity = Vector2()
var anim
var camera

var motion = Vector2.ZERO
var moved = false
var base_stats = load("res://PartyMembers/${name}/BaseStats.gd")

# Store the last input command's direction.
var direction: Vector2 = Vector2.ZERO

onready var animation_player = $AnimatedSprite

func _ready():
	var name = get_name()
	camera = get_node("/root/MainGame/Camera2D")
	var format_string = "res://PartyMembers/%s/SpriteFrames.tres"
	animation_player.frames = load(format_string % name)
	print("res://PartyMembers/${name}/SpriteFrames.tres")
	animation_player.play("IdleDown")

	

