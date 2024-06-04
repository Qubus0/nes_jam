extends Control

var beat_speed := 40
enum {
	PERFECT,
	SOLID,
	WEAK,
	MISS
}

@onready var valid := %ValidArea
var playhead: PathFollow2D
var playhead_area: Area2D


func _ready() -> void:
	play_track("TestTrack")


func _process(delta: float) -> void:
	playhead.progress += beat_speed * delta

	handle_input()


func play_track(track_name: String) -> void:
	if playhead_area and playhead_area.area_entered.is_connected(playhead_entered):
		playhead_area.area_entered.disconnect(playhead_entered)

	playhead = get_node("%" + track_name)
	playhead_area = playhead.get_node("Area")


	playhead_area.area_entered.connect(playhead_entered)


func playhead_entered(area: Area2D) -> void:
	var beat := area.get_parent()
	var new_beat: Beat = beat.duplicate()

	await get_tree().process_frame # gets rid of the error
	$Track.add_child(new_beat)
	new_beat.speed = beat_speed
	new_beat.progress_ratio = 0


func handle_input() -> void:
	if valid.get_overlapping_areas().is_empty():
		return

	var detected_area: Area2D = valid.get_overlapping_areas().front()
	if not detected_area:
		return
	var beat: Beat = detected_area.get_parent()

	if Input.is_action_just_pressed("A") or Input.is_action_just_pressed("B"):
		var direction := -1 if beat.face_left else 1
		if not Input.get_axis("B", "A") == direction:
			accuracy(MISS)
		elif %Perfect.has_overlapping_areas():
			accuracy(PERFECT)
		elif %Solid.has_overlapping_areas():
			accuracy(SOLID)
		elif %Weak.has_overlapping_areas():
			accuracy(WEAK)
		else:
			accuracy(MISS)

		beat.get_parent().remove_child(beat)
		beat.queue_free()


func _on_miss_area_entered(area: Area2D) -> void:
	accuracy(MISS)
	area.get_parent().queue_free()


func accuracy(level: int) -> void:
	print(level)
	var new_text: Sprite2D = $AccuracyText.duplicate()
	add_child(new_text)
	new_text.frame = level
	new_text.show()

	var tw := get_tree().create_tween()

	tw.tween_property(new_text, "position:y", -30, 0.7).as_relative()
	tw.parallel().tween_property(new_text, "modulate:a", 0, 0.7)
	tw.finished.connect(
		func(): if new_text: new_text.queue_free()
	)

