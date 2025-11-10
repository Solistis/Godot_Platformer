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

func _on_damage_hitbox_body_entered(body): print("DMG enter:", body)

#func _on_damage_hitbox_body_entered(body: Node2D) -> void:
	##pass
	#if body.name == "CharacterBody2D":
		#print("Player touched DamageHitbox!")
		#body.jump()
		#HealthManager.lose_one_heart()


#func _on_kill_mushy_body_entered(body: Node2D) -> void:
	##pass # Replace with function body.
	#if body.name == "CharacterBody2D":
		#print("Hit from above")
		#animated_sprite.play("hit")
		#queue_free()
		#body.jump() # make character bounce
