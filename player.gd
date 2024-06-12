class_name Player
extends CharacterBody2D

@export_group("Jump")
@export var jump_height := 50.0
@export var jump_height_min := 35.0
@export var jump_rise_time := .3
@export var jump_fall_time := .3
@export var jump_coyote_time := .1

@export_group("Movement")
@export var speed := 110.0
@export var friction := -1.0
@export var min_slope_angle_degrees := 90
@export var max_slope_acceleration := 500

@export_group("Components")
@export var health: Health
@export var sprite: AnimatedSprite2D
@export var coyote_timer: Timer

@onready var jump_velocity := ((2.0 * jump_height) / jump_rise_time) * -1.0
@onready var max_fall_velocity := ((2.0 * jump_height) / jump_fall_time)
@onready var jump_gravity := ((-2.0 * jump_height) / (jump_rise_time * jump_rise_time)) * -1.0
@onready var fall_gravity := ((-2.0 * jump_height) / (jump_fall_time * jump_fall_time)) * -1.0

var keep_animation := false
var has_coyote := false
var start_height := 0.0
var current_health := 0


func _physics_process(delta: float) -> void:
	if is_on_floor():
		has_coyote = true
	else:
		velocity.y += clamp(get_calculated_gravity() * delta, 0 , max_fall_velocity)
		if coyote_timer.is_stopped() and has_coyote:
			coyote_timer.start(jump_coyote_time)

	var jumping := velocity.y < 0
	var min_jump_reached := start_height - position.y >= jump_height_min

	if Input.is_action_just_pressed(&"up") and (is_on_floor() or has_coyote):
		velocity.y = jump_velocity
		$Jump.play()
		start_height = position.y
	if Input.is_action_just_pressed(&"right") and is_on_wall_only():
		velocity.y = jump_velocity
		velocity.x = 30
		$Jump.play()
		start_height = position.y
	if Input.is_action_just_pressed(&"left") and is_on_wall_only():
		velocity.y = jump_velocity
		velocity.x = -30
		$Jump.play()
		start_height = position.y
	elif jumping and not Input.is_action_pressed(&"up") and min_jump_reached:
		velocity.y = 0

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis(&"left", &"right")
	if direction:
		velocity.x = direction * clampf(absf(velocity.x), speed, absf(velocity.x))
	else:
		var fric := friction * delta if friction > 0 else speed
		velocity.x = move_toward(velocity.x, 0, fric)

	# sliding down slopes
	var floor_angle := rad_to_deg(get_floor_normal().angle_to(Vector2.UP))
	var can_slide: bool = min_slope_angle_degrees <= absf(floor_angle)
	if is_on_floor() and can_slide:
		apply_slope_slide(get_floor_normal(), signf(floor_angle), delta)

	move_and_slide()


func apply_slope_slide(floor_normal: Vector2, direction: float, delta: float) -> void:
	# get the direction to slide in
	var slide_direction := floor_normal.orthogonal().normalized() * direction
	var slide_force := slide_direction * max_slope_acceleration * delta
	# scale the force so that steeper slope will have more force
	slide_force *= absf(slide_direction.y)
	velocity += slide_force


func _process(_delta: float) -> void:
	current_health = health.health
	animate()


func get_calculated_gravity() -> float:
	return jump_gravity if velocity.y < 0 else fall_gravity


func animate() -> void:
	var is_moving := not is_zero_approx(velocity.x)
	if is_moving:
		sprite.flip_h = velocity.x < 0

	# keep playing the hurt anim no matter what
	if keep_animation:
		return

	var is_falling := velocity.y > 0
	var is_rising := velocity.y < 0
	var is_controlled_movement := Input.get_axis(&"left", &"right")

	if is_rising:
		# only start the animation once, to get the charge up
		if not sprite.animation == &"jump":
			sprite.play(&"jump")
	elif is_falling:
		if is_on_floor() or has_coyote:
			sprite.play(&"slide")
		else:
			sprite.play(&"fall")
	elif is_controlled_movement:
		sprite.play(&"walk")
	elif is_moving:
		sprite.play(&"slide")
	else:
		if Input.is_action_pressed(&"down"):
			sprite.play(&"duck")
		else:
			sprite.play(&"idle")


func _on_health_depleted() -> void:
	Global.game_over()


func _on_health_hurt() -> void:
	sprite.play(&"hurt")
	$Hurt.play()
	keep_animation = true


func _on_sprite_animation_finished() -> void:
	keep_animation = false


func _on_coyote_timer_timeout() -> void:
	has_coyote = false
