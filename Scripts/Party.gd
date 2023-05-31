extends Node

var members = []

# TODO: Make this more abstract so that it can be used in any scene - it will just keep track of the party members
# but not actually spawn them in the scene. That will be left up to the ExplorationScene and BattleScene
func spawn_party():
	# Initialize the party with default members
	var aisha = load("res://PartyMembers/Aisha/PartyMember.tscn").instance()
	# var kai = load("res://PartyMembers/Kai/PartyMember.tscn").instance()
	members = [aisha]
	
	for member in members:
		self.add_child(member)
