class_name FishDetails

var id: int
var name: String
var sprite: PackedScene
var move_speed: float
var value: int
var price: int
var max_hunger: int
var hunger_decay: float
var hunger_radius: float
var max_health: int
var health_regen: float
var type: String
var unlocked: bool

var scale_multiplier: float

var strength: int
var defense: int

var time_alive: int # in seconds
var life_span: int # in seconds

var hunger_needed_until_next_stage: int
var number_of_life_stages: int

var production_cooldown: float
var produces: Array[int] # array of coin id's