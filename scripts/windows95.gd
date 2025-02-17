extends Control

# Variáveis de controle
var click_count = 0
var double_click_time = 0.5  # Tempo máximo entre cliques para considerar um duplo clique
var timer = 0.0
var scene_changed = false
var lista_on = false

# Cena de gameplay
var scene_to_instance = preload("res://Interface/tela_gameplay.tscn")
var instance = scene_to_instance.instantiate()

# Referências a nós da cena
@onready var timer1 = $Timer
@onready var timer2 = $Timer2
@onready var click_sound = $Click

@onready var janela_primaria = $ListaPopup
@onready var janela_lista = $ListaPopup/Conteudo
@onready var close_button = $ListaPopup/TextureButton

@onready var animation_player = $AnimationPlayer
@onready var animation_player2 = $AnimationPlayer2
@onready var ui_elements = [
	$"Barra Inferior/Start", 
	$ligacao, 
	$Lista, 
	$Jogo,
	$"Barra Inferior/Time Panel/Time"
]  # Elementos que ficarão invisíveis

@onready var label_em_espera = $"Texto_explicação/ColorRect/ScrollContainer/VBoxContainer/Label1" as Label
@onready var controla_caracter = $Timer3
var texto_completo = ""
var indice_caractere = 0

@onready var label_mensagem = $Panel2
@onready var timer4 = $Timer4

@onready var label_mensagem1 = $Panel3

@onready var cursor_sprite = $Cursor

# Sons de vozes
@onready var fem_neutro = preload("res://soundtrack/Voices/fem_neutro.mp3")
@onready var fem_feliz = preload("res://soundtrack/Voices/fem_feliz.mp3")
@onready var fem_raiva = preload("res://soundtrack/Voices/fem_raiva.mp3")

@onready var mas_neutro = preload("res://soundtrack/Voices/mas_neutro.mp3")
@onready var mas_feliz = preload("res://soundtrack/Voices/mas_feliz.mp3")
@onready var mas_raiva = preload("res://soundtrack/Voices/mas_raiva.mp3")

@onready var audio_player = $AudioStreamPlayer

@onready var linha_roxa = $LinhaRoxa

# Controle de movimento do mouse
var mouse_override_active = false
var random_direction = Vector2.ZERO
@onready var move_timer5 = $Timer5
@onready var random_timer5 = $Timer5

@onready var move_timer6 = $Timer6
@onready var random_timer7 = $Timer7

@onready var timer8 = $Timer8

@onready var imagem9 = $"Elimar Gonzales"
@onready var timer9 = $Timer9
var blink_count = 0

@onready var imagem10 = $"Tela Azul"
@onready var timer10 = $Timer10

func _ready():
	# Configurações iniciais
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	linha_roxa.visible = false

	# Instancia a cena de gameplay
	instantiate_scene_in_panel(instance)
	close_button.pressed.connect(hide_panel)

	# Inicializa o Label de texto
	label_em_espera.text = ""
	controla_caracter.wait_time = 0.05
	controla_caracter.timeout.connect(_on_controla_caracter_timeout)

	# Toca sons iniciais
	MusicManager.boot_play_sound()
	MusicManager.play_pc_sound()

	# Verifica se é a primeira vez que a cena é carregada
	if Global.first_boot_animation:
		play_intro_animation()
		Global.first_boot_animation = false
	else:
		for element in ui_elements:
			element.visible = true

	# Configura a linha roxa (bug)
	setup_linha_roxa()

	# Configura timers para eventos aleatórios
	if Global.dia_atual >= 2:
		setup_random_movement_timers()

	# Configura eventos aleatórios
	tocar_som_em_momento_aleatorio()

	# Configura a imagem 9 (Elimar Gonzales)
	imagem9.visible = false
	if Global.dia_atual == 3:
		configurar_proximo_evento()

	# Configura a imagem 10 (Tela Azul)
	imagem10.visible = false
	aleatorizar_aparicao()

func _process(delta):
	# Atualiza a posição do cursor
	cursor_sprite.position = get_viewport().get_mouse_position()

	# Verifica duplo clique
	if click_count > 0:
		timer += delta
		if timer > double_click_time:
			click_count = 0
			timer = 0.0

	# Verifica se a instância da cena de gameplay está ativa
	if instance.problema_atual <= 2 and instance.has_method("get_pergunta_text"):
		texto_completo = instance.call("get_pergunta_text")

	# Movimento forçado do mouse
	if mouse_override_active:
		var mouse_pos = get_viewport().get_mouse_position()
		get_viewport().warp_mouse(mouse_pos + random_direction * delta * 200)

func _input(event):
	# Verifica cliques do mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		MusicManager.play_click_sound()
		
	if event is InputEventKey and event.pressed:
		# Verifica se a imagem está visível
		if imagem10.visible:
			get_tree().quit()  # Fecha o jogo

# Métodos para inicialização
func setup_linha_roxa():
	if randf() < 0.3:  # 30% de chance de aparecer
		var screen_width = get_viewport().get_visible_rect().size.x
		linha_roxa.position.x = randi_range(0, screen_width - linha_roxa.size.x)
		linha_roxa.visible = true
	else:
		linha_roxa.visible = false

func setup_random_movement_timers():
	move_timer5.one_shot = true
	random_timer5.one_shot = true
	move_timer5.timeout.connect(_on_move_timer5_timeout)
	random_timer5.timeout.connect(_on_random_timer5_timeout)
	start_random_timer5()

	move_timer6.one_shot = true
	random_timer7.one_shot = true
	move_timer6.timeout.connect(_on_move_timer6_timeout)
	random_timer7.timeout.connect(_on_random_timer7_timeout)
	start_random_timer7()

# Métodos para eventos aleatórios
func tocar_som_em_momento_aleatorio():
	var intervalo_aleatorio = randf_range(8.0, 300.0)
	timer8.start(intervalo_aleatorio)

func _on_timer_8_timeout():
	MusicManager.play_speaker_sound()
	tocar_som_em_momento_aleatorio()

func configurar_proximo_evento():
	timer9.stop()
	timer9.wait_time = randf_range(5, 200)
	timer9.one_shot = true
	timer9.timeout.connect(_on_timer9_timeout)
	timer9.start()

func _on_timer9_timeout():
	piscar_imagem()

func piscar_imagem():
	var max_blinks = 3
	var blink_speed = 0.1

	var blink_timer = Timer.new()
	add_child(blink_timer)
	blink_timer.wait_time = blink_speed
	blink_timer.one_shot = true

	blink_timer.timeout.connect(func():
		imagem9.visible = not imagem9.visible
		if blink_count <= max_blinks:
			blink_count += 1
			blink_timer.start()
		else:
			blink_timer.queue_free()
			imagem9.visible = false
			blink_count = 0
			configurar_proximo_evento()
	)

	blink_timer.start()

func aleatorizar_aparicao():
	var tempo_aleatorio = randf_range(5, 2000)
	var timer = get_tree().create_timer(tempo_aleatorio)
	await timer.timeout
	imagem10.visible = true

# Métodos para interação com a interface
func instantiate_scene_in_panel(instance):
	janela_lista.add_child(instance)

func hide_panel():
	janela_primaria.visible = false

func play_intro_animation():
	animation_player.play("startboot")

func _on_ligacao_pressed():
	click_count += 1
	if click_count == 1:
		timer = 0.0
	elif click_count == 2 and timer <= double_click_time:
		_on_double_click()
		click_count = 0
		timer = 0.0

func _on_double_click():
	$Internet.visible = true

func _on_lista_pressed():
	click_count += 1
	if click_count == 1:
		timer = 0.0
	elif click_count == 2 and timer <= double_click_time:
		_on_double_click1()
		click_count = 0
		timer = 0.0

func _on_double_click1():
	janela_primaria.visible = true
	instance.get_node("OptionButton").disabled = true
	instance.get_node("Button").disabled = true

func _on_ligar_internet_pressed():
	MusicManager.dial_sound()
	$Internet/Label2.visible = true
	$Internet/ligar_internet.visible = false
	$Internet/Label.text = "Conectando . . ."
	animation_player.play("connect_internet")
	await animation_player.animation_finished
	MusicManager.stop_dial_sound()
	$Internet.visible = false
	timer2.start(5)

func _on_timer_2_timeout():
	ligacao_ativa()
	timer2.stop()

func ligacao_ativa():
	$Atender.visible = true
	MusicManager.play_ring_sound()

func _on_button_atender_pressed():
	$Atender.visible = false
	MusicManager.stop_ring_sound()
	$"Texto_explicação/ColorRect/VScrollBar".visible = false
	$"Texto_explicação".visible = true
	controla_caracter.start()

func _on_controla_caracter_timeout():
	if indice_caractere < texto_completo.length():
		label_em_espera.text += texto_completo[indice_caractere]
		indice_caractere += 1
		animation_player2.play("sound_voice")
		tocar_som_emocao()
	else:
		controla_caracter.stop()
		$"Texto_explicação/Person/TextureRect".visible = false

func _on_button_em_espera_pressed():
	if indice_caractere < texto_completo.length():
		controla_caracter.stop()
		label_em_espera.text = texto_completo
		indice_caractere = texto_completo.length()

	janela_primaria.visible = true
	indice_caractere = 0
	instance.call("_get_text_to_tela_gameplay")
	instance.get_node("OptionButton").disabled = false
	instance.get_node("Button").disabled = false

	$"Texto_explicação".position = Vector2(858, 28)
	$"Texto_explicação".size = Vector2(263, 293)
	$"Texto_explicação/ColorRect".size = Vector2(240, 228)
	$"Texto_explicação/ColorRect/ScrollContainer".size = Vector2(230, 220)
	$"Texto_explicação/button em espera".visible = false
	$"Texto_explicação/ColorRect/VScrollBar".visible = true

func fim_do_dia_transition():
	# Sistema de fim de dia
	# Quando o timer expira, troca de cena
	linha_roxa.visible = false  # A linha some no final do dia
	MusicManager.stop_pc_sound()
	Global.dia_atual += 1
	
	
	if Global.dia_atual <= 3:
		if not scene_changed:
			scene_changed = true
			Transition.transition()
			await Transition.on_transition_finished
			get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn")
		
			Global.trys = 0
			Global.first_boot = true
			Global.first_boot_animation = true
			
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		scene_changed = true
		Transition.transition()
		await Transition.on_transition_finished
		MusicManager.stop_pc_sound()
		get_tree().change_scene_to_file("res://Interface/mainmenu.tscn")
		
		Global.dia_atual = 1
		Global.trys = 0
		Global.first_boot = true
		Global.first_boot_animation = true


func tocar_som_emocao():
	var emocao_atual = Global.dias[Global.dia_atual - 1]['quiz'][instance.problema_atual]['emocao']
	match emocao_atual:
		"fem_neutra":
			audio_player.stream = fem_neutro
		"fem_feliz":
			audio_player.stream = fem_feliz
		"fem_raiva":
			audio_player.stream = fem_raiva
		"mas_neutra":
			audio_player.stream = mas_neutro
		"mas_feliz":
			audio_player.stream = mas_feliz
		"mas_raiva":
			audio_player.stream = mas_raiva
	audio_player.play()
	audio_player.bus = "SFX"

func _on_jogo_pressed():
	label_mensagem.visible = true
	timer4.start(3)
	print("timer começou")

func _on_timer_4_timeout() -> void:
	print("timer acabou")
	label_mensagem.visible = false
	label_mensagem1.visible = false
	
func _on_start_pressed():
	$"Fim do dia2".visible = true

func _on_random_timer5_timeout():
	mouse_override_active = true
	random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	move_timer5.start(randf_range(2.0, 4.0))

func _on_move_timer5_timeout():
	mouse_override_active = false
	start_random_timer5()

func start_random_timer5():
	var tempo_aleatorio = randf_range(5.0, 3000.0)
	random_timer5.start(tempo_aleatorio)

func _on_random_timer7_timeout():
	mouse_override_active = true
	random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	move_timer6.start(randf_range(2.0, 4.0))

func _on_move_timer6_timeout():
	mouse_override_active = false
	start_random_timer7()

func start_random_timer7():
	var tempo_aleatorio = randf_range(5.0, 200.0)
	random_timer7.start(tempo_aleatorio)

func _on_sair_do_jogo_pressed():
	MusicManager.stop_pc_sound()
	get_tree().change_scene_to_file("res://Interface/mainmenu.tscn")
	

func _on_fechar_sair_pressed() -> void:
	$"Fim do dia2".visible = false
	pass # Replace with function body.


func _on_fechar_pressed() -> void:
	$"Fim do dia".visible = false
	$ListaPopup.visible = false
	fim_do_dia_transition()
	pass # Replace with function body.
