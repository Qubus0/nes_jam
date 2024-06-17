extends Node2D


signal defeated


func _on_health_hurt() -> void:
	$Sprite.play("hit")

	#var tw := get_tree().create_tween()
	#tw.tween_property($Sprite, "self_modulate", Color.REBECCA_PURPLE, .1)
	#tw.tween_property($Sprite, "self_modulate", Color.WHITE, .1)


func _on_health_depleted() -> void:
	defeated.emit()


func _on_sprite_animation_finished() -> void:
	$Sprite.play("default")


func _process(delta: float) -> void:
	%Left.progress += 20 * delta
	%Right.progress += 20 * delta
