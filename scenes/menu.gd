extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$options/mouse/current.text = String(get_owner().mouse_sensitivity)
	$options/mouse/HSlider.value = Global.mouse_sensitivity
	
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
	$options/mouse/current.text = String( value )
	pass # Replace with function body.


func _on_HSlider_drag_ended(value_changed):
	get_owner().mouse_sensitivity = float($options/mouse/current.text)
	Global.mouse_sensitivity = float($options/mouse/current.text)
	pass # Replace with function body.
