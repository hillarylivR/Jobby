extends CanvasLayer

@onready var fondo = $ColorRect
@onready var npc_imagen = $HBoxContainer/TextureRect
@onready var nombre_label = $HBoxContainer/VBoxContainer/Label
@onready var texto_label = $HBoxContainer/VBoxContainer/Label2

var mostrando := false
var callback: Callable = Callable()  # Función a ejecutar al cerrar

func mostrar_dialogo(nombre: String, texto: String, imagen: Texture, cuando_cierre: Callable = Callable()):
	nombre_label.text = nombre
	texto_label.text = texto
	npc_imagen.texture = imagen
	visible = true
	mostrando = true
	callback = cuando_cierre

func _input(event):
	if mostrando and event is InputEventMouseButton and event.pressed:
		visible = false
		mostrando = false
		if callback.is_valid():
			callback.call()
