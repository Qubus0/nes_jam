extends Stage


func _process(delta: float) -> void:
	pass


func _on_water_body_entered(body: Node2D) -> void:
	$Player.position.y = $WaterDeathZone/Water1.position.y - 10
	$Player/Sploosh.set_visible(true)
	$Player/Sploosh.play()
	$Player/Sprite.set_visible(false)
	$Player.velocity = Vector2.ZERO
	$Player.speed = 0
	$Player.fall_gravity = 0
	await get_tree().create_timer(1).timeout
	Global.game_over(self)
