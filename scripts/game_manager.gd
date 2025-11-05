extends Node

var coins: int = 0
var coins_label: Label = null  # will be registered by the scene that has it

func register_label(label: Label) -> void:
	coins_label = label
	_update_label()

func add_coins(amount: int = 1) -> void:
	coins += amount
	_update_label()
	print(coins)

func _update_label() -> void:
	if coins_label:
		coins_label.text = "Coins: " + str(coins)
