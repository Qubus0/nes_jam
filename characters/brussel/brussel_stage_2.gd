extends Node2D

const STAGE_3 = preload("res://characters/brussel/brussel_stage_3.tscn")

func _on_phase_transition_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_packed(STAGE_3)
