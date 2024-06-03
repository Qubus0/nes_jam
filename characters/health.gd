class_name Health
extends Node

# ref: https://www.youtube.com/watch?v=74y6zWZfQKk

signal depleted
signal hurt

@export var max_health := 6

var health := 0

func _ready() -> void:
	health = max_health


func damage(amount: int) -> void:
	health -= amount
	hurt.emit()

	if health <= 0:
		depleted.emit()

