class_name HungerComponent extends Node

signal hunger_depleted
signal update_icon

class HungerDefaults:
	const MAX: int = 100
	# in ms
	const DECAY: float = 0.5
	const PERCENTAGE: int = 100

var _current_hunger = HungerDefaults.MAX
var _max_hunger = HungerDefaults.MAX
var _hunger_decay = HungerDefaults.DECAY
var _hunger_percentage = HungerDefaults.PERCENTAGE

func _init(max_hunger: int = HungerDefaults.MAX, decay: float = HungerDefaults.DECAY):
	_current_hunger = max_hunger
	_max_hunger = max_hunger
	_hunger_decay = decay
	self.name = "HungerComponent"

func _death_check() -> void:
	if _hunger_percentage > 0: return
	hunger_depleted.emit()

func _icon_handler() -> void:
	if _hunger_percentage >= 30:
		update_icon.emit(Color8(0, 0, 0), false)
	if _hunger_percentage <= 30 && _hunger_percentage >= 15:
		update_icon.emit(Color8(253, 177, 8), true)
	if _hunger_percentage <= 15:
		update_icon.emit(Color8(217, 83, 70), true)

func _process(delta: float) -> void:
	_current_hunger -= delta * _hunger_decay
	_hunger_percentage = (_current_hunger / _max_hunger) * 100

	_icon_handler()
	_death_check()
