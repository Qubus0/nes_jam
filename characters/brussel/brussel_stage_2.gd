extends Node2D

const STAGE_3 = preload("res://characters/brussel/brussel_stage_3.tscn")
@onready var kick_drum: AnimatedSprite2D = $Background/KickDrum
var drum_beat = true

func _process(delta: float) -> void:
	if drum_beat == true:
		drum_beat = false
		kick_drum.play(&"playing")
		if kick_drum.frame == 3 and kick_drum.animation == &"playing":
			kick_drum.play(&"idle")
		await get_tree().create_timer(2.665).timeout
		drum_beat = true

func _on_phase_transition_body_entered(body: Node2D) -> void:
	Global.dialogue(Global.conversation.BRUSSEL_STAGE3_START)

