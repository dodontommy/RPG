extends Control

var menu_items = []
var menu_item = load("res://BattleMenuOption.tscn")
var possible_battle_options = ["Attack", "Defend", "Item", "Run"]

onready var vertical_box = get_node("VBoxContainer")

func _ready():
    # Populate menu items
    var battle_options = possible_battle_options
    for i in range(len(battle_options)):
        var item = menu_item.instance()
        item.connect("pressed", self, "select_option")
        item.set_text(battle_options[i])
        vertical_box.add_child(item)
        menu_items.append(item)

    # Set the first menu item as selected
    menu_items[0].set_selected(true)
    set_process_input(true)

func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_DOWN:
            move_selection(1)
        elif event.scancode == KEY_UP:
            move_selection(-1)
        elif event.scancode == KEY_ENTER:
            select_option()

func move_selection(direction):
    for i in range(len(menu_items)):
        if menu_items[i].is_selected():
            menu_items[i].set_selected(false)
            var next_index = (i + direction) % len(menu_items)
            menu_items[next_index].set_selected(true)
            break

func select_option():
    for i in range(len(menu_items)):
        if menu_items[i].is_pressed():
            var selected_item_text = menu_items[i].get_text()
            print("Selected option: " + selected_item_text)
            break