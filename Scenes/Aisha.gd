extends KinematicBody2D
var velocity = Vector2()
var anim
var camera
const TILE_SIZE = 16
const Z_INDEX = 100

# Store the last input command's direction.
var direction: Vector2 = Vector2.ZERO

# Speed of movement
var _pixels_per_second: float = 2 * TILE_SIZE
var _step_size: float = 1 / _pixels_per_second 

# Accumulator of deltas, aka fractions of seconds, to time movement.
var _step: float = 0 

# Count movement progress in distinct integer steps
var _pixels_moved: int = 0

var motion = Vector2.ZERO
var moved = false
var stats = load("res://AishaStats.tres")

func _ready():
	anim = $AnimatedSprite
	camera = get_node("/root/MainGame/UI/ViewportContainer/Viewport/Camera2D")
	
func is_moving() -> bool:
	return self.direction.x != 0 or self.direction.y != 0

func _physics_process(delta):
	handle_movement(delta)
	handle_camera(delta)
	
func handle_camera(delta):
	camera.set_global_position(position)
	
func handle_movement(delta):
	moved = false
	motion = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		self.direction.x = 1.1
		anim.play('MoveRight')
	if Input.is_action_pressed("MoveLeft"):
		self.direction.x = -1.1
		anim.play('MoveLeft')
	if Input.is_action_pressed("MoveDown"):
		self.direction.y = 1.1
		anim.play('MoveDown')
	if Input.is_action_pressed("MoveUp"):
		self.direction.y = -1.1
		anim.play('MoveUp')
	
	if not is_moving(): return false
	
	# delta is measured in fractions of seconds, so for a speed of
	# 4 pixels_per_second, we need to accumulate deltas until we
	# reach 1 / 4 = 0.25
	_step += delta
	if _step < _step_size: return

	# Move a pixel
	_step -= _step_size
	_pixels_moved += 1
	move_and_collide(direction)

	# Complete movement
	if _pixels_moved >= TILE_SIZE:
		direction = Vector2.ZERO
		_pixels_moved = 0
		_step = 0
		moved = true
	
	return true


