extends Node

var _input_manager: InputManager
var _scene_manager: SceneManager

enum FishType {
	PRODUCER,
	ATTACKER,
	DEFENDER
}

signal click

func get_frame_from_sheet(sheet: Sprite2D, frame_coords: Vector2i) -> Sprite2D:
	var working_sheet: Sprite2D = sheet.duplicate()
	working_sheet.frame_coords = frame_coords
	return working_sheet

func get_coordinates_from_sheet(sheet: Sprite2D, coordinates: Rect2) -> Sprite2D:
	var working_sheet: Sprite2D = sheet.duplicate()
	working_sheet.region_enabled = true
	working_sheet.region_rect = coordinates
	return working_sheet

func get_collection_of_sprites_from_sheet(sheet: Sprite2D, hframes: int, vframe_number: int) -> Array[Sprite2D]:
	var working_frames: Array[Sprite2D]
	var vertical_start: int = vframe_number * 32
	for hframe in hframes:
		var new_coordinates: = Vector2i(hframe * 32, vertical_start)
		var new_frame = get_frame_from_sheet(sheet, new_coordinates)
		working_frames.push_front(new_frame)
	return working_frames

func _init() -> void:
	self.name = "GameManager"
	self.unique_name_in_owner = true
	_input_manager = InputManager.new(click)
	_scene_manager = SceneManager.new(click)

func _ready() -> void:
	add_child(_input_manager)
	add_child(_scene_manager)
	pass
