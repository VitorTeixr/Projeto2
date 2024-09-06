extends Control

# Variáveis globais de dias e problemas
var problemas = Global.dias[Global.dia_atual - 1]['problemas']
var quiz = Global.dias[Global.dia_atual - 1]['quiz']

var resposta_selecionada = null
var problema_atual = -1  # Inicialmente sem problema selecionado

func mostrar(i):
	var file_path = i['descricao']
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		$ScrollContainer2/VBoxContainer/Label2.text = file.get_as_text()
		file.close()

func _ready() -> void:
	# Produz botões correspondentes aos problemas
	for problema in problemas:
		var botao = Button.new()
		botao.text = problema['titulo']
		
		# Conecta cada botão para mostrar o problema e registrar a resposta selecionada
		botao.connect('pressed', Callable(self, "_on_button_pressed").bind(problema))
		
		$ScrollContainer/VBoxContainer.add_child(botao)

func _on_button_pressed(problema) -> void:
	mostrar(problema)
	resposta_selecionada = problema['titulo']
	problema_atual = find_problem_index(problema)  # Encontra o índice do problema selecionado

func find_problem_index(problema) -> int:
	# Função para encontrar o índice do problema no array
	for i in range(problemas.size()):
		if problemas[i]['titulo'] == problema['titulo']:
			return i
	return -1  # Retorna -1 se o problema não for encontrado (não deve acontecer)

func _on_send_button_down() -> void:
	if resposta_selecionada != null and problema_atual != -1:
		_verify_answer()
	else:
		# Se nenhuma resposta foi selecionada, mudar de cena
		get_tree().change_scene_to_file("res://Interface/windows95.tscn")

func _on_sair_pressed():
	get_tree().change_scene_to_file("res://Interface/windows95.tscn")

func _verify_answer():
	if problema_atual < quiz.size():
		# Normalizar resposta selecionada e correta
		var resposta_normalizada = resposta_selecionada.strip_edges().to_lower()
		var resposta_correta_normalizada = quiz[problema_atual]['resposta'].strip_edges().to_lower()

		# Imprimir valores para depuração
		print("Resposta selecionada: ", resposta_normalizada)
		print("Resposta correta: ", resposta_correta_normalizada)

		# Verifica se a resposta selecionada é a correta do quiz
		if resposta_normalizada == resposta_correta_normalizada:
			print("Acertou!")
			Global.acertosD1 += 1
			Global.trys += 1
			Global.dias[Global.dia_atual - 1]['acertou'].append(problema_atual)
		else:
			print("Resposta errada.")
			Global.trys += 1
			Global.dias[Global.dia_atual - 1]['errou'].append(problema_atual)
		
		# Muda de cena após verificar a resposta
		get_tree().change_scene_to_file("res://Interface/windows95.tscn")
	else:
		print("Índice do problema atual está fora dos limites do quiz.")

func _update_problem():
	# Atualiza o problema mostrado na tela
	if problema_atual >= 0 and problema_atual < problemas.size():
		get_node("ScrollContainer2/VBoxContainer/Label2").text = problemas[problema_atual]['titulo']
	else:
		print("Problema atual está fora dos limites.")
