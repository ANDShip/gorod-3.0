extends Area2D
var is_follow = true
var is_place_free = true
var entered_obj = 0
var possible_to_information = false
@onready var polygon = $Polygon2D
var prise = 25
var is_mouse_position = true
var connected = false
var is_l_connected
var areaaa
var cnkt = null
@onready var scene = get_node("/root/scene")
@onready var label = get_node("/root/scene/CanvasLayer/Sprite2D/Label")
@onready var sprite = get_node("/root/scene/CanvasLayer/Sprite2D")
var areaa
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
						$Sprite2D2.visible = true
						Global.is_obj_follow_mouse = false
						#Global.houses_count += 1
						#add_polygon()
						is_follow = false
						print("cnkt ",cnkt)
						if cnkt != null:
							position = cnkt
							cnkt = null
									
					else:
						print("no money")
			else:
				print("zanyato")
		
		if Input.is_action_just_pressed("rotate_left"):
			rotation_degrees -= 45
			print(delta)
		if Input.is_action_just_pressed("rotate_right"):
			rotation_degrees += 45
			print(rotation)
			
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			queue_free()
			Global.is_obj_follow_mouse = false
	if Global.delete_mode == true:
		if possible_to_delete == true:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				queue_free()
	
	
	
	
	
func _on_area_entered(area):
	if is_follow:
		if area.is_follow != false:
			print(area.name)
			if area.name == "l_area":
				print("l")
			if area.name == "r_area":
				print("r")
			if area.name != "l_area" or "r_area":
				if "test_house" or "field" in area.name:
					entered_obj += 1
					print("+1")
				elif "g_house" or "road" in area.name:
					entered_obj += 1
					print("+2")
func _on_area_exited(area):
	if is_follow:
		if area.is_follow != false:
			if area.name != "l_area" or "r_area":
				if "test_house" or "field" in area.name:
					entered_obj -= 1
					print("-")
				elif "g_house" or "road" in area.name:
					entered_obj -= 1
					print("-")

func _on_mouse_entered():
	possible_to_delete = true
	#$Sprite2D3.visible = true
	possible_to_information = true
	
func _on_mouse_exited():
	possible_to_delete = false
	#$Sprite2D3.visible = false
	possible_to_information = false


#func add_polygon():
	#var new_polygon : PackedVector2Array
	#var polygon_transform = get_node("Polygon2D").get_global_transform()
	#var polygon_bp = get_node("Polygon2D").get_polygon()
	#for vertex in polygon_bp:
	#	new_polygon.append((polygon_transform * vertex))
	#	#$Polygon2D.get_polygon()
	#nav_region.get_navigation_polygon().add_outline(new_polygon)
	#nav_region.get_navigation_polygon().make_polygons_from_outlines()






func _on_area_2d_area_entered(area):
	if is_follow:
		print("name of entered area ", area.name)
		if area.name != "l_area":
			if area.name != "r_area":
				areaaa = area
				for obj in Global.all_obj_names:
					if obj in area.name:
						entered_obj += 1
						print("+")
				#if "test_house" or "field" in area.name:
					#entered_obj += 1
				#elif "g_house" or "road" in area.name:
					#entered_obj += 1
			else:
				connected = true

		else:
			connected = true


func _on_area_2d_area_exited(area):
	if is_follow:
		if area.name != "l_area":
			if area.name != "r_area":
				for obj in Global.all_obj_names:
					if obj in area.name:
						entered_obj -= 1
				#if "test_house" or "field" in area.name:
					#entered_obj -= 1
					#print("-")
				#elif "g_house" or "road" in area.name:
					#entered_obj -= 1
					#print("-")
			else:
				connected = false
		else:
			connected = false



func _on_area_2d_2_area_entered(area):
	if is_follow:
		if "connector" in area.name:
			print("popa ",area.get_parent().rotation_degrees,"  ",rotation_degrees)
			if area.get_parent().rotation_degrees == rotation_degrees or (area.get_parent().rotation_degrees + 180)  == rotation_degrees or (area.get_parent().rotation_degrees - 180)  == rotation_degrees or (area.get_parent().rotation_degrees + 90)  == rotation_degrees or (area.get_parent().rotation_degrees - 90)  == rotation_degrees:
				
				cnkt = area.get_parent().position
				var pipi = (-(area.get_parent().global_position - area.global_position))*2
				cnkt += pipi
				print("cnkt ",cnkt)

func _on_connector_area_exited(area):
	if is_follow:
		if "connector" in area.name:
			cnkt = null
