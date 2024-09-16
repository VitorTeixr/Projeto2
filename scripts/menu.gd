extends Control
class_name MainMenu

var animacao_scene = preload("res://Interface/intro.tscn")
var animacao_instance

func _ready():
	
	MusicManager.play_music("res://soundtrack/Music/Theme.mp3")
	
	if Global.start_game == false:
	# Instanciar a cena da animação
		animacao_instance = animacao_scene.instantiate()
	
	# Adicioná-la como filha da cena atual
		add_child(animacao_instance)
	
	# Acessar o AnimationPlayer dentro da cena instanciada
		var anim_player = animacao_instance.get_node("AnimationPlayer")  # Ajuste o caminho se necessário
	
	# Verificar se o AnimationPlayer foi encontrado
		anim_player.play("introduction")  # Nome correto da animação
		Global.start_game = true
		



	for _button in get_tree().get_nodes_in_group("button"):
		_button.pressed.connect(_on_button_pressed.bind(_button))


func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		"NewGame":
			MusicManager.stop_music()
			Transition.transition()
			MusicManager.play_radio_sound()
			await Transition.on_transition_finished
			MusicManager.stop_radio_sound()			
			get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn")
			
		"Options":
			get_tree().change_scene_to_file("res://Interface/Options.tscn")
			
		"Credits":
			get_tree().change_scene_to_file("res://Interface/Creditos.tscn")
			
		"Left":
			get_tree().quit()
		
			
		
			
