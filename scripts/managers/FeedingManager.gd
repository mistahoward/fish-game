extends Node
class_name FeedingManager

var _ready_to_feed: bool = false

var food_database: Dictionary = {}

var food_1: Dictionary = {
	 "id": 1,
	 "name": "pellet",
	 "sprite": load("res://assets/pellet-1.png"),
	 "sink_speed": 50,
	 "hunger_to_restore": 40,
	 "value": 2.5,
	 "price": 0,
	 "unlocked": true
}

var allowed_foods: int = 1
var spawned_food_amount: int = 0
var highest_unlocked_food_id: int = 1

func decrement_spawned_food() -> void:
	spawned_food_amount =- 1
	if spawned_food_amount < 0:
		spawned_food_amount = 0

func updated_highest_unlocked_food() -> void:
	pass

func load_food_to_db() -> void:
	food_database[food_1.id] = food_1

func _init(game_state: Signal, click_ref: Signal) -> void:
	self.name = "FeedingManager"
	self.unique_name_in_owner = true

	load_food_to_db()

	game_state.connect(func(bool_state: bool): connected(bool_state))
	click_ref.connect(func(mouse_location: Vector2): handle_click(mouse_location))

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func connected(ready_to_go: bool) -> void:
	if ready_to_go: _ready_to_feed = ready_to_go

func create_food(id: int) -> Food:
	var food_details: FoodDetails = get_food_by_id(id)
	return Food.new(food_details, decrement_spawned_food)

func handle_click(location: Vector2) -> void:
	if allowed_foods <= spawned_food_amount: return
	var working_food = create_food(1)
	working_food.position.x = location.x
	working_food.position.y = location.y
	spawned_food_amount += 1
	add_child(working_food)
	print("creating food")

func get_food_by_id(id: int) -> FoodDetails:
	var food_dict_value: Dictionary = food_database[id]
	if !food_dict_value: push_error("FOOD DETAILS NOT FOUND BY ID")

	var working_food_details: FoodDetails = FoodDetails.new()
	for food_key in food_dict_value:
		var food_value = food_dict_value[food_key]
		working_food_details[food_key] = food_value
	return working_food_details
