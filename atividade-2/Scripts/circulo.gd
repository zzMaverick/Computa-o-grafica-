extends Node2D

@export var center: Vector2 = Vector2(320, 240)
@export var radius: float = 120.0
@export var color: Color = Color(1, 0, 0)

func _ready() -> void:
	randomize()
	queue_redraw()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_PLUS) or Input.is_key_pressed(KEY_KP_ADD) or Input.is_key_pressed(KEY_EQUAL):
		radius += 10
		queue_redraw()
	elif Input.is_key_pressed(KEY_MINUS) or Input.is_key_pressed(KEY_KP_SUBTRACT):
		radius = max(10, radius - 10)
		queue_redraw()
	elif Input.is_key_pressed(KEY_C):
		color = Color(randf(), randf(), randf())
		queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, get_viewport_rect().size), Color(1, 1, 1))
	draw_circle(center, radius, color)
