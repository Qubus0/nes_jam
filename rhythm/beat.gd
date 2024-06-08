@tool
class_name Beat
extends PathFollow2D


var speed := 0
@export var face_left := true :
	set(val):
		face_left = val
		$Sprite.flip_h = not face_left
@export var theme := 0 :
	set(val):
		theme = val
		$Sprite.frame_coords.x = val


func _ready() -> void:
	$Sprite.rotation_degrees = -rotation_degrees
	$Sprite.flip_h = not face_left


func _process(delta: float) -> void:
	progress += speed * delta

