extends Control



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"Start") or event.is_action_pressed(&"Select"):
		Global.dialogue(Global.conversation.INTRO_START)
