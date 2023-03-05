extends Node

export var current_party = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_current_party(party):
	current_party = party

func get_current_party():
	return current_party

func add_to_current_party(party_member):
	current_party.append(party_member)

func remove_from_current_party(party_member):
	current_party.erase(party_member)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
