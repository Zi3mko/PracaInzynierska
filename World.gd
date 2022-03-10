extends Spatial

onready var door = $SlidingDoor
var doors = load("res://Levels/SlidingDoor.gd").new()

var position = Vector3(0,-20,0)
var position1 = Vector3(0,20,0)

onready var player = $Player
onready var pos = $Position3D

func _on_Button_open_door(state):
	if state == true:
		doors.door_open()
		door.translate(position1)
	if state == false:
		doors.door_close()
		door.translate(position)
	pass

func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()

func _on_Area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	player.translation = pos.translation

func _on_EndOfGame_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	get_tree().change_scene("res://EndMenu.tscn")
