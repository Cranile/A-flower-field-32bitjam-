extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var roomCount
var currentRoomMax
var currentRoomActual
var inspected

onready var roomCountNode = $rooms/roomsCount
onready var currentRoomNode = $rooms/Control/currentroom
onready var inspectedNode = $rooms/Control/inspected
# Called when the node enters the scene tree for the first time.
func _ready():
	updateData()
	hide()
	pass # Replace with function body.

func toggle():
	if(self.visible):
		hide()
	else:
		updateData()
		show()

func updateData():
	roomCount = Global.rooms_remain
	currentRoomMax = Global.getItemsTotal()
	currentRoomActual = Global.getItemsLeft()
	inspected = 0
	roomCountNode.text = "rooms inspected "+String(roomCount)+"/3"
	if(typeof(currentRoomActual) == TYPE_BOOL):
		currentRoomNode.hide()
		return;
	currentRoomNode.text = "Current room state\ntotal relevant objects: "+String(currentRoomMax) +"\nobjects inspected:"+ String((currentRoomMax - currentRoomActual))
	currentRoomNode.show()
