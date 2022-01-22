extends KinematicBody

var space_state
var target
export var speed := 10.0
func _ready():
	space_state = get_world().direct_space_state

func _process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin,Vector3.UP)
			move_to_player()
		else:
			set_color_green()

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")
		set_color_red()

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")
		set_color_green()
		
func move_to_player():
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed, Vector3.UP)

func set_color_red():
	$MeshInstance.get_surface_material(0).set_albedo(Color(1,0,0))
	
func set_color_green():
	$MeshInstance.get_surface_material(0).set_albedo(Color(0,1,0))
