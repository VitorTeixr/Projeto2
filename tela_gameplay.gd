extends Control


var x=[{'problema':"descrição do problema 1" ,'resposta':1},{'problema':"descrição do problema 2" ,'resposta':'b1'}]
var y=null
func _ready() -> void:
	$ScrollContainer2/VBoxContainer/Label2.text="começo"
	for _button in get_tree().get_nodes_in_group('button'):
		_button.pressed.connect(_on_button_pressed.bind(_button))
	$Label/Button.toggled=false
	pass # Replace with function body.
var resposta=null

func _on_button_pressed(_button:Button):
	match _button.name:
		'b1':
			print("b1 foi pressionada")
			resposta='b1'
			var label_text_res='res://historia_do_brasil.txt'
			var file=FileAccess.open(label_text_res,FileAccess.READ)
			var text=file.get_as_text()
			$ScrollContainer2/VBoxContainer/Label2.text=text
		'b2':
			print('b2 foi pressionado')
			var label_text_res='res://portugal.txt'
			var file=FileAccess.open(label_text_res,FileAccess.READ)
			var text=file.get_as_text()
			$ScrollContainer2/VBoxContainer/Label2.text=text
			resposta='b2'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text=x[0]['problema']

	



func _on_button_button_down():
	print(y)
	if y==x[0]["resposta"]:
		print("Acertou")


func _on_option_button_item_selected(index):
	y=index
