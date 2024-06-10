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
var moving := false
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
	elif jumping and not Input.is_action_pressed(&"up") and min_jump_reached:
		velocity.y = 0

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis(&"left", &"right")
	if direction:
		velocity.x = direction * speed
		moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, friction if friction > 0 else speed)
		moving = false

	move_and_slide()


func _process(_delta: float) -> void:
	current_health = health.health
	animate()


func get_calculated_gravity() -> float:
	return jump_gravity if velocity.y < 0 else fall_gravity


func animate() -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

	if keep_animation:
		return

	if velocity.y < 0:
		if not sprite.animation == &"jump":
			sprite.play(&"jump")
	elif velocity.y > 0:
		sprite.play(&"fall")
	elif moving:
		sprite.play(&"walk")
	else:
		if Input.is_action_pressed(&"down"):
			sprite.play(&"duck")
		else:
			sprite.play(&"idle")


func _on_health_depleted() -> void:
	get_tree().reload_current_scene()


func _on_health_hurt() -> void:
	sprite.play(&"hurt")
	$Hurt.play()
	keep_animation = true


func _on_sprite_animation_finished() -> void:
	keep_animation = false


func _on_coyote_timer_timeout() -> void:
	has_coyote = false
