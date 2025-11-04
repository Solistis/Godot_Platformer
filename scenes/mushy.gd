extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		print(y_delta)
		if (y_delta > -30):
			animated_sprite.play("hit")
			queue_free()
			body.jump()
		else:
			print("Decrease player health")
			body.queue_free()
			get_tree().reload_current_scene()
