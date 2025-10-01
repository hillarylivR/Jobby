using Godot;

public partial class Celdas : Area2D
{
	public int Index = -1;
	public bool Occupied = false;

	private CollisionShape2D colShape;
	private Sprite2D sprite;

	public override void _Ready()
	{
		colShape = GetNode<CollisionShape2D>("CollisionShape2D");
		sprite = GetNode<Sprite2D>("Sprite2D");
	}

	public void InitCell(int index, Vector2 size)
	{
		Index = index;
		if (colShape.Shape is RectangleShape2D rect)
			rect.Size = size;
	}

	public bool IsFree() => !Occupied;
	public void Occupy() => Occupied = true;
	public void Unoccupy() => Occupied = false;
}
