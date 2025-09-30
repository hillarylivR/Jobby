using Godot;
using System;

public partial class PanelContainer1 : PanelContainer
{
	public override void _Process(double delta)
	{
		foreach (Node child in GetChildren())
		{
			if (child is Panel panel)
			{
				// Si el panel está dentro del área del contenedor
				if (GetGlobalRect().HasPoint(panel.GlobalPosition))
				{
					GD.Print("Bloque dentro del contenedor: " + panel.Name);
				}
			}
		}
	}
}
