extends Node

var music_player : AudioStreamPlayer
var current_music: AudioStream = preload("res://soundtrack/Music/Theme.mp3")

var boot_sound: AudioStream = preload("res://soundtrack/Music/boot-sound-noise_eavdfikv.mp3")  # Substitua pelo caminho correto do arquivo de som

var click_sound: AudioStream = preload("res://soundtrack/SFX/Click - Sound Effect (HD).mp3")

var pc_sound: AudioStream = preload("res://soundtrack/Music/pc_sound.mp3")
var pc_player: AudioStreamPlayer

var ring_sound: AudioStream = preload("res://soundtrack/SFX/ringtone.mp3")
var ring_player = AudioStreamPlayer.new()

var dial_up_sound: AudioStream = preload("res://soundtrack/SFX/Dial Up Internet - Sound Effect (HD).mp3")
var dial_player = AudioStreamPlayer.new()

var radio_sound: AudioStream = preload("res://soundtrack/SFX/Radio Tuning sound effect.mp3")
var radio_player = AudioStreamPlayer.new()





func _ready() -> void:
	# Cria e adiciona o AudioStreamPlayer à cena
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	

# Função para carregar e tocar a música dinamicamente
func play_music(music_path: String) -> void:
	if not music_player.playing:  # Só toca se não estiver tocando
		var music_stream = load(music_path)
		if music_stream and music_stream is AudioStream:
			current_music = music_stream
			music_player.stream = current_music
			music_player.play()
			music_player.bus = "Music"

func stop_music() -> void:
	if music_player.playing:
		music_player.stop()

# Caso queira mudar a música durante o jogo
func change_music(new_music_path: String) -> void:
	stop_music()  # Para a música atual
	play_music(new_music_path)  # Carrega e toca a nova música
	

func play_click_sound():
	var click_player = AudioStreamPlayer.new()
	click_player.stream = click_sound
	add_child(click_player)  # Adiciona o player na cena atual
	click_player.play()
	click_player.bus = "SFX"
	
func boot_play_sound():
	var boot_player = AudioStreamPlayer.new()
	boot_player.stream = boot_sound
	add_child(boot_player)  # Adiciona o player na cena atual
	boot_player.bus = "Music"
	
	# Verifica se é a primeira vez que a cena foi carregada
	if Global.first_boot == true:
		boot_player.play()  # Toca o som
		Global.first_boot = false  # Marca como não sendo a primeira vez
	
func play_pc_sound():
	if not pc_player:
		pc_player = AudioStreamPlayer.new()
		add_child(pc_player)
		pc_player.stream = pc_sound
		pc_player.bus = "Music"
		
		# Configura o som para tocar em loop
		if pc_player.stream is AudioStream:
			var audio_stream = pc_player.stream as AudioStream
			audio_stream.loop = true  # Define o loop na stream
		
		pc_player.play()
		

func stop_pc_sound():
	if pc_player.playing:
		pc_player.stop()
		

func play_ring_sound():
	ring_player.stream = ring_sound
	add_child(ring_player)  # Adiciona o player na cena atual
	ring_player.bus = "SFX"
	
	if ring_player.stream is AudioStream:
			var audio_stream = ring_player.stream as AudioStream
			audio_stream.loop = true 
	
	ring_player.play()
	
func stop_ring_sound():
	if ring_player.playing:
		ring_player.stop()
		
func dial_sound():
	dial_player.stream = dial_up_sound
	add_child(dial_player)  # Adiciona o player na cena atual
	dial_player.bus = "SFX"
	dial_player.play()
	
func stop_dial_sound():
	if dial_player.playing:
		dial_player.stop()
		
func play_radio_sound():
	radio_player.stream = radio_sound
	add_child(radio_player)  # Adiciona o player na cena atual
	radio_player.bus = "SFX"
	radio_player.play()
	
func stop_radio_sound():
	if radio_player.playing:
		radio_player.stop()
	
	
