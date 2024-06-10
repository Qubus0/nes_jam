extends Node

const PAUSE_MENU = preload("res://interface/pause_menu.tscn")
const TRANSITION = preload("res://interface/transition.tscn")

var pause_menu: PauseMenu
var transition: Transition


func _ready() -> void:
	pause_menu = PAUSE_MENU.instantiate()
	add_child(pause_menu)
	transition = TRANSITION.instantiate()
	add_child(transition)

	transition.trans_in()
	pause_menu.unpause()


func change_scene_to_file(path: String) -> void:
	await transition.trans_out()
	get_tree().change_scene_to_file(path)
	await transition.trans_in()



