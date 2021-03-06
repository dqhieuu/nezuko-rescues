extends Control

signal answer_signal(type)

const root_level_path = "res://level_data"

const TOTAL_QUESTIONS = 10

var answer_square = preload("res://gui/answer_square.tscn")
var answer_long = preload("res://gui/answer_long.tscn")

var answer_buttons_square = []
var answer_buttons_long = []

var chapter = Global.selected_chapter
var current_question_idx = 0
var correctly_chosen_answers = 0

var question_set


func load_question_set():
	var file = File.new()
	file.open("res://level_data/phan%d/data.json" % chapter, File.READ)
	question_set = JSON.parse(file.get_as_text()).result
	file.close()

	for i in question_set.size():
		question_set[i]["cau"] = i+1
	question_set.shuffle()
	question_set = question_set.slice(0, TOTAL_QUESTIONS)


func set_question_textures():
	var cau = question_set[current_question_idx]["cau"]
	
	var question_image = load("res://level_data/phan%d/phan%d_cau%d_q.png" % [chapter, chapter, cau])
	$QuestionBox/QuestionImage.set_texture(question_image)
	
	for i in range(4):
		var answer_image = load("res://level_data/phan%d/phan%d_cau%d_a%d.png" % [chapter, chapter, cau, i+1])
		answer_buttons_square[i].set_image(answer_image)
		
	set_answer_count()

func go_to_next_question():
	current_question_idx += 1
	if current_question_idx < TOTAL_QUESTIONS:

		set_question_textures()
	else:
		set_result_box()


func set_visual_score():
	$VisualScore/HBoxContainer/Score.set_text("%d" % (correctly_chosen_answers * 100))

func set_result_box():
	var prev_high_score = PlayerVariables.high_scores_by_chapter[chapter-1]
	var high_score = max(prev_high_score, correctly_chosen_answers)
	PlayerVariables.high_scores_by_chapter[chapter-1] = high_score

	if correctly_chosen_answers >= Global.CHAPTER_UNLOCK_THRESHOLD:
		if prev_high_score < Global.CHAPTER_UNLOCK_THRESHOLD and chapter < 2:
			$ResultOverlay/CenterContainer/TextureRect/VBoxContainer/RewardInfo/Unlocked.show()
	else:
		$ResultOverlay/CenterContainer/TextureRect/VBoxContainer/RewardInfo/TryHarder.show()

	$ResultOverlay/CenterContainer/TextureRect/VBoxContainer/CurrentScore/Score.set_text(String(correctly_chosen_answers))
	$ResultOverlay/CenterContainer/TextureRect/VBoxContainer/CurrentScore/TotalQuestions.set_text(String(TOTAL_QUESTIONS))
	$ResultOverlay/CenterContainer/TextureRect/VBoxContainer/HighestScore/Score.set_text(String(high_score))
	var play_time =  int(get_parent().elapsed_time)
	$ResultOverlay/CenterContainer/TextureRect/VBoxContainer/CompleteTime/Time\
		.set_text("%d ph??t %d gi??y" % [play_time/60, play_time%60] if play_time>= 60 else "%d gi??y" % (play_time%60))

func set_answer_count():
	$QuestionBox/QuestionNumber.set_text("C??u %d:" % (current_question_idx + 1))
	$QuestionBox/Score.set_text("%d/%d" % [correctly_chosen_answers, TOTAL_QUESTIONS])

func get_end_signal():
	return "_" + ("win" if correctly_chosen_answers >= Global.CHAPTER_UNLOCK_THRESHOLD else "lose")
	

func _on_Answer_pressed(idx):
	$DisableClick.show()
	var signal_string = ""
	if question_set[current_question_idx]["dap_an"] == idx:
		correctly_chosen_answers += 1
		signal_string += "correct"
	else:
		signal_string += "incorrect"
			
	if current_question_idx+1 >= TOTAL_QUESTIONS:
		signal_string += get_end_signal()
	
	emit_signal("answer_signal", signal_string)
	
	$AnimationPlayer.play("HideUI")
	yield(get_tree().create_timer(0.5), "timeout")
	go_to_next_question()
	
func _init():
	randomize()
	load_question_set()


func _ready():
	set_visual_score()

	for i in range(4):
		var answer_square_instance = answer_square.instance()
		answer_square_instance.connect("pressed", self, "_on_Answer_pressed", [i])
		$Grid4x1.add_child(answer_square_instance)
		answer_buttons_square.append(answer_square_instance)

		var answer_long_instance = answer_long.instance()
		answer_long_instance.connect("pressed", self, "_on_Answer_pressed", [i])
		$Grid2x2.add_child(answer_long_instance)
		answer_buttons_long.append(answer_long_instance)
	set_question_textures()


func _on_PauseButton_pressed():
	get_parent().pause()


func _on_GoHomeButton_pressed():
	get_parent().to_main_menu()

func _on_3DScene_current_animation_finished():
	$DisableClick.hide()
	
	if current_question_idx < TOTAL_QUESTIONS:
		$AnimationPlayer.play_backwards("HideUI")
	else:
		$ResultOverlay.show()


func _on_3DScene_obstacle_finished():
	set_visual_score()
