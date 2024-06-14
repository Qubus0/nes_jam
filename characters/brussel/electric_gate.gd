extends Hitbox

@export var is_on: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_on == false:
		$AnimatedSprite2D.play(&"off")
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(2.665).timeout
		is_on = true
	elif is_on == true:
		$AnimatedSprite2D.play(&"on")
		$CollisionShape2D.disabled = false
		await get_tree().create_timer(2.665).timeout
		is_on = false
