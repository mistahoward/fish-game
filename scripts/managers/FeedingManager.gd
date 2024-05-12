extends Node
class_name FeedingManager

var _ready_to_feed: bool = false

func _init(game_state: Signal, click_ref: Signal) -> void:
	self.name = "FeedingManager"
	self.unique_name_in_owner = true
	game_state.connect(func(bool_state): connected(bool_state))
	click_ref.connect(func(vector2): create_food())

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func connected(ready_to_go: bool) -> void:
	if ready_to_go: _ready_to_feed = ready_to_go

func create_food() -> void:
	print("food create")
