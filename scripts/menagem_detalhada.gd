extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var file_path=Global.email_atual["msg"]
	var file= FileAccess.open(file_path, FileAccess.READ)
	$ScrollContainer/VBoxContainer/Label.text=file.get_as_text()
	$Label2.text="De:"+Global.email_atual['remetente']
	$Label3.text="Assunto:"+ Global.email_atual['assunto']

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn")
 # Replace with function body.


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://Interface/Mensagem.tscn") # Replace with function body.
