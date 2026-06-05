extends Node

class_name TodoManager

const SAVE_PATH = "user://todos.json"

var todos: Array = []
var next_id: int = 1

func _ready():
	load_todos()

func add_todo(title: String) -> Dictionary:
	var todo = {
		"id": next_id,
		"title": title,
		"completed": false,
		"created_at": Time.get_ticks_msec()
	}
	next_id += 1
	todos.append(todo)
	save_todos()
	return todo

func toggle_todo(todo_id: int):
	for todo in todos:
		if todo["id"] == todo_id:
			todo["completed"] = !todo["completed"]
			save_todos()
			return

func delete_todo(todo_id: int):
	todos = todos.filter(func(t): return t["id"] != todo_id)
	save_todos()

func clear_completed():
	todos = todos.filter(func(t): return !t["completed"])
	save_todos()

func delete_all():
	todos.clear()
	next_id = 1
	save_todos()

func get_todos() -> Array:
	return todos

func save_todos():
	var data = {
		"todos": todos,
		"next_id": next_id
	}
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		print("Todos saved to ", SAVE_PATH)
	else:
		print("Error saving todos")

func load_todos():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var json_string = file.get_as_text()
			var json = JSON.new()
			var error = json.parse(json_string)
			if error == OK:
				var data = json.get_data()
				todos = data.get("todos", [])
				next_id = data.get("next_id", 1)
				print("Todos loaded from ", SAVE_PATH)
				return
	
	todos = []
	next_id = 1
	print("No saved todos found, starting fresh")
