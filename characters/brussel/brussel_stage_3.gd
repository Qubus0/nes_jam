extends Node2D

@onready var kick_drum: AnimatedSprite2D = $Background/KickDrum
var drum_beat = true
const BRUSSEL_STAGE_END = preload("res://characters/brussel/brussel_stage_end.tscn")

var speed = 20
var max_speed = 30

func _process(delta: float) -> void:
	$Camera2D.position.y -= speed * delta
	if speed < max_speed:
		speed += 1 * delta

	if drum_beat == true:
		drum_beat = false
		kick_drum.play(&"playing")
		if kick_drum.frame == 3 and kick_drum.animation == &"playing":
			kick_drum.play(&"idle")
		await get_tree().create_timer(1.603).timeout
		drum_beat = true

func _on_level_end_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_packed(BRUSSEL_STAGE_END)
