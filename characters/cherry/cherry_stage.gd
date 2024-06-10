extends Node2D



func _on_out_of_bounds_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()

