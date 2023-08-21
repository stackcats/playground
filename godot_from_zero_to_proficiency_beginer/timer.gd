extends Node

var time : float = 0
var counter : int = 100

onready var timer_ui:Label = get_node("../timerUI")
onready var user_message_ui: Label = get_node('../userMessageUI')

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_ui.set_text('')
	user_message_ui.set_text('')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > 1:
		counter += 1
		time = 0
		var seconds = counter % 60
		var minutes = counter / 60
		timer_ui.set_text("%d:%d" %[minutes,seconds])
		if counter > 118:
			user_message_ui.set_text("Time Almost Up")
		elif counter > 120:
			user_message_ui.set_text("Time Up")
			get_tree().change_scene("res://scene1.tscn")
