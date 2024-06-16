extends Node

signal transition_finished

const GAME_OVER = preload("res://interface/game_over.tscn")
const DIALOGUE = preload("res://interface/dialogue.tscn")

@onready var pause_menu: PauseMenu = $PauseMenu
@onready var transition: Transition = $Transition

var last_scene_path := ""
var is_game_over := false
var cause_of_death := death.GENERIC
var current_conversation := conversation.INTRO_END

enum death {
	GENERIC,
	JUICED,
	WEAK,
}

enum conversation {
	INTRO_START,
	INTRO_END,
}

var playing_bgm := ""


func _ready() -> void:
	pause_menu.unpause()
	await transition.trans_in()
	transition_finished.emit()


func _unhandled_key_input(event: InputEvent) -> void:
	if not event.is_action_pressed("Start") and not event.is_action_pressed("Select"):
		return

	if is_game_over:
		var path := last_scene_path if last_scene_path else "res://main.tscn"
		is_game_over = false
		change_scene_to_file(path)
		return

	if not event.is_action_pressed("Start"):
		return

	if get_tree().paused:
		pause_menu.unpause()
	else:
		pause_menu.pause()


func change_scene_to_file(path: String) -> void:
	# don't ask FIXME
	if "cherry_stage" in path:
		$LemonStageBGM.stop()
		if not $CherryStageBGM.playing:
			$CherryStageBGM.play()
	elif "lemon_stage" in path:
		$CherryStageBGM.stop()
		if not $LemonStageBGM.playing:
			$LemonStageBGM.play()
	else:
		stop_music()

	await transition.trans_out()
	get_tree().change_scene_to_file(path)
	await transition.trans_in()
	transition_finished.emit()


func change_scene_to_packed(scene: PackedScene) -> void:
	stop_music()

	await transition.trans_out()
	get_tree().change_scene_to_packed(scene)
	await transition.trans_in()
	transition_finished.emit()


func game_over(origin_node: Node, death := death.GENERIC) -> void:
	var scene_root := origin_node.owner if origin_node.owner else origin_node
	last_scene_path = scene_root.scene_file_path
	is_game_over = true
	cause_of_death = death
	change_scene_to_packed(GAME_OVER)


func dialogue(convo: int) -> void:
	current_conversation = convo
	change_scene_to_packed(DIALOGUE)


func stop_music() -> void:
	$CherryStageBGM.stop()
	$LemonStageBGM.stop()

