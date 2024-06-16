extends HSlider


@export var audio_bus_name := &"Master"
@export var sample: AudioStreamPlayer
@onready var _bus := AudioServer.get_bus_index(audio_bus_name)


func _ready() -> void:
	if sample:
		sample.bus = audio_bus_name
	#value = db_to_linear(AudioServer.get_bus_volume_db(_bus))
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))


func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(_bus, linear_to_db(new_value))

	sample.play()
