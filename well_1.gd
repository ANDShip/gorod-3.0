extends Area2D
var is_follow = true
var is_place_free = true
var entered_obj = 0
var possible_to_information = false
@onready var polygon = $Polygon2D
var prise = 25
@onready var container = get_node("/root/scene/CanvasLayer/ScrollContainer2")
@onready var container_cont = get_node("/root/scene/CanvasLayer/ScrollContainer2/VBoxContainer2")
@onready var scene = get_node("/root/scene")
@onready var man = preload("res://man.tscn")
@onready var man_button = preload("res://man_button.tscn")
@onready var label = get_node("/root/scene/CanvasLayer/Information/Label")
@onready var sprite = get_node("/root/scene/CanvasLayer/Information")
@onready var nav_region = get_node("/root/scene/region")
var possible_to_delete = false
func _ready():
	Global.is_obj_follow_mouse = true
	
func _process(delta):
	#if is_follow == false:
		#if Input.is_action_just_pressed("lkm"):
			#if possible_to_information == true:
				#sprite.visible = true
	if is_follow:
		position = get_global_mouse_position()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if entered_obj == 0:
				if scene.is_button_on_mouse == false:
					if Global.money >= prise:
						Global.money -= prise
						add_polygon()
						is_follow = false
						Global.is_obj_follow_mouse = false
						$Sprite2D2.visible = true
						Global.houses_count += 1
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
	for obj in Global.all_obj_names:
		if obj in area.name:
			entered_obj += 1
func _on_area_exited(area):
	for obj in Global.all_obj_names:
		if obj in area.name:
			entered_obj -= 1

func _on_mouse_entered():
	possible_to_delete = true
	#$Sprite2D3.visible = true
	possible_to_information = true
	
func _on_mouse_exited():
	possible_to_delete = false
	#$Sprite2D3.visible = false
	possible_to_information = false
	#sprite.visible = false


func add_polygon():
	var new_polygon : PackedVector2Array
	var polygon_transform = get_node("Polygon2D").get_global_transform()
	var polygon_bp = get_node("Polygon2D").get_polygon()
	for vertex in polygon_bp:
		new_polygon.append((polygon_transform * vertex))
		$Polygon2D.get_polygon()
	nav_region.get_navigation_polygon().add_outline(new_polygon)
	nav_region.get_navigation_polygon().make_polygons_from_outlines()
