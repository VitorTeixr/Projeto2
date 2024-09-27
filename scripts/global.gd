extends Node

#dados referentes aos dias
"""
Cada dia recebe as seguintes variaveis
nome 
emails 
id_dia
pontuavao
problemas 

"""
var dias = [
	{
		'nome': "Dia 1",
		'emails': [
			{
				'remetente': "Vitória, do Departamento de Controle de Danos",
				'assunto': "Instruções do Trabalho",
				'msg': "res://Textos_jogos/Dia_1/emails/msg1.txt"
			},
			{
				'remetente': "Jason Morais",
				'assunto': "Aluguel atrasado",
				'msg': "res://Textos_jogos/Dia_1/emails/msg2.txt"
			},
			{
				'remetente': "Lucas Castro",
				'assunto': "Parabenização do Trabalho novo",
				'msg': "res://Textos_jogos/Dia_1/emails/msg3.txt"
			}
		],
		'id_dia': 1,
		'pontuacao': 0,
		'quiz': [
			{
				'pergunta': 'res://Textos_jogos/Dia_1/quiz/a1.txt',
				'resposta': 'Mal Contato',
				'emocao': 'fem_neutra'  # Adicionando a emoção aqui
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_1/quiz/a2.txt',
				'resposta': 'Oxidação',
				'emocao': 'mas_neutra'
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_1/quiz/a3.txt',
				'resposta': 'Arranhões',
				'emocao': 'mas_raiva'
			}
		],
		'problemas': [
			{
				'titulo': 'Mal Contato',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p1.txt',
				'img':'res://sprites/Ícone problemas/Mal-contato.png'
				
			},
			{
				'titulo': 'Oxidação',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p2.txt',
				'img':"res://sprites/Ícone problemas/Oxidação.png"
			},
			{
				'titulo': 'Arranhões',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p3.txt',
				'img':"res://sprites/Ícone problemas/Arranhões.png"
			},
			{
				'titulo': 'Detritos',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p4.txt',
				'img':"res://sprites/Ícone problemas/Detritos.png"
			}
		],
		'errou': [],
		'acertou': []
	},
	{
		'nome': "Dia 2",
		'emails': [
			{
				'remetente': "Vitória, do Departamento de Controle de Danos",
				'assunto': "Parabenização do primeiro dia",
				'msg': "res://Textos_jogos/Dia_2/emails/msg1.txt"
			
			}
		],
		'id_dia': 2,
		'pontuacao': 0,
		'quiz': [
			{
				'pergunta': 'res://Textos_jogos/Dia_2/quiz/a4.txt',
				'resposta': 'Arranhões',
				'emocao': 'fem_neutro'
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_2/quiz/a5.txt',
				'resposta': 'Danificado',
				'emocao': 'fem_raiva'
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_2/quiz/a6.txt',
				'resposta': 'Memória RAM',
				'emocao': 'mas_feliz'
			}
		],
		'problemas': [
			{
				'titulo': 'Memória RAM',
				'descricao': 'res://Textos_jogos/Dia_2/problemas/p5.txt'
			},
			{
				'titulo': 'Danificado',
				'descricao': 'res://Textos_jogos/Dia_2/problemas/p6.txt'
			},
			{
				'titulo': 'Virús',
				'descricao': 'res://Textos_jogos/Dia_2/problemas/p7.txt'
			}
		],
		'errou': [],
		'acertou': []
	},
	{
		'nome': "Dia 3",
		'emails': [
			{
				'remetente': "Vitória, do Departamento de Controle de Danos",
				'assunto': "Parabenização do primeiro dia",
				'msg': "res://Textos_jogos/Dia_3/emails/msg1.txt"
			
			},
			{
				'remetente': "Lucas Castro",
				'assunto': "Mais uma súplica",
				'msg': "res://Textos_jogos/Dia_3/emails/msg2.txt"
			
			}
		],
		'id_dia': 3,
		'pontuacao': 0,
		'quiz': [
			{
				'pergunta': 'res://Textos_jogos/Dia_3/quiz/a7.txt',
				'resposta': 'Detritos',
				'emocao': 'mas_feliz'
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_3/quiz/a8.txt',
				'resposta': 'Vírus',
				'emocao': 'mas_raiva'
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_3/quiz/a9.txt',
				'resposta': 'Tripala',
				'emocao': 'fem_raiva'
			}
		],
		'problemas': [
			{
				'titulo': 'Modo Avião',
				'descricao': 'res://Textos_jogos/Dia_3/problemas/p8.txt'
			},
			{
				'titulo': 'Tripala',
				'descricao': 'res://Textos_jogos/Dia_3/problemas/p9.txt'
			},
			{
				'titulo': 'Guaraná',
				'descricao': 'res://Textos_jogos/Dia_3/problemas/p10.txt'
			}
		],
		'errou': [],
		'acertou': []
	}
]



var email_atual={}
var pergunta_atual={}
#Sabe o dia atual referente ao seu idOxidação
var dia_atual=1

var trys = 0
var acertosD1 = 0

var first_boot = true
var first_boot_animation = true

var signal_atender = false

var start_game = false
