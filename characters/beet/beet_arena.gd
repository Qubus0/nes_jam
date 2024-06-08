extends Node2D

@export var pattern_speed := 40


const INSTRUMENT_SHOT = preload("res://rhythm/instrument_shot.tscn")
enum {
	PERFECT,
	SOLID,
	WEAK,
	MISS,
	WRONG
}

func _ready() -> void:
	# since the layout is offset to the top to be easier to edit,
	# that needs to be undone to start the game
	var curve := $PianoKeys.curve as Curve2D
	var last_y := curve.get_point_position(1).y
	$PianoKeys.position.y = -last_y

func _process(delta: float) -> void:
	%PianoPattern.progress -= pattern_speed * delta


func _on_rhythm_beat_hit(accuracy: int) -> void:
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
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://main.tscn")

