extends Interactable

enum STATE{
	ON,
	OFF
}

onready var state = STATE.OFF

onready var anim_player = $AnimationPlayer

signal open_door

func get_interaction_text():
	if state == STATE.OFF:
		return "Wcisnij przycisk by otworzyc drzwi"
	
func interact():
	
	if anim_player.is_playing():
		return
	
	if state == STATE.OFF:
		turn_on()
	else:
		turn_off()
		
func turn_on():
	
	if anim_player.is_playing():
		return
	
	if state == STATE.ON:
		return

	state = STATE.ON 
	anim_player.play("press")

func turn_off():
	if state == STATE.OFF:
		return
	state = STATE.OFF
	anim_player.play_backwards("press")

	


func _on_AnimationPlayer_animation_finished(anim_name):
	if state == STATE.ON:
		emit_signal("open_door",true)
	else:
		emit_signal("open_door",false)
