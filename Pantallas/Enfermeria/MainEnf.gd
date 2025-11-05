extends Node2D

@onready var check1 = $Checks/Check1
@onready var check2 = $Checks/Check2
@onready var check3 = $Checks/Check3
@onready var celda = $CeldaPaciente

func _ready():
	celda.connect("instrumento_colocado", Callable(self, "_on_instrumento_colocado"))

func _on_instrumento_colocado(id_instrumento):
	match id_instrumento:
		1:
			check1.visible = true
		2:
			check2.visible = true
		3:
			check3.visible = true
