extends Label


func _on_timer_timeout() -> void:
	text = str(int(text) -1)
	$Click.play()
	if int(text) < 0:
		queue_free()

