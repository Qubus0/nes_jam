extends Node2D


func _ready() -> void:
	$CanvasLayer/Control/BoxContainer/Tutorial.grab_focus()


func _on_tutorial_pressed() -> void:
	Global.dialogue(Global.conversation.INTRO_START)


func _on_lemon_pressed() -> void:
	if Input.is_key_pressed(KEY_ALT):
		Global.change_scene_to_file("res://characters/lemon/lemon_arena.tscn")
	else:
		Global.change_scene_to_file("res://characters/lemon/lemon_stage.tscn")


func _on_beet_pressed() -> void:
	Global.change_scene_to_file("res://characters/beet/beet_arena.tscn")


func _on_cherry_pressed() -> void:
	Global.change_scene_to_file("res://characters/cherry/cherry_stage.tscn")


func _on_brussel_pressed() -> void:
	if Input.is_key_pressed(KEY_ALT):
		Global.change_scene_to_file("res://characters/brussel/brussel_stage_3.tscn")
	else:
		Global.change_scene_to_file("res://characters/brussel/brussel_stage.tscn")

