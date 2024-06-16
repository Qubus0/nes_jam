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
	#Global.play_stage_music()
	await get_tree().create_timer(4).timeout
	can_shoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_shoot == true:
		can_shoot = false
		$Lemon/Sprite.play(&"throw_lemon")
		await get_tree().create_timer(0.5).timeout
		var projectile_instance = projectile.instantiate()
		get_parent().add_child(projectile_instance)
		projectile_instance.transform = $ThrownLemonMarker.global_transform
		var dir_left = ($Player.global_position - $ThrownLemonMarker.global_position).normalized()
		projectile_instance.projectile_direction = dir_left
		projectile_instance.projectile_speed = 100
		await get_tree().create_timer(10).timeout
		if $Lemon.visible == true:
			can_shoot = true

	if lemnote_sprite.frame == 8:
		lemnote_sprite.play(&"idle")
		await get_tree().create_timer(5).timeout
		lemnote_sprite.play(&"grow")

	if blender_sprite.frame == 3 and blender_sprite.animation == &"lemon_enter":
		blender_sprite.play(&"get_juiced")
	if blender_sprite.frame == 9 and blender_sprite.animation == &"get_juiced":
		blender_sprite.play(&"default")

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
	#$Lemon.queue_free()
	$Lemon.set_visible(false)
	%Win.show()
	can_shoot = false
	await get_tree().create_timer(2).timeout
	Global.change_scene_to_file("res://main.tscn")

func _on_sprite_frame_changed() -> void:
	if lemnote_sprite.frame == 5:
		var boulder_instance = LEMON_BOULDER.instantiate()
		if bouncing == true:
			%Bouncing.add_child(boulder_instance)
			boulder_instance.speed = 160
			bouncing = false
			await get_tree().create_timer(2.45).timeout
			blender_sprite.play(&"lemon_enter")
		else:
			%Rolling.add_child(boulder_instance)
			bouncing = true
			await get_tree().create_timer(2.22).timeout
			blender_sprite.play(&"lemon_enter")

func _on_juicing_zone_body_entered(body: Node2D) -> void:
	blender_sprite.play(&"get_juiced")
	$Player.set_visible(false)
	$Player.position.y -= 5
	$Player.velocity = Vector2.ZERO
	$Player.speed = 0
	$Player.fall_gravity = 0
	await get_tree().create_timer(1).timeout
	Global.game_over(self, Global.death.JUICED)
