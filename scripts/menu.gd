extends Control
class_name MainMenu


func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("button"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
	if not BackgroundMusic.playing:
		BackgroundMusic.play()

func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		"NewGame":
			get_tree().change_scene_to_file("res://Interface/computador_contemporaneo.tscn")
			
		"Options":
			get_tree().change_scene_to_file("res://Interface/Options.tscn")
			
		"Credits":
			get_tree().change_scene_to_file("res://Interface/Creditos.tscn")
			
		"Left":
			get_tree().quit()
		
			
		
			

