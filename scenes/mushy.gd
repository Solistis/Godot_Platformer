# mushy.gd

extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

#func _on_area_2d_body_entered(body):
	#if (body.name == "CharacterBody2D"):
		#
		## body is the character body
		#var y_delta = position.y - body.position.y
		#print(y_delta)
		#
		## jump on top
		#if (y_delta > -30):
			#print("Hit from above")
			#animated_sprite.play("hit")
			#queue_free()
			#body.jump() # make character bounce
			#


# When player touch the top of the mushy
func _on_kill_mushy_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		print("Hit from above")
		animated_sprite.play("hit")
		queue_free()
		body.jump() # make character bounce


# When player touch the side of the mushy
func _on_damage_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		print("Hit from the side")
		#animated_sprite.play("hit")
		HealthManager.lose_one_heart()
		(body as CharacterBody2D).apply_knockback(global_position)  # or call_deferred(...)
