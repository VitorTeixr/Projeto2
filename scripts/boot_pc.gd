extends Control

@onready var icon = $TextureRect  # Supondo que o ícone seja um TextureRect
@onready var loading_bar = $ProgressBar  # Supondo que a barra de carregamento seja um TextureProgressBar
@onready var animation_player = $AnimationPlayer  # O AnimationPlayer que controla o ícone
@onready var timer = $Timer  # Supondo que você tenha um Timer na cena

var blink_duration = 3.1  # Tempo total para o ícone piscar (em segundos)
var loading_speed = 25  # Velocidade de carregamento da barra (quanto maior, mais rápido)
var loading_complete = false  # Flag para verificar se o carregamento foi concluído

func _ready():
	# Esconde a barra de carregamento inicialmente
	loading_bar.visible = false
	
	# Conecta o sinal para quando a animação do ícone terminar
	animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
	
	# Inicia a animação de piscar
	animation_player.play("blink")

func _on_animation_finished(anim_name):
	if anim_name == "blink":
		# Mostra a barra de carregamento após o piscar
		loading_bar.visible = true
		
		# Começa a carregar a barra
		loading_bar.value = 0  # Certifique-se de que o valor inicial seja 0
		set_process(true)  # Habilita o processamento para carregar a barra

func _process(delta):
	if loading_bar.visible and not loading_complete:
		loading_bar.value += loading_speed * delta
		print(loading_bar.value)
		
		if loading_bar.value >= loading_bar.max_value:
			# Define como completo para evitar processar mais vezes
			loading_complete = true
			loading_bar.value = loading_bar.max_value
			
			# Para o processamento e inicia o timer
			set_process(false)
			timer.start(2)  # Inicia o timer com 2 segundos
			timer.timeout.connect(Callable(self, "_on_timer_timeout"))

func _on_timer_timeout():
	# Quando o timer expira, troca de cena
	print("Carregamento concluído.")
	get_tree().change_scene_to_file("res://Interface/windows95.tscn")
