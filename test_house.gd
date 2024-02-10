extends Area2D
var is_follow = true
var is_place_free = true
var entered_houses = 0
var possible_to_information = false
var people = 0#1 + randi() % 3
@onready var polygon = $Polygon2D
var seeds = 4 + randi() % 3
var prise = 100
var on_obj = false
@onready var container = get_node("/root/scene/CanvasLayer/ScrollContainer2")
@onready var container_cont = get_node("/root/scene/CanvasLayer/ScrollContainer2/VBoxContainer2")
@onready var scene = get_node("/root/scene")
@onready var man = preload("res://man.tscn")
@onready var man_button = preload("res://man_button.tscn")
@onready var label = get_node("/root/scene/CanvasLayer/inf/Information/Label")
@onready var inf = get_node("/root/scene/CanvasLayer/inf")
@onready var sprite = get_node("/root/scene/CanvasLayer/inf/Information")
@onready var nav_region = get_node("/root/scene/region")
@onready var house_polygon = preload("res://test_house_polygon.tscn")
var possible_to_delete = false
func _ready():
	Global.is_obj_follow_mouse = true
	
func _process(delta):
	
	if Global.is_mouse_on_window == false:
		if on_obj:
			possible_to_delete = true
			$Sprite2D3.visible = true
			possible_to_information = true
	else:
		possible_to_delete = false
		$Sprite2D3.visible = false
		possible_to_information = false
		
		
	if is_follow == false:
		if Global.is_mouse_on_window == false:
			if Input.is_action_just_pressed("lkm"):
				if possible_to_information == true:
					show_information()
	if is_follow:
		position = get_global_mouse_position()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if entered_houses == 0:
				if scene.is_button_on_mouse == false:
					if Global.money >= prise:
						Global.money -= prise
						add_polygon()
						is_follow = false
						Global.is_obj_follow_mouse = false
						$Sprite2D2.visible = true
						Global.houses_count += 1
						var m = -60
						create_man(m)
					else:
						print("no money")
			else:
				print("zanyato")
		
		if Input.is_action_just_pressed("rotate_left"):
			rotation -= deg_to_rad(45)
			print(delta)
		if Input.is_action_just_pressed("rotate_right"):
			rotation += deg_to_rad(45)
			print(rotation)
			
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			queue_free()
			Global.is_obj_follow_mouse = false
	if Global.delete_mode == true:
		if possible_to_delete == true:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				queue_free()
	
	
	
	
	
func _on_area_entered(area):
	if "test_house" or "field" in area.name:
		entered_houses += 1
		print("+")
	elif "g_house" or "road" in area.name:
		entered_houses += 1
		print("+")
func _on_area_exited(area):
	if "test_house" or "field" in area.name:
		entered_houses -= 1
		print("-")
	elif "g_house" or "road" in area.name:
		entered_houses -= 1
		print("-")

func _on_mouse_entered():
	on_obj = true
	
	
func _on_mouse_exited():
	on_obj = false
	possible_to_delete = false
	$Sprite2D3.visible = false
	possible_to_information = false
	#sprite.visible = false


func add_polygon():
	var new_polygon : PackedVector2Array
	var polygon_transform = $Polygon2D.get_global_transform()
	var polygon_bp = $Polygon2D.get_polygon()
	#print(transform.basis)
	for vertex in polygon_bp:
		#new_polygon.append((polygon_transform * Vector2((vertex.x - 444),(vertex.y - 303)) ))
		new_polygon.append((polygon_transform*Vector2(vertex)))
		print(new_polygon,polygon_transform)
		#$Polygon2D.get_polygon()
	nav_region.get_navigation_polygon().add_outline(new_polygon)
	nav_region.get_navigation_polygon().make_polygons_from_outlines()


func create_man(a):
	var instance_man = man.instantiate()
	instance_man.position.x = position.x + 90
	instance_man.position.y = position.y -70
	var people_p = get_node("/root/scene/People")
	Global.all_mans.append(instance_man)
	instance_man.name = str(Global.all_mans.size())
	people_p.add_child(instance_man)
	var man_button = man_button.instantiate()
	container_cont.add_child(man_button)
	man_button.text = str(Global.all_mans.size()) 
	man_button.man_index = Global.all_mans.size()
	
	
func polygon_init():
	var instance = house_polygon.instantiate()
	add_child(instance,true)


func show_information():
	sprite.get_node("Sell_Buy").visible = false
	sprite.get_node("name").text = "House"
	sprite.get_node("next").visible = false
	sprite.get_node("information_1").visible = true
	sprite.get_node("information_2").visible = true
	sprite.get_node("information_1").text = "People: " + str(people)
	sprite.get_node("information_2").text = "Seeds: " + str(seeds)
	sprite.get_node("Button").visible = false
	sprite.get_node("Label").visible = false
	sprite.get_node("plus").visible = false
	sprite.get_node("minus").visible = false
	sprite.get_node("max").visible = false
	sprite.get_node("cur_material").visible = false
	inf.visible = true
	#label.text = str(people)
