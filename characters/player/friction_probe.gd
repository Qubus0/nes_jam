extends RayCast2D


@export var tile_map: TileMapLayer
@export var player: Player


func _physics_process(delta: float) -> void:
	if is_colliding():
		player.friction = get_friction()


func get_friction() -> int:
	var position := tile_map.to_local(get_collision_point() + Vector2(0, 0.2))
	return int(get_custom_data_at(position, "friction"))


func get_custom_data_at(position: Vector2, custom_data_name: String) -> Variant:
	var data = get_tile_data_at(position)
	return data.get_custom_data(custom_data_name)


func get_tile_data_at(position: Vector2) -> TileData:
	var local_position: Vector2 = tile_map.local_to_map(position)
	return tile_map.get_cell_tile_data(local_position)

