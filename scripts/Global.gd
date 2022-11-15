extends Spatial

var from_scene
var current_scene
var tutorial = false

var mouse_sensitivity = 0.1
var wall_state = true
signal wall_broken

var dither = true
var dither_col = 15

var end = false

var canvas

var important_items_apo = ["bed_apo","table_apo","jars","apothecary_shelve"]
var important_items_mayor = ["library1","library2","library3","desk"]
var important_items_basement = ["boxes","book_forbiden"]

var apo_items_max 
var mayor_items_max
var basement_items_max 

var mayorDone = false
var apoDone = false
var basementDone = false

var rooms_remain = 0
var total_items_remain
func _ready():
	apo_items_max = important_items_apo.size()
	mayor_items_max = important_items_mayor.size()
	basement_items_max = important_items_basement.size()
	
	total_items_remain = apo_items_max + mayor_items_max + basement_items_max
	
	pass # Replace with function body.

func breakWall():

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

func getItemsLeft():
	if(current_scene == "mayorHouse"):
		
		return important_items_mayor.size()
	elif(current_scene == "playerHouse"):
		
		return important_items_basement.size()
	elif(current_scene == "apothecary"):
		
		return important_items_apo.size()
	else:
		return false
func getItemsTotal():
	if(current_scene == "mayorHouse"):
		print(mayor_items_max)
		return mayor_items_max
	elif(current_scene == "playerHouse"):
		print("2")
		return basement_items_max
	elif(current_scene == "apothecary"):
		print("3")
		return apo_items_max
	else:
		print("4")
		return false

func inspect(item):
	if(current_scene == "mayorHouse"):
		var search = important_items_mayor.find(item)
		if(search != -1):
			important_items_mayor.remove(search)
		if(!isMissingStuff() && !mayorDone):
			rooms_remain += 1
			mayorDone = true

	elif(current_scene == "playerHouse"):
		var search = important_items_basement.find(item)
		if(search != -1):
			important_items_basement.remove(search)
		if(!isMissingStuff() && !basementDone):
			rooms_remain += 1
			basementDone = true

	elif(current_scene == "apothecary"):
		print(important_items_apo, " , ", item)
		var search = important_items_apo.find(item)
		if(search != -1):
			important_items_apo.remove(search)
		if(!isMissingStuff() && !apoDone):
			rooms_remain += 1
			apoDone = true
	
	total_items_remain = important_items_apo.size() + important_items_mayor.size() + important_items_basement.size()
	
	if(total_items_remain <= 0):
		end = true

func openObjectives():
	get_node("/root/"+current_scene+"/CanvasLayer/ViewportContainer/objectives").toggle()

func ditherChange(param):
	dither = param
	if(param):
		dither_col = 15
	else:
		dither_col = 256
		
	get_node("/root/"+current_scene).updateDither()
	pass
