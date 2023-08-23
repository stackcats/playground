extends Button



# Called when the node enters the scene tree for the first time.
func _ready():
	connect('pressed', self, 'load_level')
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_level():
	if get_name() == 'RestartButton':
		get_tree().change_scene("res://starting_scene.tscn")
	else:
		get_tree().change_scene("res://level1.tscn")
