extends Spatial

var is_finished = false

var elapsed_time = 0

func _process(delta):
	if not is_finished:
		elapsed_time += delta


func pause():
	get_tree().paused = true
	$PauseMenu.show()

func unpause():
	get_tree().paused = false
	$PauseMenu.hide()

func _ready():
	print(get_node("/root").get_children())

func to_main_menu():
	get_tree().paused = false
	queue_free()
	get_tree().change_scene("res://main_menu.tscn")
	
