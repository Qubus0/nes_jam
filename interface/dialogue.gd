extends TabContainer


var conversation: Conversation

func _ready() -> void:
	current_tab = Global.current_conversation
	conversation = get_current_tab_control()

	await Global.transition_finished
	conversation.start()


func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_Q) and Input.is_key_pressed(KEY_SHIFT):
		Global.dialogue(current_tab +1)

	if not conversation.text_finished:
		if event.is_action_pressed("ui_accept"):
			conversation.skip()
		return

	if event.is_action_pressed("ui_accept"):
		conversation.next()
		if conversation.finished:
			if conversation.destination_scene:
				Global.change_scene_to_packed(conversation.destination_scene)
			else:
				Global.dialogue(conversation.destination_conversation)



