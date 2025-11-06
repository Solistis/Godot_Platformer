extends Node

var coins: int = 0 # current coins
var level_start_coins: int = 0 # amount of coins begin in each level
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
		
func on_level_entered() -> void:
	# Call this when a level loads
	level_start_coins = coins
	
func reset_to_level_start() -> void:
	coins = level_start_coins
	_update_label()
