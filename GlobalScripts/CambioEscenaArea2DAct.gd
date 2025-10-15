class_name CambioEscena
extends Area2D

@export var siguiente_escena: String
@export var nombre_npc: String = "Guía"
@export var mensaje: String = "¿Deseas entrar a esta área?"
@export var imagen_npc: Texture = preload("res://Assets/NPC.jpg")

var popup_abierto := false

func _on_body_entered(body):
	if body.name != "Player":
		return

	# Popup para ir al Lobby
	if siguiente_escena.ends_with("Lobby.tscn"):
		if popup_abierto:
			return
		popup_abierto = true

		var popup_scene = preload("res://GlobalScripts/Popups/PopupInfo.tscn")
		var popup_root = popup_scene.instantiate()  # Node2D root
		get_tree().current_scene.add_child(popup_root)

		var popup = popup_root.get_node("CanvasLayer")  # CanvasLayer con el script
		popup.mostrar_dialogo(nombre_npc, mensaje, imagen_npc, func():
			call_deferred("cambiar_escena")
		)

	# Popup para ir a Actividad1
	elif siguiente_escena.ends_with("Actividad1.tscn"):
		if popup_abierto:
			return
		popup_abierto = true

		var popup_scene = preload("res://GlobalScripts/Popups/PopupActividades.tscn")
		var popup_root = popup_scene.instantiate()
		get_tree().current_scene.add_child(popup_root)

		var popup = popup_root.get_node("CanvasLayer")
		popup.mostrar_dialogo(nombre_npc, mensaje, imagen_npc, func():
			call_deferred("cambiar_escena")
		)

	# Para otras escenas, cambia directo
	else:
		call_deferred("cambiar_escena")

func cambiar_escena():
	call_deferred("_cambiar_escena_deferred")

func _cambiar_escena_deferred():
	get_tree().change_scene_to_file(siguiente_escena)
