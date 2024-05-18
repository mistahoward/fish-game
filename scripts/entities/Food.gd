extends Area2D
class_name Food

var _collision_shape_object: CollisionShape2D

var _id: int
var _name: String
var _sprite: Sprite2D
var _sink_speed: float
var _hunger_to_restore: int
var _value: float
var _price: int

var unlocked: bool

var sink_direction: int = -1

var fade_initiated: bool = false

var handle_decrement: Callable

func _init(details: FoodDetails, decrement_function: Callable) -> void:
	# TODO: implement this with sink_speed

	_id = details.id
	_name = details.name
	_sprite = Sprite2D.new()
	_sprite.texture = details.sprite
	_sink_speed = details.sink_speed
	_hunger_to_restore = details.hunger_to_restore
	_value = details.value
	_price = details.price
	unlocked = details.unlocked

	handle_decrement = decrement_function

	var _collision_body_shape = CircleShape2D.new()
	_collision_body_shape.radius = self._sprite.texture.get_height() / 3
	_collision_shape_object = CollisionShape2D.new()
	_collision_shape_object.shape = _collision_body_shape
	self.collision_layer = 1
	self.collision_mask = 2
	add_child(_collision_shape_object)

func _ready() -> void:
	add_child(_sprite)

func fade_away() -> void:
	if (fade_initiated): return
	var tween: Tween = create_tween()
	tween.tween_property(self._sprite, "modulate:a", 0.0, 1)
	fade_initiated = true
	await get_tree().create_timer(1).timeout
	handle_decrement.call()
	queue_free()

func _physics_process(delta: float) -> void:
	var collision_list: Array[Node2D] = get_overlapping_bodies()
	if collision_list.size() <= 0: 
		self.position.y = self.position.y - _sink_speed * delta * sink_direction
		return
	var collided_with_bottom_of_tank = collision_list.find(StaticBody2D)
	if collided_with_bottom_of_tank: fade_away()
	