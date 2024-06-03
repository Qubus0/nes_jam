class_name Hitbox
extends Area2D


@export var damage := 1


func _init() -> void:
	collision_layer = 32	# is a hitbox
	collision_mask = 64		# collides with hurtbox




