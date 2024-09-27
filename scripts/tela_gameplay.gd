extends Control

# Lista de problemas e suas respostas corretas
@onready var scroll_container = $ScrollContainer  # Substitua pelo caminho correto do seu ScrollContainer

var problema_atual = 0 
@onready var atender_signal = get_parent().get_parent().get_parent().get_node("Atender")
@onready var fim_do_dia = get_parent().get_parent().get_parent().get_node("Fim do dia")
@onready var pontuação_texto = get_parent().get_parent().get_parent().get_node("Fim do dia/Panel/Label2")
@onready var parent_scene = get_parent().get_parent().get_parent()  # Obtém a Cena Principal
@onready var janela_explicação = get_parent().get_parent().get_parent().get_node("Texto_explicação")

func  pressionado(i):
	var file = FileAccess.open(i['descricao'], FileAccess.READ)
	var  img_path = i['img']
	print(img_path)
	var actual_img=load(img_path)
	$"Panel Imagens/Imagens".texture=actual_img
	$ScrollContainer2/VBoxContainer/Label2.text=file.get_as_text()
	$"Panel Imagens".visible = true	
	print(i)
func _ready() -> void:
	
	$OptionButton.disabled=true
	$Button.disabled=true
	$OptionButton.clear()

	
	var font = FontFile.new()
	var font_file = load("res://sprites/Fonts/Battlenet.ttf") as FontFile
	font.font_data = font_file
	
	var texture = load("res://sprites/Imagens/pixelframenormal.png")
	var stylebox_texture = StyleBoxTexture.new()
	stylebox_texture.texture = texture
	
	var texture2 = load("res://sprites/Imagens/pixeframeinverted.png")
	var stylebox_texture2 = StyleBoxTexture.new()
	stylebox_texture2.texture = texture2
	
	var black_color = Color(0, 0, 0)
	
	

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
			$OptionButton.add_theme_font_override("font", font)
			butao.text=i['titulo']
	
			
			butao.connect('pressed',func():pressionado(i))
			$ScrollContainer/VBoxContainer.add_child(butao)



func _on_button_pressed():
	var player_ans=$OptionButton.text
	parent_scene.label_em_espera.text = ""
	
	#if problema_atual >= 1:
		#parent_scene.get_node("Tela Azul").visible = true
	
	janela_explicação.visible = false
	janela_explicação.position = Vector2 (310, 178)
	janela_explicação.size = Vector2(521, 293)
	janela_explicação.get_node("ColorRect").size = Vector2(496, 228)
	janela_explicação.get_node("ColorRect/ScrollContainer").size = Vector2(483,228)
	janela_explicação.get_node("button em espera").visible = true

	if player_ans==Global.dias[Global.dia_atual-1]['quiz'][problema_atual]['resposta']:
		Global.dias[Global.dia_atual-1]['pontuacao']+=1
	
	$"Texto_Ligação/VBoxContainer/Label".text=''
	$Button.disabled=true
	$OptionButton.disabled=true
	problema_atual+=1
	
	
	if problema_atual>=len(Global.dias[Global.dia_atual-1]['quiz']):
		if Global.dia_atual >=2:
			fim_do_dia.get_node("Panel/Label").text = "Parabéns por hoje, aqui está seus resultados:"
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
