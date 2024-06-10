extends Label



func _on_blink_timeout() -> void:
	self_modulate.a = int(not self_modulate.a)
