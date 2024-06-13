extends PathFollow2D

var speed = 120

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotates = false
	loop = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 0.99:
		queue_free()
