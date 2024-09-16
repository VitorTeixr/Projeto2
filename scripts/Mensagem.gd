extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	
	var font = FontFile.new()
	var font_file = load("res://sprites/Fonts/CornDemo-Regular.ttf") as FontFile
	font.font_data = font_file
	
	for x in Global.dia_atual:
		for i in Global.dias[x]['emails']:
			var butao=Button.new()
			butao.add_theme_font_override("font", font)

			butao.text=i['remetente']
			butao.connect('pressed',func():pressionado(i))
			$Semitransparente/ScrollContainer/VBoxContainer.add_child(butao)
		


func _process(delta):
	pass


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn") # Replace with function body.


func pressionado(detalhes):
	Global.email_atual=detalhes
	print(Global.email_atual)
	get_tree().change_scene_to_file("res://Interface/menagem_detalhada.tscn")
