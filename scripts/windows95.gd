extends Control

var click_count = 0
var double_click_time = 0.5  # Tempo máximo permitido entre cliques (em segundos)
var timer = 0.0
var scene_changed = false
var lista_on = false

var scene_to_instance = preload("res://Interface/tela_gameplay.tscn")  # Carrega a cena que será instanciada
var instance = scene_to_instance.instantiate()

@onready var janela = $Panel2
@onready var timer1 = $Timer
@onready var timer2 = $Timer2
@onready var click_sound = $Click

@onready var janela_primaria = $ListaPopup
@onready var janela_lista = $ListaPopup/Conteudo
@onready var close_button = $ListaPopup/TextureButton  # Botão de fechar dentro do Panel

@onready var animation_player = $AnimationPlayer
@onready var ui_elements = [$Panel/Start, $ligacao, $Lista, $Jogo,$"Panel/Time Panel/Time"]  # Elementos que ficarão invisíveis

@onready var label_em_espera = $"Texto_explicação/ScrollContainer/VBoxContainer/Label"  # O Label onde o texto vai aparecer
@onready var controla_caracter = $Timer3  # Um Timer que controla a velocidade de exibição do texto

var texto_completo = "ASKJDKABSDKAS"
var indice_caractere = 0  # Para controlar o caractere atual

func _ready():
	
	#Instancia a cena
	instantiate_scene_in_panel(instance)
	#Fecha a cena
	close_button.pressed.connect(hide_panel)
	
	if instance.has_method("get_pergunta_text"):
		texto_completo = instance.get_pergunta_text()
		

	
	label_em_espera.text = ""  # Começa com o Label vazio
	controla_caracter.wait_time = 0.05  # Define o intervalo de tempo entre os caracteres (em segundos)
	controla_caracter.timeout.connect(_on_controla_caracter_timeout)

	#Som do inicio e de fundo
	MusicManager.boot_play_sound()
	MusicManager.play_pc_sound()

	#Sistema de fim de dia
	if Global.trys == 2:
		Global.dia_atual += 1
		janela.visible = true
		timer1.start(2)  # Inicia o timer com 2 segundos
		timer1.timeout.connect(Callable(self, "_on_timer_timeout"))


	for element in ui_elements:
		element.visible = false

	# Verifica se é a primeira vez que a cena foi carregada
	if Global.first_boot_animation:
		play_intro_animation()
		Global.first_boot_animation = false  # Marca como não sendo a primeira vez
	else:
		# Torna os ícones visíveis imediatamente se a animação já foi executada
		for element in ui_elements:
			element.visible = true
			
			
	
			
func _process(delta):
	if click_count > 0:
		timer += delta
		if timer > double_click_time:
			# Tempo excedido, resetar
			click_count = 0
			timer = 0.0
			
	
func _on_timer_timeout():
	# Sistema de fim de dia
	# Quando o timer expira, troca de cena
	if not scene_changed:
		scene_changed = true
		Transition.transition()
		await Transition.on_transition_finished
		MusicManager.stop_pc_sound()
		get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn")

		Global.trys = 0
		Global.first_boot = true
		Global.first_boot_animation = true


			
func _on_ligacao_pressed():
	click_count += 1
	if click_count == 1:
		# Primeiro clique, iniciar o temporizador
		timer = 0.0
	elif click_count == 2:
		# Segundo clique dentro do tempo permitido
		if timer <= double_click_time:
			_on_double_click()
		# Resetar para o próximo conjunto de cliques
		click_count = 0
		timer = 0.0

func _on_double_click():
	# Ação desejada ao clicar duas vezes rapidamente
	$Internet.visible = true
	
	pass

func _on_lista_pressed():
	click_count += 1
	if click_count == 1:
		# Primeiro clique, iniciar o temporizador
		timer = 0.0
	elif click_count == 2:
		# Segundo clique dentro do tempo permitido
		if timer <= double_click_time:
			_on_double_click1()
		# Resetar para o próximo conjunto de cliques
		click_count = 0
		timer = 0.0

func _on_double_click1():
	pass
	# Ação desejada ao clicar duas vezes rapidamente
	

func _input(event):
	# Verifica se o evento é um clique do botão esquerdo do mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Reproduz o som de clique
		MusicManager.play_click_sound()

func play_intro_animation():
	# Torna os ícones visíveis após 1.5 segundos (via animação)
	animation_player.play("startboot")  # Supondo que a animação seja chamada 'startboot'

func hide_panel():
	print("Fechando janela...")
	janela_primaria.visible = false  # Esconde o Panel (você também pode usar janela_lista.hide())

# Função para instanciar e adicionar a cena dentro do Panel
func instantiate_scene_in_panel(instance):
	# Adiciona a cena dentro do Panel
	janela_lista.add_child(instance)
	
	
func _on_ligar_internet_pressed() -> void:
	
	MusicManager.dial_sound()
	$Internet/Label2.visible = true
	animation_player.play("connect_internet")
	await animation_player.animation_finished
	
	MusicManager.stop_dial_sound()
	$Internet.visible = false
	timer2.start(5)
	
	pass # Replace with function body.
	
func _on_timer_2_timeout() -> void:
	ligacao_ativa()
	timer2.stop()
	print("timer terminou")
	pass # Replace with function body.
	
	
func ligacao_ativa():
	$Atender.visible = true
	MusicManager.play_ring_sound()
	pass


func _on_button_atender_pressed() -> void:
	$Atender.visible = false
	MusicManager.stop_ring_sound()
	$"Texto_explicação".visible = true
	controla_caracter.start()


func _on_controla_caracter_timeout() -> void:
	if indice_caractere < texto_completo.length():
		# Adiciona o próximo caractere ao Label
		label_em_espera.text += texto_completo[indice_caractere]
		indice_caractere += 1
	else:
		# Para o timer quando todos os caracteres já foram exibidos
		controla_caracter.stop()
		
func _on_button_em_espera_pressed() -> void:
	janela_primaria.visible = true
	$"Texto_explicação".visible = false
	instance.call("_get_text_to_tela_gameplay")
	pass # Replace with function body.
	
