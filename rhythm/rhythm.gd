extends Control

var beat_speed := 40

const BEAT = preload("res://rhythm/beat.tscn")

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

	$Track.add_child(new_beat)
	new_beat.speed = beat_speed
	new_beat.progress_ratio = 0


func handle_input() -> void:
	if not valid.has_overlapping_areas():
		return

	var detected_area: Area2D = valid.get_overlapping_areas().front()
	if not detected_area:
		return
	var beat: Beat = detected_area.get_parent()

	$Label.text = ""
	if Input.is_action_just_pressed("A") or Input.is_action_just_pressed("B"):
		var direction := -1 if beat.face_left else 1
		if not Input.get_axis("B", "A") == direction:
			$Label.text = "miss!"
			return

		if %Perfect.has_overlapping_areas():
			$Label.text = "Perfect!"
		elif %Solid.has_overlapping_areas():
			$Label.text = "solid"
		elif %Weak.has_overlapping_areas():
			$Label.text = "weak"
		else:
			$Label.text = "miss!"


func _on_miss_area_entered(area: Area2D) -> void:
	$Label.text = "miss!"
	area.get_parent().queue_free()
