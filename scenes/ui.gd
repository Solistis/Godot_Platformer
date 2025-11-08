# ui.gd

extends CanvasLayer  # (or Node, if UI is a plain Node)

@onready var coins_label: Label = %CoinsLabel
@onready var hearts_container: HBoxContainer = %HBoxContainer

func _ready() -> void:
	# Register this label with the autoload GameManager
	
	# COINS LABEL
	GameManager.register_label(coins_label)
	GameManager.on_level_entered()
	#
	
	# HEALTH
	HealthManager.register_hearts(hearts_container)
	#
