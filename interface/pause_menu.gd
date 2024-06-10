class_name PauseMenu
extends CanvasLayer

var last_focussed: Control


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("Start"):
		if get_tree().paused:
			unpause()
		else:
			pause()


func pause() -> void:
	get_tree().paused = true
	show()
	%PausedLabel.self_modulate.a = 1
	%Blink.start()
	last_focussed = get_viewport().gui_get_focus_owner()
	%Resume.grab_focus()


func unpause() -> void:
	get_tree().paused = false
	hide()
	%Blink.stop()
	if last_focussed:
		last_focussed.grab_focus()


func _on_resume_pressed() -> void:
	unpause()


func _on_menu_pressed() -> void:
	unpause()
	Global.change_scene_to_file("res://main.tscn")


func _on_blink_timeout() -> void:
	%PausedLabel.self_modulate.a = int(not %PausedLabel.self_modulate.a)