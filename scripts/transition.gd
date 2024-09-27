extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false
	$Label.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "Fadeout":
		on_transition_finished.emit()
		animation_player.play("Fadein")
		
	elif anim_name == "Fadein":
		color_rect.visible = false
	
func transition():
	if Global.dia_atual <= 3:
		$Label.text = "Dia " + str(Global.dia_atual)
		color_rect.visible = true
		$Label.visible = true
		animation_player.play("Fadeout")
		
	else:
		$Label.text = "Continua..."
		color_rect.visible = true
		$Label.visible = true
		animation_player.play("Fadeout")
		
