class_name Transition
extends CanvasLayer

@onready var mat := $ColorRect.material as ShaderMaterial
var viewport_size := Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
	)


func _ready() -> void:
	mat.set_shader_parameter("screen_size", viewport_size)
	hide()


func trans_in() -> void:
	await transtition(-0.2, 1.6)


func trans_out() -> void:
	await transtition(1.6, -0.2, true)


func transtition(from: float, to: float, out := false) -> void:
	mat.set_shader_parameter("circle_size", from)
	get_tree().paused = true
	show()
	if out:
		snapshot()
	$TextureRect.visible = out

	var origin := Vector2.ONE / 2
	var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
	if player:
		origin = player.global_position / viewport_size
	mat.set_shader_parameter("origin", origin)

	var tw := create_tween()
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.set_ease(Tween.EASE_OUT if out else Tween.EASE_IN)
	tw.tween_property($ColorRect, "material:shader_parameter/circle_size", to, 0.8)
	await tw.finished
	hide()
	get_tree().paused = false


func snapshot() -> void:
	var img = get_viewport().get_texture().get_image()
	var screenshot = ImageTexture.create_from_image(img)
	$TextureRect.texture = screenshot

