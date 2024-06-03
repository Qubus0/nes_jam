extends CharacterBody2D


const SPEED := 100.0
const JUMP_VELOCITY := -300.0

var keep_animation := 0

@onready var sprite := $Sprite


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _process(_delta: float) -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

	if keep_animation > 0:
		return

	# choose animations
	if velocity.y < 0:
		if not sprite.animation == &"jump":
			sprite.play(&"jump")
	elif velocity.y > 0:
		sprite.play(&"fall")
	elif velocity.x != 0:
		sprite.play(&"walk")
	else:
		if Input.is_action_pressed("down"):
			sprite.play(&"duck")
		else:
			sprite.play(&"idle")


func _on_health_depleted() -> void:
	get_tree().reload_current_scene()


func _on_health_hurt() -> void:
	sprite.play("hurt")
	keep_animation = 3


func _on_sprite_animation_finished() -> void:
	keep_animation -= 1

func _on_sprite_animation_looped() -> void:
	keep_animation -= 1
