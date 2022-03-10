extends Interactable

enum STATE{
	ON,
	OFF
}
onready var door = $SlidingDoor

var position = Vector3(0,0,0)
var position1 = Vector3(0,10,0)

signal open_door

var state

func _ready():
	state = STATE.OFF

func door_open():
	if state == STATE.ON:
		return
	state = STATE.ON
	#door.translate(position1)
	emit_signal("open_door",true)
	#print("signal emmited")
	
func door_close():
	if state == STATE.OFF:
		return
	#Transform(position)
	state = STATE.OFF
	emit_signal("open_door",false)
