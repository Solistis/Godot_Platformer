extends Node

func _ready() -> void:
	# Play the main menu sound as soon as the scene loads
	SoundManager.play_main_menu_music()
	
func _on_button_pressed() -> void:
	SoundManager.stop_main_menu_music()
	get_tree().change_scene_to_file("res://scenes/BossLeadUp.tscn")
