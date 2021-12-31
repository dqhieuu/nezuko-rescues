extends Control

signal my_signal
signal quit_game



func _on_ResumeButton_pressed():
	get_parent().unpause()


func _on_QuitButton_pressed():
	get_parent().to_main_menu()
