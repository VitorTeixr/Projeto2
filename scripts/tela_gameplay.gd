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
	
	# Configura o botão como não toggle
	get_node("Label/Button").toggle_mode = false

func _on_button_pressed(button: Button):
	match button.name:
		'b1':
			resposta_selecionada = 'b1'
		'b2':
			resposta_selecionada = 'b2'
	
	_verificar_resposta()

func _verificar_resposta():
	if resposta_selecionada == problemas[problema_atual]['resposta']:
		print("Acertou!")
	else:
		print("Resposta errada.")

func _atualizar_problema():
	if problema_atual < problemas.size():
		get_node("ScrollContainer2/VBoxContainer/Label2").text = problemas[problema_atual]['problema']
	else:
		print("Todos os problemas foram respondidos.")

func _on_button_button_down():
	# Pode não ser necessário se a lógica estiver em _on_button_pressed()
	pass

func _on_option_button_item_selected(index):
	# Atualiza o índice do problema se você estiver usando um OptionButton
	problema_atual = index
	_atualizar_problema()
