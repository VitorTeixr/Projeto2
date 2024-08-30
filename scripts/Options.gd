extends Node2D

@onready var music_player = BackgroundMusic

func _ready() -> void:
	
	
	for _button in get_tree().get_nodes_in_group("button"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
		
	# Carrega a configuração anterior da música
	var settings = ConfigFile.new()
	if settings.load("user://settings.cfg") == OK:
		var music_enabled = settings.get_value("audio", "music_enabled", true)
		$CheckButton.pressed = music_enabled
		_on_CheckButton_toggled(music_enabled)

func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		"voltar":
			get_tree().change_scene_to_file("res://Interface/mainmenu.tscn")
			
			

func _on_CheckButton_toggled(button_pressed: bool):
	if button_pressed:
		music_player.play()
	else:
		music_player.stop()
  
	# Salva a configuração de música
	var settings = ConfigFile.new()
	settings.set_value("audio", "music_enabled", button_pressed)
	settings.save("user://settings.cfg")
