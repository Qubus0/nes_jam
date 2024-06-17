extends Area2D

# preloading here makes the transition faster
var arena := preload("res://characters/lemon/lemon_arena.tscn")

func _on_body_entered(body: Node2D) -> void:
	Global.dialogue(Global.conversation.LEMON_ARENA_START)
	get_tree().change_scene_to_packed(arena)
