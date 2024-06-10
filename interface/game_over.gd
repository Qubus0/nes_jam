class_name GameOver
extends Control


func start() -> void:
	%Text.visible_characters = 0

	for character: String in %Text.text:
		%Text.visible_characters += 1
		await get_tree().create_timer(0.15).timeout
		if not character.strip_edges().is_empty():
			%Sound.play()


