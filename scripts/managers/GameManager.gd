extends Node

var _input_manager: InputManager
var _scene_manager: SceneManager

enum FishType {
	PRODUCER,
	ATTACKER,
	DEFENDER
}

signal click

func _init() -> void:
	self.name = "GameManager"
	self.unique_name_in_owner = true
	_input_manager = InputManager.new(click)
	_scene_manager = SceneManager.new(click)

func _ready() -> void:
	add_child(_input_manager)
	add_child(_scene_manager)
	pass
