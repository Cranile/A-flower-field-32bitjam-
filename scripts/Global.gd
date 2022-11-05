extends Spatial


var from_scene
var current_scene
var tutorial = false
var inspection_count = 0

var mouse_sensitivity = 0.1
var wall_state = true
signal wall_broken

var end = false

var canvas

var important_items_apo = ["bed_apo","table_apo","jars","apothecary_shelve"]
var important_items_mayor = ["library1","library2","library3","desk"]
var important_items_basement = ["boxes","book_forbiden"]

var total_items_remain
func _ready():
	total_items_remain = important_items_apo.size() + important_items_mayor.size() + important_items_basement.size()
	print("left: ", total_items_remain)
	pass # Replace with function body.

func breakWall():
	print("call break wall")
	wall_state = false
	emit_signal("wall_broken")
	
func isMissingStuff():
	if(current_scene == "mayorHouse"):
		if(important_items_mayor.size() <= 0):
			return false
		else:
			return true
	elif(current_scene == "playerHouse"):
		if(important_items_basement.size() <= 0):
			return false
		else:
			return true
	elif(current_scene == "apothecary"):
		if(important_items_apo.size() <= 0):
			return false
		else:
			return true
	else:
		return false

func inspect(item):
	
	if(current_scene == "mayorHouse"):
		var search = important_items_mayor.find(item)
		if(search != -1):
			important_items_mayor.remove(search)
			

	elif(current_scene == "playerHouse"):
		var search = important_items_basement.find(item)
		if(search != -1):
			important_items_basement.remove(search)
			

	elif(current_scene == "apothecary"):
		print(important_items_apo, " , ", item)
		var search = important_items_apo.find(item)
		if(search != -1):
			important_items_apo.remove(search)
			
	
	total_items_remain = important_items_apo.size() + important_items_mayor.size() + important_items_basement.size()
	print("left: ",total_items_remain)
	if(total_items_remain <= 0):
		end = true
		print("end")
