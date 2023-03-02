extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var name = get_parent().get_name()
	var texture_path = "res://Enemies/Sprites/" + str(name) + ".png"
	print(texture_path)
	texture = load(texture_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass