extends Node2D


@export var pattern_speed := 50


func _process(delta: float) -> void:
	$TopPattern.position.y += pattern_speed * delta
