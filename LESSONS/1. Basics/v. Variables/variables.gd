extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var tween := create_tween()
	#tween.tween_property($Sprite2D.material, "shader_parameter/Offset", Vector2(64.0, 0), 1)
	#tween.tween_property($Sprite2D.material, "shader_parameter/Offset", Vector2.ZERO, 1)
	#tween.tween_property($Sprite2D.material, "shader_parameter/CircleRadius", 0.1, 1)
	#tween.tween_property($Sprite2D.material, "shader_parameter/CircleRadius", 0.5, 1)
	#tween.set_loops()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
