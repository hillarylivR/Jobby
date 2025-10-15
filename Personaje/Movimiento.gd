extends CharacterBody2D

@export var speed = 350

func get_input():
	var input_direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
