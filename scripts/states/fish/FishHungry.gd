extends State
class_name FishHungry

signal velocity_update

var _move_speed: float = 10
var _initial_move_speed: float = 10
var move_direction: Vector2
var _wander_time: float
var _near_food: bool = false

var _hunger_move_speed_modifier: float = 3.25

func enter() -> void:
	panic_from_hunger()

func _init(move_speed = 10) -> void:
	_initial_move_speed = move_speed
	_move_speed = move_speed
	self.name = "FishHungryState"

func panic_from_hunger() -> void:
	print("PANIC FROM HUNGER MODE ACTIVE")
	# _move_speed = _move_speed * _hunger_move_speed_modifier

func randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	_wander_time = 50

func chase_food(arg1) -> void:
	print(arg1)
	pass

func update(delta: float) -> void:
	if _near_food:
		pass
		# chase_food()
	else:
		if _wander_time > 0:
			_wander_time -= delta
		else: randomize_wander()

func physics_update(_delta: float) -> void:
	velocity_update.emit(move_direction * _move_speed)

func exit() -> void:
	_move_speed = _initial_move_speed
