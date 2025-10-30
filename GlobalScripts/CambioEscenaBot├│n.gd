class_name CambioEscenaBoton
extends Button

@export var siguiente_escena: String

func _ready():
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	cambiar_escena()

func cambiar_escena():
	get_tree().change_scene_to_file(siguiente_escena)
