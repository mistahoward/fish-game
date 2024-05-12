extends State
class_name FishHungry

signal velocity_update

var _move_speed: float = 10
var _initial_move_speed: float = 10
var _move_direction: Vector2
var _wander_time: float
var _near_food: bool = false
var _hunger_area: Area2D

var _hunger_shape: CollisionShape2D

func enter() -> void:
	panic_from_hunger()

func _init(hunger_area, move_speed = 10) -> void:
	_hunger_area = hunger_area
	_initial_move_speed = move_speed
	_move_speed = move_speed

func panic_from_hunger() -> void:
	print("PANIC FROM HUNGER MODE ACTIVE")
	var area_children = _hunger_area.get_children()
	for children in area_children:
		if children is CollisionShape2D:
			_hunger_shape = children
			_hunger_shape.disabled = false
	_move_speed = _move_speed * 1.25
	_hunger_area.area_entered.connect(func(arg1): chase_food(arg1))

func randomize_wander() -> void:
	_move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	_wander_time = randf_range(1, 2)

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
	velocity_update.emit(_move_direction * _move_speed)

func exit() -> void:
	_hunger_shape.disabled = true
	_move_speed = _initial_move_speed
