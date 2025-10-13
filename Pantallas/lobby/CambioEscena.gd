class_name CambioEscena
extends Area2D

@export var siguiente_escena: String

func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player":
		cambiar_escena()
		
func cambiar_escena():
	get_tree().change_scene_to_file(siguiente_escena)
