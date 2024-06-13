class_name Hurtbox
extends Area2D

@export var health: Health
@export var invincibility: Timer


func  _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)


func _process_hit(damage: int) -> void:
	if invincibility and invincibility.time_left > 0:
		return

	if health:
		if invincibility: invincibility.start()
		health.damage(damage)


func _on_area_entered(hitbox: Hitbox) -> void:
	if not hitbox:
		return

	_process_hit(hitbox.damage)


func _on_body_entered(_body: Node2D) -> void:
	_process_hit(1)

