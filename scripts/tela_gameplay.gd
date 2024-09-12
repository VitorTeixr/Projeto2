extends Control

# Lista de problemas e suas respostas corretas


var problema_atual = 0  
@onready var popup=$Window
func  pressionado(i):
	var file = FileAccess.open(i['descricao'], FileAccess.READ)
	$ScrollContainer2/VBoxContainer/Label2.text=file.get_as_text()
	
	print(i)
func _ready() -> void:
	#popup.show()
	$OptionButton.disabled=true
	$OptionButton.clear()
	for x in Global.dia_atual:
		for i in Global.dias[x]['problemas']:
			var butao=Button.new()
			$OptionButton.add_item(i['titulo'])
			butao.text=i['titulo']
			butao.connect('pressed',func():pressionado(i))
			$ScrollContainer/VBoxContainer.add_child(butao)
			
	# Inicializa o texto do Label com o primeiro problema
	get_node("ScrollContainer2/VBoxContainer/Label2").text = "Selecione Um Problema"

	get_node("Label/send").toggle_mode = false
	
	
func _input(event):
	# Verifica se o evento é um clique do botão esquerdo do mouse
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Reproduz o som de clique
		#MusicManager.play_click_sound()
	pass



func _on_button_pressed():
	var player_ans=$OptionButton.text

	if player_ans==Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['resposta']:
		
		Global.dias[Global.dia_atual-1]['pontuacao']+=1
	
	$ScrollContainer3/VBoxContainer/Label.text=''
	$Button.disabled=true
	$OptionButton.disabled=true
	problema_atual+=1
	
	if problema_atual>=len(Global.dias[Global.dia_atual-1]['quiz']):
		get_tree().change_scene_to_file('res://Interface/resultado.tscn')
	else:
		$Timer.start()
		
func _on_timer_timeout():
	
	var file = FileAccess.open(Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['pergunta'], FileAccess.READ)
	$ScrollContainer3/VBoxContainer/Label.text=file.get_as_text()
	$Button.disabled=false
	$OptionButton.disabled=false
	$Timer.stop()
	pass
