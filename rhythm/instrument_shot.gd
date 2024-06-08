#@tool # uncomment and enable loop to see in editor
class_name InstrumentShot
extends PathFollow2D


@export var damage := 1
@export var speed: Curve
@export var frame: Curve


func _ready() -> void:
	$Hitbox.damage = damage


func _process(delta: float) -> void:
	progress_ratio += speed.sample_baked(progress_ratio) * delta

	%Sprite.frame = floor(frame.sample_baked(progress_ratio))

	if progress_ratio == 1:
		queue_free()
