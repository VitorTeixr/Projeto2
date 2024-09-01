extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Label2.text=Global.emails[Global.mensage]["mensagem"]


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Interface/computador_contemporaneo.tscn")
 # Replace with function body.


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://Interface/Mensagem.tscn") # Replace with function body.
