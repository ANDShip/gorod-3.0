extends Button

var man_index
var index
var man_path
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _process(delta):
	pass

func _on_pressed():
	index = man_index
	print("pathhh")
	Global.path_from_worker = "/root/scene/People/"+str(index)
	Global.is_all_fields_blinking = true
	
