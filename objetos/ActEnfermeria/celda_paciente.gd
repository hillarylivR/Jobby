extends StaticBody2D

signal instrumento_colocado(id_instrumento)

func _on_area_entered(area):
	if area.has_variable("id_instrumento"):
		emit_signal("instrumento_colocado", area.id_instrumento)
