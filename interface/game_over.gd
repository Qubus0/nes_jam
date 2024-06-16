class_name GameOver
extends Control

@onready var tabc := %TabContainer as TabContainer


func _ready() -> void:
	tabc.current_tab = Global.cause_of_death
	for text in find_children("Text", "Label"):
		text.visible_characters = 0

	await Global.transition_finished
	start()


func start() -> void:
	var death := tabc.get_current_tab_control()
	var text := death.get_node("Text")

	for character: String in text.text:
		text.visible_characters += 1
		await get_tree().create_timer(0.15).timeout
		if not character.strip_edges().is_empty():
			%Sound.play()

	$Start.show()
	$Start/Blink.start()

