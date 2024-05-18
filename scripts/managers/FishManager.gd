extends Node
class_name FishManager

var fish_database: Dictionary = {}

var fish_1: Dictionary = {
	"id": 1,
	"name": "goldfish",
	"sprite": preload("res://scenes/entities/fish_1.tscn"),
	"move_speed": 10,
	"value": 100,
	"price": 100,
	"max_hunger": 100,
	"hunger_decay": 10, # dev decay
	"max_health": 100,
	"health_regen": 0.2,
	"scale_multiplier": 3,
	"life_span": 10,
	"time_alive": 0,
	"type": "PRODUCER",
	"strength": 0,
	"defense": 0,
	"hunger_needed_until_next_stage": 0,
	"unlocked": true,
	"number_of_life_stages": 3,
}

func load_fish_to_db() -> void:
	fish_database[fish_1.id] = fish_1

func _init() -> void:
	load_fish_to_db()

func get_fish_by_id(id: int) -> FishDetails:
	var fishctionary: Dictionary = fish_database[id]
	if !fishctionary: push_error("FISH DETAILS NOT FOUND BY ID")

	var working_fish_details = FishDetails.new()
	for fish_key in fishctionary:
		var fish_value = fishctionary[fish_key]
		working_fish_details[fish_key] = fish_value
	return working_fish_details
