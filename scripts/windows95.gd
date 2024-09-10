extends Control

var click_count = 0
var double_click_time = 0.5  # Tempo máximo permitido entre cliques (em segundos)
var timer = 0.0
var scene_changed = false

@onready var janela = $Panel2
@onready var timer1 = $Timer
@onready var click_sound = $Click

@onready var janela_primaria = $ListaPopup
@onready var janela_lista = $ListaPopup/Conteudo
@onready var close_button = $ListaPopup/TextureButton  # Botão de fechar dentro do Panel

@onready var animation_player = $AnimationPlayer
@onready var ui_elements = [$Panel/Start, $ligacao, $Lista, $Jogo, $"Panel/Time Panel/Time"]  # Elementos que ficarão invisíveis

func _ready():
	# Conectando o sinal "pressed" do botão de fechar ao método hide_panel
	close_button.pressed.connect(hide_panel)
	instantiate_scene_in_panel()
	

	MusicManager.boot_play_sound()
	MusicManager.play_pc_sound()

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

func _on_timer_timeout():
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

func _process(delta):
	if click_count > 0:
		timer += delta
		if timer > double_click_time:
			# Tempo excedido, resetar
			click_count = 0
			timer = 0.0

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
	get_tree().change_scene_to_file("res://Interface/tela_gameplay.tscn")

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
	# Ação desejada ao clicar duas vezes rapidamente
	janela_primaria.visible = true

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
func instantiate_scene_in_panel():
	var scene_to_instance = preload("res://Interface/lista.tscn")  # Carrega a cena que será instanciada
	var instance = scene_to_instance.instantiate()  # Instancia a cena

	# Adiciona a cena dentro do Panel
	janela_lista.add_child(instance)
	
