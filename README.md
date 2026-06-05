# Godot 4 Todo List Application

A fully functional to-do list application built with Godot 4, featuring local storage functionality using JSON.

## Features

✅ **Add Tasks** - Add new tasks via input field or press Enter
✅ **Mark Complete** - Toggle tasks as complete/incomplete with visual feedback
✅ **Delete Tasks** - Remove individual tasks
✅ **Clear Completed** - Remove all completed tasks at once
✅ **Delete All** - Remove all tasks (with confirmation)
✅ **Local Storage** - Tasks are automatically saved to `user://todos.json`
✅ **Task Counter** - View total tasks and completed count
✅ **Empty State** - Friendly message when no tasks exist
✅ **Persistent Data** - Todos persist across app restarts

## Project Structure

```
res://
├── project.godot           # Project configuration
├── README.md              # This file
└── scenes/
    ├── MainUI.tscn        # Main UI scene
    ├── MainUI.gd          # Main UI logic
    ├── TodoItem.tscn      # Individual todo item UI
    ├── TodoItem.gd        # Todo item logic
    └── TodoManager.gd     # Todo data management & storage
```

## How to Use

1. **Clone or download** this repository
2. **Open the project** in Godot 4
3. **Run the scene**: Click the play button or press F5
4. **Add a task**: Type in the input field and click "Add" or press Enter
5. **Complete a task**: Click the checkbox next to any task
6. **Delete a task**: Click the "×" button on the task
7. **Clear completed**: Click "Clear Completed" button
8. **Manage all tasks**: Click "Delete All" to remove everything

## Technical Details

### Storage
- Tasks are stored in `user://todos.json` on the local filesystem
- The JSON file is located at:
  - **Windows**: `C:\Users\[YourUsername]\AppData\Roaming\Godot\app_userdata\Godot Todo App\todos.json`
  - **macOS**: `~/Library/Application Support/Godot/app_userdata/Godot Todo App/todos.json`
  - **Linux**: `~/.local/share/Godot/app_userdata/Godot Todo App/todos.json`

### Data Structure
```json
{
  "todos": [
    {
      "id": 1,
      "title": "Buy groceries",
      "completed": false,
      "created_at": 1654321000000
    }
  ],
  "next_id": 2
}
```

### Classes

**TodoManager** - Handles all todo operations:
- `add_todo(title)` - Create new todo
- `toggle_todo(id)` - Mark complete/incomplete
- `delete_todo(id)` - Remove todo
- `clear_completed()` - Remove all completed todos
- `delete_all()` - Clear all todos
- `save_todos()` - Write to JSON file
- `load_todos()` - Read from JSON file
- `get_todos()` - Return all todos

**MainUI** - Handles UI updates and user interaction:
- Displays todos dynamically
- Handles button clicks and input
- Refreshes UI after changes
- Shows empty state when needed

**TodoItem** - Individual todo item component:
- Displays single task with checkbox
- Shows delete button
- Emits signals when toggled or deleted

## Customization

### Change App Name
Edit `project.godot`:
```
[application]
config/name="Your App Name"
```

### Change Window Size
Edit `project.godot`:
```
[display]
window/size/viewport_width=600
window/size/viewport_height=800
```

### Customize Colors & Fonts
Modify the theme overrides in `MainUI.tscn` and `TodoItem.tscn`

### Change Storage Path
Modify `SAVE_PATH` in `TodoManager.gd`:
```gdscript
const SAVE_PATH = "user://todos.json"
```

## Future Enhancements

- 🎨 Theme customization
- 📅 Due dates for tasks
- 🏷️ Tags/categories
- ⭐ Task priority levels
- 🔍 Search functionality
- 📊 Statistics dashboard
- 🔔 Notifications
- 💾 Cloud sync
- 📦 Export/Import tasks
- 🔁 Recurring tasks

## Requirements

- Godot 4.0 or later
- No external plugins required

## License

Free to use and modify for personal or commercial projects.

## Support

For issues or feature requests, please open a GitHub issue.
