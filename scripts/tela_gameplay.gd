extends Control

# Lista de problemas e suas respostas corretas


var problema_atual = 0  
@onready var popup=$Window
@onready var atender_signal = get_parent().get_parent().get_parent().get_node("Atender")
@onready var fim_do_dia = get_parent().get_parent().get_parent().get_node("Fim do dia")


func  pressionado(i):
	var file = FileAccess.open(i['descricao'], FileAccess.READ)
	$ScrollContainer2/VBoxContainer/Label2.text=file.get_as_text()
	
	print(i)
func _ready() -> void:
	

	
	var font = FontFile.new()
	var font_file = load("res://sprites/Fonts/Battlenet.ttf") as FontFile
	font.font_data = font_file
	
	
	
	$OptionButton.disabled=true
	$OptionButton.clear()

	for x in Global.dia_atual:
		for i in Global.dias[x]['problemas']:
			var butao=Button.new()
			butao.custom_minimum_size = Vector2(100, 40)  # Largura = 200, Altura = 50
			butao.add_theme_font_override("font", font)
			$OptionButton.add_item(i['titulo'])
			butao.text=i['titulo']
	
			
			butao.connect('pressed',func():pressionado(i))
			$ScrollContainer/VBoxContainer.add_child(butao)
			
	# Inicializa o texto do Label com o primeiro problema
	get_node("ScrollContainer2/VBoxContainer/Label2").text = "Selecione Um Problema"

	
	
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
		fim_do_dia.visible = true
		Global.dia_atual += 1
	else:
		$Timer.start()
		
func _on_timer_timeout():
	if problema_atual > 0:
		atender_signal.visible = true
		MusicManager.play_ring_sound()
	$OptionButton.disabled=false
	$Button.disabled=false
	$Timer.stop()
	
	pass

func _get_text_to_tela_gameplay():
	var file = FileAccess.open(Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['pergunta'], FileAccess.READ)
	$ScrollContainer3/VBoxContainer/Label.text=file.get_as_text()
	
func get_pergunta_text():
	var file = FileAccess.open(Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['pergunta'], FileAccess.READ)
	return file.get_as_text()  # Retorna o texto da pergunta
