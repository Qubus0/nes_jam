extends Node2D



func _on_out_of_bounds_body_entered(_body: Node2D) -> void:
	Global.game_over(self)


#func _ready() -> void:
	#($Player as Player).health.hurt.connect(_player_hurt)


func _player_hurt() -> void:
	Global.game_over(self)
