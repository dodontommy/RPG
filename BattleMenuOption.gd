extends Control

export(String) var option_text = "Option"

var is_selected = false

func _ready():
    set_focus_mode(FOCUS_ALL)

func is_selected():
	return is_selected

func set_selected(selected):
	is_selected = selected
	if selected:
		get_node("Background").show()
	else:
		get_node("Background").hide()

func perform_action():
    # Override this function in child classes to perform the desired action
    pass