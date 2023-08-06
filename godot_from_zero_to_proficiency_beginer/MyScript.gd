extends Node

var number: int
var my_name: String
var counter: int

# Called when the node enters the scene tree for the first time.
func _ready():
	number = 12
	my_name = 'Mario'
	print('Hello ' + my_name + ', your number is ' + str(number))
	counter = 0
	var my_bike = Bike.new()
	my_bike.display_name()
	my_bike.display_color()
	my_bike.accelerate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
