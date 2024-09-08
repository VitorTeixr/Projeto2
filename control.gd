extends Control


var loading_progress = 0  # Progresso inicial
var loading_speed = 10  # Velocidade de carregamento

# Referência à barra de progresso de textura
@onready var texture_progress_bar = $TextureProgress

func _ready():
	texture_progress_bar.value = loading_progress

func _process(delta):
	if loading_progress < texture_progress_bar.max_value:  # O valor máximo definido para a barra
		loading_progress += loading_speed * delta
		texture_progress_bar.value = loading_progress
	else:
		_on_loading_complete()

# Função chamada quando o carregamento estiver completo
func _on_loading_complete():
	print("Carregamento completo!")
	# Aqui você pode mudar de cena ou realizar outra ação
