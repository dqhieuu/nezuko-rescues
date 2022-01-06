extends Control

var queue

func load_game(chapter):
	Global.selected_chapter = chapter
	
	get_tree().get_root().set_disable_input(true)
	$AnimationPlayer.play("NezukoRunsSideways")
	
	set_process(true)
	queue.queue_resource("res://main_game.tscn", true)



func _on_Chapter1Button_pressed():
	load_game(1)


func _on_Chapter2Button_pressed():
	load_game(2)

func _ready():
	queue = preload("res://resource_queue.gd").new()
	queue.start()
	
	if PlayerVariables.high_scores_by_chapter[0] >= Global.CHAPTER_UNLOCK_THRESHOLD:
		var chap2btn = $CenterContainer/TextureRect/VBoxContainer/Chapter2Button
		chap2btn.modulate.a = 1
		chap2btn.disabled = false
	
	var reward_items = get_tree().get_nodes_in_group("RewardItems")
	
	reward_items[0].locked = PlayerVariables.high_scores_by_chapter[0] < 10
	reward_items[1].locked = PlayerVariables.high_scores_by_chapter[1] < 10

func _process(_delta):
	# Returns true if a resource is done loading and ready to be retrieved.
	if queue.is_ready("res://main_game.tscn"):
		set_process(false)
		get_tree().get_root().set_disable_input(false)
		# Returns the fully loaded resource.
		var next_scene = queue.get_resource("res://main_game.tscn").instance()
		get_node("/root").add_child(next_scene)
		queue_free()


func _on_RewardsButton_pressed():
	$RewardScreen.show()


func _on_CloseRewardScreenButton_pressed():
	$RewardScreen.hide()


func _on_CloseRewardDisplayButton_pressed():
	$RewardScreen/RewardDisplay.hide()
