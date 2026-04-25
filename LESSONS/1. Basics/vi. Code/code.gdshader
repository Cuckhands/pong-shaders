shader_type canvas_item;

uniform float exposed_variable: hint_range(0, 1.0);
uniform vec3 color: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX += vec2(20, 10);
}

void fragment() {
	// Called for every pixel the material is visible on.
	float test_alpha = 0.5 + exposed_variable;
	COLOR.rgb = color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
