shader_type canvas_item;

uniform float circle_size: hint_range(0.0, 0.5) = 0.5;
uniform vec3 color: source_color;

void fragment() {
	float circle = distance(UV, vec2(0.5));
	COLOR = vec4(color, step(circle, circle_size));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
