extends CanvasLayer  # (or Node, if UI is a plain Node)

@onready var coins_label: Label = %CoinsLabel

func _ready() -> void:
	# Register this label with the autoload GameManager
	GameManager.register_label(coins_label)
