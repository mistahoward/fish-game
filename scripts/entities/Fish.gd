extends CharacterBody2D
class_name Fish

var _healthComponent: HealthComponent
var _hungerComponent: HungerComponent
var _state_machine: StateMachine
var _idle_state: FishIdle
var _hunger_state: FishHungry
var _death_state: FishDeath

var _possible_states: Array[State]

var _move_speed = 10
var _sprite: Sprite2D
var _name: String
var _id: int
var _value: int
var _price: int
var _max_health: int = 100
var _max_hunger: int = 100
var _hunger_decay: float = 0.5
var _health_regen: float = 0.2

var _scale_mutliplier: float = 5.0
var _life_span: int = 10 # dev value
var _time_alive: int = 0 # dev value

var _hunger_detection_area: Area2D
var _hunger_icon: Sprite2D

var _time_elapsed: float = 0.0
var _collision_shape_object: CollisionShape2D

signal update_direction
signal collided_with_bottom_of_tank

func _init(details: FishDetails) -> void:
	_id = details.id
	_name = details.name
	_value = details.value
	_price = details.price
	_max_health = details.max_health
	_max_hunger = details.max_hunger
	_hunger_decay = details.hunger_decay
	_health_regen = details.health_regen
	_scale_mutliplier = details.scale_multiplier
	_life_span = details.life_span
	_time_alive = details.time_alive
	_move_speed = details.move_speed

	_sprite = Sprite2D.new()
	_sprite.texture = details.sprite
	_sprite.scale = Vector2(_scale_mutliplier, _scale_mutliplier)

	_hunger_icon = Sprite2D.new()
	_hunger_icon.texture = load("res://assets/icons/hunger.png")
	_hunger_icon.position.x = self.position.x + (_sprite.texture.get_width() / 4)
	_hunger_icon.position.y = self.position.y - _sprite.texture.get_height() - (_sprite.texture.get_height() / 4)

	var hunger_shape = CircleShape2D.new()
	hunger_shape.radius = details.hunger_radius
	var collision_shape = CollisionShape2D.new()
	collision_shape.disabled = true
	collision_shape.shape = hunger_shape
	_hunger_detection_area = Area2D.new()
	_hunger_detection_area.position.x = self.position.x
	_hunger_detection_area.position.y = self.position.y
	_hunger_detection_area.monitorable = true
	_hunger_detection_area.monitoring = false
	_hunger_detection_area.add_child(collision_shape)

	var _collision_body_shape = CircleShape2D.new()
	_collision_body_shape.radius = self._sprite.texture.get_height() / 2.4
	_collision_shape_object = CollisionShape2D.new()
	_collision_shape_object.shape = _collision_body_shape
	self.collision_layer = 1
	self.collision_mask = 2
	add_child(_collision_shape_object)

func _ready() -> void:
	add_child(_sprite)
	add_child(_hunger_icon)
	add_child(_hunger_detection_area)

	_healthComponent = HealthComponent.new(_max_health, _health_regen)
	_hungerComponent = HungerComponent.new(_max_hunger, _hunger_decay)

	_hunger_state = FishHungry.new(_hunger_detection_area, _move_speed)
	_idle_state = FishIdle.new(_move_speed)
	_death_state = FishDeath.new(self, collided_with_bottom_of_tank)

	_possible_states.push_front(_idle_state)
	_possible_states.push_front(_hunger_state)
	_possible_states.push_front(_death_state)

	_state_machine = StateMachine.new(update_direction, _possible_states, _idle_state)

	add_child(_healthComponent)
	add_child(_hungerComponent)
	add_child(_state_machine)

	_hungerComponent.hunger_depleted.connect(die)
	_hungerComponent.update_icon.connect(func(color, display_icon): handle_hunger(color, display_icon))

	for state in _possible_states:
		state.velocity_update.connect(func(vector2): update_position(vector2))

func update_position(new_position: Vector2):
	velocity = new_position * _move_speed

func _physics_process(_delta: float) -> void:
	var collision: bool = move_and_slide()
	if velocity.x < 0:
		_sprite.flip_h = false
	else:
		_sprite.flip_h = true
	if !collision && self._state_machine.current_state != FishDeath: return
	var latest_collision: = get_last_slide_collision()
	var collider: = latest_collision.get_collider()
	# check if background / tile map has been hit, meaning the ground
	if collider is TileMap:
		if _state_machine.current_state is FishDeath:
			collided_with_bottom_of_tank.emit()
			return
		update_direction.emit(Vector2(sin(velocity.x), sin(randf_range(-1, 0))))
	if collider is StaticBody2D:
		if collider.name.begins_with("Top"):
			update_direction.emit(Vector2(sin(velocity.x), sin(randf_range(0, 1))))
		if collider.name.begins_with("Left"):
			print("HIT THE LEFT OF THE TANK")
			update_direction.emit(Vector2(sin(randf_range(1,0)), sin(velocity.y)))
		if collider.name.begins_with("Right"):
			print("HIT THE RIGHT OF THE TANK")
			update_direction.emit(Vector2(sin(randf_range(-1,0)), sin(velocity.y)))

func _process(delta: float) -> void:
	_time_elapsed += delta
	if _time_elapsed >= 1:
		_time_alive += 1
		_time_elapsed = 0

func die() -> void:
	_hunger_icon.visible = false
	_state_machine.enter_state_and_cleanup(_death_state)

func handle_hunger(color, display_icon: bool) -> void:
	if display_icon && _state_machine.current_state != _hunger_state: _state_machine.enter_state_and_cleanup(_hunger_state)
	_hunger_icon.modulate = color
	_hunger_icon.visible = display_icon
