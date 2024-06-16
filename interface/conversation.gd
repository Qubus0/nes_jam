class_name Conversation
extends Control

@export var destination_scene: PackedScene
@export var destination_conversation: Global.conversation = 0

@onready var texts: TabContainer = $Margin/Texts
@onready var current_text: RichTextLabel = texts.get_current_tab_control()

@export var character_delay := 0.08
var finished := false
var text_finished := false


func _ready() -> void:
	texts.current_tab = 0
	for text: RichTextLabel in texts.get_children():
		text.visible_characters = 0


func start() -> void:
	text_finished = false
	$Arrow.hide()
	current_text = texts.get_current_tab_control()

	for character: String in current_text.get_parsed_text():
		current_text.visible_characters += 1
		if not character.strip_edges().is_empty():
			$Sound.play()

		if character in [".", ",", "?", "!"]:
			await get_tree().create_timer(character_delay *4).timeout
		else:
			await get_tree().create_timer(character_delay).timeout

		if text_finished:
			return

	$Arrow.show()
	text_finished = true


func skip() -> void:
	current_text.visible_characters = -1

	$Arrow.show()
	text_finished = true


func next() -> void:
	var next := texts.current_tab + 1
	texts.current_tab += 1
	# if it was not incremented it's the last one
	if next > texts.current_tab:
		finished = true
	else:
		start()

