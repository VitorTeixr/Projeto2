extends Control

# Lista de problemas e suas respostas corretas
var problemas = [
	{'problema': "descrição do problema 1", 'resposta': 'b1'},
	{'problema': "descrição do problema 2", 'resposta': 'b2'}
]
var resposta_selecionada = null
var problema_atual = 0  # Índice do problema atual

func _ready() -> void:
	# Inicializa o texto do Label com o primeiro problema
	_atualizar_problema()
	
	# Conecta todos os botões do grupo 'button' ao sinal 'pressed'
	for button in get_tree().get_nodes_in_group('button'):
		button.pressed.connect(_on_button_pressed.bind(button))
	
	# Conecta o botão de verificação de resposta ao sinal 'pressed'
	var button_check = get_node("Label/Button")  # Certifique-se de que este é o caminho correto para o botão
	button_check.pressed.connect(_on_check_button_pressed)

func _on_button_pressed(button: Button):
	match button.name:
		'b1':
			resposta_selecionada = 'b1'
		'b2':
			resposta_selecionada = 'b2'

func _on_check_button_pressed():
	_verificar_resposta()

func _verificar_resposta():
	if resposta_selecionada == problemas[problema_atual]['resposta']:
		get_tree().change_scene_to_file("res://Interface/windows95.tscn")
		print("Acertou!")
	else:
		print("Resposta errada.")

func _atualizar_problema():
	if problema_atual < problemas.size():
		var label = get_node("ScrollContainer2/VBoxContainer/Label2")
		if label:
			label.text = problemas[problema_atual]['problema']
		else:
			print("Nó do Label não encontrado.")
	else:
		print("Todos os problemas foram respondidos.")


func _on_sair_pressed():
	get_tree().change_scene_to_file("res://Interface/windows95.tscn")
	pass # Replace with function body.
