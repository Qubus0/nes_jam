extends Hitbox

@export var is_on: bool
@export var facing_right: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_on == false:
		if facing_right == false:
			$AnimatedSprite2D.play(&"off_left")
		elif facing_right == true:
			$AnimatedSprite2D.play(&"off_right")
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(1.603).timeout
		is_on = true
	elif is_on == true:
		if facing_right == false:
			$AnimatedSprite2D.play(&"on_left")
		elif facing_right == true:
			$AnimatedSprite2D.play(&"on_right")
		$CollisionShape2D.disabled = false
		await get_tree().create_timer(1.603).timeout
		is_on = false
