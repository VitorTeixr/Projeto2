extends Control


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Interface/PcCyberpunk.tscn") # Replace with function body.


func _on_button_pressed():
	Global.mensage=0
	get_tree().change_scene_to_file("res://Interface/menagem_detalhada.tscn") # Replace with function body.
