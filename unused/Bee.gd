extends Spatial
signal hit_player
signal kill_player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = get_node("AnimationPlayer")

func hurt():
	animation.play("HitRecieve", 0.1)
	
func setStateIdle():
	animation.play("Flying", 0.1)
	
func setStateAttack():
	animation.play("Bite_Front", 0.1)
	
func setStateDie():
	animation.play("Death", 0.1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
