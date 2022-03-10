extends KinematicBody

export var speed := 15.0
export var jump_strength := 20.0
export var gravity := 50.0
var jumpNum = 0

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

var anim_player
onready var _spring_arm: SpringArm = $SpringArm
onready var _model: Spatial = $Mesh

func _physics_process(delta: float) -> void:
	var is_moving = false
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	
	if _velocity == Vector3.ZERO:
		anim_player.play("Idle")
	elif _velocity != Vector3.ZERO and is_on_floor() == true:
		anim_player.play("Running")
	if is_on_floor():
		jumpNum = 0
	if is_jumping:
		if jumpNum == 0:
			_velocity.y = jump_strength
			_snap_vector = Vector3.UP
			jumpNum = 1
	if Input.is_action_just_pressed("jump"):
		anim_player.play("Jumping")
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		anim_player.stop()
		anim_player.play("Jumping")
		if jumpNum == 1:
			_velocity.y = jump_strength
			_snap_vector = Vector3.UP
			jumpNum = 2
		
	elif just_landed:
		_snap_vector = Vector3.DOWN
		
	if _velocity.length() > 0.2:
		var look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angle()


func _process(_delta: float) -> void:
	_spring_arm.translation = translation

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player = get_node("AnimationPlayer")
	pass # Replace with function body.



func _on_Area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Enter")
	translation = Vector3(-102,2,0)
