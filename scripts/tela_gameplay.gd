extends Control

# Lista de problemas e suas respostas corretas


var problema_atual = 0  
@onready var popup=$Window
@onready var atender_signal = get_parent().get_parent().get_parent().get_node("Atender")
@onready var fim_do_dia = get_parent().get_parent().get_parent().get_node("Fim do dia")
@onready var pontuação_texto = get_parent().get_parent().get_parent().get_node("Fim do dia/Panel/Label2")
@onready var parent_scene = get_parent()  # Obtém a Cena Principal

func  pressionado(i):
	var file = FileAccess.open(i['descricao'], FileAccess.READ)
	$ScrollContainer2/VBoxContainer/Label2.text=file.get_as_text()
	
	print(i)
func _ready() -> void:
	
	$OptionButton.disabled=true
	$Button.disabled=true
	$OptionButton.clear()

	
	var font = FontFile.new()
	var font_file = load("res://sprites/Fonts/Battlenet.ttf") as FontFile
	font.font_data = font_file
	
	var texture = load("res://sprites/pixelframenormal.png")
	var stylebox_texture = StyleBoxTexture.new()
	stylebox_texture.texture = texture
	
	var texture2 = load("res://sprites/pixeframeinverted.png")
	var stylebox_texture2 = StyleBoxTexture.new()
	stylebox_texture2.texture = texture2
	
	var black_color = Color(0, 0, 0)
	var red_color = Color(1, 0, 0)  # Exemplo de cor para o pressed
	
	

	for x in Global.dia_atual:
		for i in Global.dias[x]['problemas']:
			var butao=Button.new()
			
			butao.custom_minimum_size = Vector2(100, 40)  # Largura = 200, Altura = 50
			
			butao.add_theme_font_override("font", font)
			butao.add_theme_font_size_override("font_size", 22)
			
			butao.add_theme_stylebox_override("normal", stylebox_texture)
			butao.add_theme_stylebox_override("hover", stylebox_texture)   # Estado hover
			butao.add_theme_stylebox_override("pressed", stylebox_texture2)  # Estado pressionado
			
			butao.add_theme_color_override("font_color", black_color)
			butao.add_theme_color_override("font_hover_color", black_color)  # Cor quando o mouse estiver sobre o botão
			butao.add_theme_color_override("font_pressed_color", black_color)  # Cor quando o botão for pressionado
			butao.add_theme_color_override("font_focus_color", black_color)  # Cor quando o botão for pressionado
			
			$OptionButton.add_item(i['titulo'])
			butao.text=i['titulo']
	
			
			butao.connect('pressed',func():pressionado(i))
			$ScrollContainer/VBoxContainer.add_child(butao)



func _on_button_pressed():
	var player_ans=$OptionButton.text
	parent_scene.label_em_espera = ""

	if player_ans==Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['resposta']:
		Global.dias[Global.dia_atual-1]['pontuacao']+=1
	
	$"Texto_Ligação/VBoxContainer/Label".text=''
	$Button.disabled=true
	$OptionButton.disabled=true
	problema_atual+=1
	
	
	if problema_atual>=len(Global.dias[Global.dia_atual-1]['quiz']):
		pontuação_texto.text=" Você acertou "+str(Global.dias[Global.dia_atual-1]['pontuacao']) + " de " + str(len(Global.dias[Global.dia_atual-1]['quiz']))
		fim_do_dia.visible = true
	else:
		$Timer.start()
		
func _on_timer_timeout():
	if problema_atual > 0:
		atender_signal.visible = true
		MusicManager.play_ring_sound()
	$Timer.stop()
	
	pass

func _get_text_to_tela_gameplay():
	var file = FileAccess.open(Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['pergunta'], FileAccess.READ)
	$"Texto_Ligação/VBoxContainer/Label".text=file.get_as_text()
	
func get_pergunta_text():
	var file = FileAccess.open(Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['pergunta'], FileAccess.READ)
	return file.get_as_text()  # Retorna o texto da pergunta
