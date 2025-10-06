extends Node2D

@export var xmin: float = -10.0
@export var xmax: float = 10.0
@export var step: float = 0.01
@export var scale_xy: float = 50.0
@export var origin: Vector2 = Vector2(320, 240) 
@export var show_axes := true
@export var line_width: float = 2.0

@export var a: float 
@export var b: float
@export var c: float 

func _ready() -> void:
	queue_redraw()

func f(x: float) -> float:
	return a * x * x + b * x + c

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, get_viewport_rect().size), Color(1, 1, 1))

	if show_axes:
		_draw_axes()

	var pts := PackedVector2Array()
	var x := xmin
	while x <= xmax:
		var y := f(x)
		var p := origin + Vector2(x * scale_xy, -y * scale_xy)
		pts.append(p)
		x += step

	draw_polyline(pts, Color(0, 0, 1), line_width, true)

	_draw_quadratic_features()

func _draw_axes() -> void:
	# grade leve
	for i in range(-10, 11):
		var gx := origin + Vector2(i * scale_xy, 0)
		draw_line(gx + Vector2(0, -1000), gx + Vector2(0, 1000), Color(0.9, 0.9, 0.9, 0.3))
		var gy := origin + Vector2(0, -i * scale_xy)
		draw_line(gy + Vector2(-1000, 0), gy + Vector2(1000, 0), Color(0.9, 0.9, 0.9, 0.3))

	# eixos principais
	draw_line(origin + Vector2(xmin * scale_xy, 0), origin + Vector2(xmax * scale_xy, 0), Color(0, 0, 0), 1.5)
	draw_line(origin + Vector2(0, -1000), origin + Vector2(0, 1000), Color(0, 0, 0), 1.5)

func _draw_quadratic_features() -> void:
	if a == 0.0:
		return 

	var delta := b*b - 4.0*a*c

	if delta >= 0.0:
		var r1 := (-b - sqrt(delta)) / (2.0 * a)
		var r2 := (-b + sqrt(delta)) / (2.0 * a)
		_draw_point(Vector2(r1, 0.0), Color(1, 0, 0))
		_draw_point(Vector2(r2, 0.0), Color(1, 0, 0))

	var xv := -b / (2.0 * a)
	var yv := f(xv)
	_draw_point(Vector2(xv, yv), Color(0, 0.6, 0))

func _draw_point(p_graph: Vector2, col: Color) -> void:
	var p := origin + Vector2(p_graph.x * scale_xy, -p_graph.y * scale_xy)
	draw_circle(p, 5.0, col)
