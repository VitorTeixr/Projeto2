extends Control

var click_count = 0
var double_click_time = 0.3  # Tempo máximo permitido entre cliques (em segundos)
var timer = 0.0

func _process(delta):
	if click_count > 0:
		timer += delta
		if timer > double_click_time:
			# Tempo excedido, resetar
			click_count = 0
			timer = 0.0


func _on_ligacao_pressed():
	print("Clicado")
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
	print("Clicado")
	# Ação desejada ao clicar duas vezes rapidamente
	get_tree().change_scene_to_file("res://Interface/tela_gameplay.tscn")
	# Aqui você pode chamar a função ou ação desejada.
		
	pass # Replace with function body.


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Interface/mainmenu.tscn")
	pass # Replace with function body.
