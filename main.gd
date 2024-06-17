extends Node2D


func _ready() -> void:
	$CanvasLayer/Control/BoxContainer/Tutorial.grab_focus()


func _on_tutorial_pressed() -> void:
	Global.dialogue(Global.conversation.INTRO_START)



func _on_lemon_pressed() -> void:
	if Input.is_key_pressed(KEY_ALT):
		Global.dialogue(Global.conversation.LEMON_ARENA_START)
	else:
		Global.dialogue(Global.conversation.LEMON_STAGE_START)


func _on_beet_pressed() -> void:
	Global.dialogue(Global.conversation.BEET_ARENA_STARTPLAYER)


func _on_cherry_pressed() -> void:
	if Input.is_key_pressed(KEY_ALT):
		Global.dialogue(Global.conversation.CHERRY_ARENA_START)
	else:
		Global.dialogue(Global.conversation.CHERRY_STAGE_START)



func _on_brussel_pressed() -> void:
	if Input.is_key_pressed(KEY_ALT):
		Global.change_scene_to_file("res://characters/brussel/brussel_stage_3.tscn")
	else:
		Global.dialogue(Global.conversation.BRUSSEL_STAGE1_START)

