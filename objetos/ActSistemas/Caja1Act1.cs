using Godot;
using System;

public partial class Caja1Act1 : Panel
{
	private bool _dragging = false;
	private Vector2 _dragOffset;
	private Node? _originalParent = null;
	private Vector2 _originalPosition = Vector2.Zero;

	public override void _GuiInput(InputEvent @event)
	{
		// Click izquierdo: comenzar / terminar arrastre
		if (@event is InputEventMouseButton mb && mb.ButtonIndex == MouseButton.Left)
		{
			if (mb.Pressed)
			{
				// INICIO DEL ARRASTRE
				_dragging = true;
				_dragOffset = mb.Position;

				// Guardar estado original
				_originalParent = GetParent();
				_originalPosition = Position;

				// REPARENT al root de la escena
				var sceneRoot = GetTree().CurrentScene as Control;
				if (sceneRoot != null && GetParent() != sceneRoot)
				{
					var globalBefore = GlobalPosition;
					_originalParent.RemoveChild(this);
					sceneRoot.AddChild(this);
					GlobalPosition = globalBefore;
				}

				// Llevar al frente
				MoveToFront();
			}
			else
			{
				// FIN DEL ARRASTRE
				_dragging = false;
				TrySnapToDropZoneOrReturn();
			}
		}
		// Movimiento del mouse
		else if (@event is InputEventMouseMotion mm && _dragging)
		{
			GlobalPosition = GetGlobalMousePosition() - _dragOffset;
		}
	}

	private void TrySnapToDropZoneOrReturn()
	{
		Rect2 myRect = GetGlobalRect();

		foreach (object obj in GetTree().GetNodesInGroup("drop_zone"))
		{
			if (obj is Control zone)
			{
				Rect2 zoneRect = zone.GetGlobalRect();
				if (zoneRect.Intersects(myRect))
				{
					GetParent().RemoveChild(this);
					zone.AddChild(this);

					// Centrar dentro del slot
					Vector2 targetLocal = (zone.Size - Size) / 2;
					Position = targetLocal;
					return;
				}
			}
		}

		// Si no cae en zona válida → volver al padre original
		if (_originalParent != null)
		{
			GetParent().RemoveChild(this);
			_originalParent.AddChild(this);

			if (!(_originalParent is Container))
				Position = _originalPosition;
		}
	}
}
