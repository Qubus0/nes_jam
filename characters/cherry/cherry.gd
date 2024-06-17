extends Node2D

signal defeated
@onready var sprite: AnimatedSprite2D = $Sprite

func _process(delta: float) -> void:
	pass

func _on_health_hurt() -> void:
	var tw := get_tree().create_tween()
	tw.tween_property($Sprite, "self_modulate", Color.REBECCA_PURPLE, .1)
	tw.tween_property($Sprite, "self_modulate", Color.WHITE, .1)
	#sprite.play(&"hurt")
	await get_tree().create_timer(0.8).timeout
	sprite.play(&"idle")

func _on_health_depleted() -> void:
	defeated.emit()
