# mushy.gd

extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound_player = $DeathSoundFx  # AudioStreamPlayer2D node

func die():
	death_sound_player.play()
	await death_sound_player.finished
	queue_free()

# When player touch the top of the mushy
func _on_kill_mushy_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		print("Hit from above")
		animated_sprite.play("hit")
		die()
		body.jump() # make character bounce


# When player touch the side of the mushy
func _on_damage_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		print("Hit from the side")
		#animated_sprite.play("hit")
		HealthManager.lose_one_heart()
		(body as CharacterBody2D).apply_knockback(global_position)  # or call_deferred(...)
