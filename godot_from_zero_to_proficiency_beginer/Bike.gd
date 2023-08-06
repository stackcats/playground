class_name Bike

var speed: float
var color: String
var name: String

func _init(new_name: String = 'A New Bike', new_color: String = 'Blue', new_speed: float = 0):
	speed = new_speed
	color = new_color
	name = new_name

func display_name():
	print('Name: ' + name)
	
func display_color():
	print('Color: ' + color)
	
func accelerate():
	speed += 1
	print("New speed: "+str(speed))
