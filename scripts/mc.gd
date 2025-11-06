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
		_play_jump()

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

# ***************************** WALKING SOUND FX ************************ #
@onready var footstep_player = $FootstepPlayer  # AudioStreamPlayer2D node

var footsteps = [
	preload("res://assets/sounds/footsteps/footstep1.wav"),
	preload("res://assets/sounds/footsteps/footstep2.wav"),
	preload("res://assets/sounds/footsteps/footstep3.wav"),
	preload("res://assets/sounds/footsteps/footstep4.wav"),
	preload("res://assets/sounds/footsteps/footstep5.wav"),	
]

func play_footstep():
	if not footstep_player.playing:
		footstep_player.play()
		
var step_frames := [1, 4]        # pick 2 frames in the 0..5 cycle
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	# Make sure FootstepPlayer stream DOES NOT loop in the Inspector.

func _play_random_step() -> void:
	# small pitch variance keeps it from sounding repetitive
	footstep_player.pitch_scale = rng.randf_range(0.95, 1.05)
	footstep_player.stream = footsteps[rng.randi_range(0, footsteps.size() - 1)]
	footstep_player.play()

# **************************************************** #
func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite.animation == "walking" and is_on_floor() and abs(velocity.x) > 0.1:
		if step_frames.has(animated_sprite.frame):
			_play_random_step()
# ************************************************************************** #

# ***************************** JUMPING SOUND FX ************************ #
@onready var jump_player = $JumpPlayer  # AudioStreamPlayer2D node
var jump_sounds := [
	preload("res://assets/sounds/jump/ESM_GCBFD_vocals_female_jump_struggled_hop.wav"),
]

func _play_jump() -> void:
	# make it quieter
	jump_player.volume_db = -12.0
	jump_player.pitch_scale = rng.randf_range(0.96, 1.04)
	jump_player.stream = jump_sounds[0] # or randomize if you add more
	jump_player.play()
# ************************************************************************** #
