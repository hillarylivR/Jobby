/**/
using Godot;
using System;

public partial class CameraFollow : Camera2D
{
	private Node2D personaje;

	public override void _Ready()
	{
		personaje = GetNode<Node2D>("Personaje");
	}
	public override void _Process(double delta)
	{
		if (personaje != null)
		{
			Position = personaje.Position;
		}
	}
}
