extends Node
onready var door = $SlidingDoor


func _on_Button_on_state_changed(state):
	door.open()
	print("Otwieranie drzwi")
