extends TextureRect

export(Texture) onready var image

export(bool) var locked = false setget set_locked, get_locked

func _on_TextureButton_pressed():
	var reward_display = get_tree().get_nodes_in_group("RewardDisplay")[0] as TextureRect
	reward_display.texture = image
	reward_display.show()

func update_lock_image():
	$Lock.show() if locked else $Lock.hide()

func _ready():
	$RewardImage.texture = image
	update_lock_image()

func set_locked(val):
	locked = val
	update_lock_image()

func get_locked():
	return locked
	
