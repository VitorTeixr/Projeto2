extends Node

var music_player : AudioStreamPlayer
var current_music: AudioStream = null

var boot_sound: AudioStream = preload("res://soundtrack/SFX/Microsoft Windows 95 Startup Sound.mp3")  # Substitua pelo caminho correto do arquivo de som

var click_sound: AudioStream = preload("res://soundtrack/SFX/Click - Sound Effect (HD).mp3")

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
	
