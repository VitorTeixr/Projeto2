extends Control

@onready var scroll_container = $ScrollContainer/VBoxContainer  # O caminho do VBoxContainer onde os botões serão adicionados
# Called when the node enters the scene tree for the first time.
func _ready():
	

	
	gerar_botoes_emails()
	
	
func gerar_botoes_emails():
	
	var font = FontFile.new()
	var font_file = load("res://sprites/Fonts/CornDemo-Regular.ttf") as FontFile
	font.font_data = font_file
	

	# Loop pelos dias até o dia atual
	for x in range(Global.dia_atual):
		var dia = Global.dias[x]  # Acessa o dia
		for i in dia['emails']:
			var butao = Button.new()
			butao.text = i['remetente']
			
			# Conecta o botão ao sinal de pressionar
			butao.connect('pressed', func(): pressionado(i))

			# Verifica se o email pertence a um dia anterior ao dia atual
			if x < Global.dia_atual - 1:
				# Se o email for de um dia anterior, altera a cor do texto para cinza
				butao.add_theme_font_override("font", font)
				butao.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))  # Cor cinza
			else:
				# Se for do dia atual, usa a fonte normal
				butao.add_theme_font_override("font", font)

			# Adiciona o botão ao VBoxContainer
			scroll_container.add_child(butao)

# Função chamada ao pressionar o botão do email
func pressionado(detalhes):
	Global.email_atual=detalhes
	print(Global.email_atual)
	get_tree().change_scene_to_file("res://Interface/menagem_detalhada.tscn")
		


func _process(delta):
	pass


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn") # Replace with function body.
