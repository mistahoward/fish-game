extends Node
class_name WealthManager

var _total_wealth: int = 0

var produce_database: Dictionary = {}

var bronze_coin: Dictionary = {
	"id": 1,
	"name": "penny",
	"sprite": preload("res://scenes/entities/coin.tscn"),
	"sink_speed": 50,
	"value": 1,
	"color": Color(136,87,42),
}