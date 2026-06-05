extends Control

@onready var todo_input = $VBoxContainer/InputContainer/TodoInput
@onready var add_button = $VBoxContainer/InputContainer/AddButton
@onready var todo_list = $VBoxContainer/ScrollContainer/TodoList
@onready var count_label = $VBoxContainer/ControlsContainer/CountLabel
@onready var clear_completed_button = $VBoxContainer/ControlsContainer/ClearCompletedButton
@onready var delete_all_button = $VBoxContainer/ControlsContainer/DeleteAllButton
@onready var empty_state = $VBoxContainer/ScrollContainer/TodoList/EmptyState
@onready var todo_manager = $TodoManager

var todo_item_scene = preload("res://scenes/TodoItem.tscn")

func _ready():
	load_todos()
	update_ui()

func _on_add_button_pressed():
	add_todo()

func _on_todo_input_submitted(new_text: String):
	add_todo()

func add_todo():
	var text = todo_input.text.strip_edges()
	if text.is_empty():
		return
	
	todo_manager.add_todo(text)
	todo_input.clear()
	refresh_todo_list()

func load_todos():
	todo_manager.load_todos()
	refresh_todo_list()

func refresh_todo_list():
	# Clear existing items (keep empty state)
	for child in todo_list.get_children():
		if child != empty_state:
			child.queue_free()
	
	var todos = todo_manager.get_todos()
	
	if todos.is_empty():
		empty_state.show()
	else:
		empty_state.hide()
		for todo in todos:
			var item = todo_item_scene.instantiate()
			item.set_todo_data(todo)
			item.toggled.connect(_on_todo_toggled.bind(todo["id"]))
			item.delete_requested.connect(_on_todo_delete_requested.bind(todo["id"]))
			todo_list.add_child(item)
	
	update_ui()

func _on_todo_toggled(todo_id: int):
	todo_manager.toggle_todo(todo_id)
	refresh_todo_list()

func _on_todo_delete_requested(todo_id: int):
	todo_manager.delete_todo(todo_id)
	refresh_todo_list()

func _on_clear_completed_pressed():
	todo_manager.clear_completed()
	refresh_todo_list()

func _on_delete_all_pressed():
	var dialog = ConfirmationDialog.new()
	dialog.dialog_text = "Delete all tasks? This cannot be undone."
	dialog.confirmed.connect(func(): 
		todo_manager.delete_all()
		refresh_todo_list()
	)
	add_child(dialog)
	dialog.popup_centered_ratio(0.7)

func update_ui():
	var todos = todo_manager.get_todos()
	var total = todos.size()
	var completed = todos.filter(func(t): return t["completed"]).size()
	
	count_label.text = "Tasks: %d (Completed: %d)" % [total, completed]
