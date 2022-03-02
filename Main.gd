extends Node
onready var door = $SlidingDoor


func _on_Button_on_state_changed():
	door.open()
	print("Otwieranie drzwi")
