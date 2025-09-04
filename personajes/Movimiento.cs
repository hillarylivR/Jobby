using Godot;
using System;

public partial class Movimiento : CharacterBody2D
{
	[Export]
	public float Speed { get; set; } = 300f; //Velocidad del personaje

	public override void _PhysicsProcess(double delta)
	{
		Vector2 direction = Vector2.Zero;

		float x = Input.GetAxis("izquierda", "derecha");
		float y = Input.GetAxis("arriba", "abajo");

		direction = new Vector2(x, y);

		// Normalizar para evitar que en diagonal sea más rápido
		if (direction != Vector2.Zero)
			direction = direction.Normalized();

		// Aplicar movimiento
		Velocity = direction * Speed;
		MoveAndSlide();
	}
}
