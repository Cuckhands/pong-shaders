shader_type canvas_item;

uniform float exposed: hint_range(0.0, 1.0, 0.05) = 0.5;

void fragment() {
	float diagonal = (UV.x + UV.y) / 2.0;
	COLOR.a *= step(exposed, diagonal);
}
