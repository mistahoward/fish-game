extends State
class_name FishIdle

signal velocity_update

var move_direction: Vector2
var wander_time: float
var _move_speed: float

func _init(move_speed = 10) -> void:
	_move_speed = move_speed
	self.name = "FishIdleState"

func randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(0, 1)).normalized()
	wander_time = randf_range(1, 3)

func enter() -> void:
	randomize_wander()

func update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else: randomize_wander()

func physics_update(_delta: float) -> void:
	velocity_update.emit(move_direction * _move_speed)
