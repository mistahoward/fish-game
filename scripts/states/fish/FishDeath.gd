extends State
class_name FishDeath

signal velocity_update

var _fish: Fish
var _move_direction: Vector2

var _gray_shader: Material

var fade_initiated: bool = false
var local_ref: Signal

func _init(affected_fish: Fish, signal_ref: Signal) -> void:
	local_ref = signal_ref
	local_ref.connect(fade_fish_sprite)
	_gray_shader = load("res://assets/GrayScale_Material.tres")
	_fish = affected_fish
	self.name = "FishDeathState"

func fade_fish_sprite() -> void:
	if (fade_initiated): return
	print("fade initiated")
	var tween = create_tween()
	tween.tween_property(_fish._sprite, "modulate:a", 0.0, 1)
	fade_initiated = true
	await get_tree().create_timer(1).timeout
	kill_fish()

func set_sprite_and_flip() -> void:
	_fish._sprite.flip_v = true
	_fish.animated_sprite.stop()
	if _fish.animated_sprite.flip_h:
		_fish._sprite.flip_h = true
	_fish.animated_sprite.visible = false
	_fish._sprite.visible = true

func sink_fish() -> void:
	_move_direction = Vector2(0, 1)

func play_audio() -> void:
	pass

func kill_fish() -> void:
	_fish.queue_free()

func grayscale_sprite() -> void:
	_fish._sprite.material = _gray_shader

func handle_sprite() -> void:
	set_sprite_and_flip()
	grayscale_sprite()

func enter() -> void:
	print("entered death state")
	_fish._hunger_icon.visible = false
	handle_sprite()
	sink_fish()
	await get_tree().create_timer(3).timeout
	fade_fish_sprite()
	await get_tree().create_timer(1).timeout
	kill_fish()

func update(delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	velocity_update.emit(_move_direction * _fish._move_speed)
