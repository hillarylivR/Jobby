using Godot;
using System.Collections.Generic;

public partial class ActSisGlobal : Node
{
	public static ActSisGlobal Instance;

	public List<Celdas> Celdas = new();
	public List<CajaProgr> CajaProgr = new();

	public bool Dragging = false;
	public bool GameOver = false;

	[Signal] public delegate void GameWonEventHandler();

	public override void _Ready()
	{
		Instance = this;
	}

	public Celdas FindCells(int index)
	{
		foreach (var c in Celdas)
			if (c.Index == index) return c;
		return null;
	}

	public void CheckWin()
	{
		foreach (var CajaProgr in CajaProgr)
		{
			if (CajaProgr.Index != CajaProgr.CellIndex)
				return; // aún no está correcto
		}

		GameOver = true;
		GD.Print("¡Nivel completado!");
		EmitSignal(SignalName.GameWon);
	}
}
