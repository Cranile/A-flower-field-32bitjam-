extends KinematicBody

var speed 
var default_speed = 10
var sprint_speed = 16
var accel = 20
var gravity = 9.8
var jump = 5

var mouse_sensitivity = 0.1
var hp = 2;


var sprinting = false
var stepSoundFrequency = [0.5,0.3]

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

var preventMove = false

var target

onready var UI = $head/Camera/UI
onready var menu = $head/Camera/UI/menu
onready var tutorial = $head/Camera/UI/tutorial
onready var crosshair = $head/Camera/UI/crosshair
onready var head = $head
onready var raycast = $head/RayCast

##var canvas

func _ready():
	Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
	Global.canvas = get_parent().get_parent()
	mouse_sensitivity = Global.mouse_sensitivity

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			menu.show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			menu.hide()
			Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
			
	if Input.is_action_just_pressed("objectives"):
		Global.openObjectives()

	direction = Vector3()
	
	speed = default_speed
	if(preventMove):
		return
	
	if raycast.is_colliding():
		crosshair.color = "#e02c2c"
		if(!Global.tutorial):
			tutorial.show()
			$timer.start()
			Global.tutorial = true
	elif(crosshair.color.to_html(false) != "ffffff"):
		crosshair.color = "#ffffff"
	
		
	if not is_on_floor():
		fall.y -= gravity * delta
	
	if Input.is_action_just_pressed("interact") && raycast.is_colliding():
		target = raycast.get_collider()
		
		if( target.is_in_group("npc") ):
			startConversation(target.get_owner().name)
		elif( target.is_in_group("door") ):
			print("door")
			target.changeScene()
		elif( target.is_in_group("object") ):
			print(target.get_parent().name)
			startConversation(target.get_parent().name)
	
	if Input.is_action_just_pressed("sprint"):
		sprinting = !sprinting
	
	if sprinting:
		speed = sprint_speed
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_backwards"):
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	if(direction != Vector3.ZERO):
		if($footstep_timer.time_left <= 0):
			$AudioStreamPlayer3D.pitch_scale = rand_range(0.9,1.4)
			$AudioStreamPlayer3D.play()
			$footstep_timer.start(stepSoundFrequency[int(sprinting)])
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP)

func recieve_damage():
	hp -= 1
	if(hp <= 0):
		print("game over")

func endScene():
	var new_dialog


func startConversation(npcName):
	var new_dialog
	if(npcName == "captain" && Global.end):
		$AnimationPlayer.play("blackout")
		new_dialog = Dialogic.start("after_end")
		preventMove = true
	elif(npcName == "captain"):
		new_dialog = Dialogic.start("introduction")
	elif(npcName == "researcher 1"):
		new_dialog = Dialogic.start("generator")
	elif(npcName == "researcher 2"):
		new_dialog = Dialogic.start("mayor")
	elif(npcName == "researcher 3"):
		new_dialog = Dialogic.start("apothecary")
	elif(npcName == "researcher 4"):
		new_dialog = Dialogic.start("basement")
	elif(npcName == "guard 1"):
		new_dialog = Dialogic.start("guard_1")
	elif(npcName == "guard 2"):
		new_dialog = Dialogic.start("guard_2")
	elif(npcName == "guard 3"):
		new_dialog = Dialogic.start("guard_3")
	elif(npcName == "ballistics expert"):
		new_dialog = Dialogic.start("barrack")
	elif(npcName == "medical researcher"):
		new_dialog = Dialogic.start("medical")
	elif(npcName == "bed_apo"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("bedapo")
	elif(npcName == "table_apo"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("tableapo")
	elif(npcName == "jars"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("jars")
	elif(npcName == "apothecary_shelve"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("aposhelve")
	elif(npcName == "boxes"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("boxes_basement")
	elif(npcName == "woodenPlanks"):
		new_dialog = Dialogic.start("planks_basement")
	elif(npcName == "wall_destructible"):
		Global.connect("wall_broken", self, "_on_Global_wall_broken" )
		new_dialog = Dialogic.start("strangewall_basement")
	elif(npcName == "book_forbiden"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("book_forbiden")
	elif(npcName == "library1"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("library1")
	elif(npcName == "library2"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("library2")
	elif(npcName == "library3"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("library3")
	elif(npcName == "chair"):
		new_dialog = Dialogic.start("chair")
	elif(npcName == "desk"):
		## register
		Global.inspect(npcName)
		new_dialog = Dialogic.start("desk")
	elif(npcName == "lake"):
		new_dialog = Dialogic.start("lake")

	if new_dialog != null:
		createNewDialogue(new_dialog)
		new_dialog.connect("timeline_end", self, "endConversation")

func createNewDialogue(new_dialog):
	preventMove = true
	Global.canvas.add_child(new_dialog)
	
func endConversation(timeline_end):
	preventMove = false

func _on_timer_timeout():
	tutorial.hide()
	pass # Replace with function body.

func _on_Global_wall_broken():
	$AnimationPlayer.play("blackout")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "blackout" && !(Global.end)):
		$AnimationPlayer.play("blackout_end")
	pass # Replace with function body.
