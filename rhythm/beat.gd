@tool
class_name Beat
extends PathFollow2D

enum Themes {
	WHITE,
	YELLOW,
	PINK,
	GREEN,
	ORANGE,
	BLUE,
}

var speed := 0
@export var face_left := true :
	set(val):
		face_left = val
		$Sprite.flip_h = not face_left

@export var theme: Themes = Themes.WHITE :
	set(val):
		theme = val
		$Sprite.frame_coords.x = val


func _ready() -> void:
	$Sprite.rotation_degrees = -rotation_degrees
	$Sprite.flip_h = not face_left


func _process(delta: float) -> void:
	progress += speed * delta

