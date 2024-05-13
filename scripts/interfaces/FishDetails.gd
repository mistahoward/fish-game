class_name FishDetails

enum FishType {
	Producer,
	Attacker,
	Defender
}

var id: int
var name: String
var sprite: Resource
var move_speed: float
var value: int
var price: int
var max_hunger: int
var hunger_decay: float
var hunger_radius: float
var max_health: int
var health_regen: float
var type: FishType
var unlocked: bool

var scale_multiplier: float

var strength: int
var defense: int

var time_alive: int # in seconds
var life_span: int # in seconds
