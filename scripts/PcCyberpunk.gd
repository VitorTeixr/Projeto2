extends Control

var click_count = 0
var double_click_time = 0.3  # Tempo máximo permitido entre cliques (em segundos)
var timer = 0.0

var click_count1 = 0
var double_click_time1 = 0.3  # Tempo máximo permitido entre cliques (em segundos)
var timer1 = 0.0

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


func _on_pc_antigo_pressed():
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
	# Aqui você pode chamar a função ou ação desejada.


func _on_emails_pressed():
	click_count1 += 1
	if click_count1 == 1:
		# Primeiro clique, iniciar o temporizador
		timer1 = 0.0
	elif click_count1 == 2:
		# Segundo clique dentro do tempo permitido
		if timer1 <= double_click_time:
			_on_double_click1()
		# Resetar para o próximo conjunto de cliques
		click_count1 = 0
		timer1 = 0.0
	
	
func _on_double_click1():
	# Ação desejada ao clicar duas vezes rapidamente
	get_tree().change_scene_to_file("res://Interface/Mensagem.tscn")
	# Aqui você pode chamar a função ou ação desejada.
