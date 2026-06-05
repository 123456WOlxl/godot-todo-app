extends PanelContainer

@onready var checkbox = $HBoxContainer/CheckBox
@onready var label = $HBoxContainer/Label
@onready var delete_button = $HBoxContainer/DeleteButton

signal toggled()
signal delete_requested()

var todo_data = {}

func set_todo_data(data: Dictionary):
	todo_data = data
	checkbox.button_pressed = data["completed"]
	label.text = data["title"]
	
	if data["completed"]:
		label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5, 1))
		var font_style = label.get_theme_stylebox("normal")
		label.add_theme_color_override("font_color_shadow", Color.WHITE)
	else:
		label.add_theme_color_override("font_color", Color(0.1, 0.1, 0.2, 1))

func _on_checkbox_toggled(_pressed):
	toggled.emit()

func _on_delete_button_pressed():
	delete_requested.emit()
