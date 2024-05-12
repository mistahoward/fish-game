extends Node

var _input_manager: InputManager
var _scene_manager: SceneManager

func _init() -> void:
	_input_manager = InputManager.new()
	_scene_manager = SceneManager.new()

func _ready() -> void:
	add_child(_input_manager)
	add_child(_scene_manager)
	pass