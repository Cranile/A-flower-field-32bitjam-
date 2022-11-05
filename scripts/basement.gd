extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var firstCall = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_scene = self.name
	if( Global.from_scene != null):
		get_node("CanvasLayer/ViewportContainer/Viewport/player").transform = get_node(Global.from_scene).transform
	if(!Global.wall_state):
		$walls/wall_destructible.queue_free()
		
	else:
		Global.connect("wall_broken", self, "_on_Global_wall_broken" )
	pass # Replace with function body.

func _on_Global_wall_broken():
	$destruction.start()
	
func _on_destruction_timeout():
	$walls/wall_destructible.queue_free()
	pass # Replace with function body.
