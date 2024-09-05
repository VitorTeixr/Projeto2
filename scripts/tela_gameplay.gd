extends Control

# Lista de problemas e suas respostas corretas
var problemas = [
	{'problema': "Descrição do Problema 1", 'resposta': 'b1'},
	{'problema': "Descrição do Problema 2", 'resposta': 'b2'}
]
var resposta_selecionada = null
var problema_atual = 0
  
func mostrar(i):
	var file_path=i['descricao']
	var file= FileAccess.open(file_path, FileAccess.READ)
	$ScrollContainer2/VBoxContainer/Label2.text=file.get_as_text()

func _ready() -> void:
	$Timer.start()
	#Produz botões correspondentes a quantidade de dias
	for a in range(Global.dia_atual):
		for i in Global.dias[a]['problemas']:
			
			var botao=Button.new()
			botao.text=i['titulo']
			botao.connect('pressed',func():mostrar(i))
			$ScrollContainer/VBoxContainer.add_child(botao)
			
			
			
			


		
func _on_send_button_pressed():
	if resposta_selecionada != null:
		_verify_answer()
	else:
		get_node("ScrollContainer2/VBoxContainer/Label2").text = "Selecione Uma Opção"
	
func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Interface/windows95.tscn")
	

			
func _verify_answer():
	if resposta_selecionada == problemas[problema_atual]['resposta']:
		print("Acertou!")
		Global.acertosD1 += 1
		Global.trys += 1
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


func _on_timer_timeout():
	print("Acabou") # Replace with function body.
