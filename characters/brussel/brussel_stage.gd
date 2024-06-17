extends Node2D

const STAGE_2 = preload("res://characters/brussel/brussel_stage_2.tscn")

func _on_phase_transition_body_entered(body: Node2D) -> void:
	Global.dialogue(Global.conversation.BRUSSEL_STAGE2_START)
