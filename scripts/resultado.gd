extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text=" Você acertou "+str(Global.dias[Global.dia_atual-1]['pontuacao']) + " de " + str(len(Global.dias[Global.dia_atual-1]['quiz']))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn")
	pass # Replace with function body.
