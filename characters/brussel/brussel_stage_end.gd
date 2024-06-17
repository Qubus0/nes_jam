extends Node2D




func _on_goal_body_entered(body: Node2D) -> void:
	Global.dialogue(Global.conversation.BRUSSEL_STAGE3_END)
