extends Area2D

@onready var nav_region = get_node("/root/scene/region")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_polygon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_polygon():
	var new_polygon : PackedVector2Array
	var polygon_transform = get_node("Polygon2D").get_global_transform()
	var polygon_bp = get_node("Polygon2D").get_polygon()
	for vertex in polygon_bp:
		new_polygon.append((polygon_transform * vertex))
		#$Polygon2D.get_polygon()
	nav_region.get_navigation_polygon().add_outline(new_polygon)
	nav_region.get_navigation_polygon().make_polygons_from_outlines()
