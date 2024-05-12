extends Node2D
class_name SceneManager

var _fish_manager: FishManager
var _feeding_manager: FeedingManager

signal in_game

func _init(click_ref: Signal) -> void:
	self.name = "SceneManager"
	self.unique_name_in_owner = true
	_fish_manager = FishManager.new()
	_feeding_manager = FeedingManager.new(in_game, click_ref)
	add_child(_feeding_manager)

func _single_fish() -> void:
	in_game.emit(true)
	var fish_details = _fish_manager.get_fish_by_id(1)
	var fish = Fish.new(fish_details)
	fish.position.x = get_viewport_rect().size.x / 2
	fish.position.y = get_viewport_rect().size.y / 2
	add_child(fish)
	pass

func _ready() -> void:
	_single_fish()
	pass
