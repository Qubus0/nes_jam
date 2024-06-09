extends CanvasLayer


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("Start"):
		if get_tree().paused:
			unpause()
		else:
			pause()


func pause() -> void:
	get_tree().paused = true
	show()
	%Blink.start()
	%Resume.grab_focus()


func unpause() -> void:
	get_tree().paused = false
	hide()
	%Blink.stop()


func _on_resume_pressed() -> void:
	unpause()


func _on_blink_timeout() -> void:
	%PausedLabel.self_modulate.a = int(not %PausedLabel.self_modulate.a)

