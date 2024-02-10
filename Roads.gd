extends Node2D

@onready var path = get_node("Path2D")
var idx = 0
var c = Color.RED

func _input(event):
	if event is InputEventScreenTouch:

#SELECT POINTS
		for p in path.curve.get_point_count():
			if path.curve.get_point_position(p).distance_to(event.position) < 40:
				idx = p
				queue_redraw()

#SELECT HANDLES
			var a = path.curve.get_point_position(p) - path.curve.get_point_out(p)
			var b = path.curve.get_point_position(p) - path.curve.get_point_in(p)
			print(a.distance_to(event.position))
			print(b.distance_to(event.position))
			if a.distance_to(event.position) < 40:
				idx = p

			if b.distance_to(event.position) < 40:
				idx = p

	if event is InputEventScreenDrag:

#DRAG POINTS
		for p in path.curve.get_point_count():
			if path.curve.get_point_position(p).distance_to(event.position) < 40 :
				path.curve.set_point_position(idx, path.curve.get_point_position(idx) + event.relative)
				queue_redraw()

#DRAG HANDLES
			var a = path.curve.get_point_position(p) - path.curve.get_point_out(p)
			var b = path.curve.get_point_position(p) - path.curve.get_point_in(p)
			var d = path.curve.get_point_position(p) - event.position

			if a.distance_to(event.position) < 40:
				path.curve.set_point_in(idx, -d + event.relative)
				path.curve.set_point_out(idx, d + event.relative)
				queue_redraw()

			if b.distance_to(event.position) < 40:
				path.curve.set_point_out(idx, -d + event.relative)
				path.curve.set_point_in(idx, d + event.relative)
				queue_redraw()

#DRAW
func _draw():
	draw_polyline(path.curve.get_baked_points(), c, 1, true)
	for p in path.curve.get_point_count():
		if p != 0 and p != path.curve.get_point_count() - 1:
			draw_circle(path.curve.get_point_position(p), 8, c)
			draw_circle(path.curve.get_point_position(p) - path.curve.get_point_in(p) * -1, 5, c)
			draw_circle(path.curve.get_point_position(p) - path.curve.get_point_out(p) * -1, 5, c)
			var a = path.curve.get_point_position(p) - path.curve.get_point_in(p) * -1
			var b = path.curve.get_point_position(p) - path.curve.get_point_out(p) * -1
			var cp = path.curve.get_point_position(p)
			draw_polyline(PackedVector2Array([a, cp]), c, 1, true)
			draw_polyline(PackedVector2Array([b, cp]), c, 1, true)
	queue_redraw()
	
#NOTE!!!
#If you are using Godot 4+, replace "onready" with "@onready", "red" with "RED" and "update()" with "queue_redraw()"
