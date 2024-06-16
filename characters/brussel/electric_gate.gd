extends Hitbox

@onready var gate_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gate_hitbox: CollisionShape2D = $CollisionShape2D

@export var is_on: bool
@export var is_fast: bool
var beat_speed
var charging = true

func _ready() -> void:
	if is_fast == true:
		beat_speed = 1.6035
	elif is_fast == false:
		beat_speed = 2.665

func _process(delta: float) -> void:
	if is_on == false:
		gate_sprite.play(&"off")
		gate_hitbox.disabled = true
		await get_tree().create_timer(beat_speed).timeout
		is_on = true
	elif is_on == true:
		gate_sprite.play(&"on")
		gate_hitbox.disabled = false
		await get_tree().create_timer(beat_speed).timeout
		is_on = false
