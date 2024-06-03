class_name Hurtbox
extends Area2D

@export var health: Health

# ref: https://www.youtube.com/watch?v=JWjzSn95bM0
func _init() -> void:
	collision_layer = 64	# is a hurtbox
	collision_mask = 32		# detects hitbox


func  _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(hitbox: Hitbox) -> void:
	if not hitbox:
		return

	if health:
		health.damage(hitbox.damage)
