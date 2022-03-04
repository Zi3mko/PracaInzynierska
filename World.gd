extends Spatial

onready var door = $SlidingDoor
var doors = load("res://Levels/SlidingDoor.gd").new()

var position = Vector3(0,-20,0)
var position1 = Vector3(0,20,0)

func _on_Button_open_door(state):
	if state == true:
		doors.door_open()
		door.translate(position1)
	if state == false:
		doors.door_close()
		door.translate(position)
	pass
