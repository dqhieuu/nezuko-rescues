extends Spatial

signal current_animation_finished
signal obstacle_finished

#const animation_states = {
#	"EnemyCorrect": ["GoToQuestionMonitor", "GoToEnemy"],
#	"EnemyIncorrect": ["GoToQuestionMonitor", "GoToEnemy"],
#	"QuestionMonitorCorrect": ["GoToQuestionMonitor", "GoToEnemy"],
#	"QuestionMonitorIncorrect": ["GoToQuestionMonitor", "GoToEnemy"],
#	"GoToEnemy": ["EnemyCorrect", "EnemyIncorrect"],
#	"GoToQuestionMonitor": ["QuestionMonitorCorrect", "QuestionMonitorIncorrect"],
#}

enum State {
	CORRECT, INCORRECT, WIN, LOSE
}

onready var traps = [$Boulder, $IronSpikes, $WoodSpikes]

onready var animation = $AnimationPlayer

var prev_state = null
var final_state = null


func _set_animation_state(state: String):
	prev_state = state
	animation.play(state)
	

func hide_all_traps():
	for trap in traps:
		trap.hide()

func spawn_trap():
	var selection = randi()%traps.size()
	traps[selection].spawn()
	yield(get_tree().create_timer(0.05), "timeout") # delay 0.05s to prevent glitchy transition
	traps[selection].show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if animation.current_animation == "":
#		var next_states = animation_states[prev_state]
#		var chosenNextState = next_states[randi()%next_states.size()]
#		animation.play(chosenNextState)
#		prev_state = chosenNextState
#		print("ABC")

const INITIAL_STATES = ["GoToEnemy", "GoToQuestionMonitor"]

func _ready():
	hide_all_traps()
	_set_animation_state(INITIAL_STATES[randi()%INITIAL_STATES.size()])


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "GoToEnemy" or anim_name == "GoToQuestionMonitor" or anim_name == "Win" or anim_name == "Lose":
		emit_signal("current_animation_finished")
		return
	
	if "Correct" in anim_name:
		emit_signal("obstacle_finished")
	
	if final_state != null:
		_set_animation_state(final_state)
		return
	
	_set_animation_state(INITIAL_STATES[randi() % INITIAL_STATES.size()])


func _on_QuestionUI_answer_signal(sig):
	if "win" in sig:
		final_state = "Win"
	elif "lose" in sig:
		final_state = "Lose"

	if "incorrect" in sig:
		if prev_state == "GoToEnemy":
			_set_animation_state("EnemyIncorrect")
		elif prev_state == "GoToQuestionMonitor":
			_set_animation_state("QuestionMonitorIncorrect")
	elif "correct" in sig:
		if prev_state == "GoToEnemy":
			_set_animation_state("EnemyCorrect")
		elif prev_state == "GoToQuestionMonitor":
			_set_animation_state("QuestionMonitorCorrect")

