extends Node
class_name FishManager

var fish_database: Dictionary = {}

var fish_1 = {
	"id": 1,
	"name": "fishy-boi",
	"sprite": load("res://assets/fish-1.png"),
	"move_speed": 5,
	"value": 100,
	"price": 100,
	"max_hunger": 100,
	"hunger_radius": 100,
	"hunger_decay": 10, # dev decay
	"max_health": 100,
	"health_regen": 0.2,
	"scale_multiplier": 2,
	"life_span": 10,
	"time_alive": 0
}

func _init() -> void:
	fish_database[fish_1.id] = fish_1

func get_fish_by_id(id) -> FishDetails:
	var fishctionary: Dictionary = fish_database[id]
	if !fishctionary: push_error("FISH DETAILS NOT FOUND BY ID")

	var working_fish_details = FishDetails.new()
	for fish_key in fishctionary:
		var fish_value = fishctionary[fish_key]
		working_fish_details[fish_key] = fish_value
	return working_fish_details