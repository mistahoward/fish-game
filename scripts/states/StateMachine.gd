extends Node
class_name StateMachine

var current_state: State
var states: Dictionary = {}
var _initial_state: State

func _init(possible_states: Array[State] = [], initial_state: State = null) -> void:
	for state in possible_states:
		states[state.name.to_lower()] = state
		state.Transitioned.connect(on_child_transition)
		add_child(state)
	_initial_state = initial_state
	self.name = "StateMachine"

func _ready() -> void:
	if _initial_state:
		_initial_state.enter()
		current_state = _initial_state

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


