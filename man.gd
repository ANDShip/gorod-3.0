extends CharacterBody2D
var man_status
var speed = 400
var intelekt = 50
var strong = 50
var authoritarianism = 50
var agility = 50
var harizma = 50
var is_going_str = true
var goodness = 50
var luck = 50
var on_field = false
var random_walk = false
var cur_position = global_position
var staying = true
var random_walk_in_process = false
@onready var nav_reg = $"../region"
@onready var nav_agent = get_node("NavigationAgent2D")
@onready var timer : Timer = $RecalculateTimer
@onready var area = get_node("/root/scene/Area2D")
var target_position : Vector2
var home_pos = Vector2.ZERO
var self_path
var direction = null

func _ready():
	speed = speed * 4
	self_path = self.get_path()
	#target_position = get_parent().global_position
	#target_position.x += 100
	print(target_position)
	target_position = global_position
	nav_agent.set_target_position(target_position)
	man_status = "home"
	

func _process(delta):
	if is_going_str:
		var rndx = randi_range(-1000,1000)
		var rndy = randi_range(800,700)
		target_position = Vector2(rndx,rndy)
		is_going_str = false
	
	if global_position == cur_position:
		staying = true
		#random_walk_in_process = false
		#random_walk = false
		#print("stop")
	else:
		#print("go")
		staying = false
		$Timer2.stop()
	if staying == true:
		if on_field == false:
			if is_going_str == false:
				if $Timer2.is_stopped() == true:
					if random_walk == false:
						$Timer2.wait_time = randf_range(3,8)
						$Timer2.start()
	if random_walk == true:
		if staying == true:
			if random_walk_in_process == false:
				$Timer3.wait_time = randf_range(3,8)
				$Timer3.start()
				var rand_x = randi_range(-100,100)
				var rand_y = randi_range(-100,100)
				target_position = global_position + Vector2(rand_x,rand_y)
				random_walk_in_process = true
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
	direction = global_position.direction_to(next_location)
	var pipa  = direction * delta * speed 
	print("target_position ",target_position,"next_location ",next_location)
	global_position += pipa
	#velocity = direction * delta * speed 
	nav_agent.set_target_position(target_position)

func _on_recalculate_timer_timeout():
	nav_agent.set_target_position(target_position)
	

func _on_button_pressed():
	if Global.is_mouse_on_window == false:
		if Global.is_all_fields_blinking == false:
			Global.is_all_fields_blinking = true
			Global.path_from_worker = get_path()


func _on_timer_timeout():
	cur_position = global_position


func _on_timer_2_timeout():
	random_walk = true


func _on_timer_3_timeout():
	random_walk = false
	random_walk_in_process = false
