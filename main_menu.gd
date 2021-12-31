extends Control

func load_game(chapter):
	Global.selected_chapter = chapter
	get_tree().change_scene("res://main_game.tscn")

func _on_Chapter1Button_pressed():
	load_game(1)


func _on_Chapter2Button_pressed():
	load_game(2)

func _ready():
	if PlayerVariables.high_scores_by_chapter[0] >= Global.CHAPTER_UNLOCK_THRESHOLD:
		var chap2btn = $CenterContainer/TextureRect/VBoxContainer/Chapter2Button
		chap2btn.modulate.a = 1
		chap2btn.disabled = false

