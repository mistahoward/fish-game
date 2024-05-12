extends Node2D
class_name InputManager

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
		print("Mouse Click/Unclick at: ", event.position)

   # Print the size of the viewport.
	# print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
