extends Hitbox

var projectile_speed = 160
var projectile_direction = Vector2.UP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	translate(projectile_speed * projectile_direction * delta)
	await get_tree().create_timer(5).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
