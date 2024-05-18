extends Node

var _input_manager: InputManager
var _scene_manager: SceneManager

enum FishType {
	PRODUCER,
	ATTACKER,
	DEFENDER
}

signal click

var money: int = 0

var _heads_up_display: Node
var _gold_ui: Label

func _init() -> void:
	self.name = "GameManager"
	self.unique_name_in_owner = true
	_input_manager = InputManager.new(click)
	_scene_manager = SceneManager.new(click)
	_heads_up_display = preload("res://scenes/ui/heads_up.tscn").instantiate()
	_gold_ui = _heads_up_display.find_child("GoldAmount")
	_gold_ui.text = str(money)

func _ready() -> void:
	add_child(_heads_up_display)
	add_child(_input_manager)
	add_child(_scene_manager)
	pass

func add_money(additional_money: int) -> void:
	money =+ additional_money
	_gold_ui.text = str(money)