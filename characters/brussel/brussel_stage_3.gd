extends Node2D

@onready var kick_drum: AnimatedSprite2D = $Background/KickDrum
var drum_beat = true

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
	%Win.show()
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	Global.change_scene_to_file("res://main.tscn")
