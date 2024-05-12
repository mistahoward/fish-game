extends Node2D
class_name SceneManager

var _feeding_manager: FeedingManager

func _init() -> void:
	_feeding_manager = FeedingManager.new()

func _single_fish() -> void:
	var fish = Fish.new()
	fish.position.x = get_viewport_rect().size.x / 2
	fish.position.y = get_viewport_rect().size.y / 2
	add_child(fish)
	pass

func _ready() -> void:
	_single_fish()
	pass
