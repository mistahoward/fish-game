extends CharacterBody2D
class_name Fish

var _healthComponent: HealthComponent
var _hungerComponent: HungerComponent
var _state_machine: StateMachine
var _idle_state: State
var _hunger_state: State

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

var _hunger_detection_area: Area2D
var _hunger_icon: Sprite2D

func _init(details: FishDetails) -> void:
	_id = details.id
	_name = details.name
	_value = details.value
	_price = details.price
	_max_health = details.max_health
	_max_hunger = details.max_hunger
	_hunger_decay = details.hunger_decay
	_health_regen = details.health_regen

	_sprite = Sprite2D.new()
	_sprite.texture = details.sprite
	_sprite.scale = Vector2(5, 5)

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

func _ready() -> void:
	add_child(_sprite)
	add_child(_hunger_icon)
	add_child(_hunger_detection_area)

	print("fish instantiated")

	_healthComponent = HealthComponent.new(_max_health, _health_regen)
	_hungerComponent = HungerComponent.new(_max_hunger, _hunger_decay)

	_hunger_state = FishHungry.new(_hunger_detection_area, _move_speed)
	_idle_state = FishIdle.new(_move_speed)
	_possible_states.push_front(_idle_state)
	_possible_states.push_front(_hunger_state)

	_state_machine = StateMachine.new(_possible_states, _idle_state)

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
	move_and_slide()

	if velocity.x < 0:
		_sprite.flip_h = false
	else:
		_sprite.flip_h = true

func die() -> void:
	# play death stuff
	queue_free()

func handle_hunger(color, display_icon: bool) -> void:
	if display_icon && _state_machine.current_state != _hunger_state: _state_machine.enter_state_and_cleanup(_hunger_state)
	_hunger_icon.modulate = color
	_hunger_icon.visible = display_icon
