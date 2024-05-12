class_name HealthComponent extends Node

class HealthDefaults:
	const MAX: int = 100
	const REGEN: float = 0.1

var _current_health = HealthDefaults.MAX
var _max_health = HealthDefaults.MAX
var _health_regen = HealthDefaults.REGEN

func _init(max_health: int = HealthDefaults.MAX, regen: float = HealthDefaults.REGEN):
	_current_health = max_health
	_health_regen = regen
	_max_health = max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
