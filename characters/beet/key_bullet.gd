@tool
extends Hitbox

@export var dark := false :
	set(val):
		dark = val
		update()
@export var short := false:
	set(val):
		short = val
		update()

@onready var sprite := $Sprite as Sprite2D


func _ready() -> void:
	update()

func update() -> void:
	if not is_node_ready():
		return
	var frame := 0
	if dark: frame += int(sprite.hframes / 2)
	if short: frame += 1

	sprite.frame = frame
	($CollisionBack as CollisionShape2D).disabled = short




