extends StaticBody


export var scene = "";
export var this_scene = "";

func _ready():
	pass # Replace with function body.

func changeScene():
	if(scene == "" || this_scene ==""):
		print("error, no scene assigned")
		return;
	Global.from_scene = this_scene
	print("scene is: ",scene)
	print("this is at:",this_scene)
	get_tree().change_scene(scene)
