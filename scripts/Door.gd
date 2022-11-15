extends StaticBody


export var scene = "";
export var this_scene = "";

var doubleCheck = true

func _ready():
	pass # Replace with function body.

## this will work as an intermediary for the time being
func changeScene():
	if(scene == "" || this_scene ==""):
		print("error, no scene assigned")
		return;
	## if the player didnt miss anything, let them go
	## if they missed something but clicked twice on a row let them go
	if(!(Global.isMissingStuff()) || Global.isMissingStuff() && !doubleCheck):
			changeMap()
	else:
		createTimer()
		

func createTimer():
	Global.canvas.add_child( Dialogic.start("hint") )
	doubleCheck = false
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", self, "_on_timer_timeout")


func changeMap():
	Global.from_scene = this_scene
	get_tree().change_scene(scene)
	pass

func _on_timer_timeout():
	doubleCheck = true
