extends KinematicBody2D
var velocity = Vector2()
var anim

func _ready():
	anim = $AnimatedSprite

func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("MoveRight"):
		velocity.x += 1
		anim.play('MoveRight')
	if Input.is_action_pressed("MoveLeft"):
		velocity.x -= 1
		anim.play('MoveLeft')
	if Input.is_action_pressed("MoveDown"):
		velocity.y += 1
		anim.play('MoveDown')
	if Input.is_action_pressed("MoveUp"):
		velocity.y -= 1
		anim.play('MoveUp')
	velocity = velocity.normalized() * 100
	move_and_slide(velocity)
