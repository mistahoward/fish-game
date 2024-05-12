extends CharacterBody2D
class_name Fish

var _healthComponent: HealthComponent
var _hungerComponent: HungerComponent

var hunger_icon: Sprite2D

func _ready() -> void:
	_healthComponent = HealthComponent.new()
	_hungerComponent = HungerComponent.new(30, 2)
	add_child(_healthComponent)
	add_child(_hungerComponent)
	_hungerComponent.hunger_depleted.connect(die)
	_hungerComponent.update_icon.connect(func(arg1, arg2): handle_icon(arg1, arg2))
	hunger_icon = $hunger_icon

func _physics_process(_delta: float) -> void:
	move_and_slide()

	if velocity.x < 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

func die() -> void:
	# play death stuff
	queue_free()

func handle_icon(color, display_icon: bool) -> void:
	print(color, display_icon)
	hunger_icon.modulate = color
	hunger_icon.visible = display_icon
