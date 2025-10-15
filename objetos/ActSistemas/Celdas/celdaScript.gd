extends StaticBody2D

@export var celda_id: int
var caja_actual: Node = null

func _ready():
	modulate = Color(Color.MEDIUM_SLATE_BLUE, 0.7)
