extends CharacterBody2D
var man_status
var speed = 50
var intelekt = 50
var strong = 50
var authoritarianism = 50
var agility = 50
var harizma = 50
var goodness = 50
var luck = 50




@onready var nav_reg = $"../region"
@onready var nav_agent = get_node("NavigationAgent2D")
@onready var timer : Timer = $RecalculateTimer
var target_position : Vector2
var home_pos = Vector2.ZERO
var self_path

func _ready():
	speed = speed * 4
	self_path = self.get_path()
	#target_position = get_parent().global_position
	#target_position.x += 100
	print(target_position)
	target_position = global_position
	nav_agent.set_target_position(target_position)
	man_status = "home"
	home_pos = global_position

func _physics_process(delta):
	
	if Global.going_with_man == true:
		target_position = get_global_mouse_position()
	if Input.is_action_just_pressed("q"):
		if Global.is_all_fields_blinking:
			if Global.path_from_worker == get_path():
				target_position = home_pos
				Global.is_all_fields_blinking = false
	if nav_agent.is_navigation_finished():
		return
	var next_location = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_location)
	global_position += direction * delta * speed 
	#velocity = direction * delta * speed 
	nav_agent.set_target_position(target_position)

func _on_recalculate_timer_timeout():
	nav_agent.set_target_position(target_position)


func _on_button_pressed():
	if Global.is_mouse_on_window == false:
		if Global.is_all_fields_blinking == false:
			Global.is_all_fields_blinking = true
			Global.path_from_worker = get_path()
