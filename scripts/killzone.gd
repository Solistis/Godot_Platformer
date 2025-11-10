# killzone.gd

extends Area2D

@onready var timer: Timer = $Timer



func _on_body_entered(body: Node2D) -> void:
	print("You Died!")
	Engine.time_scale = 0.5
	
	# coins
	GameManager.reset_to_level_start()
	GameManager._update_label() 
	#
	
	# Health
	HealthManager.lose_one_heart()
	#
	
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
