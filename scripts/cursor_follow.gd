extends Sprite2D

func set_shader_position(new_pos: Vector2):
	if material is ShaderMaterial:
		material.set_shader_parameter("position", new_pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# if I have a shader,
	if material is ShaderMaterial:
		# make sure changes to it don't affect others using this same material
		material = material.duplicate()
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	
	if material is ShaderMaterial:
		set_shader_position(global_position)
