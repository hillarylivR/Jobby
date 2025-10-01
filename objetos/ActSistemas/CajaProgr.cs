using Godot;

public partial class CajaProgr : Area2D
{
	public int Index = -1;      // índice correcto
	public int CellIndex = -1;  // dónde se colocó

	private bool dragging = false;
	private Vector2 dragOffset = Vector2.Zero;

	private Sprite2D sprite;

	public override void _Ready()
	{
		sprite = GetNode<Sprite2D>("Sprite2D");

		// conectar señal de input_event en C#
		this.Connect("input_event", new Callable(this, nameof(OnInputEvent)));
	}

	public void InitPiece(int index, Texture2D texture, Vector2 startPos)
	{
		Index = index;
		sprite.Texture = texture;
		Position = startPos;
	}

	public void OnInputEvent(Node viewport, InputEvent @event, int shapeIdx)
	{
		if (ActSisGlobal.Instance.GameOver)
			return;

		if (@event is InputEventMouseButton mouse && mouse.ButtonIndex == MouseButton.Left)
		{
			if (mouse.Pressed)
			{
				if (CellIndex != -1)
				{
					var Celdas = ActSisGlobal.Instance.FindCells(CellIndex);
					Celdas?.Unoccupy();
					CellIndex = -1;
				}
				dragging = true;
				ActSisGlobal.Instance.Dragging = true;
				ZIndex = 100;
				dragOffset = GlobalPosition - GetGlobalMousePosition();
			}
			else
			{
				dragging = false;
				ActSisGlobal.Instance.Dragging = false;
				ZIndex = 0;
				DropPiece();
				ActSisGlobal.Instance.CheckWin();
			}
		}
		else if (@event is InputEventMouseMotion && dragging)
		{
			GlobalPosition = GetGlobalMousePosition() + dragOffset;
		}
	}

	private void DropPiece()
	{
		foreach (var area in GetOverlappingAreas())
		{
			if (area is Celdas Celdas && Celdas.IsInGroup("Celdas") && Celdas.IsFree())
			{
				CellIndex = Celdas.Index;
				Celdas.Occupy();
				GlobalPosition = Celdas.GlobalPosition;
				return;
			}
		}
	}
}
