extends Control


const root_level_path = "res://level_data"


const dap_an = [
	{
		"dap_an": 0
	},
	{
		"dap_an": 2
	},
	{
		"dap_an": 1
	},
	{
		"dap_an": 3
	},
	{
		"dap_an": 0
	},
	{
		"dap_an": 3
	},
	{
		"dap_an": 0
	},
	{
		"dap_an": 1
	},
	{
		"dap_an": 2
	},
	{
		"dap_an": 0
	},
	{
		"dap_an": 3
	},
	{
		"dap_an": 1
	},
	{
		"dap_an": 0
	},
	{
		"dap_an": 3
	},
	{
		"dap_an": 3
	},
	{
		"dap_an": 1
	},
	{
		"dap_an": 0
	}
]

var total_questions = dap_an.size()

var answer_square = preload("res://gui/answer_square.tscn")
var answer_long = preload("res://gui/answer_long.tscn")

var answer_buttons_square = []
var answer_buttons_long = []

var current_section_idx = 0
var current_question_idx = 0

var correctly_chosen_answers = 0

	
func load_question():
	var cau = current_question_idx + 1
	var phan = current_section_idx + 1
	
	var question_image = load("res://level_data/phan%d/phan%d_cau%d_q.png" % [phan, phan, cau])
	$QuestionBox/QuestionImage.set_texture(question_image)
	
	for i in range(4):
		var answer_image = load("res://level_data/phan%d/phan%d_cau%d_a%d.png" % [phan, phan, cau, i+1])
		answer_buttons_square[i].set_image(answer_image)
		
	set_answer_count()

func go_to_next_question():
	current_question_idx = current_question_idx+1
	if current_question_idx < total_questions:
		load_question()
	else:
		pass

func set_answer_count():
	$Score.set_text("%d/%d" % [correctly_chosen_answers, total_questions])

func _on_Answer_pressed(idx):
	print(idx)
	if dap_an[current_question_idx]["dap_an"] == idx:
		correctly_chosen_answers = correctly_chosen_answers + 1

	go_to_next_question()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(4):
		var answer_square_instance = answer_square.instance()
		answer_square_instance.connect("pressed", self, "_on_Answer_pressed", [i])
		$Grid4x1.add_child(answer_square_instance)
		answer_buttons_square.append(answer_square_instance)
		
		var answer_long_instance = answer_long.instance()
		answer_long_instance.connect("pressed", self, "_on_Answer_pressed", [i])
		$Grid2x2.add_child(answer_long_instance)
		answer_buttons_long.append(answer_long_instance)
	
	load_question()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
