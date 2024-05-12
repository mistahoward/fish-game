extends Node2D
class_name InputManager

var _click: Signal

func _init(click_ref: Signal) -> void:
	self.name = "InputManager"
	self.unique_name_in_owner = true
	_click = click_ref

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# print(get_viewport().get_mouse_position())
	pass

func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		_click.emit(event.position)
