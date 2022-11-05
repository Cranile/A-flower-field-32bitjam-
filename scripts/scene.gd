extends Spatial

func _ready():
	if( Global.from_scene != null):
		get_node("CanvasLayer/ViewportContainer/Viewport/player").transform = get_node(Global.from_scene).transform
	Global.current_scene = self.name
	
	if(self.name == "town" && Global.end):
		Global.canvas.add_child( Dialogic.start("end") )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
