extends Node3D

var rot_x: float = 0.0
var rot_y: float = 0.0
@export var step_deg_per_sec: float = 180.0
@export var spacing: float = 1.4

func _ready():
	

	var meshes = get_children()
	for i in range(meshes.size()):
		if meshes[i] is MeshInstance3D:
			var mat = StandardMaterial3D.new()
			mat.albedo_color =  Color(randf(), randf(), randf())
			meshes[i].set_surface_override_material(0, mat)

func _process(delta: float) -> void:
	var step := deg_to_rad(step_deg_per_sec) * delta

	if Input.is_key_pressed(KEY_RIGHT):
		rot_y += step
	if Input.is_key_pressed(KEY_LEFT):
		rot_y -= step
	if Input.is_key_pressed(KEY_UP):
		rot_x += step
	if Input.is_key_pressed(KEY_DOWN):
		rot_x -= step

	rotation = Vector3(rot_x, rot_y, 0.0)
