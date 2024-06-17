extends Stage



func _process(delta: float) -> void:
	$Player/Camera2D.drag_horizontal_offset = remap(
		clampf($Player.velocity.x, -300, 300),
		-300, 300, -1, 1
	)


func _on_out_of_bounds_body_entered(_body: Node2D) -> void:
	Global.game_over(self)


#func _ready() -> void:
	#($Player as Player).health.hurt.connect(_player_hurt)


func _player_hurt() -> void:
	Global.game_over(self)


func _on_goal_body_entered(body: Node2D) -> void:
	Global.dialogue(Global.conversation.CHERRY_ARENA_START)

