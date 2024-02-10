extends Polygon2D

@onready var nav_region = get_node("/root/scene/region")
# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = get_parent().global_position
	var new_polygon : PackedVector2Array
	var polygon_transform = get_global_transform()
	var polygon_bp = get_polygon()
	#print(transform.basis)
	for vertex in polygon_bp:
		new_polygon.append((polygon_transform.basis_xform(vertex)))
		print(new_polygon,polygon_transform)
		#$Polygon2D.get_polygon()
	nav_region.get_navigation_polygon().add_outline(new_polygon)
	nav_region.get_navigation_polygon().make_polygons_from_outlines()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
