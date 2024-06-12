extends Node2D

var can_shoot = false
var bouncing = false

@onready var thrown_lemon_marker: Marker2D = $ThrownLemonMarker
@onready var lemnote_sprite: AnimatedSprite2D = $LemonNote/Sprite
@onready var blender_sprite: AnimatedSprite2D = $Blender/Sprite

var projectile = preload("res://characters/lemon/lemon_projectile.tscn")
const LEMON_BOULDER = preload("res://characters/lemon/lemon_boulder.tscn")

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
	await get_tree().create_timer(2).timeout
	can_shoot = true

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
	
	if lemnote_sprite.frame == 8:
		lemnote_sprite.play(&"idle")
		await get_tree().create_timer(5).timeout
		lemnote_sprite.play(&"grow")
	
	if blender_sprite.animation_finished && blender_sprite.animation == &"lemon_enter":
		blender_sprite.play(&"get_juiced")
	#if blender_sprite.animation_finished && blender_sprite.animation == &"get_juiced":
		#blender_sprite.play(&"default")

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
	can_shoot = false
	await get_tree().create_timer(2).timeout
	Global.change_scene_to_file("res://main.tscn")

func _on_sprite_frame_changed() -> void:
	if lemnote_sprite.frame == 5:
		var boulder_instance = LEMON_BOULDER.instantiate()
		if bouncing == true:
			%Bouncing.add_child(boulder_instance)
			bouncing = false
		else:
			%Rolling.add_child(boulder_instance)
			bouncing = true
		if boulder_instance.progress_ratio >= 0.99:
			blender_sprite.play(&"lemon_enter")

func _on_killzone_area_entered(area: Area2D) -> void:
	blender_sprite.play(&"get_juiced")
	$Player.queue_free()
