extends Node2D

@onready var main = $"../../"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		main.pauseMenu()
		print("return")


func _on_button_pressed():
	main.pauseMenu()
	print("return")

func _on_button_2_pressed():
	get_tree().quit()
