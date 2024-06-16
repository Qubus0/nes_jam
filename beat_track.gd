@tool
class_name BeatTrack
extends Node2D

signal music_started

@export var track_delay := 0.0
@export var track: AudioStream :
	set(new_track):
		track = new_track
		_update()


var track_time := .0
# points from the curve2d on the instrument
var beat_track_length := 144.014 # Vector2(9, 2).distance_to(Vector2(-133, 26))
var beat_speed := 50
var time_to_first_beat := beat_track_length / (beat_speed)

# https://docs.godotengine.org/en/stable/tutorials/audio/sync_with_audio.html
var _time_begin: int
var _time_delay: int

var _pause_begin := 0


func _update() -> void:
	if not Engine.is_editor_hint():
		return
	var preview := $AudioStreamPreview as AudioStreamPreview

	preview.stream_path = track.resource_path if track is AudioStreamWAV else ""
	preview._update_preview()
	($Rhythm.curve as Curve2D).set_point_position(1, Vector2(track.get_length() * 10, 0))
	($Music as AudioStreamPlayer).stream = track


func _ready() -> void:
	print(time_to_first_beat)
	if Engine.is_editor_hint():
		return

	_time_begin = Time.get_ticks_usec()
	_time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()

	position.y = 160 # debug

	#$Music.play()
	get_tree().create_timer(time_to_first_beat).timeout.connect(
		func():
			$Music.play()
			music_started.emit()
	)


var update := 0.0
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update += _delta
		if update < 1:
			return
		update = 0

		%Playhead.progress = (time_to_first_beat - track_delay) * 10
		$AudioStreamPreview.position.x = %Playhead.global_position.x
		for beat: Beat in get_tree().get_nodes_in_group(&"beat"):
			beat.progress = (time_to_first_beat + beat.time_sec) * 10
		return

	sync_time()
	global_position.x = -%Playhead.position.x + 30


func sync_time() -> void:
	if get_tree().paused:
		if _pause_begin <= 0:
			_pause_begin = Time.get_ticks_usec()
		return

	if _pause_begin > 0:
		_time_delay += (Time.get_ticks_usec() - _pause_begin) / 1_000_000.0
		_pause_begin = 0

	# Obtain from ticks.
	track_time = (Time.get_ticks_usec() - _time_begin) / 1_000_000.0
	# Compensate for latency.
	track_time -= _time_delay
	# May be below 0 (did not begin yet).
	track_time = max(0, track_time)

