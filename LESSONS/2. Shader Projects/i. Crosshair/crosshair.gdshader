shader_type canvas_item;

uniform float center_size: hint_range(0.0, 1.0) = 0.5;
uniform float circle_distance: hint_range(0.0, 1.0) = 0.75;
uniform float ring_width: hint_range(0.0, 1.0) = 0.25;

float create_circles(vec2 uv) {
	float center_circle = step(distance(vec2(0.5), uv), center_size * 0.1);
	float outer_circle = step(distance(vec2(0.5), uv), circle_distance * 0.5);
	float inner_circle = step(distance(vec2(0.5), uv), circle_distance * 0.5 - (ring_width * 0.5));
	
	return center_circle + outer_circle - inner_circle;
}

float create_bars(vec2 uv) {
	return 1.;
}

void fragment() {
	COLOR.rgb = vec3(1);
	
	COLOR.a = create_circles(UV);
}