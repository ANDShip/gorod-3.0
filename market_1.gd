extends Area2D
var is_follow = true
var is_place_free = true
var entered_obj = 0
var possible_to_information = false
@onready var polygon = $Polygon2D
var prise = 100
var c = true
var cur_wheat_to_sell = 0
@onready var scene = get_node("/root/scene")
@onready var nav_region = get_node("/root/scene/region")
@onready var container = get_node("/root/scene/CanvasLayer/ScrollContainer/VBoxContainer")
@onready var inf = get_node("/root/scene/CanvasLayer/inf")
@onready var sprite = get_node("/root/scene/CanvasLayer/inf/Information")
var possible_to_delete = false
func _ready():
	Global.is_obj_follow_mouse = true
	
func _process(delta):
	if scene.button_sell_pressed == true:
		c = true
		scene.button_sell_pressed = false
	if sprite.get_node("Sell_Buy").is_anything_selected():
		if sprite.get_node("Sell_Buy").get_item_text(sprite.get_node("Sell_Buy").get_selected_items()[0]) == "wheat":
			if c:
				c = false
				scene.selected_item_sell_buy = "wheat"
				sprite.get_node("cur_material").text = str(Global.wheat)
				scene.cur_wheat_to_sell = Global.wheat
				sprite.get_node("plus").visible = true
				sprite.get_node("minus").visible = true
				sprite.get_node("max").visible = true
				sprite.get_node("cur_material").visible = true
			if scene.market_aktion == "plus":
				var plus = scene.cur_wheat_to_sell + 10
				if plus <= Global.wheat:
					sprite.get_node("cur_material").text = str(plus)
					scene.cur_wheat_to_sell += 10
				scene.market_aktion = "none"
			if scene.market_aktion == "minus":
				var minus = scene.cur_wheat_to_sell - 10
				if minus >= 0:
					sprite.get_node("cur_material").text = str(minus)
					scene.cur_wheat_to_sell -= 10
				scene.market_aktion = "none"
			if scene.market_aktion == "max":
				var max = Global.wheat
				
				sprite.get_node("cur_material").text = str(max)
				scene.cur_wheat_to_sell = max
				scene.market_aktion = "none"
	
	if is_follow == false:
		if Global.is_all_fields_blinking == false:
			if Global.is_mouse_on_window == false:
				if Input.is_action_just_pressed("lkm"):
					if possible_to_information == true:
						if inf.visible == false:
							show_information()
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


func show_information():
	sprite.get_node("name").text = "Market"
	sprite.get_node("next").visible = true
	sprite.get_node("next").text = "Buy"
	#sprite.get_node("next").visible = false
	sprite.get_node("information_1").visible = false
	sprite.get_node("information_2").visible = false
	sprite.get_node("Sell_Buy").visible = true
	sprite.get_node("Button").visible = false
	sprite.get_node("Label").visible = false
	sprite.get_node("next").text = "Sell"
	sprite.get_node("plus").visible = false
	sprite.get_node("minus").visible = false
	sprite.get_node("max").visible = false
	sprite.get_node("cur_material").visible = false
	inf.visible = true
