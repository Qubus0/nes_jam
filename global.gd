extends Node


@onready var pause_menu: PauseMenu = $PauseMenu
@onready var transition: Transition = $Transition
@onready var game_over_screen: GameOver = $GameOver


func _ready() -> void:
	await transition.trans_in()
	pause_menu.unpause()


func change_scene_to_file(path: String) -> void:
	await transition.trans_out()
	get_tree().change_scene_to_file(path)
	await transition.trans_in()


func game_over() -> void:
	await transition.trans_out()
	get_tree().paused = true
	game_over_screen.appear()
	await transition.trans_in()
	game_over_screen.start()



