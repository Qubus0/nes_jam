extends Node2D


var bad_accuracy_counter := 0


const INSTRUMENT_SHOT = preload("res://rhythm/instrument_shot.tscn")
enum {
	PERFECT,
	SOLID,
	WEAK,
	MISS,
	WRONG
}


var time := 0.0
func _process(delta: float) -> void:
	time += delta

func _on_rhythm_beat_hit(accuracy: int) -> void:
	if accuracy == MISS or accuracy == WRONG or accuracy == WEAK:
		bad_accuracy_counter += 1

	if bad_accuracy_counter > 8:
		Global.dialogue(Global.conversation.INTRO_END)
	elif time > 35.5:
		Global.dialogue(Global.conversation.INTRO_BIGSHOT)

	var shot: InstrumentShot = INSTRUMENT_SHOT.instantiate()
	match accuracy:
		PERFECT:
			shot.damage = 6
			%Perfect.add_child(shot)
		WEAK:
			shot.damage = 2
			%Attack.add_child(shot)
		_:
			shot.damage = 3
			%Attack.add_child(shot)


func _on_beet_defeated() -> void:
	$Beet.queue_free()
	%Win.show()
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	Global.change_scene_to_file("res://main.tscn")



func _on_music_started() -> void:
	$AnimatedSprite2D.play(&"default")
