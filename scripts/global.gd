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
				'resposta': 'Mal Contato'
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_1/quiz/a2.txt',
				'resposta': 'Oxidação'
			},
			{
				'pergunta': 'res://Textos_jogos/Dia_1/quiz/a3.txt',
				'resposta': 'Arranhões'
			}
		],
		'problemas': [
			{
				'titulo': 'Mal Contato',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p1.txt'
			},
			{
				'titulo': 'Oxidação',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p2.txt'
			},
			{
				'titulo': 'Arranhões',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p3.txt'
			},
			{
				'titulo': 'Detritos',
				'descricao': 'res://Textos_jogos/Dia_1/problemas/p4.txt'
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
