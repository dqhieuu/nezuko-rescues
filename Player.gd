extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 30
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
export var jump_impulse = 20
export var bounce_impulse = 16
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float, 0.1, 1) var mouse_sensitivity: float = 0.5
export(float, -50, 0) var min_pitch: float = -50
export(float, 0, 50) var max_pitch: float = 50

onready var camera_pivot = $CameraPivot
onready var camera = $CameraPivot/SpringArm/Camera
onready var animation = $Pivot/nezuko/AnimationPlayer

var velocity = Vector3.ZERO

var is_camera_moving = false
var dest_camera_transform = Transform()

func setStateRun():
	animation.play("run", 0.1)

func setStateIdle():
	animation.play("idle", 0.1)

func setStateGetHit():
	animation.play("head_hit", 0.1)
	
func setStateCombatIdle():
	animation.play("combat_idle", 0.1)
	
func setStateAttack():
	animation.play("flip_kick", 0.1, 1.5)

func setStateDie():
	animation.play("death_animation", 0.1)

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
#	# We create a local variable to store the input direction.
#	var direction = Vector3.ZERO
#
#	# We check for each move input and update the direction accordingly.
#	if Input.is_action_pressed("move_right"):
#		direction += transform.basis.x
#	if Input.is_action_pressed("move_left"):
#		direction -= transform.basis.x
#	if Input.is_action_pressed("move_back"):
#		# Notice how we are working with the vector's x and z axes.
#		# In 3D, the XZ plane is the ground plane.
#		direction += transform.basis.z
#	if Input.is_action_pressed("move_forward"):
#		direction -= transform.basis.z
#	if direction != Vector3.ZERO:
#		direction = direction.normalized()
#		get_node("Pivot").look_at(translation + direction, Vector3.UP)
#		setStateRun()
#	else:
#		setStateIdle()
#	velocity.x = direction.x * speed
#	velocity.z = direction.z * speed
#	# Vertical velocity
#	velocity.y -= fall_acceleration * delta
#	velocity = move_and_slide(velocity, Vector3.UP)

	lerp_cam_pos()

#func get_transform_difference(t1: Transform, t2: Transform):
#	var t_origin_diff = (t1.origin-t2.origin).abs()
#	var t_basis_diff = (t1.basis.x-t2.basis.x).abs()+(t1.basis.y-t2.basis.y).abs()+(t1.basis.z-t2.basis.z).abs()
#	var t_diff = t_origin_diff + t_basis_diff*180/PI
#	print(t_diff.x + t_diff.y + t_diff.z)
#	return t_diff.x + t_diff.y + t_diff.z
#
	

func change_camera_pos(transform):
	is_camera_moving = true
	dest_camera_transform = transform


func lerp_cam_pos():
	if not is_camera_moving:
		return
#	if get_transform_difference(camera_pivot.transform, dest_camera_transform) <= 1:
#		camera_pivot.transform = dest_camera_transform
#		is_camera_moving = false
#		print("DONE")
#		return
	var prev_transform = camera_pivot.transform
	camera_pivot.transform.basis = prev_transform.basis.slerp(dest_camera_transform.basis, 0.1)
	camera_pivot.transform.origin = prev_transform.origin.linear_interpolate(dest_camera_transform.origin, 0.1)
	
	
func camera_pos_side():
	change_camera_pos(Transform(Basis(Vector3(-16*PI/180,-87*PI/180,0)), Vector3(-13,15.58,0.85)))

func camera_pos_back():
	change_camera_pos(Transform(Basis(Vector3(-16*PI/180,-147*PI/180,0)), Vector3(-4.66,15.58,-3.86)))
	
	
#func _input(event):
#	if event is InputEventMouseMotion:
#		rotation_degrees.y -= event.relative.x * mouse_sensitivity
#		camera_pivot.rotation_degrees.x -= event.relative.y * mouse_sensitivity
#		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, min_pitch, max_pitch)
#	pass
	
#func _ready():
#	camera_pos_side()
#	yield(get_tree().create_timer(3.0), "timeout")
#	camera_pos_back()
#	setStateAttack()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass# Replace with function body.
