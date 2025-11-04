extends CharacterBody2D

const SPEED = 60
var direction = 1

var is_dead = false

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $hitbox

#var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if !is_dead:
		if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = false
		elif ray_cast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = true
		
		# Move the enemy
		velocity.x = direction * SPEED
		move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var y_delta = body.position.y - position.y
		if y_delta > 0:  # Player is above the enemy
			is_dead = true
			animated_sprite.play("hit")  # Optional hit animation
			queue_free()  # Remove the enemy
			body.velocity.y = -300  # Make the player bounce after hitting enemy
		else:
			# Decrease player health or trigger death
			body.queue_free()
