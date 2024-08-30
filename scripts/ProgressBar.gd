extends ProgressBar

var progress = 0.0

func _ready():
	# Inicializa a barra de progresso
	set_value(progress)
	_update_icon_position()

func _process(delta):
	# Simula progresso (aumenta a barra progressivamente)
	if progress < 100:
		progress += 20 * delta
		set_value(progress)
		_update_icon_position()

	if progress >= 100:
		get_tree().change_scene_to_file("res://Interface/windows95.tscn")

func _update_icon_position():
	# Obter o TextureRect (ícone)
	var icon = $TextureRect

	# Calcula a nova posição X do ícone
	var progress_ratio = progress / max_value  # razão de progresso
	var bar_width = get_rect().size.x  # largura da barra de progresso
	var icon_position_x = bar_width * progress_ratio - icon.size.x / 2

	# Define a nova posição do ícone
	icon.position.x = icon_position_x
