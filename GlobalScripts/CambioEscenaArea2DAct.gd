class_name CambioEscenaArea2DAct
extends Area2D

@export var siguiente_escena: String        # Ruta completa de la escena destino
@export var nombre_npc: String = "Guía"
@export var imagen_npc: Texture = preload("res://Assets/personajes/NPC.jpg")


func _on_body_entered(body):
	if siguiente_escena == "res://Pantallas/IngSistemas/ActividadSis1.tscn":
		var popup_scene = preload("res://GlobalScripts/Popups/PopupInfo.tscn")
		var popup_root = popup_scene.instantiate()
		get_tree().current_scene.add_child(popup_root)

		var popup = popup_root.get_node("CanvasLayer")
		popup.mostrar_dialogo(
			nombre_npc,
			"Bienvenido a la Actividad de Ingeniería de Sistemas.\n\nSigue las instrucciones en pantalla y completa los pasos de la simulación para avanzar.",
			imagen_npc,
			func():
				call_deferred("cambiar_escena")
		)
	else:
		call_deferred("cambiar_escena")


func cambiar_escena():
	call_deferred("_cambiar_escena_deferred")

func _cambiar_escena_deferred():
	get_tree().change_scene_to_file(siguiente_escena)


func _on_computador_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
