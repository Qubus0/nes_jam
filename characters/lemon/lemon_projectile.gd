extends Hitbox

var projectile_speed = 120
var projectile_angle = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += projectile_speed * delta * -1

func _on_body_entered(body: Node2D) -> void:
	queue_free()
