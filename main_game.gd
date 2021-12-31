extends Spatial

var is_paused = false
var is_finished = false

var elapsed_time = 0

func _process(delta):
	if not (is_paused or is_finished):
		elapsed_time += delta

func pause():
	is_paused = true
	$PauseMenu.show()

func unpause():
	is_paused = false
	$PauseMenu.hide()

func to_main_menu():
	get_tree().change_scene("res://main_menu.tscn")
