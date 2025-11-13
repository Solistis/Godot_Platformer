# SoundManager.gd
extends Node

# ************** RANDOM GENERATOR TO PICK VARIETY OF SOUND ************ #
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
# ********************************************************************* #

@onready var girl_scream_player = $GirlScreamPlayer
@onready var coin_pickup_player = $CoinPickUpPlayer
@onready var mc_hurt_player = $HurtPlayer
@onready var mc_dash_player = $DashSoundPlayer
@onready var mushy_death_player = $MushyDeathPlayer
@onready var main_menu_player = $MainMenuPlayer




func play_girl_scream() -> void:
	girl_scream_player.play()
	
func play_coin_pickup() -> void:
	coin_pickup_player.play()
	
func play_hurt() -> void:
	mc_hurt_player.play()
	
func play_mushy_death() -> AudioStreamPlayer:
	mushy_death_player.play()
	return mushy_death_player
	
func play_dash() -> AudioStreamPlayer:
	mc_dash_player.play()
	return mc_dash_player
	
func play_main_menu_music() -> void:
	main_menu_player.play()
	
func stop_main_menu_music() -> void:
	main_menu_player.stop()
	
# ***************************** JUMPING SOUND FX ************************ #
@onready var jump_player = $JumpPlayer  # AudioStreamPlayer2D node
var jump_sounds := [
	preload("res://assets/sounds/jump/ESM_GCBFD_vocals_female_jump_struggled_hop.wav"),
]

func play_jump() -> void:
	# make it quieter
	jump_player.volume_db = -12.0
	jump_player.pitch_scale = rng.randf_range(0.96, 1.04)
	jump_player.stream = jump_sounds[0] # or randomize if you add more
	jump_player.play()
# ************************************************************************** #
	
# ***************************** WALKING SOUND FX ************************ #
@onready var footstep_player = $FootstepPlayer  # AudioStreamPlayer2D node

var footsteps = [
	preload("res://assets/sounds/footsteps/footstep1.wav"),
	preload("res://assets/sounds/footsteps/footstep2.wav"),
	preload("res://assets/sounds/footsteps/footstep3.wav"),
	preload("res://assets/sounds/footsteps/footstep4.wav"),
	preload("res://assets/sounds/footsteps/footstep5.wav"),	
]
		
func play_random_step() -> void:
	# small pitch variance keeps it from sounding repetitive
	footstep_player.pitch_scale = rng.randf_range(0.95, 1.05)
	footstep_player.stream = footsteps[rng.randi_range(0, footsteps.size() - 1)]
	footstep_player.play()
