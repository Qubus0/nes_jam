extends CanvasLayer

@export var player: Player
@onready var health_sprite: AnimatedSprite2D = $"HealthSprite"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.current_health >= 0 && player.current_health <= 3:
		health_sprite.frame = player.current_health
