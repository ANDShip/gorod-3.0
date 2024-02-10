extends Node2D

var is_button_on_mouse = false
var is_following = false
var following_house 
var cur_crop_type = "null"
var start_working = false
var cur_wheat_to_sell = 0
var market_aktion = "none"
@onready var pause_menu = $CanvasLayer/pause_menu
var selected_item_sell_buy = null
var house_1 = preload("res://test_house.tscn")
var g_house = preload("res://g_house.tscn")
var field_1 = preload("res://field.tscn")
var road = preload("res://road_1.tscn")
var road_2 = preload("res://road_2.tscn")
var x_road = preload("res://road_x.tscn")
var well_1 = preload("res://well_1.tscn")
var market_1 = preload("res://market_1.tscn")
var tent_1 = preload("res://tent_1.tscn")
var paused = false
var button_sell_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func inst_house():
	var instance = house_1.instantiate()
	$Houses.add_child(instance,true)
	print(instance.name)
	Global.houses.append(instance.name)
	following_house = instance

func inst_g_house():
	var instance = g_house.instantiate()
	$Houses.add_child(instance,true)
	print(instance.name)
	Global.houses.append(instance.name)
	following_house = instance


func inst_field():
	var instance = field_1.instantiate()
	$Fields.add_child(instance,true)
	print(instance.name)
	Global.fields.append(instance.name)
	following_house = instance
	
func inst_market_1():
	var instance = market_1.instantiate()
	$Houses.add_child(instance,true)
	print(instance.name)
	Global.houses.append(instance.name)
	following_house = instance
	
func inst_road():
	var instance = road.instantiate()
	$Roads.add_child(instance,true)
	print(instance.name)
	Global.roads.append(instance.name)
	following_house = instance
	
	
func inst_x_road():
	var instance = x_road.instantiate()
	$Roads.add_child(instance,true)
	print(instance.name)
	Global.roads.append(instance.name)
	following_house = instance
	
func inst_road_2():
	var instance = road_2.instantiate()
	$Roads.add_child(instance,true)
	print(instance.name)
	Global.roads.append(instance.name)
	following_house = instance
	
	
func inst_well_1():
	var instance = well_1.instantiate()
	$Enviroment.add_child(instance,true)
	print(instance.name)
	Global.roads.append(instance.name)
	following_house = instance
	
func inst_tent_1():
	var instance = tent_1.instantiate()
	$Houses.add_child(instance,true)
	print(instance.name)
	Global.houses.append(instance.name)
	following_house = instance
	
func _on_button_pressed():
	print(Global.is_obj_follow_mouse)
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			print("--")
			Global.is_all_fields_blinking = false
			inst_house()
			is_following = true

func _input(event):
	if Global.is_all_fields_blinking:
		$CanvasLayer/HBoxContainer/TextureRect2.visible = true
	else:
		$CanvasLayer/HBoxContainer/TextureRect2.visible = false
	
	if event.is_action_pressed("rkm"):
		if Global.is_all_fields_blinking:
			Global.is_all_fields_blinking = false
	
	if event.is_action_pressed("lkm"):
		if is_following == true:
			is_following = false
		if Global.delete_mode == true:
			print("delete")
		
	if event.is_action_pressed("r"):
		if Global.going_with_man == false:
			Global.going_with_man = true
		else:
			Global.going_with_man = false
	if event.is_action_pressed("delete_mode"):
		#if Global.delete_mode:
		#	!Global.delete_mode
		#else:
		if Global.delete_mode:
			Global.delete_mode = false
			$CanvasLayer/HBoxContainer/TextureRect.visible = false
			#$CanvasLayer/Label.text = "Delete Mode: false"
		else:
			Global.delete_mode = true
			$CanvasLayer/HBoxContainer/TextureRect.visible = true
			#$CanvasLayer/Label.text = "Delete Mode: true"
		print(Global.delete_mode)

	
	if event.is_action_pressed("esc"):
		pauseMenu()
	
func _on_button_2_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_field()
			is_following = true




func _on_button_mouse_entered():

	is_button_on_mouse = true
	#print(is_button_on_mouse)

func _on_button_mouse_exited():
	is_button_on_mouse = false


func _on_button_2_mouse_entered():

	is_button_on_mouse = true
	#print(is_button_on_mouse)

func _on_button_2_mouse_exited():
	is_button_on_mouse = false



func pauseMenu():
	if paused:
		pause_menu.show()
		get_tree().paused = true
	else:
		pause_menu.hide()
		get_tree().paused = false
		
	paused = !paused


func _on_texture_button_pressed():
	if $CanvasLayer/ScrollContainer.visible == true:
		$CanvasLayer/ScrollContainer.visible = false
	else:
		$CanvasLayer/ScrollContainer.visible = true


func _on_texture_button_2_pressed():
	if $CanvasLayer/ScrollContainer2.visible == true:
		$CanvasLayer/ScrollContainer2.visible = false
	else:
		$CanvasLayer/ScrollContainer2.visible = true
	
		



func _on_texture_button_3_pressed():
	if $CanvasLayer/Control/menu_scroll_container.visible == false:
		$CanvasLayer/Control/TextureRect.visible = true
		$CanvasLayer/Control/menu_scroll_container.visible = true
		$CanvasLayer/Control/elements_scroll_container.visible = false
		$CanvasLayer/Control/Back_Button.visible = false
	else:
		$CanvasLayer/Control/TextureRect.visible = false
		$CanvasLayer/Control/menu_scroll_container.visible = false
		$CanvasLayer/Control/elements_scroll_container.visible = false
		$CanvasLayer/Control/Back_Button.visible = false

func _on_houses_pressed():
	showing_buttons()
	$CanvasLayer/Control/elements_scroll_container/elements_container/house_1.visible = true
	$CanvasLayer/Control/elements_scroll_container/elements_container/house_g.visible = true
	$CanvasLayer/Control/elements_scroll_container/elements_container/market_1.visible = true
	$CanvasLayer/Control/elements_scroll_container/elements_container/tent_1.visible = true

func _on_fields_pressed():
	showing_buttons()
	$CanvasLayer/Control/elements_scroll_container/elements_container/field.visible = true



func _on_roads_pressed():
	showing_buttons()
	$CanvasLayer/Control/elements_scroll_container/elements_container/road_1.visible = true
	$CanvasLayer/Control/elements_scroll_container/elements_container/road_x.visible = true
	$CanvasLayer/Control/elements_scroll_container/elements_container/road_2.visible = true


func _on_enviroment_pressed():
	showing_buttons()
	$CanvasLayer/Control/elements_scroll_container/elements_container/well_1.visible = true


func _on_back_button_pressed():
	$CanvasLayer/Control/menu_scroll_container.visible = true
	$CanvasLayer/Control/elements_scroll_container.visible = false
	$CanvasLayer/Control/Back_Button.visible = false


func _on_house_1_pressed():
	print(Global.is_obj_follow_mouse)
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			print("--")
			Global.is_all_fields_blinking = false
			inst_house()
			is_following = true


func _on_field_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_field()
			is_following = true
		else:
			print("following mouse")

func _on_road_1_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_road()
			is_following = true


func _on_house_g_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_g_house()
			is_following = true


func _on_road_x_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_x_road()
			is_following = true


func _on_road_2_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_road_2()
			is_following = true





func _on_well_1_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_well_1()
			is_following = true


func _on_button_inform_pressed():
	$CanvasLayer/inf.visible = false
	#cur_crop_type = "null"
	start_working = false

func _on_inf_mouse_entered():
	Global.is_mouse_on_window = true


func _on_inf_mouse_exited():
	Global.is_mouse_on_window = false


func _on_next_pressed():
	if $CanvasLayer/inf/Information/next.text == "Sell":
		if selected_item_sell_buy == "wheat":
			Global.money += cur_wheat_to_sell
			Global.wheat -= cur_wheat_to_sell
			button_sell_pressed = true
			$CanvasLayer/inf/Information/Sell_Buy.deselect_all()
	if $CanvasLayer/inf/Information/next.text == "Stop":
		start_working = false
		$CanvasLayer/inf.visible = false
		#$CanvasLayer/inf/Information/next.text = "Work"
	else:
		start_working = true
		$CanvasLayer/inf.visible = false
		#$CanvasLayer/inf/Information/next.text = "Stop"

func _on_button3_pressed():
	var crop_type = "wheat"
	cur_crop_type = crop_type
	$CanvasLayer/inf/Information/Label.text = "Current: " + crop_type


func _on_market_1_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_market_1()
			is_following = true


func _on_tent_1_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_tent_1()
			is_following = true

func _on_plus_pressed():
	market_aktion = "plus"


func _on_minus_pressed():
	market_aktion = "minus"


func _on_max_pressed():
	market_aktion = "max"

func showing_buttons():
	$CanvasLayer/Control/elements_scroll_container.visible = true
	$CanvasLayer/Control/elements_scroll_container/elements_container/market_1.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/house_1.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/house_g.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/field.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/road_1.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/road_x.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/road_2.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/well_1.visible = false
	$CanvasLayer/Control/elements_scroll_container/elements_container/tent_1.visible = false
	$CanvasLayer/Control/Back_Button.visible = true

	$CanvasLayer/Control/menu_scroll_container.visible = false

