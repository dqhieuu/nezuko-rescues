extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = $AnimationPlayer

onready var INITIAL_TRANSFORM = transform

var is_dead = false

func hurt():
	animation.play("HitRecieve", 0.1)
	
func setStateIdle():
	animation.play("Idle", 0.1)
	
	
func setStateAttack():
	animation.play("Bite_Front", 0.1)
	
func setStateDie():
	animation.play("Death", 0.1)
	yield(get_tree().create_timer(0.5), "timeout")
	is_dead = true

func _init():
	randomize()

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.get_animation("Idle").set_loop(true)

func reset():
	is_dead = false
	visible = true
	transform = INITIAL_TRANSFORM
	setStateIdle()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if is_dead:
		if scale.x >= 0.05:
			scale = scale.linear_interpolate(Vector3.ZERO, 0.15)
		else:
			if visible == true:
				visible = false
		
