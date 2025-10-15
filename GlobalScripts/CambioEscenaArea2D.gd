class_name CambioEscenaArea2D
extends Area2D

@export var siguiente_escena: String        # Nombre de la escena destino, ejemplo "Lobby"
@export var nombre_npc: String = "Fides"
@export var imagen_npc: Texture = preload("res://Assets/NPC.jpg")

var popup_abierto := false

# Mensajes específicos según la sala de origen
var mensajes_lobby := {
	"IngSistemas": "Llegaste al Lobby desde Ingeniería de Sistemas. Información posterior específica.",
	"Enfermería": "Llegaste al Lobby desde Enfermería. Información diferente."
}

func _on_body_entered(body):
	if body.name != "Player":
		return

	var origen = get_tree().current_scene.name
	var destino = siguiente_escena

	# Caso: desde otra sala hacia Lobby
	if destino == "res://Pantallas/Lobby/Lobby.tscn" and origen in mensajes_lobby:
		var popup_scene = preload("res://GlobalScripts/Popups/PopupInfo.tscn")
		var popup_root = popup_scene.instantiate()  # Node2D root
		get_tree().current_scene.add_child(popup_root)

		var popup = popup_root.get_node("CanvasLayer")  # CanvasLayer con el script
		popup.mostrar_dialogo(nombre_npc, mensajes_lobby[origen], imagen_npc, func():
			call_deferred("cambiar_escena")
		)
	else:
		# Otros casos: cambiar directamente
		call_deferred("cambiar_escena")


func cambiar_escena():
	call_deferred("_cambiar_escena_deferred")

func _cambiar_escena_deferred():
	var ruta = siguiente_escena
	get_tree().change_scene_to_file(ruta)
