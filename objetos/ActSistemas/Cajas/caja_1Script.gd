extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

@onready var label = $Label
@export var texto: String = "HOLA HOLA"

func _ready():
	label.text = texto

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			GlobalSistemas.is_dragging = true
			
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		
		elif Input.is_action_just_released("click"):
			var shape_center = body_ref.get_node("CollisionShape2D").global_position
			GlobalSistemas.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self, "position", shape_center, 0.2).set_ease(Tween.EASE_OUT)
			else: 
				tween.tween_property(self, "global_position", shape_center, 0.2).set_ease(Tween.EASE_OUT)

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
