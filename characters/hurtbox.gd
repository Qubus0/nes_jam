class_name Hurtbox
extends Area2D

@export var health: Health
@export var invincibility: Timer

func  _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(hitbox: Hitbox) -> void:
	if not hitbox:
		return
	if invincibility and invincibility.time_left > 0:
		return

	if health:
		if invincibility: invincibility.start()
		health.damage(hitbox.damage)
