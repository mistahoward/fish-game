extends State
class_name FishDeath

signal velocity_update

var _fish: Fish
var _move_direction: Vector2

var _shader_material: Material

func _init(affected_fish: Fish) -> void:
	_shader_material = load("res://assets/GrayScale_Material.tres")
	_fish = affected_fish
	self.name = "FishDeathState"

func flip_fish() -> void:
	_fish._sprite.flip_v = true

func sink_fish() -> void:
	_move_direction = Vector2(0, 1)

func play_audio() -> void:
	pass

func kill_fish() -> void:
	_fish.queue_free()

func grayscale_sprite() -> void:
	_fish._sprite.material = _shader_material

func handle_sprite() -> void:
	flip_fish()
	grayscale_sprite()

func enter() -> void:
	print("entered death state")
	_fish._hunger_icon.visible = false
	handle_sprite()
	sink_fish()
	await get_tree().create_timer(3).timeout
	kill_fish()

func update(delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	velocity_update.emit(_move_direction * _fish._move_speed)
