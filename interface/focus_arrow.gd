extends TextureRect

# doesn't work on first load
#func _ready() -> void:
	#get_viewport().gui_focus_changed.connect(_on_gui_focus_changed)
	#await get_parent().ready


func _process(_delta: float) -> void:
	var focussed := get_viewport().gui_get_focus_owner()
	if focussed:
		_on_gui_focus_changed(focussed)


func _on_gui_focus_changed(target: Control) -> void:
	var new_pos := target.global_position
	new_pos.x -= size.x * 1.5
	new_pos.y -= size.y/2
	new_pos.y += target.size.y/2

	global_position = new_pos
	#var tw := get_tree().create_tween()
	#tw.tween_property(self, "global_position", new_pos, 0.1)


