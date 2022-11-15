extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$options/ScrollContainer/VBoxContainer/mouse/mouse/current.text = String(get_owner().mouse_sensitivity)
	$options/ScrollContainer/VBoxContainer/mouse/mouse/HSlider.value = Global.mouse_sensitivity
	$options/ScrollContainer/VBoxContainer/dither/dither.pressed = Global.dither
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func hideAll():
	for child in self.get_children():
		child.hide()

func _on_exit_button_up():
	get_tree().quit()
	pass # Replace with function body.


func _on_credits_button_up():
	hideAll()
	$credits.show()
	pass # Replace with function body.


func _on_options_button_up():
	hideAll()
	$options.show()
	pass # Replace with function body.


func _on_menu_visibility_changed():
	hideAll()
	$main.show()
	pass # Replace with function body.

## CREDITS
func _on_dither_button_up():
	OS.shell_open("https://github.com/MenacingMecha/godot-psx-style-demo")
	pass # Replace with function body.

func _on_footsteps_button_up():
	OS.shell_open("https://freesound.org/people/Nox_Sound/sounds/490951/")
	pass # Replace with function body.
	
func _on_base_model_button_up():
	OS.shell_open("https://www.starkcrafts.com/")
	pass # Replace with function body.

func _on_textures_button_up():
	OS.shell_open("https://www.textures.com")
	pass # Replace with function body.


func _on_HSlider_value_changed(value):
	$options/ScrollContainer/VBoxContainer/mouse/mouse/current.text = String( value )
	get_owner().mouse_sensitivity = float($options/ScrollContainer/VBoxContainer/mouse/mouse/current.text)
	Global.mouse_sensitivity = float($options/ScrollContainer/VBoxContainer/mouse/mouse/current.text)
	pass # Replace with function body.

func _on_masterSlide_value_changed(value):
	if(value == 0):
		AudioServer.set_bus_mute(0,true)
		return
	AudioServer.set_bus_mute(0,false)
	AudioServer.set_bus_volume_db(0,value)
	
	pass # Replace with function body.

func _on_full_pressed():
	OS.window_fullscreen = true
	pass # Replace with function body.


func _on_win_pressed():
	OS.window_fullscreen = false
	pass # Replace with function body.


func _on_OptionButton_item_selected(index):
	var res = [[256,448],[640,480],[1280,960],[1920,1080]]
	get_tree().set_screen_stretch(
		SceneTree.STRETCH_MODE_VIEWPORT,
		SceneTree.STRETCH_ASPECT_KEEP,
		Vector2( res[index][0], res[index][1] )
	)
	pass # Replace with function body.

func _on_size2_item_selected(index):
	var res = [[256,448],[640,480],[1280,960],[1920,1080]]
	OS.set_window_size(Vector2( res[index][0], res[index][1] ))
	pass # Replace with function body.


func _on_dither_pressed():
	#disable dither
	Global.ditherChange( $options/ScrollContainer/VBoxContainer/dither/dither.pressed )
	pass # Replace with function body.



