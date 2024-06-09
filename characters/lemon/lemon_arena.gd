extends Node2D

var can_shoot = true
@onready var thrown_lemon_marker: Marker2D = $ThrownLemonMarker
var projectile = preload("res://characters/lemon/lemon_projectile.tscn")

const INSTRUMENT_SHOT = preload("res://rhythm/instrument_shot.tscn")
enum {
	PERFECT,
	SOLID,
	WEAK,
	MISS,
	WRONG
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_shoot == true:
		can_shoot = false
		var projectile_instance = projectile.instantiate()
		get_parent().add_child(projectile_instance)
		projectile_instance.transform = $ThrownLemonMarker.global_transform
		var dir_left = ($Player.global_position - $ThrownLemonMarker.global_position).normalized()
		projectile_instance.projectile_direction = dir_left
		await get_tree().create_timer(8).timeout
		can_shoot = true

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

func _on_lemon_defeated() -> void:
	$Lemon.queue_free()
	%Win.show()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://main.tscn")
