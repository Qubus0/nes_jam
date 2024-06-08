#@tool # uncomment and enable loop to see in editor
extends PathFollow2D

signal note_arrrived

@export var speed: Curve
@export var frame: Curve


func _process(delta: float) -> void:
	progress_ratio += speed.sample_baked(progress_ratio) * delta

	%Sprite.frame = floor(frame.sample_baked(progress_ratio))

	if progress_ratio == 1:
		note_arrrived.emit()
		queue_free()
