class_name CambioEscenaArea2D
extends Area2D

@export var siguiente_escena: String        # Ruta completa de la escena destino
@export var nombre_npc: String = "Guía"
@export var imagen_npc: Texture = preload("res://Assets/personajes/akchuali.png")

var popup_abierto := false

# Rutas posibles de imágenes del NPC
var imagenes_npc = [
	"res://Assets/personajes/akchuali.png",
	"res://Assets/personajes/bobotonto.png",
	"res://Assets/personajes/god.png",
	"res://Assets/personajes/oky.png",
	"res://Assets/personajes/oyeoye.png"
]

# Mensajes específicos según la sala de origen
var mensajes_lobby := {
	"IngSistemas": "Llegaste al Lobby desde Ingeniería de Sistemas. Información posterior específica.",
	"Enfermeria": "Llegaste al Lobby desde Enfermería. Información diferente.",
	"Administracion": "Llegaste al Lobby desde Administración de Empresas. Información diferente."
}

func _ready():
	# Cargar aleatoriamente una imagen diferente al iniciar
	randomize()  # asegura que no repita siempre la misma
	var aleatoria = imagenes_npc[randi() % imagenes_npc.size()]
	imagen_npc = load(aleatoria)


func _on_body_entered(body):
	if body.name != "Player":
		return

	var origen = get_tree().current_scene.name
	var destino = siguiente_escena

	# Caso: desde otra sala hacia Lobby
	if destino == "res://Pantallas/Lobby/Lobby.tscn" and origen in mensajes_lobby:
		var popup_scene = preload("res://GlobalScripts/Popups/PopupInfo.tscn")
		var popup_root = popup_scene.instantiate()
		get_tree().current_scene.add_child(popup_root)

		var popup = popup_root.get_node("CanvasLayer")
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
