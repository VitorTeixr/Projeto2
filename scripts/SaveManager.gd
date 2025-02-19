extends Node

# Salvar o progresso no arquivo

func salvar_progresso():
	var dados = {
		"dia_atual": 1,  # Nunca salva menos que 1
		"first_boot": Global.first_boot,
		"first_boot_animation": Global.first_boot_animation
	}

	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(dados))
	file.close()
	print("Progresso salvo corretamente:", dados)  # Debug
	
func carregar_progresso():
	var save_path = "user://savegame.json"
	
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var dados = JSON.parse_string(file.get_as_text())
		file.close()
		
		if dados:
			Global.dia_atual = dados.get("dia_atual")
			Global.first_boot = dados.get("first_boot", true)
			Global.first_boot_animation = dados.get("first_boot_animation", true)
			print("Progresso carregado:", dados)  # Apenas para depuração
		else:
			print("Erro ao carregar progresso. Iniciando novo jogo.")
			Global.dia_atual = 1  # Garantindo que comece no dia 1 se houver erro
	else:
		print("Nenhum save encontrado. Começando do zero.")
		Global.dia_atual = 1  # Nenhum save? Começa no dia 1
