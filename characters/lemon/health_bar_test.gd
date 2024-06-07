extends Control

@onready var player: CharacterBody2D = $"../../Player"
#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.current_health >= 0 && player.current_health <= 6:
		animated_sprite_2d.frame = player.current_health
