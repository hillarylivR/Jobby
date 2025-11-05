extends Node2D

@onready var img_escena = preload("res://Objetos/ActEnfermeria/Instrumentos.tscn")

var imagenes = [
	preload("res://Assets/actividades/estetoscopio.png"),
	preload("res://Assets/actividades/presion.png"),
	preload("res://Assets/actividades/canalizador.png"),
	preload("res://Assets/actividades/medicina.webp")
]

func _ready():
	var numInstrumentos = imagenes.size()
	var separacion = 150
	var pos_y = 480
	var inicio_x = 550

	for i in range(numInstrumentos):
		var instrumento = img_escena.instantiate()
		instrumento.position = Vector2(inicio_x + i * separacion, pos_y)

		instrumento.textura = imagenes[i]

		add_child(instrumento)
