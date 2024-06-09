extends Node


#func _unhandled_key_input(event: InputEvent) -> void:
	#if event.is_action_pressed("Start"):
		#get_tree().change_scene_to_file("res://main.tscn")
