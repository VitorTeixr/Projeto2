extends Control

var click_count = 0
var double_click_time = 0.5  # Tempo máximo permitido entre cliques (em segundos)
var timer = 0.0
var scene_changed = false

@onready var janela = $Panel2
@onready var timer1 = $Timer

func _ready():
	if Global.trys == 2:
		Global.dia_atual += 1
		janela.visible = true
		timer1.start(2)  # Inicia o timer com 2 segundos
		timer1.timeout.connect(Callable(self, "_on_timer_timeout"))
			
func _on_timer_timeout():
	# Quando o timer expira, troca de cena
	if not scene_changed:
		scene_changed = true
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn")

func _process(delta):
	if click_count > 0:
		timer += delta
		if timer > double_click_time:
			# Tempo excedido, resetar
			click_count = 0
			timer = 0.0
			



func _on_ligacao_pressed():
	click_count += 1
	if click_count == 1:
		# Primeiro clique, iniciar o temporizador
		timer = 0.0
	elif click_count == 2:
		# Segundo clique dentro do tempo permitido
		if timer <= double_click_time:
			_on_double_click()
		# Resetar para o próximo conjunto de cliques
		click_count = 0
		timer = 0.0
	
func _on_double_click():
	# Ação desejada ao clicar duas vezes rapidamente
	get_tree().change_scene_to_file("res://Interface/tela_gameplay.tscn")
	# Aqui você pode chamar a função ou ação desejada.
		
	pass # Replace with function body.
	
	



func _on_start_pressed():
	print (Global.acertosD1)
	get_tree().change_scene_to_file("res://Interface/mainmenu.tscn")
	pass # Replace with function body.
