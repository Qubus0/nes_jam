extends PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotates = false
	loop = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += 120 * delta
	if progress_ratio >= 0.99:
		queue_free()
