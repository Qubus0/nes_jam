extends CharacterBody2D

const SPEED = 115
var direction = 1
var is_diving = false

var can_shoot = true
var projectile = preload("res://characters/lemon/lemon_projectile.tscn")

@onready var player: CharacterBody2D = $"../Player"

@onready var player_scan: ShapeCast2D = $PlayerScan
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

@onready var turret_ray_1: RayCast2D = $TurretRay1
@onready var turret_ray_2: RayCast2D = $TurretRay2
@onready var turret_ray_3: RayCast2D = $TurretRay3
@onready var turret_ray_4: RayCast2D = $TurretRay4

@onready var sub_dive_area: RayCast2D = $"../SubDiveArea"


@onready var turret_left: AnimatedSprite2D = $TurretLeft/AnimatedSprite2D
@onready var turret_right: AnimatedSprite2D = $TurretRight/AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_right.is_colliding():
		direction = -1
	
	if turret_ray_1.is_colliding():
		turret_left.frame = 1
		turret_right.frame = 1
	if turret_ray_4.is_colliding():
		turret_left.frame = 2
		turret_right.frame = 2
	if turret_ray_2.is_colliding() || turret_ray_3.is_colliding():
		turret_left.frame = 0
		turret_right.frame = 0
	position.x -= direction * SPEED * delta
	if sub_dive_area.is_colliding():
		is_diving = true
	if is_diving == true:
		can_shoot = false
		position.y += 30 * delta
	Shoot()

func Shoot():
	if can_shoot == true:
		can_shoot = false
		var projectile_instance = projectile.instantiate()
		var projectile_instance2 = projectile.instantiate()
		get_parent().add_child(projectile_instance)
		get_parent().add_child(projectile_instance2)
		projectile_instance.transform = $LeftTurretMarker.global_transform
		projectile_instance2.transform = $RightTurretMarker.global_transform
		if player_scan.is_colliding():
			var dir_left
			var dir_right
			var first_value = bool(randi() % 2)
			var second_value = bool(randi() % 2)
			if first_value == true:
				dir_left = (player.global_position - $LeftTurretMarker.global_position).normalized()
			elif first_value == false:
				dir_left = ($"../Player/PredictiveAim".global_position - $LeftTurretMarker.global_position).normalized()
			if second_value == true:
				dir_right = (player.global_position - $RightTurretMarker.global_position).normalized()
			elif second_value == false:
				dir_right = ($"../Player/PredictiveAim".global_position - $RightTurretMarker.global_position).normalized()
			projectile_instance.projectile_direction = dir_left
			projectile_instance2.projectile_direction = dir_right
			$ShootSound.play()
		await get_tree().create_timer(3).timeout
		can_shoot = true
