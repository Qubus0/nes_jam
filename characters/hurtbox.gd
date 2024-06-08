class_name Hurtbox
extends Area2D

@export var health: Health


func  _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(hitbox: Hitbox) -> void:
	if not hitbox:
		return

	if health:
		health.damage(hitbox.damage)
