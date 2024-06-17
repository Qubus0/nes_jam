extends Node2D

var fire_cube = false
var direction = true

@export var pattern_speed := 40
const FIREWORK = preload("res://characters/cherry/firework.tscn")
const ICE_CUBE = preload("res://characters/cherry/ice_cube.tscn")

const INSTRUMENT_SHOT = preload("res://rhythm/instrument_shot.tscn")
enum {
	PERFECT,
	SOLID,
	WEAK,
	MISS,
	WRONG
}

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	fire_cube = true

func _process(delta: float) -> void:
	var firework_instance = FIREWORK.instantiate()
	var firework_instance2 = FIREWORK.instantiate()
	firework_instance.transform = $ArenaFloor/Floor1/FireworkMarkLeft.global_transform
	firework_instance2.transform = $ArenaFloor/Floor1/FireworkMarkRight.global_transform

	if fire_cube == true:
		fire_cube = false
		var cube_instance = ICE_CUBE.instantiate()
		if direction == true:
			$TempAtt1.add_child(cube_instance)
			direction = false
		else:
			$TempAtt2.add_child(cube_instance)
			direction = true
		await get_tree().create_timer(4).timeout
		if $Cherry.visible == true:
			fire_cube = true

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
	$Cherry.set_visible(false)
	Global.dialogue(Global.conversation.CHERRY_ARENA_END)

