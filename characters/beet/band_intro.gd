extends Node2D




func _on_show_stopper_timeout() -> void:
	Global.dialogue(Global.conversation.BEET_ARENA_START)


func _on_dropper_timeout() -> void:
	$Hand.show()
	$Piano.play("default")


func _on_piano_animation_finished() -> void:
	$Hurt.play()
