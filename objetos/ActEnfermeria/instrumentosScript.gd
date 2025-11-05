extends Node2D

var draggable: bool = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

@export var id_instrumento: int = 0
@onready var sprite = $Estetoscopio
@export var textura: Texture2D

func _ready():
	if textura:
		sprite.texture = textura
		
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				draggable = true
			else:
				draggable = false

func _process(delta):
	if draggable:
		global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			GlobalSistemas.is_dragging = true

		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset

		elif Input.is_action_just_released("click"):
			GlobalSistemas.is_dragging = false
			var tween = get_tree().create_tween()

			if is_inside_dropable and body_ref != null:
				var CeldaPos = body_ref.global_position
				tween.tween_property(self, "position", CeldaPos, 0.2).set_ease(Tween.EASE_OUT)

				if body_ref.has_method("set_caja_actual"):
					body_ref.set_caja_actual(self)
				elif "caja_actual" in body_ref:
					body_ref.caja_actual = self
					get_parent().verificar_orden()
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	if not GlobalSistemas.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited():
	if not GlobalSistemas.is_dragging:
		draggable = false
		scale = Vector2(1, 1)

func _on_area_2d_body_entered(body: StaticBody2D):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_BLUE, 0.7)
