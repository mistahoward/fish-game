extends State
class_name FishHungry

signal velocity_update

var _move_speed: float = 10
var move_direction: Vector2

var found_food: bool = false

var _fish: Fish

var chased_food: Food

var _eat_range: Area2D

func enter() -> void:
	var _eat_range_shape = CircleShape2D.new()
	_eat_range = Area2D.new()
	_eat_range_shape.radius = _fish._sprite.texture.get_height() / 2
	var _eat_range_collision: CollisionShape2D = CollisionShape2D.new()
	_eat_range_collision.shape = _eat_range_shape
	_eat_range.add_child(_eat_range_collision)
	var debug_color = Color.RED
	debug_color.a = 0.2
	_eat_range_collision.debug_color = debug_color
	_fish.add_child(_eat_range)
	_eat_range.area_entered.connect(func (node: Node2D): body_entered(node))

func body_entered(node_entered: Node2D):
	if !node_entered is Food: return
	var working_food: Food = node_entered
	_fish._hungerComponent._update_hunger(working_food._hunger_to_restore)
	working_food.consumed()
	_fish.handle_idle()

func _init(fish: Fish) -> void:
	_move_speed = fish._move_speed
	self.name = "FishHungryState"

	_fish = fish

func chase_food(food_to_chase: Food, delta: float) -> void:
	if found_food:
		var direction: Vector2 = (food_to_chase.position - _fish.position).normalized()
		velocity_update.emit(direction * _move_speed)
	found_food = true

func update(delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var available_food: Array[Node] = GameManager._scene_manager._feeding_manager.get_children()
	if available_food.size() <= 0:
		print("no more foods :(")
		found_food = false
	var nearest_food: Food
	for food: Food in available_food:
		if !nearest_food:
			nearest_food = food
			continue
		var nearest_food_pos = nearest_food.distance_to(_fish)
		var current_food = food.distance_to(_fish)
		if current_food > nearest_food_pos: return
		nearest_food = current_food
	if !nearest_food: return
	chase_food(nearest_food, _delta)

func exit() -> void:
	_fish.remove_child(_eat_range)
	_fish._hunger_icon.visible = false
