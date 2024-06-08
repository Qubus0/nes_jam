extends Node2D


func _ready() -> void:
	$CanvasLayer/Control/BoxContainer/Lemon.grab_focus()


func _on_lemon_pressed() -> void:
	get_tree().change_scene_to_file("res://characters/lemon/lemon_stage.tscn")


func _on_beet_pressed() -> void:
	get_tree().change_scene_to_file("res://characters/beet/beet_arena.tscn")
