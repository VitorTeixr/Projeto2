extends Control

var i=0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_timer_timeout():
	print(i)
	i+=1 
	if i==10:
		get_tree().change_scene_to_file("res://Interface/windows95.tscn")
	

