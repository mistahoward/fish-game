extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)

	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if !current_state: return
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	if !current_state: return
	current_state.physics_update(delta)

func enter_state_and_cleanup(new_state: State) -> void:
	if current_state: current_state.exit()
	new_state.enter()
	current_state = new_state

func on_child_transition(state: State, new_state_name: String) -> void:
	if state != current_state: return

	var state_by_name: State = states.get(new_state_name.to_lower())

	if !state_by_name: return
	enter_state_and_cleanup(state_by_name)


