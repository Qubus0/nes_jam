extends Hitbox

@onready var wall_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_hitbox: CollisionShape2D = $CollisionShape2D

@export var is_on: bool
@export var facing_right: bool
@export var is_fast: bool
var beat_speed

func _ready() -> void:
	if is_fast == true:
		beat_speed = 1.6035
	elif is_fast == false:
		beat_speed = 2.665

func _process(delta: float) -> void:
	if is_on == false:
		if facing_right == false:
			wall_sprite.play(&"off_left")
		elif facing_right == true:
			wall_sprite.play(&"off_right")
		wall_hitbox.disabled = true
		await get_tree().create_timer(beat_speed).timeout
		is_on = true
	elif is_on == true:
		if facing_right == false:
			wall_sprite.play(&"on_left")
		elif facing_right == true:
			wall_sprite.play(&"on_right")
		wall_hitbox.disabled = false
		await get_tree().create_timer(beat_speed).timeout
		is_on = false
