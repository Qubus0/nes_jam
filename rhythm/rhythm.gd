extends Control

signal beat_hit(accuracy: int)

@export var track: BeatTrack

enum {
	PERFECT,
	SOLID,
	WEAK,
	MISS,
	WRONG
}

@onready var valid := %ValidArea
@onready var playhead: PathFollow2D = track.get_node("%Playhead")
var playhead_area: Area2D
var playhead_offset := 0.0


func _ready() -> void:
	playhead_area = playhead.get_node("Area")
	playhead_area.area_entered.connect(playhead_entered)
	playhead_offset = playhead.progress


func _process(_delta: float) -> void:
	playhead.progress = playhead_offset + track.track_time * 10
	handle_input()


#func play_track(track_name: String) -> void:
	#if playhead_area and playhead_area.area_entered.is_connected(playhead_entered):
		#playhead_area.area_entered.disconnect(playhead_entered)
#
	#playhead = get_node("%" + track_name + "Playhead")
	#playhead.progress_ratio = 0
	#playhead_area = playhead.get_node("Area")
	#playhead_area.area_entered.connect(playhead_entered)


func playhead_entered(area: Area2D) -> void:
	var beat := area.get_parent()
	var new_beat: Beat = beat.duplicate()

	await get_tree().process_frame # gets rid of the error
	%Track.add_child(new_beat)
	new_beat.speed = track.beat_speed
	new_beat.progress_ratio = 0


func handle_input() -> void:
	if valid.get_overlapping_areas().is_empty():
		return

	var detected_area: Area2D = valid.get_overlapping_areas().front()
	#var detected_area := %Track.get_child(0)

	if not detected_area:
		return
	var beat: Beat = detected_area.get_parent()

	if Input.is_action_just_pressed("A") or Input.is_action_just_pressed("B"):
		var direction := -1 if beat.face_left else 1
		if not Input.get_axis("B", "A") == direction:
			show_accuracy(WRONG)
		elif %Perfect.has_overlapping_areas():
			show_accuracy(PERFECT)
			beat_hit.emit(PERFECT)
		elif %Solid.has_overlapping_areas():
			show_accuracy(SOLID)
			beat_hit.emit(SOLID)
		elif %Weak.has_overlapping_areas():
			show_accuracy(WEAK)
			beat_hit.emit(WEAK)
		else:
			show_accuracy(MISS)

		beat.get_parent().remove_child(beat)
		beat.queue_free()



func _on_miss_area_entered(area: Area2D) -> void:
	show_accuracy(MISS)
	area.get_parent().queue_free()


func show_accuracy(accuracy: int) -> void:
	var new_text: Sprite2D = $AccuracyText.duplicate()
	add_child(new_text)
	new_text.frame_coords.y = accuracy
	new_text.show()

	match accuracy:
		PERFECT:
			$PerfectSparks.play(&"default")
			$BeatPerfect.play()
		WRONG, MISS:
			$BeatWrong.play()
		_:
			$BeatHit.play()

	$BeatSparks.play(&"default")

	var tw := get_tree().create_tween()
	tw.parallel().tween_property(new_text, "frame_coords:x", 4, 0.5	)
	tw.finished.connect(
		func(): if new_text: new_text.queue_free()
	)

