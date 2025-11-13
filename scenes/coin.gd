extends Area2D

# sounds
@onready var pick_up_player = $PickUpPlayer

# when MC character's body go into coin
func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		$AnimatedSprite2D.visible = false # Hide the coin
		pick_up_player.play()
		await pick_up_player.finished
		queue_free() # Delete the coin
		GameManager.add_coins()
