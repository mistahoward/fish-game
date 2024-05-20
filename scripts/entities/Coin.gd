extends Area2D
class_name Coin

var _id: int
var _name: String

var _sink_speed: float
var _value: int
var _sprite: Sprite2D

var _animated_sprite: AnimatedSprite2D

var _collision_shape_object: CollisionShape2D

var sink_direction: int = -1

var handle_increment: Callable
