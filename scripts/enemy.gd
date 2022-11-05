extends KinematicBody

onready var nav = get_parent()
onready var player = get_parent().get_node("player")
onready var followTimer = $followTimer

var path = []
var path_node = 0

var speed = 7
var threshhold = .2

var followPlayer = false
var isInRange = false
var velocity = Vector3.ZERO
var lastKnownPos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	
	if(isInRange and !followPlayer):
		aim()
	if(followPlayer):
		var playerpos = player.translation
		look_at(Vector3(playerpos.x, global_transform.origin.y, playerpos.z), Vector3.UP)
		
		if path.size() > 0:
			move_to()
	pass

func move_to():
	if( path_node == path.size() ):
		
		return
	
	if( global_transform.origin.distance_to(path[path_node]) < threshhold):
		
		path_node += 1
	else:
		var direction = path[path_node] - global_transform.origin
		velocity = direction.normalized() * speed
		
		move_and_slide(velocity,Vector3.UP)

func aim():
	
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(self.translation, player.translation, [self], 25)
	if result and result.collider.name == "player":
		followPlayer = true
		get_target_path()
		followTimer.start()
	elif result and !result.collider.name == "player":
		followTimer.stop()
		followPlayer = false
		lastKnownPos = player.translation

func get_target_path():
	
	path = nav.get_simple_path(global_transform.origin, player.global_transform.origin)
	path_node = 0

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		isInRange = true

func _on_followTimer_timeout():
	aim()

func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		isInRange = false

func _on_Area2_body_entered(body):
	print("collision")
	
	pass # Replace with function body.
