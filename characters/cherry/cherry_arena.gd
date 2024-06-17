extends Node2D

@export var pattern_speed := 40
const FIREWORK = preload("res://characters/cherry/firework.tscn")

const INSTRUMENT_SHOT = preload("res://rhythm/instrument_shot.tscn")
enum {
	PERFECT,
	SOLID,
	WEAK,
	MISS,
	WRONG
}

func _process(delta: float) -> void:
	var firework_instance = FIREWORK.instantiate()
	var firework_instance2 = FIREWORK.instantiate()
	firework_instance.transform = $ArenaFloor/Floor1/FireworkMarkLeft.global_transform
	firework_instance2.transform = $ArenaFloor/Floor1/FireworkMarkRight.global_transform

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

func _on_cherry_defeated() -> void:
	$Cherry.queue_free()
	%Win.show()
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	Global.change_scene_to_file("res://main.tscn")

