extends Control

var click_count = 0
var double_click_time = 0.3  # Tempo máximo permitido entre cliques (em segundos)
var timer = 0.0

var click_count1 = 0
var double_click_time1 = 0.3  # Tempo máximo permitido entre cliques (em segundos)
var timer1 = 0.0



@onready var mensagem_label = $MensagemLabel  # Adicione um nó Label na cena para exibir a mensagem

func _ready():
	MusicManager.stop_radio_sound()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mensagem_label.visible = false  # Inicialmente, a mensagem está invisível

func _process(delta):
	if click_count > 0:
		timer += delta
		if timer > double_click_time:
			# Tempo excedido, resetar
			click_count = 0
			timer = 0.0
			
	if click_count1 > 0:
		timer1 += delta
		if timer1 > double_click_time1:
			# Tempo excedido, resetar
			click_count1 = 0
			timer1 = 0.0
	
	var time = Time.get_time_dict_from_system()
	$Time.text = "%02d:%02d" % [time.hour, time.minute]

func _on_pc_antigo_pressed():
	if not Global.emails_checked:
		# Exibe a mensagem se os emails não foram verificados
		mensagem_label.visible = true
		return  # Impede que o jogador prossiga

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
	get_tree().change_scene_to_file("res://Interface/boot_pc.tscn")
	Global.emails_checked = false

func _on_emails_pressed():
	click_count1 += 1
	if click_count1 == 1:
		# Primeiro clique, iniciar o temporizador
		timer1 = 0.0
	elif click_count1 == 2:
		# Segundo clique dentro do tempo permitido
		if timer1 <= double_click_time1:
			_on_double_click1()
		# Resetar para o próximo conjunto de cliques
		click_count1 = 0
		timer1 = 0.0
	
func _on_double_click1():
	# Ação desejada ao clicar duas vezes rapidamente
	Global.emails_checked = true  # Marca que os emails foram verificados
	mensagem_label.visible = false  # Esconde a mensagem
	get_tree().change_scene_to_file("res://Interface/Mensagem.tscn")
