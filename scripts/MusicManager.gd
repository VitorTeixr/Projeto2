extends Node

var music_player : AudioStreamPlayer
var current_music: AudioStream = null

func _ready() -> void:
	# Cria e adiciona o AudioStreamPlayer à cena
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	# Carrega e toca a primeira música dinamicamente

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
