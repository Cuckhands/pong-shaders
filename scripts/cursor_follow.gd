extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if material is ShaderMaterial:
		material = material.duplicate()
		var bg_tex = material.get_shader_parameter("background_texture")
		if bg_tex:
			material.set_shader_parameter("texture_size", bg_tex.get_size())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = get_global_mouse_position()
