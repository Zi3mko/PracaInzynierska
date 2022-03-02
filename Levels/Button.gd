extends Interactable

enum STATE { 
	OPEN,
	CLOSED
}

onready var state = STATE.CLOSED

onready var anim_player = $AnimationPlayer

signal on_state_changed


func get_interaction_text():
	if state == STATE.OPEN:
		return "to turn off"
	return "to turn on"
	
func interact():
	if anim_player.is_playing():
		return
	if state == STATE.OPEN:
		turn_off()
	else:
		turn_on()
		
func turn_off():
	if anim_player.is_playing():
		return
	if state == STATE.CLOSED:
		return
	state = STATE.CLOSED
	anim_player.play_backwards("press")
	
func turn_on():
	if anim_player.is_playing():
		return
	if state == STATE.OPEN:
		return
	state = STATE.OPEN
	anim_player.play("press")

func _on_AnimationPlayer_animation_finished(_anim_name):
	if state == STATE.OPEN:
		emit_signal("on_state_changed", true)
		print("TRUE")
	else:
		emit_signal("on_state_changed", false)
		print("FALSE")
