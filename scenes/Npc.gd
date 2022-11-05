extends Spatial

# Called when the node enters the scene tree for the first time.
export var weaponEnabled = false

func _ready():
	if(weaponEnabled):
		$PSX_Guard_Body/gun.show()
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
