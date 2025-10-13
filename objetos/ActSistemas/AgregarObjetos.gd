extends Node2D

@onready var caja_escena = preload("res://objetos/ActSistemas/Cajas/Caja1.tscn")
@onready var celda_escena = preload("res://objetos/ActSistemas/Celdas/Celda.tscn")
var numCajas = 0

func _ready():
	var textos = ['numeros = [2, 4, 6, 8]\n suma = 0', 'for n in numeros:\n suma += n', 'print("La suma es:", suma)']
	var posiciones = [Vector2(50, 300), Vector2(50, 200), Vector2(50, 100)]

	for i in range(textos.size()):
		var caja = caja_escena.instantiate()
		caja.texto = textos[i]
		caja.position = posiciones[i]
		add_child(caja)
		numCajas += 1
	crear_celdas(numCajas)

func crear_celdas(num):
	var c = 80
	for i in range(num):
		var celda = celda_escena.instantiate()
		celda.position = Vector2(600, c)
		add_child(celda)
		c += 100
		
