extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 200.0
const DASH_DURATION = 0.5
const DASH_COOLDOWN = 1.0
const ATTACK_DURATION = 0.6

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking = false
var can_dash = true
var is_dashing = false


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $hitbox  # Ensure this is an Area2D node

		
func jump():
	velocity.y = JUMP_VELOCITY

# ----------------------------------- movements ----------------------- #
func _physics_process(delta: float) -> void:
	
	# ---- KNOCKBACK MODE ----
	if is_knocked:
		# optional: add some horizontal damping while sliding back
		SoundManager.play_hurt()
		velocity.x = move_toward(velocity.x, 0.0, 1200.0 * delta)
		knock_time_left -= delta
		if knock_time_left <= 0.0:
			is_knocked = false
		move_and_slide()
		update_animation()
		return
	# ------------------------
	
	# Handle Dashing
	if is_dashing:
		move_and_slide()
		return
	
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SoundManager.play_jump()

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")

	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Horizontal Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Dash Input
	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash()

	# Apply Movement
	move_and_slide()
	
	# Play animations
	update_animation()

# Dash Function
func start_dash():
	is_dashing = true
	can_dash = false
	
	SoundManager.play_dash()
	
	
	velocity.x = DASH_SPEED * (1 if not animated_sprite.flip_h else -1)
	animated_sprite.play("dash")  # Ensure you have a "dash" animation
	await(get_tree().create_timer(DASH_DURATION).timeout)
	is_dashing = false
	velocity.x = 0
	await(get_tree().create_timer(DASH_COOLDOWN).timeout)
	can_dash = true

# ---------------------------- animation --------------------- #
func update_animation():
	# Play animations
	if is_attacking:
		animated_sprite.play("attack")
	elif is_on_floor():
		if velocity.x == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("walking")
	else:
		animated_sprite.play("jumping")
# ----------------------------------------------- #

func _on_resume_pressed() -> void:
	pass # Replace with function body.

# **************************************************** #
var step_frames := [1, 4]        # pick 2 frames in the 0..5 cycle

func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite.animation == "walking" and is_on_floor() and abs(velocity.x) > 0.1:
		if step_frames.has(animated_sprite.frame):
			SoundManager.play_random_step()
# ************************************************************************** #


# ***************************** Knock back effect ********************* #

const KNOCKBACK_X := 600.0   # push harder left/right
const KNOCK_DURATION := 0.40 # seconds

var is_knocked := false
var knock_time_left := 0.0

func apply_knockback(from_pos: Vector2, duration: float = KNOCK_DURATION) -> void:
	if is_knocked:
		return
	is_knocked = true
	knock_time_left = duration

	var dir: int = sign(global_position.x - from_pos.x)  # push away from hitter
	if dir == 0: dir = 1

	velocity.x = dir * KNOCKBACK_X
	# no vertical pop: leave velocity.y as-is
	
# ************************************************************************** #
