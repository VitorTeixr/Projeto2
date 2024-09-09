extends Control

# Lista de problemas e suas respostas corretas
var problemas = [
	{'problema': "Descrição do Problema 1", 'resposta': 'b1'},
	{'problema': "Descrição do Problema 2", 'resposta': 'b2'}
]
var resposta_selecionada = null  # Índice do problema atual
var problema_atual = 0  


func _ready() -> void:
	# Inicializa o texto do Label com o primeiro problema
	get_node("Sair").pressed.connect(_on_exit_button_pressed)
	get_node("Label/send").pressed.connect(_on_send_button_pressed)
	get_node("ScrollContainer2/VBoxContainer/Label2").text = "Selecione Um Problema"

	for button in get_tree().get_nodes_in_group('buttonTG'):
		button.pressed.connect(_on_button_pressed.bind(button))

	get_node("Label/send").toggle_mode = false
	
func _on_send_button_pressed():
	_verify_answer()	
	
func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Interface/windows95.tscn")
	
func _on_button_pressed(button: Button):
	match button.name:
		'b1':
			resposta_selecionada = 'b1'
			_update_label_text("res://Textos_jogos/Dia_1/problemas/p1.txt")
		'b2':
			resposta_selecionada = 'b2'
			_update_label_text("res://Textos_jogos/Dia_1/problemas/p2.txt")
	
			
func _verify_answer():
	if resposta_selecionada == problemas[problema_atual]['resposta']:
		print("Acertou!")
		Global.trys += 1
		Global.acertosD1 +=1
		get_tree().change_scene_to_file("res://Interface/windows95.tscn")
	else:
		print("Resposta errada.")
		Global.trys += 1
		get_tree().change_scene_to_file("res://Interface/windows95.tscn")


func _update_problem():
	if problema_atual < problemas.size():
		get_node("ScrollContainer2/VBoxContainer/Label2").text = problemas[problema_atual]['problema']
	else:
		print("Todos os problemas foram respondidos.")


func _update_label_text(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		$ScrollContainer2/VBoxContainer/Label2.text = text
		file.close()

func _on_option_button_item_selected(index):
	# Atualiza o índice do problema se você estiver usando um OptionButton
	problema_atual = index
	_update_problem()
	
	
func _input(event):
	# Verifica se o evento é um clique do botão esquerdo do mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Reproduz o som de clique
		MusicManager.play_click_sound()
