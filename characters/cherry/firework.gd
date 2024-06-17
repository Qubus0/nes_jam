extends Hitbox

var projectile_speed = 180
var projectile_direction = Vector2.UP

func _physics_process(delta: float) -> void:
	translate(projectile_speed * projectile_direction * delta)
	await get_tree().create_timer(5).timeout
	queue_free()
