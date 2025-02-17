extends Node2D

@onready var cursor_sprite = $Cursor

func _ready() -> void:
	
	
	for _button in get_tree().get_nodes_in_group("button"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		"voltar":
			get_tree().change_scene_to_file("res://Interface/mainmenu.tscn")

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	cursor_sprite.position = mouse_position
