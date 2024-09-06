extends Node

@onready var music_player = AudioStreamPlayer.new()  # Cria um novo AudioStreamPlayer
var is_playing = false
var music_disabled = false  # Controla se a música está desativada ou não

func _ready():
	if not music_player:  # Garante que o AudioStreamPlayer seja inicializado
		music_player = AudioStreamPlayer.new()
		add_child(music_player)  # Adiciona o player à cena
		music_player.stream = preload("res://soundtrack/Musica.mp3")  # Defina o arquivo de música corretamente

	if not music_disabled and not is_playing:
		play_music()

func play_music():
	if not music_disabled and not is_playing:
		music_player.play()  # Toca a música
		is_playing = true
		print("Música tocando...")

func stop_music():
	if is_playing:
		music_player.stop()  # Para a música
		is_playing = false
		print("Música parada.")
