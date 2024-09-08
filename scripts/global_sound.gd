extends Node

var click_sound

func _ready():
	click_sound = preload("res://soundtrack/SFX/Click - Sound Effect (HD).mp3")

func play_click_sound():
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = click_sound
	audio_player.play()
	
