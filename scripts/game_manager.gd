extends Node

@onready var coins_label: Label = %CoinsLabel

var coins = 0

func add_coins():
	coins += 1
	print(coins)
	coins_label.text = "Coins: " + str(coins)
